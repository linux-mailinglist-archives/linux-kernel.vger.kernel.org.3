Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDA510177
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351999AbiDZPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352097AbiDZPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43E15949B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSuSh018608;
        Tue, 26 Apr 2022 15:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XASC8R938XZ5zv4dXTHdr1y+ObQbBhIQ6mqRknjeR7o=;
 b=sFUKtZIiZLh3OTfIlS+6O2erP/2E0MlGZCiNbDxVGjv6nmkoZn8bmHSquo5aptPL9xA4
 Wty56bE8mK9Zqwtwq6BaDFylls+xDLmgX78DJRIv8/tyYJ6amPr3BqPB2VsEMOhjZJZS
 21p2orbekHtOfMz8aKFY3NGqahy7A2Ej6Q5YCLubGDpc2FeqQ4NNCOGudTwWqqTQ0SCr
 fh2i4fuyHrpF8iK+A57cXNN1ql++6DqDZgferPM9cV3U1ZPqKQvPpCMiyW4YBAyesO9K
 IrEX0Q6yKR/29NPnDzEv5J5kMsJe+Sat790ni481acS5jiiGPPiA/7JYXB5dAcHUpXK9 qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxej3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF5554019202;
        Tue, 26 Apr 2022 15:07:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ff1x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrCK1Z7nfd4Kp0yGEWTc6wCT39XCMuFxSt2DgGxWHjdY9c76n575P9MKE6gsQ6W6rvnRrdKtGEVhfFjUwJ3sMhchw1pEYViWnSSwwhT/6zcElCFcE7nL0y/ZmFfllSdnHx3Yn+Et4pgVpVeXaFOVGMRGwQ4BaHPfr7z1GFg8A28CIkMcyT8ytS3AEyVVXkhRMd6sf1ccOOgxTI1Zk1JS2A0FHToT5h+XXY/LVpx57IaisY+AMkW8c7wBcj7zfeRHbP7gtbbKlSy+61sss5AcdWXlKxttPDAsPvoWVacLrIt+oMmCXgPiP8Mt3hD2NLnTvbziic0bD8q+W7NuY3nD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XASC8R938XZ5zv4dXTHdr1y+ObQbBhIQ6mqRknjeR7o=;
 b=dnNYG5iiB7Y63WrurxcR+gpmOx0Zge09JsE3wqnhqM+mL45Ycx8cSbIq9F6i0j+c34HqgguS6IRn8WUAqag+ivml9vaNFTka2k+BQk5vDRmskTGU5EDan9XsyS087n/baMnEr5J7vz+BQzicRBA069B5jPXJMj3sAlyYsZ7FXi1/ZzTVJMWr5eRXF5eDB+DgDc2guoKtNUsFevAayxbDSyCsCAiGX3m0d4qtS0pe8CJwwYEBur+QF1wYk87B4D86yw3Zi3fuyY8abO9++rPcTh0faJE+8YrH4QWZEWFgd6T+mh3AmmzW2+WcxSBnjXquwPrdIK+Lwa1vLygQue0ZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XASC8R938XZ5zv4dXTHdr1y+ObQbBhIQ6mqRknjeR7o=;
 b=soFzXzylXLyVHlg5/xfqURD+qLfIPeb2OqTBYP8yeQU+mQJY/OZsXuxFbRT3EG47fFcUtPVHmM8q3EDwXO7vkCLEcvCxJAz5/AHg3sn5wf+sdMHfYKjI/kCZfLPTu7Q5gnBAd+uAXu4qST8kbhvjZFHkYfGQlSVRBkH0COSJGsA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 48/70] perf: use VMA iterator
