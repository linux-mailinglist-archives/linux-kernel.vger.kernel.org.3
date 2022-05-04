Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8865192CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiEDAaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244638AbiEDAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:30:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D218E28
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:26:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KsJW6018676;
        Wed, 4 May 2022 00:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=nNvq1G67dkMayRjWXetfV34oIYkJD2KF/2G3khY5CJwViDmipr+0vLPqcMlSCIHsu8St
 u3V9wqXuEVykWREh3cuGqf1ED4NtFU9f6G3phC169pUaUp0Eer90jojUfyKnxTyP20wq
 Ym39/Htu3jJ4zwUQqP0Se1k8WehnS5/3W/CnfwfK+bY2uGQwsetslpKaYOe81RQtpeUL
 q3SPjloOCOIavGgaL7M3CgFWC0xJghXAcZCp6TjvY5kIZFqRo6CLo0RaC8+JaT+8LlPS
 vwMJusfgtrwt4Ih1sPKMocNDYxQkY483q0osUXAa/OZX8MgkBweiNMESP0OiLFh8qMid Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt733e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:26:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2440FRZP031746;
        Wed, 4 May 2022 00:26:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmu7qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWD5nF1I6K2gcGZzsjDD9QXrzYgP4Sh99wMVTxPpwlA6z1HmwhfZ1/kwnpumNKie+7/LU0berp3havi964ra4u4Sv/DIr30Tyj1kmn9xDH6zGUl1/d2U0xCJ1kmMlXsiTxClnPrGiAj3Lkn6hSz/WkVrd9tC5n7Rnb057zyWeGyP5rGY4NywCQDbJb74dynvJCawRJph47tSS8iYvVE032vlXiONektXskjhdcHDH12T59QBCryAxH8ir1SKw71dq/D1jpExouP4vtdnSzVuo2xZ8DdCqi6xYFjWKSqYhDLh0MSrIwH8EHX/MZGotrcrAoOtQ5DUFm+qikvA9apPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=S6Fz6keQf5E0opDFJMYEhENicsCneTyybXJ1GOEK1uxg7ly+R1A2kjYp0OnChPgvZ/uz/yTH54QTdWtxKyTbkOEgpxKRyTRG6pg4LoYYVn4H/wJV0TVJdF9ZUyv2Da2lBHYlD+oN8y3Eo3xKnDjLXU0gjIJgxnCzMNN4PAwa1bNWH0a9JYpQPl1QUoxcB1hYZphE0s0hlhwBgx0eZ0nWaBEIPjLSWrtf90vW8TW1N+il2YJNVfNxdFNHuNm3J2KcGCA0x6mBAR9c4Z3AO45RGm/wY+34pVT7ZZtvtbVWAuieClGDhCZVXWkwn4H8dOu44h5BxxGxkIlLGMKH+KF2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=Uvjy3kI3HCvKUBRxkTrda0PMQcmaNXjbcx7+e6YorIPPZaZRvlSxMKmvKh+GycNmbnQTFaaCMa7WrWX6Lbia1dsOp1Oiuwz3fPdlvsNswXHNacxq0VOfKQ+8TbWk9G7y6tCRmOcS2KXU3MvggPSlQRkyIQ6/WZGD6gCpJnbZtNg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3081.namprd10.prod.outlook.com (2603:10b6:5:62::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 4 May
 2022 00:26:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:26:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/1] mips: rename mt_init to mips_mt_init
