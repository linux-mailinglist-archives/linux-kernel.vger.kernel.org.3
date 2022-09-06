Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAB5AF4F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIFTvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIFTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767F474CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcraR007596;
        Tue, 6 Sep 2022 19:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wTx8LJLamzU+dh72t0zjH65UWhRbrPaGmvJGGb/H5FI=;
 b=u/XCgwMdfUJUIUF/04VtLhrAVSkmjVHVSxvS8cIuJYB16cYF9dkzUt0FxcdJ/KQXfvDT
 4wf5mcxMjHzMGt2tV7aGPN9lurnDloE6QZ8nbJXkOKErD32yKTJIRSae8/yXXD+HGkjD
 Knf8nWax1MPptZeAoC/EnEwAVfT6A1UWssbgZ+kSWM6Jz6D+dteupE4kZhXt1ey2ScTz
 FChPDasn8wegPV/L5GvettsAwd6P6oU0x+tbgTomGVeBLUm2CdEKfEwRW1MRB9g7uwe+
 Pr6DawQwDV4on2nJW02AvYnBKEH7arKE+bqbVoD5RepH8QIUS22VT9ZK1MDFT8wYlbTf gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6up3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JRFHK023652;
        Tue, 6 Sep 2022 19:49:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9krq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvNySlx8Wnamb18Lw+eqEFFVKoW7Q/k4q6DZDGkDLhvPNmDo9ist4kk19b7DjCgUMqqz8zs4uTDFZ+dLimV0+F7MsIZ2WHz3HfXAMb1NilSE+ciU9aAGdfyoqfP6gR4K0G03POfFjMIcu0GsZpPUcNZiAdH2xvP0Rmn8uuZAJKn7y9G/1BF8SE+FEnmONBjrYhPMhpF2/h6Yx0Hn9mcL3yIhzZJZ0ATsS5/XdkpKEFM4FZKqL1abGHWOot+ttmzAmDIrd0k5R+6rdXVgs5YxOsRvxQeiJfprgtE3HZWL1znsGmQomL9R8//XOWnaDNDmOolgMJ9uKmLD/XwJwnoaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTx8LJLamzU+dh72t0zjH65UWhRbrPaGmvJGGb/H5FI=;
 b=TZ6QEjQ+ioA5A5MuikgsMJ2bxV9hEQGbSGBF77sif4GL0dZrnL4qkXua5+YQDKE0FYV2umK+3Lhw1EQKR/Bef5RqaS/U7zRM1QaX/HQ1220c0cvdVSCtJNLaMx6i9chsWKj8oecUDtGca7UcVB1o31YU8/3Z7CHGTbnMwZ8ZRhbab07fdytS1kqXjfDmD+Y9K2gVBiS+PtJMY7CMdz0y8ablEvMR8hPKofMW4xPiOEWCkM9p4Gov5ByzOQotJnIFU8pqKA+m3uDW/GUczkRZvuanbVIEYtJ4rsFxAN06tOHoVDZ0zLRjrLSPOQwhfQ/R4AubHz01pAuEoMeiHYppfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTx8LJLamzU+dh72t0zjH65UWhRbrPaGmvJGGb/H5FI=;
 b=drnn8/1CNb0vWmVya2Yxw/6J4zUeu5hBgH2u6JXzijcE8Ui5Job2rctzy8rmGgHLidh7sFV6AlPLG4TiSuxHTn7zJukIVGXFKNeBkGAXy8uQG5fpTV+XXDp+luhcqAEuY1DDQXbaWLmTNTFHoaTvtO9kLZPsWCqZA2PJ5ImMhz0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 30/70] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v14 30/70] arm64: remove mmap linked list from vdso
