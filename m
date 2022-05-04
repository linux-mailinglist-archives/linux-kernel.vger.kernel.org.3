Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB3519369
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiEDBVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47150443F8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnJSE013484;
        Wed, 4 May 2022 01:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=R1xYEt+OPnuUBSMOBrdr1bVNYJeW+XCy2bQpbCmF+lZfKpMaOQcZsce1oTNm62ZBqTdp
 vBJhY4UzOnoHTRb12KlWN0S2fIic+hAtBYzJelZ8opKKMXpeBUdFXGqtNNS5wJcylCYP
 2e2BTLInaEMe0AUb3TIs0Vz19ivRZMZTZhuBcltvPV+2g75EQMkzXk/qGxmeFXwSOR2K
 UaV4I3vXXK+7JLhp7QY+sMx0kOSW1sAfeYZK6GqgqmkaaweeDy6ZGqvnrGloGykl3+5v
 XSjuJYhgNNTYyyFAUSp4Y1PO/FWTCoDMbvPWH2hmEFGowJBQI/wI6XLPt0NyC/PieXj+ lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AUFc023411;
        Wed, 4 May 2022 01:14:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9g4fp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT6IxLLK1euvg9DgNaFphe4QwQ7bSOWttcuUXkCjY0Kea6fEGpmDKO/fRvsGsD3xhn3ZnythmQKQ8A2WdHxvZkVhl20r/JBUQ+qeJwn5c/z/xL3mN8zZeBZf15LC+4qJSGz7fhnHLWfgEM1h0XLUM+yIO5x7waBU3OPAWg3RL+H0xhq+4M1m44Kj1uABFvifXbPI5GlI95wXJxHTMZcvdNWpCdCsm+kAFuJx1C9MzyNqm8Lw+T/Kg7Q6dscdB2CryZMzZNaKxYZy8jpVMSkYeFOqY6s7eEqTCY2VUCGLxwy4qbWzjKLxOKIcgchbuCtoNw+vzfy364AF9xH5W86o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=SZZvcqHI5qGo50Uqe2t3aACdIOl+Wx7WOaYhJVP6ekFv9T+E/COY1v1b9quXAIKekzxF3oi1xPM6SUP2RW2aX/ChchSv0xGL1s0Sg8KekRxgSIULHZYBVWGRaB5uuR7UUpmfrXRLkLCMQvbLIAq8nQjqqurkPamxk7lnP9vE8M6NUU7nGIE45TmcLoN0SnsZRLlG9F3fIpfP4rDf/N7IViI+I/wU18nLC6OPVuF5CQ4zuOPhSpSsauJD6Z6JvT7Sijny80/PZkg2LGH7qXLVAA8VBKhaZxy8NzGdRctfhoakfg/CNuQOhK6/5qpDIR/8X4tfN8pqGdR8ts8UMcZBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyz3PxHVjK6B3/q2iPn/dnS5gbHkdsvEg8ysspfoiW4=;
 b=YaLsOFkV7AaKp36EybGLFbEduerX2EaHsm7cbGiL3HElRq7RwfhqKge5derFSusVBMomkqoMf3wesdJ0pRxuU4C6aE1mP+d9I2IUaTdkXkaBOoUzRfeD4gJpcIjRic3/o2/yPQrU8BEm3IMW015agXh6rq0ytcEdWDA0UodAJs8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 50/69] bpf: remove VMA linked list
