Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E736519354
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbiEDBUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E74341311
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LFfx4018740;
        Wed, 4 May 2022 01:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=js5i9r1YfiG82iI9RU5DUQ10v52qvbhRVUqU9E/uOm29Jm2C2fZ2fXn5aMyzQ7hFvtyM
 UYgJFa8ZrXe5CC3t9vNkPnrHAuQiTfUhIOZP10bklNDzWrJBNQpyaAfSOlTFkg+5HsuW
 vGEhDzoiHuls/SsQZCuD+OgURkjhZwAqU4zyCKGfbxGgauNX43fPF2nnZtYpFlEvNKAW
 TZh4ftpP+RLR3G5eL+yphndxmMaFdWK47NVlVel4h2wniinP/+OYWK/Sj5elAHKGBVFY
 UUBXAUwXQZnY93O7ykR+QsszyhUlzB7c3VO4pygIJxYW2ajpBdjVhDy7EHSBFgiQs6gf Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AtoA020100;
        Wed, 4 May 2022 01:14:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3GtVzMUv9eMHSFSR5mknPGCUoqM6p75PmO5DAHApQBXnd1OLgow/lffAxKUkHbenDMWD5CCHVsQhQeR+pUSf1hDEMHyETkOw5A75h7knyoXN8H7LVRnDvKY9xgOQvL4vCVsX0LUkneR8RDq+kjTIfxW7Vc+MQYfEoqlCLCvO4iCzOuzpcvHwdkIVRU6OQfy/901DtKVzrH9ErAET45KF8PGCPey9XTl1DbeR2FLlFRqTKbmGdS54TIt5XIJY0uPp4vWR2AOOOxzSt4IH7qzoGuN6xDEKjKh/qEB+V1XoteJeGoVqBdk47ZedM0+Cj19ISlqZmmsg4NIxt96aj0VWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=QTy36eKsxRgbIh9hbrib9/qzq44+nC/4GXQIfohMD82TPu1LDVVf7KcNUmUs0lG9/OvMUh7D8ZWb73aYWTl6ASW9FY2CWv2i8SYME9sfaISoPl+4amtIIY5OdR1nIhdoyCvhGCWw5VNnln0xGbUM3DEl0L1cuDOBA088Q/V6aN2TOpRtku2sAbPVqp+wGj4S7N2nm52qu96q88MAfNjBzOpvXC1g5UMQHPIYScrwKU1nS0AvldTB8OS+UXJdTaER1uvqPh0ckZSFPCK9G47be0dPVX4hS/6SBly9o6kG+3OzBxPKHoEYY+yqE4y9wrUlq0yFcr77nO8UnaJYNwx/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=L7wsIDhAHznmlJioBCxdTysXcrencictervIO5wWVIxa/CYA2rzOPbHIRMEymxfwwOQlowiE+CJczdKV1fKwBAfvUDyZf5KgAtdRhlmoVWPk4ymJO7DMpwCjJ5U5SjRydxk219hqWhMId6DvO5dqHcGQCgy5brb70EfwSduYEdc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 37/69] cxl: remove vma linked list walk
