Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FD59C237
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiHVPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiHVPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:06:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B13AE57
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkUsK022008;
        Mon, 22 Aug 2022 15:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IdcEVd19vLmghooy7OKciyfIeDDRrTvzJKwqb2rh6gs=;
 b=V1kzhRxI1M3FuXocWtvR65Ios6t5DCFHGgWJyv9iAY0eQfGJP+NU436TszztfhjnrNpj
 UowmeEfVprbXLqXHcWfsPEnhRthjfAW8Ug1puflUcPHV8no1/tfYwvil04yRoFpZ4Uj7
 4XUypHhGMWfq/rsiTxqKixQ1vZ3+UvrxAM2p5wSrnV+XluUzp0BZ42FXK1LqXpAAkwZW
 SF84D/ePTtLnbgMoV+4p95VFCAeMjNnclyC+L78AlnoF86JzYETQyp7rwkQ12vMznwHV
 7GqMyE9+MdwmRctuZd7qvI+xj2A6WmTLCFxV8r7MxYVjLCdTgFn6LEEqExqnl2kuhLE6 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4N92037781;
        Mon, 22 Aug 2022 15:05:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3by9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knxW83fK7KLWx/3geUMJS88ByOu3fee9hVRuChqP/E6+YhGEzk6+Uz6FxYPRPoZ56XpquMfpmggFsztV0qBpNGuNMMoikP0wDe0X5diqpI+Ra1ZrVZLzVdJj2+kkiE4kZLcfqMlaFfXbLyB8/Qz0gr5XKzPDEqOVp4oELiNByaQKxECzBP2lLwYsJg3cfadiKr+f+0cL+AV5dry3vC92oKScvwdbwOdy48UeioG90m7xUjilVOQlm/ZpCGNJzpru4pCMUanVM2iVouEMfajLxf3AWs5e4JSYUUSUJmy7lR2w1aMQNA8dnEd7YSDAjwFTNMgSXY8/w35VxBO5xBRyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdcEVd19vLmghooy7OKciyfIeDDRrTvzJKwqb2rh6gs=;
 b=Bljrl8ThRJRF4aGdVMDd6Tm+AcpjbJ1/94ZClGbhjKIi3X6F9jMZr6FZyId8hutpJlpcZXdODGT8cf6OD3DyuhohcRWPZhhAYKAmwrU57JCqwC1LB7iWVaWmbgkyK8z5vWoXs32cv+ojcPil1p/sstw/gGOFHdJ5Cthfh9+Ska2B92QCqPrklpKCDmsiekp7j9I2pQ/sZLfVf5kmabk0uv/YlExSrWCxo6PD2pLz9RG9ELGjStzde48UrNhGAvLPy1ReKhi9n9v80EZhJgDZjeHXseDNxx0ykcE96DuTgN2v9IIpp7xaXynJfiLvUm8ixT8VXv6B1m0XRv54J9HGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdcEVd19vLmghooy7OKciyfIeDDRrTvzJKwqb2rh6gs=;
 b=rf8XLwrnMjsJ9xBO7Tx5nEGZ9J+JI3RPdFsBR/C1AoKj88gqSeG6OxeGuKYIHxjeaDp++We0FfFiy+lWhOQ4Znr45jRFlYR0r6jGnkdY6t6RAO7zzBQHyWuolR8kJbPLIL8Juwt4duffofts9w8QJWMZLDUGFksp3kBlg0IcOhE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v13 31/70] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v13 31/70] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Thread-Index: AQHYtjibt7aS0JsmpEa5sUvJR98XKw==