Thread-Topic: [PATCH v9 50/69] bpf: remove VMA linked list
Thread-Index: AQHYX1Q9vQsGKESn1UKSfp/Zbw/+Yw==
Date:   Wed, 4 May 2022 01:14:01 +0000
Message-ID: <20220504011345.662299-35-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2a96818-6ba3-44ec-1d12-08da2d6b74a8
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728A676D95162989A374F0DFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKKoatc37QXNiZRInzO6vPys48OuHRv9A909SeSlzwc6T8QHahVgr71Vwmq90OGK7ONS4i2AzC9/riV91FPRasrFTZttHzB4/v8JT4bGjcj3K7y0Bmah+1kFdoWSe6khPGbyJ6j8zSvezSWiYx6/3hHS8panXmxG0jPEo762gDVEuuXf3GLGYZ5zw2p4G1emYIFTPZWwFdVHwht5EwJ2aFMO8wbC9pu3q9KuDsp2oWhowbW+E/DlfvRf72YT972IB7BzZW7TEvelhmuMXp0kHu8URl1HcrpcnESDpaeXwmQWJTh8/LCfEhCRa5BCGL1PRgfM3LUdkdhxWkqcS66nMj9tuTI2AOY00YLUMmAgyMQL6TGJtZaF/eJ6A0xcX/yVzRoZHJ0N5wtViqKihw7mINjHPv9uLrMNnSdej03pYkjHHtOHVC+OvLURF9D4IV2vfWXjQMeM4PROeXsIOrMLgUqBY9PZc5L/H9trn8QhFBY8TCAgGj+aqbSnLe92IzNu2H5Ohsl3MoqhWhNfetaEvZvlLiteAViYl8VIsEzLAQvb+UmLhpKP1loZ/lymPLPsg0M1JsB/E9VTfTO+PENMLcXKw0z55nb1HKGLIAbAC9hQKIztJifQ6hyQL+PxffcSfWLy2MVY04X//jrllWebVy3HmFyBcz8xCuxor9cY/r/l/8H+VRVu4Iyx19f09zWQFSuvabszrcBjbjPII/WB1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q2eW/EDQ54aGIQL/MAFvQW4ZptUeDC3AAYjtzIQJ36zm96sSh3DOqkqWAL?=
 =?iso-8859-1?Q?Qg3dXUgOhEXMncbDnCSUrVsKArO46pOjSemEJE8U8lXjAUnU2FRGUHB6A1?=
 =?iso-8859-1?Q?msPJ8ZyozaX4XiY4vVBMilQ/pZhipxIjH8yjaCTi5UyLlreSyQ09682ltr?=
 =?iso-8859-1?Q?Zx7hwQhrYzhakeYdfXJZwIATXL/RD393BeNli59p4zQU7W9hoVSbYtJsPS?=
 =?iso-8859-1?Q?ldr2QMMb5/xYCfjyxxPciAzi/+TgSmtkjS9WkinemME+g2N5TL15GE++zB?=
 =?iso-8859-1?Q?tgKqBwNqmNJVd185b8JjI4EKmWcqppY94DJ43xZNjvdQbsmWc+m9r2THBq?=
 =?iso-8859-1?Q?6lOdqpyMmXmg2jI7XiOq1rcWE+FsZyBxDzb9GeOJbRDw6o1KIuKsPA4YtS?=
 =?iso-8859-1?Q?5bCL+ppHmzqFPh6wG/MMNUPKj6/EV4al5eI5qSdeCSxnuTBYA9Kfflj79H?=
 =?iso-8859-1?Q?q6pErpJChTJzb6wILabogovU9X1JNW2G8Mw2C6UGrbqxQixp3b5wF9g9vx?=
 =?iso-8859-1?Q?M5elF8MPwl9Bcp9YWCsLrqNG01RvZDTvyBLlmmwY844Y0zEPDeq6u1v7Uf?=
 =?iso-8859-1?Q?R9YcIBW+uieXBxBvxcHqAJlbzHG4N9jYeWg4LRlYzPio2z1ayaDhb/blYP?=
 =?iso-8859-1?Q?Aynf3LlUaKajbFE7BEL8vdpNoepEehOZJp0hwQTO3DGwPEtxb9g+KjxLYx?=
 =?iso-8859-1?Q?ioB95Rgz6co7gjZn+LVd8IEWvMkuFPujDBBQu2RvCpAfGyWqd/9RuqHvrj?=
 =?iso-8859-1?Q?Oke5mNgdX8GlmQHttELjK3m84xZ96xJ9zGXLqgRGBHHAAdfu+F5+0vmZ/3?=
 =?iso-8859-1?Q?Wvb2CTqBFT+nSLfSszgvJ8wSrcFnbD4QXSbHUxlf8WF9h2iOaYBq3EbdUf?=
 =?iso-8859-1?Q?eW6EyMF6N9xoCqEAxppksC9YYRe6rZHxf2UmOTmZGwzZHfLTbu4Okweu4l?=
 =?iso-8859-1?Q?tPtqb1pwJCrv+ZfIccSyyo3E23ja95ZIr4/hHk5Z7F6Ik2szocMSJ+p6fG?=
 =?iso-8859-1?Q?e5afn/xrX3eoZ0T+4AMAp3Kl/znLSJjlOENobw7uEU2NtAJ+t5xTYerhtl?=
 =?iso-8859-1?Q?w2zJ9V2wG2jzmf8BPXk1t7Ai70GQsBfYfoCXfqzY+VDtgOCsrtueE4Ggjd?=
 =?iso-8859-1?Q?fBoittmSUsvLUJd79XWk7Nfs0/BGI+r921CD9dhgxAd9dYoeNM714aREZs?=
 =?iso-8859-1?Q?HGF0TgJk3U6kZXspZnLDBd7SA65sNlYbqB+8WshMB3Wg2hs2PZ4KrnmNgo?=
 =?iso-8859-1?Q?SfjTV6z8Lj5IGarXTXlq6SQN9fe5ClW997FPDMB5p+1IVeuzeWtg6g9Tzt?=
 =?iso-8859-1?Q?xhczRm/Dfr8rN3cUZqa9916kGvZ0VbnbjR4Ac14Ugg0Kf6tDNCrmaKgt43?=
 =?iso-8859-1?Q?eoZs7iFLPU2nidXVyate5Ly6aqxGq2Q/AtmAoCZSEUuvab+XQR/o2PBw+V?=
 =?iso-8859-1?Q?+pnIQTbmqcyvLy0y1ird49ymDxpK9n/mY+MdxWbunb4xF+0RWOV2eqZBKW?=
 =?iso-8859-1?Q?gJAJUawrEkCEB90MK3xkp5iHKqT+a1N13r6ZRIsOL6mg+rn4hsUQsIS6iv?=
 =?iso-8859-1?Q?dEYpkYSvtpiBxe722ntS+EI2lmfKilB3wGn1oHungrRfoDYxTRfEppO7Nx?=
 =?iso-8859-1?Q?IPCQYP8boGWmTlCUpgC5tx9oA4u+dP8qK1im/mfAp0CICd1xkZS/LGt1DM?=
 =?iso-8859-1?Q?Zewq8fXWiCY27pidwMd8gloWDK7j+y4dyHgVBizyX670hw9+BH5irupvRp?=
 =?iso-8859-1?Q?dzFbQ4SQwoAAWD5oQPz58Rg4lkP2Cw0wgG2mm7qESDagmnAgFMGdlNT0Y0?=
 =?iso-8859-1?Q?d/P1EE50MkE3F6UHwN/qAJB3BDisScc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a96818-6ba3-44ec-1d12-08da2d6b74a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:01.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JrVFhBdtlqknHBIAWtg98WDLCkohuVzGP/4TdlErvHlqSUe9Lad90ZtnFpB+YZoDecwZjnQ9owbx91+MN5BvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: 5g6BGiViF4zOq5wocdPjTS31ODB1PKpB
X-Proofpoint-ORIG-GUID: 5g6BGiViF4zOq5wocdPjTS31ODB1PKpB
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
