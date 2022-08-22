Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A259C21E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiHVPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiHVPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BF2CC8B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEiqKf017861;
        Mon, 22 Aug 2022 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=vHYcsLHD3O3hSaDpaNj11mmj6yQeIIRdwstWPCrWCdn7GsvjcQjrJt36U3ix+XqMuoXq
 fqC+I91yv0b/EzSHgrRAkWVxnKRJlIamoY1xfMOBts5kYGerLCICDOAHOiDJ4uSB+ZRg
 LKMwRXQMtjvXrL2VOPDFRLNeJSCHGoQX7Sz9gczJMy8HVaB10pC6/sCdc5rq56FIH7ZH
 ky2iT4vnouVr0baUtaSP6rY3jmkZMhJlhZUI1J8GitPCvepOJwi7l4c3iP4okPFyUsmR
 3WGvovNwwDk24omIH7NjSvaqnzGQIYDm2DEQ6pkY1o7DQ6F0SILnI9rPJTApqUpwbbIV 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt03w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OkD035558;
        Mon, 22 Aug 2022 15:03:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKl3eQguhQewCIzNHXHBVe3CnEoqldfvcj3BnwLsUe6dcrQu704HxNd0Ap0Oay6+zUQyGsxTmDvHegjFoMrLBLTmk6AccoFQSJC6l+ySv7oZmh0ogwMeNYzxBggsM1vPEuHd1fKXtbY+7ivtufvoHrrQdjCVcTqIWUTKvoxLQ/vOZy5FqDDjakJMT/bxl7lWgUkT/ttfpl6xDNEE+vwouBh83g16gX9MvdeTZwFU5atUgKhXOLIJkUryxDQS42D/64LvZnU9vKRKV0xtpFwh7dfKz8kl/euHls+iHf6i3yYYYpsbtcgGY2kWWmHfgbHbOo88LlC343/NORaD4y4hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=k8Qxw4fNepdkVOhhr7bqxsUDUz/WTwKMcM4/cwceDQWC1idr5hq0OOm5S4B7NXVhrtFstdnfin9F/1Z/vI5lugDvdMYEdqO4n9Kw4rTnYYaNOxB8ZPCmI4jREDjc3F3CShkoWrB8/uBnMYN+Q6p0r93kNRUJJaNrI1vOYamDUmu2c9svvbI6d8BEf9mzm0bwEMWD71MHfWm+kE7rtSbqpLSyfE81ewsvsRWssZBie40IpDA4+S5D1UnoQ/zP8+zCWzm6aRnXWTvQ62c1wV5joSQ6g3ZS5jvmZq4ieRjdsbllMlErtMprbizkQwvVuwBxDkUre4yaySlmWRz6W6ydCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=cv0m51QoMPz8yivMDd9vZ8xSGwFLlK7FJiXqTRUE0JBLVpvUx5ikRfaUSF4S7NCneKlv7FCDrh+6EPMl0LzRXXJFz1BJ5nx4C7+/uW0MNkLiOTQK78EYitLm2G0MWHa61hY1reb+2iGFh5heWNhzc/yPSwWPF+581N6huSK+3ew=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 16/70] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v13 16/70] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYtjhQQfZ9WCIhVk+ZZUOgMir0aQ==