Thread-Index: AQHYwimxZQ58bq4M4U+BCmLn06Tx3w==
Date:   Tue, 6 Sep 2022 19:48:53 +0000
Message-ID: <20220906194824.2110408-31-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4e426b-297a-4608-6160-08da9040eb09
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZIz4F4TbHiV8/9LW4PpoKpcnqYAEgouJaHLPX/F2Sv/Rr7ez2ZrmrzMCg1WOBmUr0Wi9Zbr6n1QGMYpxNWRslsU8y/h/fj4wtRFRW1uAxwLQUczb/j/TPFzS89MpRj6Vm5FfPilJpYyST6o9T2YQZoLfAmVyWEckzfy+ZQF0xikIKMH2k1EFIXk+lAILEJ1Z162eAzmuACZ3lQd0R5JrRtIFl231YcBfVktbzRL9aqFWiN+5AepYQcmJetINkuO8wyHMB+kSaQ9PSOp5EmiezlCosPo73ZPQ7hLHpgwz90RFmGJXxPC9Sc5l2mxX/Ipfwjl5f4G1FVVBtj8/on3zUK4W6FQx4wmwjFbGHIy5JZv4lVFUays2A5A8wpcyTPBOv7ColaSl5qnU7PkMf0lpXMvPBZ6tvOAjevBQg7ESTJDFyj4bE8RSsZjzaOiRpmuey6f1JisWBD7XyKcMm6olnJhdy3pL+igx032gY8zta0vN5YYpg0epD+q+iUzNdQX2KgtOfHOXXYF03nAELrs3j1gQCYum1vxYViwwPb2YJgA+D+OuNXd76SqpXRKoDujQhNcrRWA3KDXwCZUfh5k8umqJNJIwiLaJd4JsEyJ/YekAxuJqtbcVOxQbkXue3fFvJ5C6ysEi4C02TNXTVADis1WptBtu7+XEL+vqoDsNN2CHggGxdT0E+xP4OAvshxxCyCjPNu9XCRW5n3MGj0wwUvdqO1NQTRJr2IpuRhuhyFdJ194HRmXc/XHzLoUN0mihYjTH72p27oKqQ3p31cZ8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F0DCynnDppkPB7AsDZyQJpHt4YseYFK5SPBDuTlz4diSHAicyJNFBTw1k6?=
 =?iso-8859-1?Q?AEtAVjRj0rpOzEUkaNUciFgHDrsougQMxSbpG9maMsIjJnHNQ9LmHZzDla?=
 =?iso-8859-1?Q?2xPSrz1AiwDpnuOQi9O3fz8XfsR3GWJHAR3mYwXe4CqaNdC5wExQeQmneo?=
 =?iso-8859-1?Q?9BP74tqFAaZ/7tRuRyx5foQS+21o7YX2lzVUy1LlbqVcGn4tNj4KosHApj?=
 =?iso-8859-1?Q?6fWvYPZDCi2Rg7AFwEHN6XCv2Ux2o1XysKsECSM6J0lNWPeEKB0Ug4xGLr?=
 =?iso-8859-1?Q?SMtT5WLDlFZir76Nspl1RHJSDs7RrCElb2/H+ka6epeaI4QJWXIDwgrEsf?=
 =?iso-8859-1?Q?wWBJF1m98FQB1YUbBjKw1z5/o8xDVvMw5VAKX1c1ArLBKhG8+LCl8ZmvLb?=
 =?iso-8859-1?Q?z9zZqHsOFsBsRhMpWOsW4EH+fsKA085jGMakC629Jkw+/szLqTfAtD4tNu?=
 =?iso-8859-1?Q?MzVV0UNqFAa9+uhiD3E+EUTeMfzt0j2eL+zIfom700eh6uzKbFkUbO3DjQ?=
 =?iso-8859-1?Q?xmyz3HDLYia5ML3gYYkyPYCB41abgH3ccW4kOwLs8dBDonTf2ZOnvWSOJ2?=
 =?iso-8859-1?Q?6vaIIWUCHZJnDY3d0/Fqr4ziRdxUbmnmwV3toI8bkIYrIqL1JXa/WVm8/F?=
 =?iso-8859-1?Q?p6cItcAw89PWSCaExCp7tr1MGmL5ndPl5JNdiYaMsGTGlro1Lp6uHtTO6P?=
 =?iso-8859-1?Q?iJVdHHqv+ARTl0xdefVu8y8wuEY7p72ytr3BMk0S89i+kkia3o0xlvJ1Eh?=
 =?iso-8859-1?Q?ArZyhRs33HguKhIUJiS/+mpbaq9Ye2GB9Nvecng8O1Suz2rn6S1vzK0R7s?=
 =?iso-8859-1?Q?hysgk2np6tvZb67csEbeW7V1Tm4zUvBHBEokUwCxgOfx4+g5+/hVxrneWM?=
 =?iso-8859-1?Q?lWybLj3lOHVhHJKd8lcNrpkklnURkZKRaVApObLEHZwW/miijlw4AKbshY?=
 =?iso-8859-1?Q?brYHSEg7xxuoAlfBCvwgmhQKLUtp9soDsEjoSCRuCgjVQK9xUDL6x8elTh?=
 =?iso-8859-1?Q?gLM43VXjyi+1Bhu8LCsxbLl3I842YdQMnkUVB5z6EcWaDTOaPHEg9oBO1C?=
 =?iso-8859-1?Q?AsjczWgEKfDgaaRm2iqODodywF4+ue6vjM0aFZagJY7oJM/+HaQVXtF7Hs?=
 =?iso-8859-1?Q?ltv+S8rEkV0yRrqXcOdnxWfyneRGJphzJLKLtavrd7t+8rlqOxWD0f32PD?=
 =?iso-8859-1?Q?bHtgJWI5B7srGoq4VRrGIyqqgF9qopn/oVzDuHrHf1Fd5N/PBHdanzZTiN?=
 =?iso-8859-1?Q?hbVRK9/P2XDFtQ0zJCF9HJ2jf0GuUGP1t3FzuLEWDMjvSLmE7M1xJKRNqT?=
 =?iso-8859-1?Q?GHpAJ504F1dZEDMEsf+vXsBa1N/1PSmCkCNQsx2BxmsAHPKCHETRNDcW5O?=
 =?iso-8859-1?Q?ciLByu7doaUqCT9BGyRaClbkbpe8tpkTOiY+gve4w0Fwk4ndNmDpQuhQLG?=
 =?iso-8859-1?Q?OvikHiNQ64OOfvlQPowngba1oZtrsBYQlKoVMko+Fdo92m0cHGn61NiLov?=
 =?iso-8859-1?Q?x9UcDZKbUVYrsf/mcCiMnDRODVi8c8eccbuxSLtmQfOjHsl13FdrDbeb3+?=
 =?iso-8859-1?Q?SaspBlRVzzLoUs3JdkZaEU+JoBC97+eIe43tPAKdC7X7CWLnQjFiLwgW0E?=
 =?iso-8859-1?Q?Oh9EdkFDm6ZTHU1X4iYR+KZD0YeYIJGfn6lsjdhefIxpLKHqvGc7MyZw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4e426b-297a-4608-6160-08da9040eb09
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:53.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YP0eIxWZq3pS92Qnw0D6E0Cp4KAFU6/UIaMvpA/Siyvb+GSmgLuqTl/ynP1eBcl5kMCX7lyQfk2pO3Zr/zKmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: FIhQfG20V15tYGN2okM7lIiGe2u9U4Pj
X-Proofpoint-GUID: FIhQfG20V15tYGN2okM7lIiGe2u9U4Pj
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
