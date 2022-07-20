Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4257ADC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiGTCXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiGTCWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A148CBD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Ktu7002392;
        Wed, 20 Jul 2022 02:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=ceTzyk4BP/bOvLq8Eoca0G7/bmyOs0hNPDEONxezbLQaZh2jlKIU20TLSedefWECGAck
 RigPNJxZOknSv9RzlqMJ81tnT38oHOAC8rmqA1mfT9QtXiRLbM8b8oKDcfOGzdviUIDx
 NbtKtsokOpNJyBhffHZjnYfFGxo3NJXBqPUq9Ep5gjxydi19qrceWR/fhp9DDksy11zI
 9uVMJo3x59U2+KWnJ2vUIDnZfaBtuOAHZN/1Q5irUWhIUtHQAESr0JW/SPUF4a3jWsdf
 jtxLuojRAcNqPmxc3Y5NVV70ic/PYiHrJP11dyAdBF5PSHHCud9wyUCmHDT+R74ec3C2 PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHEnZ007944;
        Wed, 20 Jul 2022 02:18:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naTYAoKjZhovoZMpLHZxIkqIdKx9eAXbR8YpEuQ6qbXvESDRuWkX6QLoaUVgQIbx6zc7MXlH3ElKr2pfhjX0NXCy1uAOYxJW1dL2CxElDGFr53BKVAx8UkENCU3VotYmyWTKWk8nLqeQqveJLNwBauS1WlKim2CQAj9/aD7MPnidYn0wKxbPhBzvbojow9/7vJ4IS8yfkSgPtfy6h7p9wmFE92UaJekJsEXfw6D2A1gIdmSAh82OdKhhttMbelS5V7bsKs2kyP9vneLElbVi+ji79G00gfRAcfklC06f70iwvi5RmKkv3PYq1PJOj8pmNwwDzRdtG0nFkQhuTcftRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=ezr69Jttuz3bvg59gRImcGNObKNzswlrHvizaG8A2fsVZ+yuUJmJdTeLkEzR5ZMVqcantvkEnO0xEwioa//bmBoC7Hq/q1QySJvIkD0DiPzbjkScFpIJMNSNCyj48+ZrLRMczmriFsV2A48yZTzJ/xgBOLt+8F1BAU0opPUjfPh3LRxu+hmZ1xr4v8oeG7FDxRmXNFRfd+2cFv8qBCqk0Ki9EqF4QpGhXZWcizGTh7j56F48boxEs/3tV8EBd0ITfUskgb73q2gaGCCD87jLqdv80wyf72zipigkuLgXPSabwSMiOg1ehWm6zWcgyWj/9r0LCEYSRUonAtvzTsXWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=tUWzAawWa3a632C8Smx25F3aYPhtozcvUDu/RLVkqatNaUJ637YX6ipEX8T6oU1I3M/2+1IlTzr02P+jgWKsGiUlHe40y7v6ZIIRgaAQ6v4ei+V01qpqlwBcr32lDKS3suAt6opMX8fOdB358qkq6e7+IndLe+M+qEC91c5yX5g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:18:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Topic: [PATCH v12 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYm97vWDEJ3Ynop0SQySzL67LEoQ==