Thread-Topic: [PATCH 1/1] mips: rename mt_init to mips_mt_init
Thread-Index: AQHYX02XagZmmFBYlUCIETC2LE4BNg==
Date:   Wed, 4 May 2022 00:26:26 +0000
Message-ID: <20220504002554.654642-2-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504002554.654642-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3a02a32-211c-4c8a-7bb1-08da2d64ba04
x-ms-traffictypediagnostic: DM6PR10MB3081:EE_
x-microsoft-antispam-prvs: <DM6PR10MB30813004BB63EFBD66BB59CBFDC39@DM6PR10MB3081.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7Vjii1t59xNddnDJ3W8hufJR1VOq6BiB+uVKC0ukOmVL9eZ1ePl826ADPMoA6lXg2phMT7c0OARM0yO8fdI/SzOl8ZuAOnxjwB/WFoy/PDZYtpASmv32/x5JpzSy6wqha2kGuwZJejfm+yio1yxW0hdKEYTHLQWZcI8Gxpsju96oEvoe9EgSFjC1Recj5S1G9x4InaK2A+Oe1FU86tcCqOn+LKC+B22xdQqP0VFDXFUuYDJJBYS6FJwgGp6XttKmbWVY0VQQTFgD2LsC3jPaoru60uLCOEs8ThVy7s/AFeVHJR3NrcPt80Des8Ryy6D4cLA/lVhJlrOgXC0+Qq5unVRrNdhirz7T4T658pNG8vuk/ibnJT+RpKHZBY5RkPTZr2tSIj0dBQKtp00wCotnFsux9rFeScti1eDcB00OetbwuQarl/zko00SpHgmq409aHJOCDvsSdZ8iVvYuB4kr0ZPHKCJACUmG34ZzRyi6f0Mm8Goh1icZtCnu7moRAR/e1cBBT5i6BiHrpjxvGDX3YkRvhWO7/Stt50AF+Pv7EPkFLTa6FVESIOZBVwnP2k7etsTAfFNike2CyCuapD5ZNV3xvgsdqMLQ/DHBLFRgYSyZ8aVW5FGLsNsNgQnAuTH5eGOOIZitpUirmgLZPv6vU7gVLQ/5y76yBfppIgaFLP8DuFf+BOnTq3G2a/1rl/KAAiAc0FiztKXx5I0UMUvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(83380400001)(508600001)(66446008)(66946007)(66556008)(66476007)(8676002)(110136005)(71200400001)(76116006)(8936002)(44832011)(4744005)(316002)(5660300002)(64756008)(2616005)(186003)(1076003)(26005)(6512007)(6506007)(2906002)(86362001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tnliE9osGAhUlcNvX27XbbngsY5utv3vCqlkNPAjtl/+ywZ4X+YYYj2U64?=
 =?iso-8859-1?Q?BBI+nAAdqJSLwMXfklIWI5AVQ6z6HFdwPkDV5wBO7I31cMKpEbGyJt9c7E?=
 =?iso-8859-1?Q?0SRBEIpbery52FPwQfvaskdE6YBKHRVRMyVFHw5wAak1l/LotqVeTw1CW0?=
 =?iso-8859-1?Q?l1GTQ3S9630Z5v4hDQ7MG3femuA/nRpMKM/7PKF6FQEu2zDT2rwFQEqLxg?=
 =?iso-8859-1?Q?B/qDshbJpa3+/a8t72CITSVqdxDQPr+Voa6oZ/kkIwzOQiucemACXO1UsG?=
 =?iso-8859-1?Q?v4idQ+4iP++9dW22S9nPFiNw19z6zuWbEcAB4brJ+ZphhkB7djD/Mb+sVl?=
 =?iso-8859-1?Q?C0jswKcMJ+F1kajy02yVD35BJteg+rWXFtKYEGcj0E460DHRy43S5laB6H?=
 =?iso-8859-1?Q?+RzfhYZlouTCMC/nWG0FgMeBs0BCjJ51jgdh8U8QeQyjRDeav1Bih5g6y0?=
 =?iso-8859-1?Q?28QsjhxTmTjS/gVtuY8ZG0JcJInrvRlzzCv5vC+aMTmhW4+PUNj7LYAE/3?=
 =?iso-8859-1?Q?aLN8Guxr2JfYC/H9Z9S/JrmvV7dxyfIpNSd7/10pDU8q3Wvdg+hYHifslq?=
 =?iso-8859-1?Q?Vk6VbXUMYDGfYXC88KkGcFzbAGGlbq/cWv9Ry4COq30UC0NyFD7tRt8g4l?=
 =?iso-8859-1?Q?gQgLZYDSGZxpi0kNigECJXsN/f+IRYSbt8QKLdrgQIJ7M0oXNqg0n+W7VC?=
 =?iso-8859-1?Q?6OfX4KBKD41njnPEFoTog16Gs1GiZ8HHPQwUXEF7LBtzJLKhsplkTc/fqn?=
 =?iso-8859-1?Q?7C2+rwNzD+XCjuz4rlkJ7hockqa5SmKk6FsqbKccKPiuqUOpdLo518CJ8j?=
 =?iso-8859-1?Q?3tX+JIH4CZDPs13wiFUGfMxunzALNrrtjvwBvYBJCk+2jtYk85LrlKgAl9?=
 =?iso-8859-1?Q?g7DEOIZybvOf6wmmh2TAlMQHBguHjMvSq+lgGx8bbUwbfw5r9AeE8pMj28?=
 =?iso-8859-1?Q?Vlhe8gVaOcotGI4VfSI4+H3mN6gzH1ZqGzv9CAqKtCNg5IYRRCl9eHZUg/?=
 =?iso-8859-1?Q?mhYzF5uHCf/pHYXEeMFhgO2deRTsUYC7RNC2kXJxpyrNtNZZOCe1HYGg6T?=
 =?iso-8859-1?Q?WSu75kf9PM9m2golmiF4UqLvJoyO6NQYPgttMShdXqlm+SDbokeuM0ioDa?=
 =?iso-8859-1?Q?JQpICigNjGPriRiqBIh1O7MDhAYy7huJv7IULIpPBARH2+yqPl1dn1MYJq?=
 =?iso-8859-1?Q?VaxbO0KRwtymrxWPR/nmubH2vxqkGh+PeEX1eEn9TFIsbK6judnYImxqdH?=
 =?iso-8859-1?Q?B/A9HPGKX26IOkRu1vfFdpGq2XRxdqAINBvTQ3IuSpd4RnwREhepXZ8NVd?=
 =?iso-8859-1?Q?FCBCSqef8PR97HqAEPFTfHKnw5Lue/5XvShIfwaE6OIogwDZsvRehpM6/U?=
 =?iso-8859-1?Q?uGAZ8LZjLj4ejaQ7V2FDFNpJJpOoe8IWEPpN7Ij9pcsNQQEWcZVU/Cn61r?=
 =?iso-8859-1?Q?0Xw8Cju7OPZOWfn/d3mgxk13bLO4OWLxu8IUvUl0Yvmn3xMjSqRCXT0ugB?=
 =?iso-8859-1?Q?VXEwyqXSa6ETcuNJYrf6qtGXKBpKe9KnoEKwbrymzO6IydLJRJz84rpGYE?=
 =?iso-8859-1?Q?0hHx27LvXXsi+b1cGqR6yGLpJWHZXpt1do+Ziy9b0PsiBxr4zOWXH43WP0?=
 =?iso-8859-1?Q?qpwUFZiIfP5gE8yVrYqgBllWwkDdDJ3fs5g8Y7pc7ugaXuRMEBxqFnKnVX?=
 =?iso-8859-1?Q?0PkPOo3dh7q7ngzCereURKq0EBWVDrgqlZ2G3L5MX/3SJIaY1gTcyWbNNy?=
 =?iso-8859-1?Q?rNc+99RjIUtJRwucKEqNyOtJc85/yMGszMu7aH/mnD0IthedBGmyK4+AoC?=
 =?iso-8859-1?Q?8XyyVK/L0+vqnlxwVinMBb+Ws5LnISM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a02a32-211c-4c8a-7bb1-08da2d64ba04
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 00:26:26.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +270mVuxwDk1myJ65J+9h9wSRCN3X5Rc8qZoPGLk+4454GzN18qHrlvGKQW83LagGXFJdWz1QWQA03Vi8+/xGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040000
X-Proofpoint-ORIG-GUID: UuztD96C5fF1AlTU4I8ecxDUOKQ6VHOU
X-Proofpoint-GUID: UuztD96C5fF1AlTU4I8ecxDUOKQ6VHOU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move mt_init out of the way for the maple tree.  Use mips_mt prefix to
match the rest of the functions in the file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/mips/kernel/mips-mt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index d5f7362e8c24..dc023a979803 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -230,7 +230,7 @@ void mips_mt_set_cpuoptions(void)
=20
 struct class *mt_class;
=20
-static int __init mt_init(void)
+static int __init mips_mt_init(void)
 {
 	struct class *mtc;
=20
@@ -243,4 +243,4 @@ static int __init mt_init(void)
 	return 0;
 }
=20
-subsys_initcall(mt_init);
+subsys_initcall(mips_mt_init);
--=20
2.35.1