Date:   Mon, 22 Aug 2022 15:03:19 +0000
Message-ID: <20220822150128.1562046-17-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5283af3-79ab-4c1e-8b28-08da844f738e
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +P83fQKMlxS8G/CEBB+YfPnRM7psx7EP9XQ+4niOHVSthw6xmQ+UIWKw3pf12Nwo2jYIPz1JOW+Smb7jFb+BgSzh8Ja31eFVyw7BsrsLrCOp5hWFoOg+OiQKPrZQo3yGz3edih/FQLStWIRxV6smdDIwY9RcKhUaNCjBs/RhRMqVdXRO5yiJW5UogZRptTrFRYeZ3a3af2I1HsDqPckWCdFEO/nuo9iEjH7s+Qh0isXwNVqWKL9K/RZz67jL/soRDDKjUd/QWQ7ZXht9CxCXCaEuime7p0AnT/0KvCvd1bPfsdihgQXH26viXNm++lb60NQP4kei6EryfEMAxunFiGx9P0odWLhWr8qv8YNzgyDuPxOpuuIc+rMG1Fa9SPR5xOr3PDHMUbyLQfTj2V3mJLBsHMbCVQFMjQDZRCNAkJA4Z3ECzvPRWjGFCQdQi+NgNxNA7JIyGf9g2kCX20Teu4iPd4YVOCZrijaH3aUnseH3EiLzMgHwc0QWklcFovp4ZANS6kWbJGbR+VJRAhe9P7hhYnppm2tS8rWQ6KrGApmfUY4UKBy0Sv+BEnoZLrDO+FBYbUzrpBZqeXtUE/JMikT9S4KMhcrkc+jEuT4pcqrYts4E/Dp8WIOgKotjkJGAN/6DPWP6Vxko4nf/H09ClbpTQeimH8Dw58qSXcRtISa6oKOtrf9B0RoiRiJTM63bfU5KjiAr9lkoIWdOHpY0Mb9lS55R24NqKjOF05Nf+8Vvd5luXTSgw064v1TwGop+7FNYa3T5g4RKMBYdGGWZaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mtlsDsKKrVFduzP0GQ6Vko0a0gtKYRxvkBnX3GUqLgYDyQ190qO3cVFkal?=
 =?iso-8859-1?Q?4+mKYkVe/aCCWbuZAeSUPFAS2INbDcq9B+GL0AKyGrSCwbgpUOkTgIuWA6?=
 =?iso-8859-1?Q?lYuK9vmNSSHGMc1rC6cp5NBSP/Rufv9lIjAGUmI3r73keaTOzBVkapb46L?=
 =?iso-8859-1?Q?9j1bAGufCWpYmDsW9WlUrJsKN8tHix/r6zerYyWZLFbZ9bj3s809qQIyJm?=
 =?iso-8859-1?Q?tIlccAXo1fthz5HNYN0rX0DXCSjMhOn1MrROBo1SE1OT3O++6ouCdylsp5?=
 =?iso-8859-1?Q?gAPxx0M3fgXAOmBUkWkOvgxD02sOQu53CH2f1SorsBWIk7V+VvywSOOpvK?=
 =?iso-8859-1?Q?Tt8tKfSZUt6NKa+mfWgoU9oMrOp8wCb+Qt8ExvOKiBUZ19vtxuOw0C74Hu?=
 =?iso-8859-1?Q?ZNJDd3x5i0rdxCj6S1AB0ENxSiOwngG+56rzPJIGxM7CaFq7vTxiFGAOsq?=
 =?iso-8859-1?Q?HxgEJpMa1Jcil6lBwolryzB4nsVoh9XVhesmZ3XCn2CXHkLOBU8EhFnAEM?=
 =?iso-8859-1?Q?5pS9GFRkGH49SRWuB4yMUN3+IuRq9W6pmiFFSM/wB4l65nsKl1IQa4uTXu?=
 =?iso-8859-1?Q?K1kjk2Er57AxD3ZBe6rG5RQgWkeRSwzRX76xQDSStQAP8V68UgFkkhxCN1?=
 =?iso-8859-1?Q?FAHox1jHDJWd29/4uATF6dDzaaR09WLg0Co9dQuFp4vQrKFjIEyjFtlZSj?=
 =?iso-8859-1?Q?n1RlqKqX/Eh9Hf+OqSODBmHd6qEQCfUNTqtYAmcYnNivly2ni18gr9GAd1?=
 =?iso-8859-1?Q?Eqt0IQf/rF6lb6X2iCmjFqLP9QC85VqwRWKeRIbY1PRmDIoLA8TiddZCgt?=
 =?iso-8859-1?Q?X/pv8agtk9xx9LGR60zv5hKhXaa9lsZHM0PnF0MLnR1WCqAhIuxnp63c8Y?=
 =?iso-8859-1?Q?qQbqLjHZ5mznfuwa2oGTYmuJzGOgH/6v8Jh3iF97uJ3WGZO9xKTFo+WfRr?=
 =?iso-8859-1?Q?P8GuYf5ET4wN31akCko3wf46StRdjS6op/PO6nKa8qUb3MKFvRyjppCV4I?=
 =?iso-8859-1?Q?/2fsfX+hi3BsJbA7HhEZucQjdTSFjdZFv/XFtrFZwPT4ObGcTbD+osFYH9?=
 =?iso-8859-1?Q?BcS1tN0kM3aGaIc9eyYt73laRlcdRz26NHVsUvpBr8aRupAHz1/iKqAAS/?=
 =?iso-8859-1?Q?cpMTLQ7vHdj4Q2G3S93E8uiKqrGK8a06rEx3kk0zoGnB6GZthCJwXSq827?=
 =?iso-8859-1?Q?/vartSnz6OTh/UnNS7ipudEbveskZBLAgt/RSlW3fLhvbQjsSOx0xP/l7Y?=
 =?iso-8859-1?Q?gdnJXfxWIyeDCfeEyPnCXJ9a2Ijfz2dw4pokcwfZ+15U4dr7AMx2KR89e2?=
 =?iso-8859-1?Q?CGYB3nYkMM5NQX0BAHoPiDa7ihACC6w1W4R0UM4w2RM53FIkTy3pq+EVo2?=
 =?iso-8859-1?Q?oI4ox7Q44k3qVEwxpTMjwb+xLGJn25UIZI4QVerrYHAKozGcm16a2mUt2t?=
 =?iso-8859-1?Q?7GWFVVRsgclB2NhiCMg2+Goj0uOe62sPTkTnd9lNJBXIch/MhTM8iscons?=
 =?iso-8859-1?Q?f0bcKh7rnrC/RNzvna3TvHIfldAvumd6Bgiimb9AnLsiobuYNXuxx3cmX5?=
 =?iso-8859-1?Q?cSECN5WrTvQ1m5v0GPXzx4KIVxx9J3S5ElEPhgqfclAT2KXcjXGbFQpH03?=
 =?iso-8859-1?Q?LWlIsUMFUUqBxxGQqrn/VZGQXb/belb8rcHKAvp6wasBVpaIn/p8hOPw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5283af3-79ab-4c1e-8b28-08da844f738e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:19.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDfogoQML9AAJuk2X/g2Loy91FU3iJznEK1g/QFkXSFNtzk9+g43VrqWCSdTIrG1YrICEKa6ToPgVy1RxZ72pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: wlE_GumuVgUTXAFZNzaawZVwmMMq4mun
X-Proofpoint-GUID: wlE_GumuVgUTXAFZNzaawZVwmMMq4mun
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