Date:   Wed, 20 Jul 2022 02:18:01 +0000
Message-ID: <20220720021727.17018-57-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ce120c4-2cd8-4799-f1c4-08da69f62ad7
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqgrtpf4EKDW9zyKIH6s/WAIh4CLzHXzB3NkWDVk9A17ehzib4qKjYlcxvt23YoSxP4CvI9nJy2JRpyltYf5Ee6u1GDU5e8wPPSdiawFNcDziOQfGrTA+qoH1593u8Fawb5ANr1/NJruK1fxGlu4u801DcO1t8vmvpCWPxR4C7HY6jy+YIPR/tZft9PEquHUa+aXOYd5s1A+W2FwjIFiBYv+hZfvNtw/3E76Tl4DCgSezp+pVldXEOBKEenjQmBMYef7OyEsnXwfR3eN2lWEjeKt0kt5XnIcmCFWJ0c71nJCRj1qQAdr5tTiiVERCq2LtmQ9UlND0uvqz3m5BnX7dPFFxg2BiKDNC3GP9542jVwM5ZFFNy5TrRcq3gcJT7vAR7ZvvKQBziy9jy9dKKvcpoqvYgcLbbP4WDAoY7D4XEP35EekhJKzoY/C176pd2bn03HRecGelDHBgpTqeZqu+a/Mn1JeVqfhaxaraFF5f9vsJWhbgHwwDcNLHLk+0Yo2vYBNjOz1EKiOO6388DZsGmTK7ljfwd1qjWXFGKMBO/XmTBr1r/GCHaMQrR/WqYZStiLiAMzEZ95m9xb3MwO88YQz1PDUlBYwHDSU2qRDiTYvJCRUux5cQLp0ghK6JXOKs3Tx8RpJq+won1YvRZSgalCvDxSbWNYcww7ZdZZb1DyZNGXXtATJRym2f5oWc5otl8Ao9tsei55nZJjb+SLU4RdLL3cmmAPRWjYl/720m0Fj9gvwAdTlBG2LGjUEQ4LstMFOQ/vUUCxhFC4lIbi//5aFybQum8oc/3k7xMd/cDFYs/WSD1SRjmHPbS9p88H10U7Z3HYWQhv5r0sn0AAS5jAMXg9LxicvmEUaYAfUzPFOkHWRs1rBCxbxJgh9OATA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aKx1yD5CYTHKj0+MTkgSu2r5fpel3MgoHEkkQiD0aG2sU3kDi7/Dh84dws?=
 =?iso-8859-1?Q?/hvCs7NFaoZEMrEDyP+qhnjj/+K8ygg7vMiTRQ5yCB1Nmu/eUbys64MM/Y?=
 =?iso-8859-1?Q?DnXCxGQkBiO8859E5vfncbIY3Lq2wvPHa5pqaqKGQIEGVhIPpeMb7KvYLc?=
 =?iso-8859-1?Q?IZYhxzg7FS5dWIBMCjFpqTfZSdUHJ5HsXFAktdkQt8UUw3LmrGb1bjUutP?=
 =?iso-8859-1?Q?XT7LuUGyLJO0G4OaHSGgUvuQypKDQuNiRL/Wbt78/yqDo3UPJLWygF37Nu?=
 =?iso-8859-1?Q?CLXu6Yx7Bt/KLV+0S8Odi/8VqojpLwAQThh9RjlITP05hnF4NQtP16JHSD?=
 =?iso-8859-1?Q?T0OkPZq2alxTMqnwhsf2epyRnIvanbuBptya/TQbBKP+TsplUG1J0Nv1B+?=
 =?iso-8859-1?Q?zHNXviTjL/Tw7anhlHIcbRhPIO0081T4kvmeqqD1UUkAXTVANk1H6ImKsp?=
 =?iso-8859-1?Q?6yBubfvOxqnGCdqHBnYI8wlo39v17TVQhTZ2nxy4iFgOIJhGTD0NZUZ6Xw?=
 =?iso-8859-1?Q?RkCe6mnB5bpEwuMbdCc/CJUFm7KwJ+53+xbUB/w1RFuQ29TQVarOOwyFKi?=
 =?iso-8859-1?Q?TyqFTylKY2pwbQSQRC9sFBsNt0c+4+r7O8YWIqORf2n08PzEHbjhkI5O4I?=
 =?iso-8859-1?Q?BxTG+JOrTcfMlw2rw6ExvV7ufD8UXDRnJ1skr1HZJzvNtz3nOw08XIK8Hy?=
 =?iso-8859-1?Q?3Qku9bMpzEB72hxt4okC/t6m8MzC6Wd1s+KXehMsKBS3btDatXFqUn4LvE?=
 =?iso-8859-1?Q?Hfx7VWtsz4rXBpzJJQN3vz/ioefGTli5a5AR6jfCLvrGn+s5iyQSiEocVx?=
 =?iso-8859-1?Q?Z03XiGJ1n9/ECapxeSWYNYpMPrxcihuRsDzTelG0xuFGHL7TX363p9Hlm3?=
 =?iso-8859-1?Q?XVzS58w6eDrt8fyLwHykV5Recjx8tmOnXPBer8T24e7isRSqVYXunTuzMw?=
 =?iso-8859-1?Q?iAnfwV5zwYO7DgNNSeKF0DDtP/Sjm5jkZWq+NN0jbVmx0WZlJujM+PVWGU?=
 =?iso-8859-1?Q?9R8xdC1Is14UwNqdET0WZ8obDJsBWMjTt275urRpaFHJCeiyKid3lIa2R/?=
 =?iso-8859-1?Q?U+2ixTUsBgICfpxIscjvs2tb/xIzqVxNmZj5gU2shHNh7e3mQG9/jiFDyO?=
 =?iso-8859-1?Q?PQYDCKUKJWWg6GjOj5sKksBCUZ3pmeyE1z3GbfgUZWrbyFQpWyeUiSOkcG?=
 =?iso-8859-1?Q?lBooCxfFXiWwGMiPD4QLAAmHrwDEINAQgoHfuUv1JNMH5uFZ5mUPRgypdr?=
 =?iso-8859-1?Q?zhh0IS9zWjsOPEg5MmiTXYXl65jKHLmg0CtoO3PIIsBKSs48IDBkNPKMQE?=
 =?iso-8859-1?Q?/LGncpxWERWladD3t92GZWPmyaOoGNKqe6doORRpyjFcx0RJccwSeNrdfz?=
 =?iso-8859-1?Q?X+QdR5EaZIvpSchEYr9umUuugtaC1IAbDRAsADZp9whwlOTUv/m1/QJtUN?=
 =?iso-8859-1?Q?wIny6GCSHbT02q7Sas8j2GI1LV64kgxmK1agdsNaiO55XLDMydNXLubqkL?=
 =?iso-8859-1?Q?HEapyJ89uf682pjBNF1Xr3PsHiTKZZmbewH1mdBiUGBiRPAa/DrHKjjjMV?=
 =?iso-8859-1?Q?7VGgDgeAn7rq0fyCzY1kwjhKLwpEXHH1ZE579WiaUOq4pEB4SwgZ4HuCx+?=
 =?iso-8859-1?Q?vVPi6FR7iWrYJxXUH43KpLII7EaX/PrrUJZLdPzAOcqFvQnhCVIIulLQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce120c4-2cd8-4799-f1c4-08da69f62ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:01.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmT5jmp4wrXCCm/XK2sSZHSJDV2g7oB0iRwugacKOM1FvH4lk3HKqDrucmmNX/zj5w8z10E+VUNpyaIvWwpkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: E9sgMlKLk1z6MBsLdl_mDEryWgxMRc-7
X-Proofpoint-GUID: E9sgMlKLk1z6MBsLdl_mDEryWgxMRc-7
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

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should be
no functional change to this scenario with the new code.

Link: https://lkml.kernel.org/r/20220504011345.662299-41-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-57-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mempolicy.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..d5993b47bdb8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -381,9 +381,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -656,7 +657,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -671,9 +672,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -787,26 +789,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) {
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -815,6 +815,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -822,19 +824,25 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1049,6 +1057,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1064,8 +1073,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1195,14 +1205,13 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 	struct folio *dst, *src =3D page_folio(page);
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
 	gfp_t gfp =3D GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (folio_test_hugetlb(src))
@@ -1480,6 +1489,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1505,9 +1515,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.35.1
