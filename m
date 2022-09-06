Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD85AF4EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiIFTwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIFTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185287D787
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9gv019965;
        Tue, 6 Sep 2022 19:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=lXUoW2vDXxa7onNMF5JTUHKiE+f7ISivt2BRB2Z2WpQJ71grZls9xeNky3B1lHBJghUG
 IPBPj/Sw3kBuh9x02Mz2jOPxeYlg75TwgMj2Fp0udkboB7XyngpDtpz1TByIHhWT2Cwh
 +xSkNtcRhy7Geu6MOoQCICaLDY/gUXXYRMUITykz3k/h+xQQAN29hewAQZW9gArOHFtL
 QnJPCELyMrijIZTZ/S3bkLDEMlcKBiEobQhIBcPJmKir8K9nK1aJ38VZpSm+mSXS+PjI
 ARWQez1bBV6enOwzsyAdYs1S6xaYEcpBiNqcm0e2/GH8wyAzH2V9ISfqc92VW1F8632G Tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67P031251;
        Tue, 6 Sep 2022 19:49:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP4xUmTH03ddbhnclvTJhYeO16CduQAvvSfrhfbDEOXzB2MqO2W7IJhVzI5y78PLz8oX8Q4g2AnhZZnM+z6Tu82oCHklVLpiN9zJd9OLMklVPxE5L35pU4hTsc/8l1WcvuGL7Fj+s1XmSQTTdVWXckZJKe4PzT7Ws7gWjEdLors32U8R0FqePt8E6pSYQhQDX1FGQcN/+P0nStaU2BQDVf63e4evoPc7Yv0NMUyuPWH4S7Bckj3ppjaBre7QCPszkZoNWrm4vdJ8Fc6K08TMYodPPwDiGCERJlxbC/mN1T/EdKepIbqqaWQ0S3TNz4T8o8OKKyu7U0oGaFrCk9UZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=UrnUhvQnbIJ4zeVJ9qZ6aDrBaPoaDj8EVByZtrzN2QNOJGxnsSxgWUDLLKior70kV4H6DRISHifRzI5LKOS9Xo02JJHlqzVHlvQj3VDYyN/WQ2b7ZQ6YgRRqXV4x+eAHD2LIrlcxknm7v8l+1KQjExszBciRWHh2Qkn/JBtjrPhb6038mNNXvpf6EXvO/mkJoBpxRDdB2lc3yZgxnp+X5Wq2sRF4t7OU8XKYUlKpfOW/Pa/JI91+jzpZUb5QRWWdMAruYTyetsBk7AiuwhI0d7NnGgAy17TNf4fVgdaovqgC1guYRzjkwCXHFMuGWRaHRuGnfM/LUGsNbIDRpIBLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=oiEWgBMdd6JS0p3OIqDNaJUn7stDckoWvJ2BJX5Eu+azu4Qas1+LeUf+zpE4m/CES54YIh7YjNEw21XijFFZILCQmShNRo6Rm+bhO0yWUjCgejamvZeSKp2vdn6VbNC9tteYjuIUkKQqPVg0Vn5WSQAhUiFjjpZEA1w6A8CqCJw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 50/70] bpf: remove VMA linked list
