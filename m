Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6257ADC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiGTC1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiGTCXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DD65D73
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1KtuC002392;
        Wed, 20 Jul 2022 02:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=sq8lw4ngjKo2V0M1hvnni6DWVDyay8apV6iTdIg0KVyQPkQ3YTsBUxTFD3fSsEVUgz1u
 uJjRb+ZohO0hCEw3ftPe/MDjNMv8WDpEg5T299UEIdFL3zOTv4ZFlLTwEPrTgF/mE4D+
 x6AVkgNQYo4WSrtWslfgdEDD2AXx6U5Y0FkkPsV0lzOzBJU6YGiI5agYkEtSJxdA2J6O
 XD6DuolEJh+PwpFvyYk2khl62mwDLpS3umvY7mCCcRaEREBIJkNKM8YsLo/iCcjhLTRZ
 F3zNfAjPz2/7J9SyjgZ3HvbbJmsC6WpyG+tslDp3Fy1TrRlxP2IirV8nWdAj7NInU2YP 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1x7ak007828;
        Wed, 20 Jul 2022 02:19:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3uu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAFL7DwsVhGYxQMht0DNhQ/on0h7cQZVBgXAhLdTseUKlEEccVoZWqrOtH3DNLic4D3BoYm2/aHZF2VuoeYMdjbg34uHqxMgbCdwvDbZIWS7TBmfIndRzbKgne+LT4ASR8kldWeRUUo5In0NfhR2Fc4XdSRNghA0TMW64DPFiliLA9sprCN8eep3B7mSuMKafLoyA57PfWaa6gMvnAS45f9wflXAdQj2KmGWy6rUpx6aqKBTg7oYAtAO6nZbFe7O6X+LKUA79bjyU7Qm0Q6710YxZZbjAUHCjxKVjtdoO3mu5qa/F/c/UHukWobRUGAEBkpRZtfzJEBT2EYcmVLPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=cExqgO5NprNg1PgN+Cn9Lw9ESTteQA3nwqzk9h2d6M/VOWcr3RUzL0cp7dYYhVh/av781CHeF2qzaihRpj/Vlid2LWYGM7a4EyjaUsfJev2OaQryIf9CGALNg3GUcoyjciSIRrxMItBW9ntDzYhRZIofUGBKQfWtbzNpoDm41tclWa4EJ8vj4DQRlJIgVR+MRvoIKP3Tcyn0jeIMI9hs1E6rs06xPrLnr0yRtOHufXk6xCiIRafOF02kZhudGMDefzZqoxKUOc8hvXSGfFlT38njESZvineBFH2wV49ecZ5CZ/kkZ3Ds2tVP1P9hn9Niszf3kelpNlE6ygy1d+CmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=V7XHLrFtWi4DqiRXpWy5CCxaRz8FcrNwF2kZZumnFAIuOyr7dbDbiSPFZcuYACnVvtsmkGWgWP7DHnX2wflCXW66AFbmp8xpT2X+RARN42eefIibt7jwcR95Qovsk0iihwt7/0YrhOE1opzgxC79wRdeaannMLtO3BRvu3xE5H8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:19:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 66/69] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v12 66/69] riscv: use vma iterator for vdso
