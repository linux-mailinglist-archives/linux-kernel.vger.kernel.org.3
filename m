Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A704519351
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiEDBTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiEDBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAB41F85
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnGv1029440;
        Wed, 4 May 2022 01:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=nV+ldQIHy8IWUWqUo/QU0XkblZKZSPwDHsMxaoWcC1bxTSrXzpSqjykGdfN2r8Hx1vWc
 sUzaoW6Krt329JZqXKmnaXw5yagkftOC0vaLB/JNJkcDE3kRxwLXgrSd0at8JGrhmERh
 O/uXmbsam5F+BAez1aSC8ZWX8MYXY9KZODhoOQj4xwIvVP71p8gaosEBNEamPSPrFKoy
 CFCYhR5V2yV5SbDE/HmhJ//Tvq6qnpo4+IM0ykdeWTGUdeKOv9CvxZfqRIszoPGnzmv2
 yZ2klem47Cs//Ve8kEDByhNHn2MJQWp/frQDG4XQr+7IQuNWMIGbmrToFhUFvSYSske7 EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f618-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AxHr004437;
        Wed, 4 May 2022 01:13:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2w67b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKREOom0r1EFE8F8tmlRH/4zQs4rm5+m+p2bn6qz/xv3UdpFN0S5kCNOuF0o2MrsF+V5FO+sxkp2B5Wu7grA73t500VnDhwaParAanf3qs6Zi2aEZS9iXzBexJsvowSeFApwxr+vGapxyRW3dnOw4eGSprfINHGJB2WQaDGYaQqRjCy6Jzn44OidgURFxgiQodVGpkCDq5P2W4K+vBZhAaMPAHdrFI5cGmKMaYIdIC6ryXaakv4TXOjmd+6SZqp1zceVeWzOuA4lF7CMT+Zp1TVQBDAIY0jVggVmJY9DpKfyJoCKwBEGSvEmfI+EijJHCPotEKJwA6bB4q+Ft3PZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=aj2QY+jQA+brvXr+CPGz8HlCFp5xxEYtv+hCag0OdiSMv9kPPbI42y9VWqKv9QwIvmFUMVV+tc89+pau89KQa6zLYibzwHPQ87H7mnronlJhfCHWlh/f0hZODJDdvsbgFZvCFco0CE5U3RVRYffW6B+yBnFudLqITCNfyM1XUlnvg8Y/bbi9NGCB+pJwMwYs7crtnKAYyywFpXP5bRDtvAWkS6G/oGWYJxxFvcW+G6BV+SDPhZYtLJFCLHhdSVckaPe3xw5nVIFWs9XOS20OTsb8BIXB3+qIJ2psZBUHyqLs6XVsWBkyBPLRxQYZ+i0R/OkSKANPlucfCYIc9n4a9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoAQ0z7wTYteDrn936jXoPOYmddh3bdgopscNkeFN5k=;
 b=HMaezzA3SjiJGJ3MCP4SPC9AMhSstTUHUrgOxrKU56cgOvLETjz0ApfGoZ3P+jxN9QmHyuu/TgkVOfLL4BDWor04UHx91EH4p8kb6C2gAdMnznY3id8+CHuGyCgypnCuutFZq0OElNAJ0srLBy+AJj8V0NPgUwyeuSsfZ2WoOsU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 31/69] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v9 31/69] arm64: Change elfcore for_each_mte_vma() to use
 VMA iterator