Thread-Topic: [PATCH v8 48/70] perf: use VMA iterator
Thread-Index: AQHYWX8+PUgnqgSfskCaxxMmPWSybA==
Date:   Tue, 26 Apr 2022 15:06:45 +0000
Message-ID: <20220426150616.3937571-49-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cf19776-1d9e-4cd3-85e4-08da27967ab7
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929524AD74E5DD5A1B01588FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3nz/E5XWWiTxP3jzWPutmt+Rod2+ANyxHyUkrhI9CDxlaQ7bAAfgB9r4DWisN6bgbzdinDRdYBvgIM/D+82KLt2WH7hBGikb9swZwsumLMstqG2ZsNlcUCc4MjiulPFqjEcasfMglL5qH/sTplJQWvW1OyPSGoQjCSUYkPw2u7kgulTXtdGFOsOIIGnveiDCGm/JBXHAYKx0iMK9BVKGpfV/PYNi0sCOa859ot35rAZEInUgrC688CQ7zl93Rzw4dT3NOkQeml88W7pns9ZyLJF8SjJfn05is5hrAtU5dbY9kkGv/r9gvrkjyJcduId4zsF3QbMsydd5j7tyv2rj/Sa4SiPtxNrRKFirJnp5RX3++gM8Qgv1A+e89+jGUZRj/uRP7RDFmHDTh0FnDd+coZFu8YEPXLAytrwm1b++1zXtPAlH+xHO59fC7zjhmLnSW22oubujnvgq7gI/0+bzlBVmFLdJjEjCSZ5/FQkdDVwU8gPHQiO+IMsBE3o8PSgdM850LZkZcKR81QgsPGTphdCacA/B68qY66xEZ04ScZM4uZUSPH+/rORRtsyQtu3JiBF70p9ezYE/+vdZMA783e6LMgJxzYUSr/3IHxCxTdNeLnnznEOtVhG9S6k0Xsd3SloBVqyq443Wak2WbHyDM5bbqFzH6mQyfhpAgyZyg4BWnrJh2u38eW94+PsiL2g19suOHgWTjyHpJn5W+fmyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KmMFCdiNNNlVM88RlnI/fQziMw3T44oyTh9EVUY5vWXRN9JIh4TnBfMT1Q?=
 =?iso-8859-1?Q?EjpAFtoS1M/5mP7vFjIo74+P4sB5cOk8Mf4tobw84Z5c29fgnTMvaPHUl3?=
 =?iso-8859-1?Q?PYw4eBIxgO4+w52FKPlpTqpAZvHb+J8/iFpqA47wfBCYAb26uIxiWR53Es?=
 =?iso-8859-1?Q?OuBnFSCqswAcX6QIkWZA0dWnbjLkzRCCZZoXk+WUIvBpyebYVFzEMLFZm8?=
 =?iso-8859-1?Q?xkdgIQkLDJoi2EY2ay0UNQZP3bZqai/JjRSP6K/0i514OM56unv15cQCIH?=
 =?iso-8859-1?Q?8/q/PPAEeOX2wx04OfxdtBMMFgbOeqK1MBSGzrSgTMUvvrknymFxvXwG+V?=
 =?iso-8859-1?Q?2sTQP4/AZgNoz3yIsuhdiUKn300Lw+YPU5ydg1ZzkqIm2Q7vAbCwt8LqfE?=
 =?iso-8859-1?Q?sYXQaeR/DGIHllXG5tBz/npUZLUfzWmFQjT87cprcXjOTe7PV/U97Jc1KT?=
 =?iso-8859-1?Q?Oyf9DUsVlMg4/4GYav96O0zhtpkDK8S+VSvxTbl9KxKFgRurjmXUzVOLUh?=
 =?iso-8859-1?Q?2mPRzj9Umwk3uyu6ITmr1pgoilhF1DcckHg6Cf6RN1wOEBZwrGLxOu9nTf?=
 =?iso-8859-1?Q?O/0WOhGs4naGQlhrI3Ngg0hrQ1qTYD5LmYBqm3QnUYi42hVlnSeHm38Uz+?=
 =?iso-8859-1?Q?aIV09qjpnJlODwe5508bqxxJ/g4x1SPiE8VglxD0134s+6SN8gHfVUuK3r?=
 =?iso-8859-1?Q?bth0b+88MkIof+zmZO1kbZ2qovRgJqAzEFpuQf8/ZIJJqcide6vobiJoPw?=
 =?iso-8859-1?Q?P0YSzSkQX8lrEtlXyV+J2J6JxnchUpd5QxrBXpuYwxl8bEgyBixMNoSknn?=
 =?iso-8859-1?Q?6Gixl1cu5exmd0kmX1VDBjeudyCoTW5R+05hwVxN4CHPsFZQoV7baWlN7I?=
 =?iso-8859-1?Q?QzkcLIKVIagJEIou60iNv4K49V9bh0xx1MNvJVPqcCbWFa79aMzXFwuNba?=
 =?iso-8859-1?Q?d0c7ippgtlNg6jB298dP+u4o99r3ZgB+0J42O96Q7rR2vCAGvZcFE3N6IY?=
 =?iso-8859-1?Q?JzSBiOO4r3cJL9BlcnhWjQIRglr3GVaQugcfgMCA8FmC/c21rdHJfAEE6z?=
 =?iso-8859-1?Q?qVuTG7N9T8esdbrRNqZJdLW+RcKi/Gy+zjPy2m4Ep5ITx/uoaUSkMZXStB?=
 =?iso-8859-1?Q?lUxwl3uP8A3Ya0GCjhqGNX4gMI4tlZqTrJY8ERqAQQp3ezz7ZlA671Tvup?=
 =?iso-8859-1?Q?8jlZLyQbQlapf/kSfXinUgjLw5bzJVb2ZGbYc+IxZDjPb8khDNgvGRWxi1?=
 =?iso-8859-1?Q?cbDu2Q7bPYnfW6w+8M0k1QjdxPZeNXd6DK1x/YsCz8Svb9JnekjJtGoUzq?=
 =?iso-8859-1?Q?CwdydjwonjsyUvT4ZzJ4gH1B+wb0FM2+Cf3Brdvr6CDPJaxpTrrNsLeoKu?=
 =?iso-8859-1?Q?44XSQ/nj2Ui31x6ZvYh6dECK5rfApkopPuik20UmWLbrbIuB8kUBFAAysl?=
 =?iso-8859-1?Q?f6U4q9DKQTo4otFGnAEIkTZgmdTQjICmjJJfOXeOMS73+P2ntOg4aF9PgT?=
 =?iso-8859-1?Q?A1rLGjdmFEZ7gA4OSwsHsYLGLTXLI68xa1o8xv8zc1iXQmbiExDtH38Nm0?=
 =?iso-8859-1?Q?IKgax4Lo8cOj6MlWa32SnUOgHTp2b/YMSE+k2r2JNpec5TmPfdR09F29vP?=
 =?iso-8859-1?Q?msWQ8sDBTI05mgLA9yFAaW54KmQqzh7Zrg9p0IOEI+5pyoqDIK78VKTU/9?=
 =?iso-8859-1?Q?1GEXvsmo4ckDrjA6UXvO1g8LNBR7uhgdruXrgj+SA1kt2VlHa3Ls5gllgl?=
 =?iso-8859-1?Q?CGh6FGxytyhobn8Rwpr1KzUf4y8Y32BuB9jHvjXOnhfICoYg0/W7x6BpaW?=
 =?iso-8859-1?Q?AMUtPwtDckpy8yZTmZ4n3tDbgTBzkVE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf19776-1d9e-4cd3-85e4-08da27967ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:45.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhVqjSpcVXgtFHfigu9tUqkjYL1g+3dvRxINjr4Oc2lSNckEQS04CQYmIRItxVx+K2P1qsDdAp06E2aVZrpJCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: mwRo29COK5RbsU3iHAOFPiyHHHaW8DCt
X-Proofpoint-ORIG-GUID: mwRo29COK5RbsU3iHAOFPiyHHHaW8DCt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23bb19716ad3..b20b14d8dba7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10211,8 +10211,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4ef5385815d3..c3b2f695cc74 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1230,11 +1231,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1982,9 +1984,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
