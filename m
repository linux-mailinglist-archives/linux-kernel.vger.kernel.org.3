Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978A0510195
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351933AbiDZPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352144AbiDZPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771315A42A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT30i025784;
        Tue, 26 Apr 2022 15:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=juB3M50/4C0h/ZttTG+2df1rUqWzZeoIVkZkN/PHFvFxd/Y8q+8CC53T5uY2Y29p7UMl
 VcJFoRtqXTicVeMJ378Okh2OLHdby7O/98U3KoX3StkwEETD0aPOZGkHoqnghwdrxahK
 m3jPrSaKX0ZLfZrb1bkhWWH9llU5RA74YFXhrIHtRm6pJjRFWf9bLQczwuPBFy189P41
 ggwp81o0Sde0tixD3o5BukdgmhsYe9oHldXMZdUvvkE7MugXXalpI+j/LNoRMQo8jc6c
 gBXt3msUmOWHu1cRIa9pRf8+IYM4CGkOcCISwhY9N9gnt+0cjKjdu9EoAQxWsemqd0e9 JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USU037884;
        Tue, 26 Apr 2022 15:07:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBYSzfC5mJHH7vK5cqsZQaFwafP83zc3dYWZoCt9KkKE+AhNPk7JqVCG/WF67+lUjjoJ/Ot4UnGMqJlhi82jneuvRY+otJku5EbTxB1avEjXGsgqbeJDG98WOrKxdlTw/ezzfWvwRQ4c9PHl0kv+/tuHkSmJ8Xt98ffhGZ3KU0a6Sioo7PXLUtXiadLp4EwiJGOD/ZdXHwyvZv9cME5JF7apM7UmSNysC3MPmFIva+I5p/c7nK07koK9FdA3stJ8ngdbxTR0PcsbJnHJxQsPRAR/rZtbrzLMCBzVEE4YuVCdT2oYyESCUoDBqqnEqYjnhyc4QYwSa/VGkJyR9gm4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=TYvOTHMnsDmVqR+xzZphlDhwThMtWf01iAQjlYV28Fxjm7uMtQRuAe1DIKbHJ2e+5NNCxQHsl/6MiR7IhTc8MmrHWdvTj3RcI35Rh3DYw4fxiqQIjVLq0Mdwpdb71tzJi5dEJNScqUryxae9xZRNPk1kHaPL+6fty0OgzynlXYyMjcdvbHFhN3yriYAI2yH43gt43nLEJl+URcgUihYAl3bOEKSVMo+wspCkcWvMTnHLbzOWFIvoyxR8uunl3f8SBSB+V0X3jwa5PX3VnsCyx6WgnxnE+jnrPofjn4FuTbpdoPTFiBKL4ndWopxr6+Wwsq+cRZb5DDzJlTBNs6CIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=YPJqyK/iZauWzzw5GOCU9IwDlspEZ5QAXlsAWVCo/1Z5INU80ohiDtop7c2JGlQf+N+6/4ryfEz1c5KYag5UHsr2hzSEDhcxLztzZcYGycpltosFEDW4cOsUF10h4SfgAnN7MoScBTDBaOL/A9BfM6VTiL/+Zh5JQakq3LFaTlE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 51/70] bpf: remove VMA linked list