Date:   Mon, 22 Aug 2022 15:05:25 +0000
Message-ID: <20220822150128.1562046-32-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5dae55d-993e-45d4-da9f-08da844fbe72
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XofXGyDvzQWR6kDpAdkt1RwGEGh1F2vqkgbWB0jLKYepKDl8VHifJT3e35+OsPjitDydX7AzftA0/jEsL4zSfnuILy9suE5/49suBEXjAJDx7lYzKiuSVEiYvWhUIH0qZb4Lh3HoKGz9DHwcvyDKZF0IMLZNRy7CJW+G5tsuS8ijcKutVTqHu6ZFzpgebdRgPy/Wn+51HVIRYyt7ioOMsE36JTAudqO1N5kUK36i7vIbcudVKiWD3CKKVY5KLZB79tmxDZAYoPeckVtXYpV3xCfpXioKaASyMp8Jl9syizouMyO/tPCu1xR9srisCSd0JBYLiYQT6OmY7q6yVJt9Z7R/Et0EFf5bsETpJD8LOe4gr9JU3R0nMTwmOwy8iVX8JGAPccSxlQlAkiC3o5TMq/MWg4ivJRd5UkaGN0YC6aHmBRaUNC0bUEk2Ia93tFvwuBp5H4KsoaSHL15BGPfGwS5HMnHYWS2iUB5wFRlrBZRtMsKkTThmFvH3Z5fR3CXCYzWQ1H5CeemKVhe9SXOY7U3obLsBgSx8U1Y2cUvMhDabvktjWmspfPXCwIyN/3SLgCHHTxrktQ1Qq86aCN8gLUADeVBxXOphy5Y9VnOuhAFSVEZU6MaRBUZbEepWNrjfPSKEkGwDXN5QXcSyPXiR9fiwgB8YS5+c0PhfFYv2X+QFOBrDSBTk+rKZFMJ2QhJ0x6qFEiycaW6aPq+/Da4TnVsZjY1KjOxQEHYdGQe4I4wWi5CQysnuPCEcboPjKbvpRCNRHML5HZbHFGaR4z/NCTIjF9dNIvlix+xrLN+RC3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(966005)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jE+uvMYdQaV0W1f3takkgsrjDa/WxnWTDCoDvh4AWwUqmRBzXJNNqLWCBY?=
 =?iso-8859-1?Q?8wvlsouy4jZBKzNyFjP4rfK2sReb4RRj9qrDiC2WxPX9mU+61LT1xZUx/U?=
 =?iso-8859-1?Q?8QPdY/5dWT6hI6diwYvLZUUnwZMkEvlHMt94UJingSTA9qJDgehLpGyk/v?=
 =?iso-8859-1?Q?2IRAeLCbNACw3Bppk3Aujwotd4vFGzjRq3wntEOyOKxgL7DXW+Zq2Qf2xR?=
 =?iso-8859-1?Q?hoxcJapLWQbZppNWGPk6y16jLItJe8VvgpJWPKa2JXQWyAyJlfVp0t44Bg?=
 =?iso-8859-1?Q?Ge/Z5jRFgVGmOFfWW2h+dBg/xqpMQ55HeabN6wQ5ZiQkqRigMKaxmFpchu?=
 =?iso-8859-1?Q?4d6wsQQDGFECIFjIg29BkjtBoZy85/qzDKnXm+5caGwL/dvLBHqqylSObd?=
 =?iso-8859-1?Q?5hA48+HFmzHCQ1W6UWv9TwmjGJ57EZ07DRZB2YvcJ77f7PL/sSHKcK2hnG?=
 =?iso-8859-1?Q?YJuIMt+b9cytdemk4S4f/RI+uex34ryFhT7VR2dSiHTnWmXV8u85wLq0DY?=
 =?iso-8859-1?Q?YQCufWiOACcZF8A1H92QvX5JQjr3eVe8pnejGPvJhUw29zC8bQIbDtRW+f?=
 =?iso-8859-1?Q?BCuBt7vj8acGeYnFByNOnuHYu6FXd6+kLRvoObxHt25j5CK6okY0FZwzOp?=
 =?iso-8859-1?Q?7Sy3zVDdBIu3nu7XuE7rDp8UKXNCGpAr38VlN5zgR2SXVtpIv7tBlm0Av1?=
 =?iso-8859-1?Q?hhKaCoYv3hOl+WcfAoeM9Qaj5BA1GHul6tnV9+MLaT+GMq0sVZhusQcqY4?=
 =?iso-8859-1?Q?lXVpW1SRO0V5R6DCgLnVd1BIKH7is1iK9qbIOesutXQxVmRgIeyY0TVSix?=
 =?iso-8859-1?Q?v9fVlfp4XRxY5x/vqzOCDaEpkiFOS40fjYKixb6EKjzv4hfHYaXIhEMtz1?=
 =?iso-8859-1?Q?zBjYZRLCQ/XlAaAzLD7e+gBiGZmOdZyN/VLHZ5KWtot4LjH/8P0sgGDs8d?=
 =?iso-8859-1?Q?NoeIbs7PUvBnIL8s40csu5UXN26yslHfHhTQiPmgIpfktROlWcsS53WSrT?=
 =?iso-8859-1?Q?qdqIjxFOV3R5PADYTwilxm/M1+cy60jlpq+hS3397NXl5XaRDLluQA2NCL?=
 =?iso-8859-1?Q?Em6FGcPV0/KIkhUMWOqFBvUn3EXo+Dw3qUubsEWwxQWoJ4K7f/Pc06WvxJ?=
 =?iso-8859-1?Q?5JRl8emMCLz6hFJXDv30I969nIAdKIm2ejOLri5yaIs22UqCfUztlZGQNl?=
 =?iso-8859-1?Q?JSkq6mFlDL+4MUAt1T5h/e7Zc4IFYma6hr7DHIl6+MEKmAvyjOJKRZ+1q3?=
 =?iso-8859-1?Q?LtxJ5XqGV8Dqk5nnxj4Tsh81ToN1z51F5pAa248Z1Jmj6DTtQfmIHFtHAf?=
 =?iso-8859-1?Q?iEeSMRoha/Wm482Fih6v7F0HOxPMVFZcIPzAOFaXPMc2NDdBaK/pRh3Z6e?=
 =?iso-8859-1?Q?G+m97FhEmeop8mCI8/MS8WvfmjsPcBiNh8KOO8J+9sT534dOgJNG0A33Wn?=
 =?iso-8859-1?Q?58Ve0xGeFRpEHI0+ScNslCe3PJlAImiffN+fLVJ8XBkwlaSbhTMNT0b2dz?=
 =?iso-8859-1?Q?QNFW2dfanMUSWQfD848PNREpLrtzZQ4wGLOIhXC3uLEmQ9hF/AJsTEpwZU?=
 =?iso-8859-1?Q?vKHlSrJXufFWGivZdoEIIEyez/hQFZpJaKJWQdqeMcEvwn4tUIFbTwvwUL?=
 =?iso-8859-1?Q?WjEmS6ZUT4dOyqYX21X3oJq6IRK9FlwbLTsJ90vFlmaSdSBF+S6ExbmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dae55d-993e-45d4-da9f-08da844fbe72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:25.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bP5siL5t767bfJbN7y6bpjsCPuqnvg7x3T/hof7BPQFkepkHuSGMt/wd6uEX7Fo31Q12raEpBTR3LYlXpju0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=863 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-GUID: I1clnSbX7pTuGihIlp7BHqGzMEoD6Gkk
X-Proofpoint-ORIG-GUID: I1clnSbX7pTuGihIlp7BHqGzMEoD6Gkk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Rework for_each_mte_vma() to use a VMA iterator instead of an explicit
linked-list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20220218023650.672072-1-Liam.Howlett@oracle=
.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 98d67444a5b6..27ef7ad3ffd2 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -81,8 +81,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -91,8 +92,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_AARCH64_MEMTAG_MTE;
@@ -116,8 +118,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -126,8 +129,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.35.1
