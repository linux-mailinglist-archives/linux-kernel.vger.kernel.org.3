Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E951016A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352210AbiDZPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352101AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098015A433
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2bO015530;
        Tue, 26 Apr 2022 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=vcCa6KObaHiHfhNQ5qvHb0q7M3FNw3VXKuBySzqp+PJdgZ4xGtYsu+IZTvVp/LGp5oUa
 WI35TIOcR6h9IICbJi00oYpWbKK8vS46X1Qhu2ywAWp1kXzK51AzmSwRnaV3UfSMUgaW
 E3EPzi/jTDyCWbAVp6UJhkeMO6K4ZIjiDfC+XBJ2DcvndgP6orVIaW9WnRMpy3HdUShO
 gNAOYYx5s0pUWNxgc6Lr2Q+OMciXrLHBrzJ9YW6JA6Ys+LQQGjtafZmUNyu2niaWbvd8
 ugSAWxCWeWw6WsM9Fan1zOYI3fWkoImDRQTwkVX/QG3Rn1FHNvBXJsNxaSro5k/NIuX1 hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64We012598;
        Tue, 26 Apr 2022 15:07:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grd1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m159dbTutuVb/kIl3/oLzc28DjA5nQQyWwLEXl9ih4W7wxxWoOvigBHBobsVCzHi22JZeS1bJOK/PkjP3X387l0NaAQGxWa8AXPbuDkNF/VB+1dVkaonj8sGySWbO+8NQXzKVCYatphZbMpSjd+aUcHnC/HrlHPv/E0EP1/xKYutPSQOffsbZ5aG5xxxrt85p44TsvjBXWYUVIfoFV7SzGBfOfeTLyCH3SAvoVOKzh4BMOE/6RWL8agDGsS4hsF55RaypfQE47t704ip5Li2PUkBM4KibOlfUiNb+i1MAsTeZgRykEmEIxDJ3WqIRhMFsGbJcednhxLxaVr9SCA7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=NkiZSovKzui7LEaxL/LEfUz5ZsjdCFR8ZlmPVUpbmOEJe1bXQ7zQr6HvLpYwqvrF6o2p31HpBMAHay9D11akPH2n0VZuxAcM5h0lyvJCCFBQanER61Z72wClQjovGuoWqKVTV9xPzc8X81s9l1M4jDR2Qf0navWDrfBq+4Y1IdapiuMD7lrF2lbLoTYBt/yNBoEOHU7eZPz344hOg972NteitHvR94IHK4KjN+gnBmfPoodzpnp4duMpekxhjHv9qkyNWXzXUh7QF2lfSP4cwCqBh1mMIUBO4J7vOgH7HsY+eJJUXKEtXPnOJaYSvyzI7di62RHqU39ZvuMzG3H3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=P+KEq2bzvClYpBrqqd93QHVjJ1W86JxPBcqxnJ/6eNpQVTE/HQdljaexVQMeZeRdBqG+HSARt3ONZgnZl4DCHNzysVPUqvAYoXbviktHa30rDMbylKGJvw+ZhmgmvkHGCNyPjRfWeV49mHYGqQqxgdjPvPrmP2SlYi4fPFrH0WA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 32/70] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v8 32/70] arm64: Change elfcore for_each_mte_vma() to use
 VMA iterator