Thread-Index: AQHYX1Q5Tyr3+l+wzkGa4v1fmWuVZw==
Date:   Wed, 4 May 2022 01:13:54 +0000
Message-ID: <20220504011345.662299-16-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f448fb4d-162b-4644-ac5d-08da2d6b5bf5
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5830D32518963DB4CB3C8281FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XrA1mFfgQF7mxhNYf3wWeCgguL/QgDxzZNramqfD+8A9VKsNHCDeAqbtnS/+W+AcS7cHfLYhEQ2tbgPuZcMHoAYMQvg+zoGNwlrkX3goRYDKGGb563DPCu3cjCqU1C/tbAY37mlXuNTuqYoSTR4Y5IcVwxgOQrx4g2bY0/YXkGux5l+4xz1ozHDXQgI8bEOM1C1gBB8eSjQth9h5FSrDw5ljgiHZ4HFreGDE+ZPH7E/i5lQ0DsxeD443STIgQN7qTnZWgORZ3Wd963Ae8ZU3kYh5Ugh50Dnrug4tuYRMFYKRrvFNQrSq+/SdFElvR1yNBslW9kTrOa4R3NzX11jHtaF83OjDbY7OLc9iQsnALajhadu6/6ZfceFvTM8h0xP3XOakS4NGTi1aZfIAc/lSO+xl1jDAdfM5TiaUzg73HZbT6ZNsOqdcb6RykiuDa2B1ZtKPZ2ygLJJ1IFnIKXzFWFNFRp27tDDVz7Yq0W+l/6zhwmGJIod0ajNrQHEJX8vyssx+YPMFGwerh0cWNuezdq4sM7AZNipMJz/MA5pEmPOwyYa3940Hay2EFsz3bPlFKUS0GaGr79O36VlAJZ4ThJF+X1NxuNJU94Dn0cENKK0t4j/GJ8RWBCghY3pr9OXOTTFsz6Ppkc5SKOSt4wsK/Bfr0+Nkujpo/hgr28cVotnHqCjR977xM4dRtoq7wSIUmCrHTjXuajQsQktKZGVQNl94TZqyhkYb1gosO2fY8pRVWaaK/dfnsDpo12rj1nHYC9ZjdmD9aFhj/5LFmtrBTaKnUpVLeD8nnoitN0YXGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(966005)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZJLLedBPwmBxFt9igly9KNWMpxkZudljP/HCPDJlBt0kqJVkOHNP5S2pCX?=
 =?iso-8859-1?Q?litydhNGY/gRyUfCNHzeyUrOd9Sxd5RsuIA1fTIDHnmPJNhi6TsNdO6jly?=
 =?iso-8859-1?Q?0SlLUDxPARYGw/hEhIXxP66uGNCcd4OreTIBjFz+ARmei4pmCtNTvitAhZ?=
 =?iso-8859-1?Q?s8znbn4lQud3exZwPht+/FewkyCYYuJ1gp4GaRkil5t970fpTD+x1wK/aB?=
 =?iso-8859-1?Q?Z9sbPCJDiitGTzgqX0Qp3ZrnnvpBc3uEyAX296Bpnva3Jd/wiz+OxHkz9H?=
 =?iso-8859-1?Q?M6bXuONThE/FIXFxR4EScqhWDnCzS1/q33c8wza9LWK2kMRE6fW/wv/Jop?=
 =?iso-8859-1?Q?ol743T9fFEhl30Kk2R/pkENXIeFVlRMTJ93kOWLc2zyo8aaaM4ZzVOcWuO?=
 =?iso-8859-1?Q?oKs7mqDFIWo9a5+dCb0tdPMy74Wg8k3MUKqi6MUbw4eG8ufTAIqsEOFMUG?=
 =?iso-8859-1?Q?u1XEjaAlcfBau1CuxJJkmkO44sY+sPIIcsxEH4XMba+y0V3+dDijxVVy2e?=
 =?iso-8859-1?Q?rlCxR+fqQl9OvPEG89vJAiHqg4UhHjiNNr9u9JCGCYZrc/sVS43KINLf4B?=
 =?iso-8859-1?Q?7rN/StOkihOEM7eRh7sO1grmmLq5pZ7+IJqJsjLracbC7Vr1l+ueIlQ8O2?=
 =?iso-8859-1?Q?ODrc0aD0JbXHmr2heCpF3dABZtYvucE92rIGZiGaOJ+4ZqWzzMVFSd86Qt?=
 =?iso-8859-1?Q?1wEakfxxQTAHJBWu4V37NrLdxz2OZWVvrSAtlplk6xFLDGxHWJTqBk8PFy?=
 =?iso-8859-1?Q?rJrxqmfjUz26QGSRTrJPmqWq1JPkA2ac9+AKm4vpPDnOrwVsVVBkjy2t0T?=
 =?iso-8859-1?Q?BeR6tqBfmSl/Mhsvn2p1g4lB4s8z0HWC6csDietM8ZDGvsR5i25whk/xR1?=
 =?iso-8859-1?Q?P8VydvkkFGZ+fth77YKrSZe/OMOFwWithXwQiouGTUtffQ4Oa2X6XIUl0/?=
 =?iso-8859-1?Q?5iwrRyJpTSHRU+XNBfrFnoccXSUl4nxkgOpOFzUzbKv5YlJutgge/b81bn?=
 =?iso-8859-1?Q?CiiHvYBZNhxWCbhYBXugWXXMBuqoyas3yVL7jNZJnk3P70i8iB9BMSnW+b?=
 =?iso-8859-1?Q?cKrFdFCcV/oBUOcWSNBc2SbIMYN02Ohto9/Q2wL0dhVbFfhZdXHR2iNUOw?=
 =?iso-8859-1?Q?uJaAgakAl2e0Fl49NmooJfBW+pw59egey6ehKs6XZLyN1w6Nw0UJRQLELZ?=
 =?iso-8859-1?Q?bHnEufGySO2fuOODK7mY7Xns3aRlmAUkvP5qe1HaN1snLCAy7bmtTzu5H7?=
 =?iso-8859-1?Q?lLr0GW58scP1gv00UX8+NxalKCZepJeQ7axbXAUOiQr7Xenpa67J/JB9I+?=
 =?iso-8859-1?Q?fbxBNSmb4LgZHZ00UT8G3A1AaUzeYR6B1URbbgfCtKjGatWr7gkfYf+P0k?=
 =?iso-8859-1?Q?mRU7DIRQ88f1VrH7A8BxP3SYRq5ALpWz6eIGPK1AfNysby47NXBz8BoDBH?=
 =?iso-8859-1?Q?r0HPya7erS8ptehGypUxUj1XLujnN6FZEw9ULJh+BYHai8zfaHA2/WssGk?=
 =?iso-8859-1?Q?wVlJtnR2TJ6QAxc1IRQjLnfX9N4vLs+U2+7DV2t4289GmNuq2JOg/4VUaJ?=
 =?iso-8859-1?Q?D9mhYdU1Ej/yB663xEk8QFJPITzqyVnQdK9Qi0gSQ44PfmnRNVmsKpQjER?=
 =?iso-8859-1?Q?W3Y5fBb2MILHEIZ9yuBv3XfOvSxikN5JUPMcsJuXJJDqm1+fpAVNIs1k9i?=
 =?iso-8859-1?Q?WFsscb/bDPIdGWGY69Y/Q8T/TmwyL7VWjXTM6eu0B3sIiGCMoAn1YATQLh?=
 =?iso-8859-1?Q?Hss3pa1Tk+5hl6xbuYfGUoF+wirT5hYGSRHzvpZgQCdeq9RZXGXcpMg8Z9?=
 =?iso-8859-1?Q?oMjltR8kXSpExhpElt8xbNn4+Io8w70=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f448fb4d-162b-4644-ac5d-08da2d6b5bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:54.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xv/OPDOK4uCDmpsxM+9upC/JOdRWBIYT+Anc9NfYgKi/tj3ymN+rji2/QnNwCpfDzqZUzaUcFRSo6VeDCFQg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=925 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: NjeyAAsnIo0AuoahJKspMgrSzdeA06Jn
X-Proofpoint-GUID: NjeyAAsnIo0AuoahJKspMgrSzdeA06Jn
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
