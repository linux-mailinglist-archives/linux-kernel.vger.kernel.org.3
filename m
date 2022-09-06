Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B15AF4E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIFTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiIFTuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2980487
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id945019957;
        Tue, 6 Sep 2022 19:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=YRUyYd+03DUpfcMwZBgfYc1DZM4JSNhSYQpG+8lrxx5U+TO4+vIkga+b8QTaNXg62Kqx
 SK880qHUfAiiXArbBa1YdQY4/kQ0wqEXlnjWnJwg6uxc4WSmVdDg/giCToqwAuBLzpMk
 TlRK+7ZCLuYjysKzf/doy9ZXGAehCVvysr4VbmIn2DkT5fZWhveTEdtVNd696MgMI0Oj
 Z+fOJTC/laZzsseqeR5gmXvDapVBqwyNlxsXVMEnpVsjziRkMKThOwJUBypIzMtmNux2
 lw+ULWvU8HEtTC5+z9Hdrjm6KuvVPDVUAfX0Pskj7n7Co+BIde7pPTAHe5iy6L71ywLM oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WR039711;
        Tue, 6 Sep 2022 19:49:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSRQIHKVgbzJWivSf65OU2WhJJ1GdIKHVQ5S03apXQFUtAmbLF3htkmU67UCQHsjV2jAcIlZdYuTJ0x9CF9jxRU0v5/0UhuWF8dFukDgRzVNKWxEnI4/b1T02Ycpd5EGIG4oEIn0YN129JBw61BLDDsgxDhkaJ/DPiaGSWxtpQnhAeLCfwJNFCGd8B5B6zCZDy1Z10KdTb9lsPSJsTnffXtDNYU3ZEgLDRNSVNtTUC1H/79BMKF1ibTG8KzpK3Slt5c/dBIJW0AfMz1Ic0MNJGs8ZKF7TFzZyK2a/d6jOqoJ+DFQxFD9hYMY2WmQdpbyt7OUA6Vx5tRmP1WZwVxwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=Kf/t1oDsmcqmCx+/uCWGntXWAYlMykfY2uAJ+JEBDCXWOYOFhH61IB+f1rtm3WwMLHp/yJo/Ac+XPaoYbGN0D03ig7YJklBc7LX08h2w71b4Xjzlw/6+6Mdh0lo/yPkF2B0CO45qK9DJ4dd364teCr1/9/2MI+oBQ/dKv+IMU6RTS40/a9FjscexE4IRhFdkDBboS6uVC/p7YrbW7kNv91gEogttokCG2+05mz7vKCvFjY01EMqHwuQXlN3Nf0X5pu6E4bgz5EnqvcKXRAsHdLEEKp6rvDRxWsviptmkxCi2BEkqkRoEsJqnuXxsgpBa39W6qFjN34aIbWD6oV1cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=VOdWFloWE4BOuIdRt0ADha4Fv+uedk+8vOBivyiG6nAIHvhjNP70fitJymmfUVtgy+PQv1KtXYeUBVQAJpVxrsf7/4FnvJ6cTCqpPrYkYk+TzIZ58/Z8rgW1LbnBz2YuDDytelaJT3XyaVfqMcgQm/QhxuhvOXWqRj4uan+81Wc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 37/70] cxl: remove vma linked list walk