Thread-Index: AQHYWX86XSBUg/VvGEWqPjE2/UIXcw==
Date:   Tue, 26 Apr 2022 15:06:39 +0000
Message-ID: <20220426150616.3937571-33-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e362849d-1e69-4414-d761-08da279670da
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29298CE4D178B53EAC04A510FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIiD3A8eyHvUiga9nZESPqX7a412RNkkD4n9+77smypdm384YUAEs4I0IGng2ZrM/QXgvtnpkLOFaupgjgicoYPFgv2/w8fpv70CMnzJncLR34/1sIgn8pRwG65D4ZU5YlLU6cyYEbEaiH7ip83NbM+z7VgVsFvEDHgxUAyPre9p47z2j7iNw5Kl3DmVOgDudQMPo8JRcAlbOgObjyYNoQqwDVBXfB3YWJZh8OhrFBK2dQ6KAxoasNNXI23TtuKyGQkNENBYGTiue0wU6p1++o+/1wg3lWLtSDYYKRD+Q4yvNnt8uJgPSEFbKwxQikFMy+lln+JGKEZO2TARO/URMgtyRbViOTehqH6zBXZApvImtuyoBBOxrXpBg6a6aiGVFXL0vfZRntCuL4ihovGk3kaQ/iBz5PT+UTSyxjdyDQxNjYAgpNS6Ng2USoV3oFYcV7Z/KFeuPFeTB2YakUTm9uLBlpEgxXdD4t9qgto2tXoUZVghGORYgm7oP0NzwnNvoUBFDwUiKYMYY9kSxvQZ4Ct3PKm0DNSq7KhXvnf1SyKhOBMpHtaDtJcckv77lKgrewu+q0WZDlT1zrVHkrdzuizHQRtq6yV9IeTxtXBU+CMo+rOwgOZaDr296sTvmb0tXwK6j2gfAQeDefmyWQACETlriJVbfebzAODdfG5BgyWMBZXpzuTKRrNwf1XEtsvLBwxgqJsKYWcIVbmjgScLIgNlntMk8ZJzakNhow7O2dmNEn4EW82gudXY5it4wa7vllXIyZkQOT1alRjc+Xi3OukVWvP0OSi3yO+1Quc2sUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(966005)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AkR2wyfzkDh8J2yy+kyRZe1KSlAVG54sQcyytXAHXzKEOzmSUKq8wtJDvV?=
 =?iso-8859-1?Q?+YJfkKSNqvVmVIhmKeCilAc1PTUOFqILEUjgoAYwJmjg51tEC/VxB1WCTc?=
 =?iso-8859-1?Q?P2db7BRlauruBbrcAQeX2eIBMQBAt/MO0d5+n0lO918lry4nDG/NCDZzjT?=
 =?iso-8859-1?Q?YN8MbZXhdv2jdiBVJA9mvd/VlNgo34fGjzZIFNBCRiwt8U4LdQk5U9rfAi?=
 =?iso-8859-1?Q?YH2SpA7wzjxN9ZceU0tEVRfIzRTMjZ1hLOWAAwPC1X789NqNtqqZCiE+zR?=
 =?iso-8859-1?Q?dRfqRcB4AS0uv7rV8RR6B7VaN+l/aU3OCajLee116lJ4e/mnytKIn3jjDr?=
 =?iso-8859-1?Q?l5q/ft1+SRmgnc3hfvJs/jFIT5QAZjaBaJGLxB3fQtV7qEu5VVSGVu4sJv?=
 =?iso-8859-1?Q?W80psoyklFr9owWsWFwTnRuotYdyvWU21SFXbKyXHccU6KQtIsinvcMCIG?=
 =?iso-8859-1?Q?G1GPlDMiUuEQeHzaSBGI10iMjmpOOE6FlKGU5IZdST9jhprSRPBKRbkPa7?=
 =?iso-8859-1?Q?MmX3lfMbIkUFAzR8Y01upsmExgy8cqA7ii/SHxgd3Bagr+jbOOgquGvccd?=
 =?iso-8859-1?Q?bXaqgJCYjEoz/UeCe8R2ZvQCc30K4LDuTMlwbBMC0WU5BlndG/WIOAZTGb?=
 =?iso-8859-1?Q?y8fwaA4+2Es9/nxGwmd6Lbb7Oq95YYekN5zshN4UdrExpkWqBvFosEGxES?=
 =?iso-8859-1?Q?dV47Kx1XYnWfHbL7m4XF6yPZg7nMp2jF/7iW44R4N0J60DLrZe089vbGtl?=
 =?iso-8859-1?Q?xdMVxRgHPeWeVaKnU5UOlsOYV72G4nVFzfTMRSR5mXgeIp04eh54Bg/LUx?=
 =?iso-8859-1?Q?zpbAaQxE3yOs1FFwDvgQioEpCDSOvGVS99xOo7PrbJKXnQYv+5i9ycZWco?=
 =?iso-8859-1?Q?WIDJzZoDkGyyBr5Cg5e7hbohylosBrjvKUUUGJnvEUz1PItH48sg8A9CWe?=
 =?iso-8859-1?Q?tqiZc83vsFX+qE762MKwBoqbF6iwTZj38ObCSye/NtU9cbIYRfA2ZD1Vm4?=
 =?iso-8859-1?Q?c7IJ8UBKsBhKYoBKu2h/+fUKZ/ORLmCbC/otn6cGI32jLdoeZ7/pGsLprQ?=
 =?iso-8859-1?Q?Jgjzgrl1ZPkzgUytjnpkWqlaqYBjczd8BBTHAA61aHg2bLLWNx7M1MOLwK?=
 =?iso-8859-1?Q?xKmDN+0XptMYgYyP1BxnI+5Ma0s0cG+VfOpI9hS6p3whhjpgZn7cIqKOTA?=
 =?iso-8859-1?Q?9nfphaz8+g3/9worZiNK8plTNyYgPs6dSWoXJYQbbMzoHnbADMPKL94284?=
 =?iso-8859-1?Q?g04yv24VdYtupy30wGp7TssE9VvdJTQHmRvjJJmwTP0xLCKtSo7I7pMtOJ?=
 =?iso-8859-1?Q?jad+ZzPF0W1vzrgBxnYQIyg0SgkqU57gzF2ZRt395ytpfQCqwUGYJF3sC1?=
 =?iso-8859-1?Q?YgOfP3aDIhrQcrZIfnIhCzec8g7YvNckwSET+Tnv6trcncNxMU6rNsVZWZ?=
 =?iso-8859-1?Q?sM7nMDaPqchlMeFWURtPSi3q21gSlpON7bdUXLC775L2W9vEOuAm0cOTlM?=
 =?iso-8859-1?Q?EjbkA0Z64gRsZA5/wWRZ8SdHuBcVc+uB9LEIjbQcByLCkByuBxlPrx1tK1?=
 =?iso-8859-1?Q?EaVHvRAfyNW3GXaxKiogK9DMjwCkXtymGzU0ewNZJd2aJZqngOxxxwzgir?=
 =?iso-8859-1?Q?mOv4ycUgeeIAwiYMa0N7jba2U8K7fXI/P9ntM/TzAJUnbUYrRoW8GD1U2U?=
 =?iso-8859-1?Q?8C4YS4JVdM4aBaiSz1xhWRhIcVAdfMe7UxksR9HjHOQriWidw5sb4B6XME?=
 =?iso-8859-1?Q?KdrZa2NhGgQC4u/9PulvR8wTgStqUakRCrS2k9bUYMQ5atl+oZ6+RGGXzN?=
 =?iso-8859-1?Q?Svs01e9GNJ0ZDRBy0o0I8MsrFhWo9n4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e362849d-1e69-4414-d761-08da279670da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:39.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XatjvYmKsaAJC2A5bbSbigSxsDHIurjkdeBl+3o5NjBsbXEoaruWCmehdt5tIsjGsNRBoYDNSZV03ljGqYilXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=924
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: CYPajHNHC608yV74b7w8WdsCqzGMnAv-
X-Proofpoint-GUID: CYPajHNHC608yV74b7w8WdsCqzGMnAv-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 2b3f3d0544b9..e66ab0f09256 100644
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
 		phdr.p_type =3D PT_ARM_MEMTAG_MTE;
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