Thread-Topic: [PATCH v8 51/70] bpf: remove VMA linked list
Thread-Index: AQHYWX8/kip3zr3Ao0a3wL5ewMse0g==
Date:   Tue, 26 Apr 2022 15:06:47 +0000
Message-ID: <20220426150616.3937571-52-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61dda9b6-d065-4965-c204-08da27967bdc
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377D948366B0FA6EE32177CFDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IE96qxy848kCepXqktRNrGFoomkmmQt8qCNDtk70W6yc1WFbJrrosd3Yr4VfxCeQXEG3EG9NO5HOFLPZGGYg2uxHmlplmYDtPYBq34v8dYIvB7Dge0JzTAbObtmrlXwd8lA+jiqayHTc784mxSDWsqQrMZzD7gE34S2zvnwMF/79sGfVcTleVlYxpwz2DRbzQj2yG+mRD0kw2hMC2mvH+Z0dUitDojT9MziHux5z7dPmwcuxCzrFsEa+e/7FBkFJXWLV4fN3qRehIR0kzSpEkoVrtSb+JC7cWCLfyUbw5uORLl5OQhxxdv/+KVOyJ45Fec+su76U/pxtMginWhSlDN95U1NBfArFZCpxzN0fTxjL9qwIcfm3mz9Fv8+nqCnkPGCaq0kCiLDqWrRFxT1ZDsSy9E6khbCm7HqgzYajRAQ6Y98GJAR9D5zWK2qEkfqVSWsnbsqzMJ1MmrJCb18v+oWIXdUmOMUhuNVfiiFGMcklZPJs1Ufr0Lp4+37yQ5YhrIysw265Utpxew7ap+Lm2w6lthkWhG/ZGpKjJbHjqKIurPKau6ng8dVAEHLu8HdUfbKS5jQdNRdy7cR9RHf6VTsjHKVJPcuRD+mw4WW4zWXsJ7uGs4cnLvVqKtOjmZgvbK5cbYBOBPiCOsEUyNQeDjypH1DdWSdQfkNccjwUZuUPetucMFZEKeKcxbDrnHkIgX+SMJX3g/8l/jpgRoYjMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1OlGesgjfbyCW7V75z9bV2aB4U32kWDgo9icLIIyQJuUJ9qXltCnXkPuas?=
 =?iso-8859-1?Q?Z0blGIPG9+HSpgiqem2dqmvtL/dHNMv+C0Nmurhgx6cIeV3AM45/hyTvkL?=
 =?iso-8859-1?Q?PvrgJ6Uov8IPmKvewy9pKMosIBf3olSGedtZI+tievUS3cNsL33a3nxY/m?=
 =?iso-8859-1?Q?NNsz0mYk9l5Sflx8nNXhw1G6pzy3s3xPbhKSB1ODuAyu4llJkT6laYPw0P?=
 =?iso-8859-1?Q?OklCC5wIN3tOFZf6n1mSpJwRJe5kTwyqKuV9IX7+eHMehqHyA1LkdaUTmf?=
 =?iso-8859-1?Q?UOQLiqk8ONAgtf+2xogfmzlKaKO6ICECXkc50K59DN6qLKSIPl1CmAGQ+e?=
 =?iso-8859-1?Q?zTdBT+S6u4fESfFlC5icZavz+uhfMWa+VOK75rgDHRLiZ7g3ewmgoe/PDj?=
 =?iso-8859-1?Q?h+j7oAy4eMMhl582DHHlqf7De3BB3SmuMg9tzSo9HPo30Wub98FmC+mtIC?=
 =?iso-8859-1?Q?OBB9mRhMcBIKyXMGzxu0oCeuXDm+FA1i5RPpnM7lS0CV84K9hYU6gGOsvn?=
 =?iso-8859-1?Q?lTuGulxN8Twvds5uhU2qTalf4xnU7iaKjXGr9UnT++aBiQmYamzuRm1FRC?=
 =?iso-8859-1?Q?EnOBGXj+NvK+5+CMkYM9kckTW1Oy3G0hWUKxZhmXd1Jn3Mr5gh9RJvFTn0?=
 =?iso-8859-1?Q?5hF8g4BgiK67ZWWJlaPUf/ozI7Cn+g5FS9dErDVlaONWymTkI58b1HNFRV?=
 =?iso-8859-1?Q?Jh4WZkLv3oeib8ZnDGehrNBIcKtHJIOFkkhTgzjRY4H0sGJoTjrxRgqIsu?=
 =?iso-8859-1?Q?ya4gF8ao45uE5AXFUvv1LEsKwyVlxGKLumrQJ/xWwNk6D87ONpzqe56Z/p?=
 =?iso-8859-1?Q?klDiaDxQtNoEaTVa4HN1HiWAw6dEsXinhbNRylL4n5AFWWQ+1dO4m2woov?=
 =?iso-8859-1?Q?yi6wsWLAQIV7lVQ2EYDEavRHQPzpcQaElG5z0t7hmN0yXp2UllI0NA4EC5?=
 =?iso-8859-1?Q?kp3sP/yU6zEOkVkYxBQx8sAGF9Gt+mTgHuuwE363Ihd5VI8dsERT/qwxp7?=
 =?iso-8859-1?Q?IuaUpbroDOm5ZiQIKs0C7+IsbVgvexV5cIdONpMwGuVkyXcCTV3Z3w18P+?=
 =?iso-8859-1?Q?fTBqFTAJpxMV19H2SAZtEcDnychVdAPvG5dOBHUYC/1LsUOkxETrT/L7Od?=
 =?iso-8859-1?Q?aVGL4TR6jGTkwjS3ViM67DAP9HbigBI1yCYq6WCNfeaxkSqWjFTJOEd309?=
 =?iso-8859-1?Q?75O2Z1yH7xqNBQMGKImlINqD8i+BHR2ftK/4TTO1z/IITmaBvOflOueaGs?=
 =?iso-8859-1?Q?APtS7A7abs6gDHT21f2ohVMrdjdMoNdDgLvnnPMqOthH+sbCwJ80saDb68?=
 =?iso-8859-1?Q?n1xb22zbB0TpVoJ8Xugt423Eh4kQ37tBVCUCDoi2T126l0inwpmJK7DZQ7?=
 =?iso-8859-1?Q?taeDan5SsojAIu7IHcr/KGLNvA7FbyOhVXzW+DPeE7QOjaDNfG7nilYRlN?=
 =?iso-8859-1?Q?84EVF7wkr2/fkIJQ5yoV0lLeR9G6T87VNo1OVNFTT5REITMhMw4LDAAF11?=
 =?iso-8859-1?Q?4lwqw5mP4OrrLJKJJPtPExp2IrLr6DahmN7oV/W+ohBzB+5bH2K8H8EpaP?=
 =?iso-8859-1?Q?j42TX4jV6hu+LJ8EtRYnD008HjAsG309EJfk2s3lpalUlf+EZgc1u9+juk?=
 =?iso-8859-1?Q?00RyorHoy6WoC+HnhFATTjm02h0lV//1Ch3S7bVYfdtUiKiSEQUoP+pK1n?=
 =?iso-8859-1?Q?VBun9T6SeTuYFWxEr3SJGV/iYi1zdgxf66vtSOEhFBi1gGuNxcFpkD1qxq?=
 =?iso-8859-1?Q?Km009hyW48Ep9a2Q6hydmgC0dCvBkjCk8dHtLTOeyASl7IHMI14DzNegt5?=
 =?iso-8859-1?Q?G/n5/ST7T1Br59moxsI10RlUw+SadKE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dda9b6-d065-4965-c204-08da27967bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:47.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Q4TL7gNXouwmGzMt+a1qT5l+dU/VW9nsGOxraxE+xEAz6tUxdjp4HOg36nc5ujvE1Vz329NhDJVcdAoN3sUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 511UQX9iA6AGSf-qq6L7PwTERZUjb3XJ
X-Proofpoint-ORIG-GUID: 511UQX9iA6AGSf-qq6L7PwTERZUjb3XJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d94696198ef8..9a0bbc808433 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -300,8 +300,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -401,10 +401,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -418,7 +418,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.35.1
