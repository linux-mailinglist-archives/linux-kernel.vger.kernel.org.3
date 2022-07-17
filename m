Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C1577375
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGQCvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiGQCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8821A054
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8gpr031743;
        Sun, 17 Jul 2022 02:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=FVzmrzaZk1DlWNUZGRm34uETcq2jZgadopqT+wn9oUU+gfZJUmSjoZVkkkzKk3R3lb3s
 vlndyBKqQeOgSnCjuQ+WwV17Yf9wkcTegOm+XyiE4VorIDKiPzmJRdhJFpWRWelGWwou
 HsDeNJ8D3gLuF//qPpXO3LMWsWOhgLEQ7x4jq2ls4+CWVFA2HhKEKrS9QIjMXabOxKtD
 vB0+ENfLYo2/jWIFiIUdY0Tpj1ReRWhlz4uNYpgGguwv6O9KhTf/qB2CIiYa3O6H2XE9
 E9LEwA+Y2Q+OapWoLrI9cPWcBt1s+eeoQHapjtR/mldvhZ9SfBgbBRs3JCNJJEveskJu Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxx036125;
        Sun, 17 Jul 2022 02:47:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8WC5otg4j4fbU6WMsBzaYWe1LDr5fXXU0ks8WFDO6UV59TfL9SVhuCzrZ3jbMs9cyWRpB7G5h15KzExSEq9PjcFFnEA3tc3v/sf7B8UpcEWSttDZsX/PaGHz41xNKhOFTQrYKNiozlLHM5IMDnap6/xrUxlt3VL65nhsKHhmqlv3OpFoBTm3jx2ZqqxPcXEbvyfNJToBtbM0JfrMyszALiqzN1LPgp0+1Zfe5ibwgfqnD/XckQKsaIFaPMY1gBJX3AO8DYzO6KUi4khj4pkNyYMyyLL+cfgjrVmoxmdFSrg6vowi9iBN1BPwARCocKxu19+c+4pQWIjc1rOG9aqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=SX5ze/ZgW2RBTrjAnVeUDmw+l71ewZUMKI4757Dyq0HxcXS+7Vsrokn/iwof0itU9LqsMP0VbiYBF8cVZRzCg+Tl7IAXuRKQAAe/8h+3oS/7JnRxdXOw9OSqi0HuTof4Qu5EsxqQyQZIANs1RjhzyTkvwidINiLhq3S5InyGTjN53+v3HdbN4dKX5lEp1NY/yROQs2kiH0er7PbT9J2DRbfqXLoXTNlF0trp+V+38Bu7A8BhiV73SabrCpYXJLK28Snpz9BW6MwqnUQOIBLUgYp9Nt50Oc3l9ye7T4CQa+3G++714s67QpYQnocXZrrhn16+fHjbGfU6ghlHOGDRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=CEpDGfnAVSahBzP/EncxUyphIjVH44D54x74G4RTJwQhZvMa/I4R1OAcEW9z4zlbDyfMLtoePX8u9aWVm4ycrk4qRHC6ml4cXntHX8A+HqGYBHLZrsDLbERjPhRMp38CzoUb6DIa8KEDg7LLc6AvcCJ0ra9YGtdt8MJ77lDmloQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 57/69] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v11 57/69] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYmYd6Y0/VnE5raki8NaRiiz8S8g==