Thread-Topic: [PATCH v14 37/70] cxl: remove vma linked list walk
Thread-Index: AQHYwimymKEemIy49EWc2jXbmtDzYQ==
Date:   Tue, 6 Sep 2022 19:48:55 +0000
Message-ID: <20220906194824.2110408-38-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f2bb7c7-9696-41e3-38db-08da9040eebe
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkBHOIOOQDPQUE4NydeuvIEdHr7EWUi07YwJ1ST57IjulqKbhoFQxyZwpohWWkkWu3p4Qxp9lmj2CFozkQYoaEsaoiiVOFz97hrN7JMPSKdJuQIUWswTCFJvQerU6+f9mV/GGleHcaNtwFx3WbFu77H39nGdhKdcmwuxaaFZ5XlD/N3apORmE8/BRnQWYmPD5HNMzaEUUWbK0wCehasudfM45arf2epKEHnvMnKiwbCf0deFoZS2+XsCP+niqfEF/fQCV1DIBy3Wr/XbsVt5N6TrPI8Ar46ws89dZpPY64TIxZ3YrDGpORRVG+kxaOS2OSkV8gpqNiVgWGAQvwMo55fZWM0XGTmhdE/6D6t6mNathPVvFoC9fL3ov1aJmt6iCGgoxFb+Lj3XpB0qYjMecmBEACTx8ZsSuCMSOkX2xaLKbny0L3i4m3UPnNw1SCpWq0wFBKFULOulgefqhRNWtKlLi9IrugDF9N6wXvL+EbTYbguLe1DKHG2qxMmXwmS/X7ZyVVjZccBxOmiEGvjA+10APQCXWIpkFkYnPUqqpVU97Y4uZDAz5A9Y3Yil/zetm2gymveyXuwsvxLZ155Nz/xkzy8rFOu5+aJXVdmEqV6dgqa3eHVX5J++P4jnhAh9AeJYkg5znJnYzBGH81QKfAiQNoJnSaM8E7V3FtyeSAx5a1j9DqCks0iFC8TI5GUmr3vZi2w8r6mcydLJmxbVodh8cf1RWN1+rEg99pBwk/ITTohiXCyvYbw3H3Ju3Me2V0nfjk/a9VtTyFP3qXuszg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8GRVSgg8auRoU5uKzCb2IhfYX1FDecnvlFNss/z0Zj9yYVqT7V5eXYWde+?=
 =?iso-8859-1?Q?FIglXBL+EfsJvw7l2hMz+Y+JH9Ndu2fl/PBa0gnV2h+/9ZgV86EXHv4x5I?=
 =?iso-8859-1?Q?No85B3QQ3CAHvYRWncYa21xyxYvmOhLt39XkwWeBYKMxzyO0YWrm7uNzOf?=
 =?iso-8859-1?Q?/yMxUAXmnOga2dm55MKM4QDK2fhY1qzHzUI7SB9foNZHab42jnS3UpIdSO?=
 =?iso-8859-1?Q?Y9BQZ2a9lwgjsZBMeY2vpD9ro0Dh9fLncU7UzpXN1uO9gh1uUH8UuPhu7n?=
 =?iso-8859-1?Q?4H2V7Eeb+1pcoSBltvtmODQi6p1e/4IXb++5j5ksQzdTAdM1r3Bw7EOLn1?=
 =?iso-8859-1?Q?vCkXnHtNUpkhr7JFjmMYKnH2uUaNbllnrlCeGucVbLz6bGag9czM4+mBzp?=
 =?iso-8859-1?Q?VuYWlUOQb6OVidajtPAbpR6eS6bmrxZp7+K3+vKosshB6D/hBio4nIsfOR?=
 =?iso-8859-1?Q?E53LoZKHvcu2htiaV2er3jSRs2twlr1gJ6KMKqTGQDtWAAsaczhv6ife7f?=
 =?iso-8859-1?Q?hpmradkK7tU4+JaohktqOXdBvj6yc9ULrnnGkELJw+m4ZsrCAvIfr/RzgP?=
 =?iso-8859-1?Q?X3Qr3Z+E5ryKD6U3sjjyRpCGtuw3k0dWkBl0uOc0DrAoL28CckoUbKcG4d?=
 =?iso-8859-1?Q?ko9WD4TOCIKzBbBu9KrV1ZF0E4tTfuVv2bn55ouMLJicrq/an/aXaFj7Kx?=
 =?iso-8859-1?Q?MUWjv7/EC5MLPwzQQrDuf+NllzhJraYMigl6ei0uuw3UIHd7IKeCYvylEr?=
 =?iso-8859-1?Q?a6wnZBmOAfKHSRl5NxxVOw3aPUE7foqWl3Bm7LeFLND5BPG2lPYaPkM+zg?=
 =?iso-8859-1?Q?E1LrqWq5pvJ5xqU1wyg+DEHMmRD0GqeX52pbKmi8tx9mFkm1hvV+BiV93a?=
 =?iso-8859-1?Q?v2xJvcyzFS8deJHAjgB9EcR5PF05kqlRCCiSEs7sgD7aptjrf9CPQgPOdr?=
 =?iso-8859-1?Q?eC+zDl+5Qd+ICLK50N5L2TRvFSpArhCAEIGEvNdNiasrXY8oN4qBEORT8+?=
 =?iso-8859-1?Q?HL7qi2EKW6V+YG7xQ1c6SGItZASOw2urhr66/Em7dZio3mQofZnP/K2rR1?=
 =?iso-8859-1?Q?wIU4Id0qZXTaIUf0++rrE8/rCm/WjPwXnhj7pXFa0Ivh5do67Fv1/tfcQI?=
 =?iso-8859-1?Q?itzcMMIuZI8Warul6KEFsvRtuPQxtxRxqk5vjR0auOzNT44eXoJ+UNE9y4?=
 =?iso-8859-1?Q?MQADTR5N9PjJ2oQ5fvzW7dnxXeKU/vk9Xv03ghCokBr6Axw3+CVj1sYPy7?=
 =?iso-8859-1?Q?6aE+jTHLM0XkA3cpbw9yuOjkxXZiIg1X7pN8mYaZZnqMnr3MZZZ3mQeBgl?=
 =?iso-8859-1?Q?qyUWnyQM4iegunQYQbe3F2SE8ifCS6S/B6XCeoNCMMbV7bmUn9T7qIpyYj?=
 =?iso-8859-1?Q?hH5w5x77Bgy2wR7/rkEQzUR/+EqdpqS+hXhDplnTaynW2PkcerSrLTtTfW?=
 =?iso-8859-1?Q?n4WsjC0bUVNvgzOvBdcTOIJgr4HELCipID1Vy+35PBWW+OPwWd29pusXsm?=
 =?iso-8859-1?Q?gyjnImK/Rusj8cQRS0pI+bfAp8yer55PbmwExbmFTh31qO6g6WUkvUW+tS?=
 =?iso-8859-1?Q?NPqYF9e45zBdLKeYVoctTPXQhlKFjzb4VVndWBlVKj1DqU9eLl55iNLouh?=
 =?iso-8859-1?Q?4XZmSUNz7yQC4zWhUzexZmkQ0OeURCQZ64/r6lRZB2eVjIcr0ASWdkmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2bb7c7-9696-41e3-38db-08da9040eebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:55.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VuVhn4ihiSBqHL2sZFNyNA91PbDCYxlKGIDVGpJ1NPKVarqBTai+aLDSDTX7nNUBCQYIq9sYFAJTDKEGe+PUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: hG3gdoXTKSON3hZ9R53NXvko1Xq_X0CC
X-Proofpoint-ORIG-GUID: hG3gdoXTKSON3hZ9R53NXvko1Xq_X0CC
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

Use the VMA iterator instead.  This requires a little restructuring of the
surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.35.1