Thread-Topic: [PATCH v14 50/70] bpf: remove VMA linked list
Thread-Index: AQHYwim1B2dPT8sINEuxow7qdJLGXw==
Date:   Tue, 6 Sep 2022 19:48:59 +0000
Message-ID: <20220906194824.2110408-51-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56f9c4f7-9cf9-48f9-a221-08da9040f32a
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Js5lyIIgYmPGN13vWLBGb1A/sav32wPHJzzwMgGZFKfNg6iwMKIe0r1MgJwKnzKSCH8AEaBJdY9nh2m1j70psTO/bYBI7HiA80isT0BSj1T3aEYWtncJ3Bue8REhvHCtJGUMxOaIAqJYi12ffBKJ0szPf8CpcRddBUA3QndhWV0/DsDjabNdVuSZNA4z1voga1TcsJZbcKdrWud58rLQGe/Rt4Y9Gflhp9IX/cYtrmuwFfo9vWxPBQ/HSfIKtJ3uL1I3/KF/qNYAx0zbE4wzHyLQk132igEL8LsRrcu2QdLtpHaVLs774pcf/i0CVTCLzmUykeFB9C/gZMvKefxzk4NZo7XKLm0ZuNlOJ99i+XsHPAatAVK7MV4ER2YUSf1J3h5zO1gIC9ahDlDP2M8V6z8OzXXksxHxz5WQplmgTvLux6NdB6CxIr78JFmtUKiefFZTZVVhAJt/+sc9guowt6YiNAlun1c5swuswr/PNjLZNHV7kfLC3kMG7PscAVeuhS7Z0cBOlvpOOHVMduMgRRAWPz/ZrSzrZz6w6iOBElgdFPqSAGjExI37dEvXNPv0YGkJY8OLVoolCZI2MZssnEXmO7F2FiQTz0K8fs0GTWp60F0uu7DxJJry4QhLnuLkCmztOk4ReHXIvu4u4EWL8WJX6GGyodNzwxqxUeITtP/Txx3ySdrZHu3iBhn/KHlQsgFs7ANdJAC73edZ6nXx2MjpjFawVbMT7xU4zWs31mIPUo2ah2ACSksqlEWulp0uyWm04H0tewcw/sHgdkRvzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(316002)(86362001)(107886003)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f4IK1ngMy2YhqLF9/DOsImIDRwM7TAQrrujrMn8JpvIgeIVvd3PPn7A42M?=
 =?iso-8859-1?Q?pPvINmuOBKxWRQs7lOqymEqtNg3UX+WZqa8GmGoNBHc1Y2eXFI4U6qjsdl?=
 =?iso-8859-1?Q?ercYWxgJ+6gKHII0f39SnbrVyQ3BCl+c56hVGhnfiqCt8zSwRyjhaDiUrB?=
 =?iso-8859-1?Q?WOlD4NwCynTE2ddeo5d0gkV+1QEcnPTVswxXKY1VRoSE7REj7esNjFoxsU?=
 =?iso-8859-1?Q?O7/BjubrEr2peLcVhX7HybU2/X/6XRF26ZVz8d/H6t+mUHi68OrB2685nv?=
 =?iso-8859-1?Q?xKDOrvJP6r7mlb2cxAxEA73ywj/2BWzgvX+trw+m2kcsdycuwr3Rwbo4JR?=
 =?iso-8859-1?Q?JEiyL9tjI7jgLMGHw/lQ50Ki9USecMZRl794o/grK4ciGHoTgp+OU2Jfqv?=
 =?iso-8859-1?Q?WusvUCJN56LMYH0IdchMSNswGBKfGej/ryujPfsYDI/0MmreBaL6m0z0uz?=
 =?iso-8859-1?Q?xZnNpsU4Xakk4uMYtUQOPcKq8mH1l2egnNLLfWFkuuY1UTKXIEGbu+lLq4?=
 =?iso-8859-1?Q?ZWUpaDlRaP61j4iCOKhipiGebkZVRfpVHEikJv5iKOV8q7HhBmwMRt1M9V?=
 =?iso-8859-1?Q?OhE7hg7GTy1I6Ly1L4j+5SraF0QlDXOkPknQPiuYeZx+iAgQaWmZmxwB25?=
 =?iso-8859-1?Q?Pc1ilYrdN+lHnfFsKQmpfO660T/E4DTnlmv7wJD06eciDZ+JvrNHAkkrhT?=
 =?iso-8859-1?Q?ew2+oWGWjGnk2TcVabx6Qzhv0RzHJQCazWxVgsOAQ5YABUqocXKAon8eWY?=
 =?iso-8859-1?Q?kH4HiXlES49KE+nUThpPkB3yspB5BRX2Kkf7DNs4qPXOtYUGAQr/+qPhWu?=
 =?iso-8859-1?Q?AwJbEbkV5/ANL8pJIDajh+5MIDBo5UsMno7BLEv0d+zSIcL0Aaqzto5lSL?=
 =?iso-8859-1?Q?Jog2fY51Ei1bOGz7M631/BJvwLwLCDNN5Uh9nE+zP7Cr5z3Q0VIR5Le6WR?=
 =?iso-8859-1?Q?L/dpeoK86Zfo097LW7rvSNqVopvJryVL3UR9cK/svwv+7A8MDHRY0xIFvp?=
 =?iso-8859-1?Q?jxmPSMtiIgBrilmMCSwA3xRoCI6QWFL7qw8zT///ojbNNU7LjOTaM+xZcf?=
 =?iso-8859-1?Q?whlMj8wnfDTCgk0Yo7lZxDflNoBZGYbB+xc7OwZMn2rKlEuvxNmcbFQiO6?=
 =?iso-8859-1?Q?pWoF8Lk1+8ZKlDerIRRqtni+VS87G9EIHpYll8wTlyDYYUwpMZE3CgvMIy?=
 =?iso-8859-1?Q?NDu1H+0hJyuIMglTDzHnBfwxvGOnxebRYqrk8jgTyIUfKHEYUITEgQkDXd?=
 =?iso-8859-1?Q?mZUntGpfYxxykZlJWtb4VjedBt4On5+47KHAyE9BF6q0eB+wNijSVRo3N2?=
 =?iso-8859-1?Q?jiJLgrsS/RbKoOeMMHAZRM9AoIH4EyPabH1vlwgbS72v5ufUdElalLR0yI?=
 =?iso-8859-1?Q?91CTIglGqUTFGjSE58CB+FK+1lZnzqHHiOIPGVTUCvPKzCN66yTf+1/7e4?=
 =?iso-8859-1?Q?rWvyveL5kZ8IqpHcnkI9FK47FLdy6YJXd8maau4edRhCY5wdsO8rSKPi81?=
 =?iso-8859-1?Q?6dOeZi/oSjgY/6HgWqqLeRnRehiaAifTeudNGYTlGESBLV7lqlOZD7Wucc?=
 =?iso-8859-1?Q?kqcYJjyRrJf1uJ9V+QZNsNzV76rN7DzrdBtsUiohA0jLiMY+lDXF9XXxEA?=
 =?iso-8859-1?Q?bxIzwmvn2Wk2zGFsUGa4y4tTwI8+2gnaSIryp4qFMtT6hOD5Ig2jOF2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f9c4f7-9cf9-48f9-a221-08da9040f32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:59.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEbwdUqrMIfprLIbI4TqtcNIxOGq/MBeduNHG0D7lsdowPYQ/nfoR4IebaEqJ7MpXnuSOMGWTumYGuyhw08yLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: 1HNf8BlSBHlvlS1Fp27FK1DbPjVKFkZG
X-Proofpoint-ORIG-GUID: 1HNf8BlSBHlvlS1Fp27FK1DbPjVKFkZG
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

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..1c8debd42dc9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
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
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
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
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
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