Thread-Index: AQHYm97xQ5yzt6KK4EWvH1VXn8Zgxg==
Date:   Wed, 20 Jul 2022 02:18:04 +0000
Message-ID: <20220720021727.17018-67-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a70a6e4-c722-42b7-4073-08da69f6402b
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/Gv5pzJVQLKZNLD+02EHBFk3XEP6cblM4JPwnXKXGbb+m7iam34EIkk9AQG9hQuxliSdMl5m32bi8elykyf4zwnaTmLo6kwJzunpMF0WuvcPBO981hVQ5TuM+2Pz3zP72j333fjgWapn3KPyOJ37yJz1OdwvXaGbV9BnVQsxQTSKcV+jo8qoF0nuLk7XVKcrV0SWJfykEFGK4NkKN7tgHhQnX26O6Nmj5VvzWh7+wOEv22FXNleA/MHAcxHuFJXReElMxKMytcFnJigAsHKScFCv124YesLzOz/umFx869wpHGnVmVohYkAFHIlP6wFPT/kQCMWw1hk7x+f78pE0j3iScjok/YaC3hAVpQGkWDO+gsGLSBN5q9Sdgmn/FXzY18kS9lOo3Kg5ZgF8TR21bcJbjccXDDuGX1Fo88EHHlhTutTm//lGe14o8HMQ2OcGS5b4qpuxKg+Bu4TE25Dva27wLn3MrlxGDq5wU937fcA7SOVXm1jXF9BVSF1O/YMuZe/QAah8JLftA8q7ih7Vu3Zs+dTI5lQaIedAJjigoGj69xbgyvEiRQUTvNoczNEf2xgVLvypIrEFjJ9ChyPEzv/FsnTMREr7bogTTB6mSK0ikv4/UOB7FBYPWM4eFIEQyWt3/wBjTSO/EKAoYChClDUIPAV42pLPw9T+P4tLd09eF9WRcF93daIL/gS8uscFF5f066BkFD/JmYD7Z/M9mCR3JiRjbOiHyNYXcY1J1juJAmHV/w2YGn08Tw7FweOMMYCVw5Pj+zDjv7fEtlujxeW9TTqBVKR7FpKAmgI1A03Bqh1DOd5HShSYHBEnbLfkfQ1RETwGdztF4ASpOr9REOd9OZi3aiJgT1bkp8yAf67iVDi9EUbAtABJL9NCzz0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZHBduH4/ysxxjkEmdY9YOR5GbwcyWRCsFKdYinlkMD/D5YDyv1R3IB/YQf?=
 =?iso-8859-1?Q?5Qd4RUdG4EVKg9qiQNAM7sce6mIeFEXE2FFryvS9DK3JdqX+fcovbRzHlD?=
 =?iso-8859-1?Q?whWQM3qMcizpngkAkJfEqskOJlt3DjM66vixCQ3C/guGU32fQXwwOXfke4?=
 =?iso-8859-1?Q?q098/6VJrurB3evsHE0+Ta4Qc/FHIjjQsJiWgTm6DI/4RKxhfL8cUq8EUo?=
 =?iso-8859-1?Q?NGhdNwuMZxZOPdwLxcA2fOsgEts43rqs8/TbS9Pm+QSCtu/JeIgpnUXQNp?=
 =?iso-8859-1?Q?B/o5VJkWefUeMwSU+hDu8DD6NU/JJIEA2ljOic8i0F6379K+mywE/yCmio?=
 =?iso-8859-1?Q?aAB90vhV3L4yCXTNBvJKmORbaVP3o6EQzSzVMl3k4ZwqCEqc4VuyGyvbF8?=
 =?iso-8859-1?Q?8zfWmwLX+Iuf9WKYIFuuLz2fNHtnjiKzGU8TgWdY8IkEHTBKuL2u+mylqg?=
 =?iso-8859-1?Q?pqJEredLugt84HVL2qfGY6u9KjyZpuzdOsa5S50sQb0eRMZKhtj1pbp1g2?=
 =?iso-8859-1?Q?ir1IipgYJm2fmOXvvkgYkbxFgiYppJAHiSvyNfZPSHFBrsuuvCNTxou9R8?=
 =?iso-8859-1?Q?pH5S4JvjN8AiIRSAf3AcZeVBuu6Wi4l8agPS3e8cJcl82kOXd++ikNXsMX?=
 =?iso-8859-1?Q?P09lLofrP8rQNF99lc8YRaBa969kzYRbZk/efldUuA6gSB0K1p/iqJ1Itd?=
 =?iso-8859-1?Q?iR/gyFwIzS3f1WPhZ52DkOwcXfHlp1i4ceD7MQtlM1nJhIFpW8ApYSQIHc?=
 =?iso-8859-1?Q?dUboRCWThM1OPc4cPPRSc1m95rCqCf4nR24XsFZDmn3f/VjpxzcuVkzU/H?=
 =?iso-8859-1?Q?XE5nmna+NunhKiueF3twvCtngTJnsN82XAXe2WzGaH19SCYeitZwuA0sYm?=
 =?iso-8859-1?Q?CIqlnZk8SUma0l0y/JyqDHux2SNZtDE1t8aB9nCpV+OlWTwLJZWDrHhR4j?=
 =?iso-8859-1?Q?5ue4OFWtJcVxDJOaAoz5MRh5Rua2YV8FOjENpXh8Hl4UnxpZfUEYUJnV9C?=
 =?iso-8859-1?Q?fdNg7fke2YavbgI2HN7j0y45jV8NRE+soizXqX/Pyo5qINQQgZ4EJL43k/?=
 =?iso-8859-1?Q?77JdX+kW8syATSr4AGTVg7+4g3dJY/psiyUii7a6BleY2tV9oR5inhx8k/?=
 =?iso-8859-1?Q?n2v1zVX4wHef+48/+FYk5+S1KKTFP6U1634Z5TZS148DgulnIjnZMi9xtp?=
 =?iso-8859-1?Q?Gn+V4uZPJ0yHK8niSDguQh0wIBqAPVkcEVMQ8S9fEKesREvMFh4/zftuWs?=
 =?iso-8859-1?Q?3orkXqlKkm/5FYJkPewfthu0CxliUFPXbCcFvUm/O/9neNpoJiF/Z64N60?=
 =?iso-8859-1?Q?NqSRerswvM7OJy+xDnZucunwZEONZFLIPaMzkyTUXuRMWglXs7VRupF1Gh?=
 =?iso-8859-1?Q?Yk5qYuThaLfD7LVVd7EifH0Qj09WVBJziKCLgDEHrCdIPFhUoJBFZt6mO4?=
 =?iso-8859-1?Q?BMYTaYZZitLFbqpmkDstRX0KZDmf/KBAdDZnRz9peC9AQbdS8TTDLQqsGi?=
 =?iso-8859-1?Q?60fYeEexXnaGffzdEfAxK6XCOkDwGVrYqyp2qhDYIV4W1Srxs1duuQxdHr?=
 =?iso-8859-1?Q?BAKSj5xsJ0cpP2s1amjPf2rg6UDCxIHHX2mv7k1Z00OmInXDSgPQ1BCzyo?=
 =?iso-8859-1?Q?czy1II8ARgVCqKMrrKKSu03avZlS3PLFbADnL0B+vPJ1HocBeRWoAtTA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a70a6e4-c722-42b7-4073-08da69f6402b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:04.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdKZiASSNIaocGX9efg/dxHAY5C0EVc221CuIx602Ry0eCO6QwUIoP/jYpiajZloOT+Uu5G91gLaMwxA/SCfVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=906 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: yfRHJ7mV2FRsNz8pyfN_uSYcSjhrdw2H
X-Proofpoint-GUID: yfRHJ7mV2FRsNz8pyfN_uSYcSjhrdw2H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the linked list use in favour of the vma iterator.

Link: https://lkml.kernel.org/r/20220504011345.662299-51-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-67-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..692e7ae3dcb8 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -114,11 +114,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info->dm))
--=20
2.35.1
