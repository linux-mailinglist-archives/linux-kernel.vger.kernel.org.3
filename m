Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1225AF4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIFTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIFTt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA474CA18
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id941019957;
        Tue, 6 Sep 2022 19:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UyIhaJU7K1ZeV3aBjcOvHjWnqpvOanZIFSCjREPW6Ds=;
 b=1jQr95HiR6XG/cVlq5vzRai1BGOK3ECvpJo0n7ngeSi91U13JaE6GBZjaiOE6a5AG7u6
 JIT8a3k9H4+T7Eufc38J4A4L57J4vmkTfZUKfrqsbLRZ/PVx5e26m0Bq5MUJZbhlU9Ly
 uhT1hFMC8w+fCKsp4V+uQobL6+782SzjKjIyUSHi5QPhX3DhNgHsTLs4rjVX0a6Nkmbb
 V5O6USKGJOORvP1vIG4Rb4RCuAhv4XJens8a5vrWOCh90uVtQC3MmMH0bXnGNkoeqlO7
 Z1ZlvEl+DBrSNu2tCzJNQessQXmqqmPCbzVsVgUZnWAO9nAObFYMyNgYAKu5xUk9fPyA jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JLGjn039722;
        Tue, 6 Sep 2022 19:49:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7h2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwSCyaKrRVgIaLrY661MToJlEpiqztbVMEkdqNoqc85rfhcAK/w+u4AX9pg8xdvOMDb8P+XEBYa+ref4GcxpvrbeNNjafF77W2zCz4MSVDkO8mCzTXt7o94s36K6tM8AgbM6JsLW+NB3Er3VN264sHhiCkNEDZmJgyWStuH54bOO7KcEdtTZQ96qA8v7ob2SyLcYM6X9iMFLHnYLSJiW1xlINL6h2cGYr917gUlLgRNauwwdIheiFQW2e17YH/mk7aVQe4EBPQIZlLswkI8kG40+8O8eWbx4GW62Ivr8E3Vfaxxr/Jt5qlR3NLatY0myBpDHucyw0ev4r5fxF1TMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyIhaJU7K1ZeV3aBjcOvHjWnqpvOanZIFSCjREPW6Ds=;
 b=j1XGQGnvAOzvELTgQU8i6ZBAuddYEAfwywdfFMRCOl68E6EodEYsbyO9HbZ0jIeK3sc455Cm+EiXftZMzDSXUBTvfpxzTtSth9is88yEC/EKNW3azZLM0v9NjNT5iNcMKg/mDRSSNbo79uwIkl/nPoh91V6zUQfkV2HBAfM8P8llai61qtiQMxaJCmXVr+Cf1g7rpbQv7uzkUpuyvkBPwZSNHwXGjQsnYjATpE8foOgjTL5pPUV5sKc5kpGoVAb5Qsj6QfWghLa0QI2Xj87CawZPEqaDx1CTPFDQIh8li/PZQc2yX9Vn592AWTiUr8FJLsoBQPyULw6fbQYGLxc82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyIhaJU7K1ZeV3aBjcOvHjWnqpvOanZIFSCjREPW6Ds=;
 b=TOshUYyic57ODBEQ32uW+Gme9xwY7wyaMRo6igLUg/p8ID5ZecetaPUeElSfFBKSb2cXWrcke/0w3QgoQtzOIy2viKLbuUNx4LbCVGXJvmxGg9kPGLeVMgsrHg4H9Ex93CN6A1t+4hfe5g9LRXQ/qDjZJjIbtolXftoOsjmiByM=
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
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 31/70] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v14 31/70] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Thread-Index: AQHYwimxivnP7afeDkuibXPS2bHt6Q==
Date:   Tue, 6 Sep 2022 19:48:53 +0000
Message-ID: <20220906194824.2110408-32-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06a2d358-7699-4bc3-48fe-08da9040eb53
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYZPb1E3Hy2kVniRRc3/2A/YYYt+P4pspzXUgBHLUiXh0w2OlBIrBx03frWW+Y8oCfFtCe1oQmGeKmrRUefHC+85mjx7Z9zIty8vUX2tIb+kv3f9uOgLVtpWLv0MEPIpu3sIev5PGwQxPdpE7Ar4HkS0KLuYG1iJ6PP6ecLYbI5AnnEGDWpK2qVDfQ88k0a8qd1JGSQIFBTH/l0Hny58vDOZCRFEvR4+jDkE0Pie8XtPODy0NJ4ZNDfZcPz24FdazEM43BZOKC8YiFkGe38mS3C30BGIZ58ojrIppcjud1vDPiEjn+9Vbw5Ik7M0CQOr+IJ+eAA656sWnwuoR0AIg0nf9ao9B6JW9nZ/tmmzqjO14LI2wBRXQfOUe7xxRjlaCjrADEZ0dJpqMtECaORORJxO8csbOqhTQa2GPrqYlAK05FzVnXf1/ogjaEDVlvVEWSERBbZyR+/JBrnNDBgfqHZ9S7k7iWqPZBY+FSTftczT+ACZcmzCFOkEKbtf8MiC8yanWYhzuoBtCK+fRR0jTeoeEe1Jj8oeRi+CMx+UnVHoCFGU5NkJVnAFJJLbhv0iV6e1V2Iy0o8zKVwexEyTgFaF4fxnuWkIN6eOUxQcvqwjp414iYDuHQIoUY31tfnbed2mF1LK+/N4IkPKbH5E5lG1misEfkuUg58FHy+2VWUJnwFQJ4H2CO+UjC57RIYDGQmtak4s57T32wUsOPQ8Bab1BEMW02XRakNeiEEQIH9mg0f7BZ/8zb4MWaiYDDsxpfv/HxZ0Y8sFA5RNZwVl9tvtFZ8agx3f7mRsGSAh/b4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(966005)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3c/rK0PjkRldLyr64anh0HG4kwzpsNojNrrM8CDupUQ9WgtomrJZBlox4I?=
 =?iso-8859-1?Q?IgBRLm7QMvUY7B8u9gXoNMM+guCVA8896V0wof9SIYFzU49odl2JMjQQgJ?=
 =?iso-8859-1?Q?RFEucW4/EKyRdRHgPzHNlNCXWkrtg3HzJ/zBoYOc2My6EErU0MFE8HN9ts?=
 =?iso-8859-1?Q?YoeeJMl1F57K/7vYdZj+2VGSjwRMQWq03JEvObjf33jjk4CQE6KkePSPOM?=
 =?iso-8859-1?Q?SLO3ON6/TIjMeieRtJUxAnyOud05BSE5Q0CfDvAHcV9B3h+gnwFP3DHhIC?=
 =?iso-8859-1?Q?z4B+11hl54Wiva3PmCdosCMabSFX5RZO2b8T94rEdq2VadQ8M67e6Z0Ltb?=
 =?iso-8859-1?Q?gtZy6hR0KZO5ykV/4ssmOtmcvitKKRu1aSd+UWQSW8wLux1zqOnEODjLlu?=
 =?iso-8859-1?Q?lSv+2UO0mWl/+vMZ6XbzXKEd5pZ6jGSqSbW9Kcftu3hgzy0S1KILufHcYm?=
 =?iso-8859-1?Q?Qb3Ayn+V2thWjZ2cd6mxU93pen3qzpD557frtLVAQgUHzJxazlAsKj/qm6?=
 =?iso-8859-1?Q?vQSlS8R6sc1GRGPTzpVndpmh7TnG9FoFRQ0wgMTpOOrnSP93cit9RrvLWw?=
 =?iso-8859-1?Q?fpI9E5fDhsVxIBcqyS0cqueitzVLbYkjU/sR+/77/xKL165mFw6S+vA+lM?=
 =?iso-8859-1?Q?3tBvUQS3d5dT2JF2HPjly4RKysOewdhW6cyUa0x2JwKDboSGXvTbq8N/SS?=
 =?iso-8859-1?Q?LBRC1efQzKplBoagR90j4SLp4dPxRSFZGtOWKD1mtrembWBn7d8x1f50ZN?=
 =?iso-8859-1?Q?X4djZ+/5SOBO0Z8EnA2mNgy9fNk6rVfp/es5m20fm7bSkq07fc/uAtBKJZ?=
 =?iso-8859-1?Q?ouOpBtoaINltJ9R/n6AfRK5kcTEsyxzaAq91Llrxd/fT+UA48atpNmOhe0?=
 =?iso-8859-1?Q?G8Png9gwLhkmKjVECUEDsXbSF604oQH603fBP8RFHMzyrANk5GzkIjVA4B?=
 =?iso-8859-1?Q?Obx0AP2ggrEIRiRW66EHfbXxe5akVdZgQoGJurH3jRF1BsRPk2vX6osYTC?=
 =?iso-8859-1?Q?R2aZEaLrVpTKIv/14SXrKGC6ThcnXFf8zR/coFh+zjjAnJ5S28fDCZNlJm?=
 =?iso-8859-1?Q?2lykhLLQqoM9i36+gR57Kz1WzetSazJ97VUUCQgWNqsYhWMqAzvRYsgzeJ?=
 =?iso-8859-1?Q?ehgknBRGLfVG8LKCsJGUtiSAdMEEqLAYSFCksOprP0En1GpihaPzv9ObeT?=
 =?iso-8859-1?Q?tkEnnNGhoG2pocFKh15lPFsPPlqfrEfLFmQPO4QFBuSwZNRflbcAAAK6Wq?=
 =?iso-8859-1?Q?sjl+w2RXzO/3KcTsMxYTSBKdqs1vqGhYkX4r8wdedlS2F9w1wKWouo4ToE?=
 =?iso-8859-1?Q?1SnXTrKnEIYn1jaN3ObWLkwq3dCHtxlHhUSUx0zfmYw8Bwa/TdZPbLoDel?=
 =?iso-8859-1?Q?F9vS1+CcW4JiIvjSB9nsNRdSHBAloS6S9qRAbPNU8vQOxFp0FrrMtx/XRk?=
 =?iso-8859-1?Q?EQXZ/ks7gPVkALv1yrPKA6JDhzKLuY1Uyj4xawO9ncRoYrvqF/drXdOyfE?=
 =?iso-8859-1?Q?cDvZdhoeanTgxc7cQlI1mX+U1OF42sysZ+Qpnn7hGof9xPDGwp6gIsYLNJ?=
 =?iso-8859-1?Q?ZJGtwhGINt0/3JVHN1uyJ7ukomfcUwh1TAdAwjePfhf0l8oBnIFb2tANVA?=
 =?iso-8859-1?Q?lsv9xv7+pTuj3ksVUNEnPN1mvMtO7/hp4LKXB7jZfCBBPhIpqE8EYzag?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a2d358-7699-4bc3-48fe-08da9040eb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:53.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYDLFeHTTkFOsNjvolhMVAUyos/mEuhTrdoj+GCzlkoyNWpT4Xxg/FMZcLy+qDIoLkv6oChVNCkJLKk74On4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=894
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: N8CsmCuRHBgT7grWwgflqL6X9ThzIAbD
X-Proofpoint-ORIG-GUID: N8CsmCuRHBgT7grWwgflqL6X9ThzIAbD
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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