Thread-Topic: [PATCH v9 37/69] cxl: remove vma linked list walk
Thread-Index: AQHYX1Q6oxd7y1RdTkSlRSE/wzQzdQ==
Date:   Wed, 4 May 2022 01:13:57 +0000
Message-ID: <20220504011345.662299-22-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c229fe-4c51-4793-d50e-08da2d6b5e50
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB37282D907D0EECA5BE96319DFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCpJCozvaCg8y3LAW/bLnloGUMXgsIGMkLZdTFA5PC6CqRW18yn9gZ9D/T26UORCq5I0kXtD7ywSRavrW1zsTE+d6MQk4gBcvLNEKt8noig00Aj3FzX04EO75jOzOsj6XQry/yedrLYqD1dyDeW5AnV6daVdsVXNX6eoXraHWIo1FPKghadn48e4TuMWSc6djudlVKMzdI0lDD7aWeW/tJfNzkKM7JkZFNV9Rof+O2rTyH+5DbEiHWIIKeFk1kicm7VAx5FRfclt0rC09/Xf7LkY5zmNiN47Yb64fmZmXjnr5GfmFsa7aTnSsi9DAFOokQI7zXkVTUJgmweWvAvbJJx5F8k056RW4bxjjwNESka1KK0Ksj6/B5qa9eRApRPblK9rIUDxfTTuVAM1PBYz2XrUQ9zBbVm8NfXtZNM78rYw3kvw215zQnD0X/idy8HJXrrEcO5JiiIRAWsWrvjOZHoWD04csE463w6uZtXLqWBcOHYql3CxjpSOUuD+5aLtl13i0oers5Heu4yQN8eKtw3rFw5NfKWya4AyqQqC26gV/4L05WGWhMLaZVivdfdQA3LiwLvigFw25n5RiIa+RjqzDIpEyshPf8sIqfnnaUgZZ8iGvfeZafLYGPqyfnBdon8HGFynGMOKrQ3zrfg7ZxjUEEN8GM0eeMY5kv9F5q7Hh9iJsmJgRZoTgqJxfAh+Fm3MY4SaFaQI3DZ0ICxdtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QnIKK5MPZS/VNvdwgPrmo5AdMNzhl7dwaEijAgmAliKVA6JrG8JBrHPSms?=
 =?iso-8859-1?Q?BqvfMaSEANnaYjVYEPp7kSm8pRl1/cWOM6dM3Cpv818K9hq1KoR5DPVbLD?=
 =?iso-8859-1?Q?r3rvtlF+wjYSJ6FSujZkCY/yPB5EC26blzW7/wr6p5rbeywibOK1utoPOd?=
 =?iso-8859-1?Q?ffwuyl5OatT9sOTXoNNMHz358i9++OwuNWOiJsDPptTeTqbc28l51V4Kb8?=
 =?iso-8859-1?Q?iYZ8TrponFZNfTlNUmB4ZoxDJBQnCKsVEuH+J5pXhPT9sJGTx2x28qFTQi?=
 =?iso-8859-1?Q?NYnq3P90qlzvv+RCklrO5O54nEA/Rwm0DAWcramFTlsQnt57VGI523Zhwy?=
 =?iso-8859-1?Q?fLWebHyhoAvO7um/wHA6yXyNoC13JkLSVLz3Xu2nYpoqR4JCF05dLXkJy8?=
 =?iso-8859-1?Q?QQdnQzTP8mGZkVkpZHCnLayy2AEzRwSqDcU+uTzrhmMW3we29x4Q0k2Vxb?=
 =?iso-8859-1?Q?rlL+7rp10JSmRt4hYHUjmQ6Kh/EZG+sKDGvYAwJ7r4PL0H1GQldyZKLIxJ?=
 =?iso-8859-1?Q?ZcTxJKp9Ca/TswCp3baMBA6C1LF1B1ZJgUFInyXncrZqwS27HCDuozPXQQ?=
 =?iso-8859-1?Q?I8ZEVUyuEHeWlh5QdmLH6Wjcj5pxbKpFm5DTvcd6TPeaaO9uuxJ3edsXoL?=
 =?iso-8859-1?Q?pGdyydFTVFC2z60d239rYmn10LZPElo9oYz2CuQGOtVMoUcCnEtfyQpbIs?=
 =?iso-8859-1?Q?jxgldwQPQTa16FH8hW3cynfWUyA/EaBHF2HN8SEY1xDQ7j77XRnW4kA7NB?=
 =?iso-8859-1?Q?SSk5Z4nMa6OIT5/W73kqwBSv7lGGmLSLbIy6VtPPlUGzItFdk7s3/4h7be?=
 =?iso-8859-1?Q?rMCt3F8IlPJJmDW59RbBfJaWgQox7my8TdWmCoWMryOo2UmU8ZBFL6zKDu?=
 =?iso-8859-1?Q?NfH55m7X0sSajhOFcFJaAH4Yi/lXaN3HLrHbNQfQq8fUrU+T6fmIPCT+cb?=
 =?iso-8859-1?Q?XzgMhqudt0JHjMvY28J46zKgLXDf9d4cz/Tslfi8lSyeN0+23U+FaWOBPn?=
 =?iso-8859-1?Q?DQawudFh02dshr9JBzrMN+/RM5Cu2itj37cOwM8NP1pPEtCyllrpaa1iCo?=
 =?iso-8859-1?Q?7CypDlXjcniN0CZoOmtT3XTHaanY6EqB3YDftYfXgJTyzAFupr3q9i+9hd?=
 =?iso-8859-1?Q?ICTMHz7RVTzEDLDu5ecSyuZAnsV8ObEZ7aJJPkOb+Bh8yZmJcMTdPZ/Pf4?=
 =?iso-8859-1?Q?pjvmCUIJXEaTZt1cvmTg1gVEO36pgXNxPCVTQ/3ZEgN7YQze1+i6BGPoap?=
 =?iso-8859-1?Q?KDoU9UHzfX5TnJes78lTw6q+1ftQrmcrJOqfdmQiAn646hRTv4GAqCXmaR?=
 =?iso-8859-1?Q?uLQDXnLlADjxQahY25kw9GBt1S83thqOfWfbTvBS7BAIBlsosgGhWLJlfn?=
 =?iso-8859-1?Q?U4aPgp67m+cfi+ZFt+8F6dRqVz38iQ76Csm61vDNUmEzFAN4ActyNro7v+?=
 =?iso-8859-1?Q?lwcp9FHXVDdSauXgFNoNvevR1nchN4DKLk9rCluTiY9JFSsgyMw/+OorMJ?=
 =?iso-8859-1?Q?VbE4snCgbZ5nkjafkhLrmMDHmVzwEEDleTI/mdoiA8UDIpySwgdNnXq22P?=
 =?iso-8859-1?Q?uFy28LCAv994/+kYlYK1aZBt0KbwX1lpQ5toNEV86XAJ8LDy//yPH7x9uG?=
 =?iso-8859-1?Q?+kl7i4zo5jAPcw8HcZ4BlGezKqfanZ1v246QNgjwu8L/egd6/pHC02dWAk?=
 =?iso-8859-1?Q?kNPrf4tWawOnvQRDxoZK1Vkh7fKj60QOLYUK/L9+bpSTcP9/hWzvuzYkFe?=
 =?iso-8859-1?Q?tW9Fck5t/XqdBrk2FSRqbdCv/gor+mXa0FRlz+XndBzi4RuLdFjP4/azi0?=
 =?iso-8859-1?Q?8XHF811MJQuoPdeAxbXyG6YvC2H9N2g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c229fe-4c51-4793-d50e-08da2d6b5e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:57.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UinNJTpgZxAqE1C1w9Td+oiggvBT1DOVOfcKJVeN4IBrrgkbcL4Lz5IvgvGc8y2BSZys72jXXVRnKy/TgY2zhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: BAGGUfPoUukYX6C4VzE-DRGCOsA5OYJz
X-Proofpoint-GUID: BAGGUfPoUukYX6C4VzE-DRGCOsA5OYJz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