Date:   Sun, 17 Jul 2022 02:46:55 +0000
Message-ID: <20220717024615.2106835-58-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3c00c62-66b8-498d-f661-08da679eb2d8
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/AQfMIk2A7kCotl3udqQ/h4alonjAw33m0DPb8O1HW9+PwZY6DSVFumRQ6LQw0xhtOA4dB2EpXrCovDHzswZWE6Os2IIiLKHGbSgWL5VRM0d6VtratN/SXrz/xRXloP0MGk9zq3wZyBoUk5MsU7Nsv/1O38iRhXombp6WEbfOmWvOINsVjIlbCDiR3eVPXQM52Sd4xxl8fvn9+t6acH7xN2PmJWTgEgxC88vDQsGESZIZEFZbg4X0T2/euK52WEyHYkPZqhendyG3x4Tbg/9F4baDMqKn8IDbODDRnHQtfxbwBSGs/EcVMyjyEvidl7ZfnqrOL+691gcYudPvkSGXwhJWggAN+uzwFEy9/DxBe8jViN5UZTM6KPP5scyW6Kshav/p7jXqdOTeT5dVKo8zN3RZPTZw2BPn1Bgykwu5FkoitFjpxx3ktrwISsz9lGGFyJBUr1XlMjWx78sT/N+2Ry4v2+PFDJugwYZ0du8kaCaE17a2h8a6ALdjZEqN6o0x2NBlpnecrfgzc2MKJ5OQok1DB3VNFq46RXlY4Y6MIMMkEH2qL2qGgPYAuZioUZ4RVVL/nRdYqvDD/+2rPXpyQw21lOlcpSwOq+0XCgxh0If5uPLN+NugqPMPTNuWT6d2flDZt9zoqiGeG/5ifOLe2/A7DCwhWP4unyA7kZjEaxZU5Zf4w16WPGntzkjJNpFIkHZR3acqLHF6V2YHBRYcdpCOfZQG2+KaX7Ck/W2oS5E9e4OG9ZiKc7ByWezK4mJ+/LnMFGy3qKr24UdSFwemt1UYKYuDDvTKPTvRKWqCaVexQneEHdiqzzFMEug0s9MXx20jgIYh2jZaXA8WfuP2Y1Bieg/6pwp67mjq0xdJt8LJaQJ4M8KyaB3IxqDL27
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T0e8rL6eAqblSD2e/2ZfoCBxlWRqFPQqC9p3+t6gDuirDXwiVBE7urf3zu?=
 =?iso-8859-1?Q?JCNttXahQMVXObg/seLtZPYmveNyYaypq4Z9hzgD6GmAMoZnPa9WDyA/bu?=
 =?iso-8859-1?Q?/u3/ll+R/9N7wPGFzp83mbQWCwaboM9ShCvdcPukAFKNeqjqDQwTbKM3He?=
 =?iso-8859-1?Q?FBh2aS88WCQiwkzfIgIsr/oUguuXPNb30F3ljHNx0UoNTwEDUzPBO9wR+4?=
 =?iso-8859-1?Q?qe7rNW99DA+apmwgnpGhpr5UHgFV/t+RfGhkcwW/GRyzO2PCYet2BQn+qJ?=
 =?iso-8859-1?Q?48d5GT3vQoudg6rA+s28199qkllxLtIhWAqkPiqWuhyWcmUdDKuxSpxnac?=
 =?iso-8859-1?Q?Y0vVC7RW7VCvgaYdl9f8vhAp5w/LbKrqmpcoaUzko6MYbBqRuVHfL9Q3+P?=
 =?iso-8859-1?Q?tqtJFr6za4EzIp6pFXcU4GjJ/EtVv/P5bRvuL7VLagucOdGcV3AovOcah4?=
 =?iso-8859-1?Q?X9ZzlxUuI9UIN0TYR6xWhXBzQt7doVabL90W8BTVuaJMixUa8bHAYRc/BW?=
 =?iso-8859-1?Q?IUKuplAp7gDCyOgxFQR/Ha9Bser3ds+y13uQ8tlcyd8WiEEiRI1LsKFL1e?=
 =?iso-8859-1?Q?e2uN38KMVFQyrF/f5zP2zko8vS9XJMaCkg6RuC8VG26AU7GHKq7Q4/8PnB?=
 =?iso-8859-1?Q?o8sIHMbu5FhcBkbWl0+Sxs69LaGw8JrOx3h/YdtxICIrzHgXs2fkxS5iGv?=
 =?iso-8859-1?Q?jKpUSb0G/l7EGYQDiEC+4l9imnC7iNyFAeIo9H25iEKh00/2+8I0+/RGdI?=
 =?iso-8859-1?Q?dRYj8QMkjHNbfikTQ/uRW4FrbH+IBHSeIoniRP0f5/OOmO4V+tqoLNWpPS?=
 =?iso-8859-1?Q?FhtfeJslMkrv1ucZhzkI1s/HyQyQ9/7xOZ42NkjxPwmo3mW+O5P6ARy/I3?=
 =?iso-8859-1?Q?Dba7sRnPuvWwXDYHYioojznTL8gDWYXQBtiluzX78UNCo6KE2V5Wy2XG7q?=
 =?iso-8859-1?Q?C2BBNpXbOKS1vfPMmHfeOtgvF3crAmlJC7XwG4dQ8jbxrGMgu3q9JS/0Ou?=
 =?iso-8859-1?Q?XVRGlwcEHov6Bm2OAqLOhm2z1VGaivVZmC0GI3fVYF7Slt0OP8LMbwQzUr?=
 =?iso-8859-1?Q?PthBIDzHEDmlzbZLzP1vDSWxOxOyWeRy1eEfkj0PH/1TBmyrxlH8eFzd51?=
 =?iso-8859-1?Q?YYE22G50bEH51xGijkePqGvVXdg9pN0blG8lZqT5NirYU6y8oS3hZzBNR2?=
 =?iso-8859-1?Q?hxbQD0MK6fiLYlpXV4rRMtqgUappDTxhy5LwLnsaCqD+V3G3a8k/2zwSDu?=
 =?iso-8859-1?Q?RKDd+/Oj/lalfeazogkPogXgGROCbd7uwmjASixjJv9HAyei6iQarzRvgM?=
 =?iso-8859-1?Q?R0E1vcKx91vAN5jEk+fo97oddoKNDurcNExMPRCB5MvLnBwKwdwZZVD7sa?=
 =?iso-8859-1?Q?AQgP2RejnCRNmlc3DX8bs+oieSOgKBgmSgAM87yl3E+GTK5+Iljoznchfg?=
 =?iso-8859-1?Q?ZFoJt1sD0mDB5w5Oc79UynhOcz153B42XU7iF+LO6s9SbQzib+t6mq7d4r?=
 =?iso-8859-1?Q?pNqX8K7jThGjrb7Eb3K7LU7+ohKAdh0E1JFR0ZlExsDxYuxK30FQC5bEUZ?=
 =?iso-8859-1?Q?rry8CNBzRPda0ljKTE14HGz1p3foTw85p5nqYgsT4J+AXll6iWSTPctlVM?=
 =?iso-8859-1?Q?AjhJI7h7s3MfAnTYwDQ4/+TZKCpTOqaURuS4XUJY+smboM52OTC49ofA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c00c62-66b8-498d-f661-08da679eb2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:55.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4OFAtlP1fOMGi9MakXolQGMkHQ/vRcRCM6gFYo/4BXacWGOyumUwqnuK6wTkHjlPONhiZFagWXAb+FilqGOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: vBMoVMUh7ypvBsCqL5AToVRvWrGJfxbo
X-Proofpoint-GUID: vBMoVMUh7ypvBsCqL5AToVRvWrGJfxbo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Link: https://lkml.kernel.org/r/20220504011345.662299-42-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-58-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mlock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..c41604ba5197 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -687,6 +689,7 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
--=20
2.35.1
