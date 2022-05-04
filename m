Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9D51935C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiEDBTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245114AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC4434BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243N1sJ1003197;
        Wed, 4 May 2022 01:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uHYq9OiwrQfsdBG9rOOWiNjAOBhrQhYxo34Y5T2TPRI=;
 b=hx6ZqgiGqHtlcpboP9X6qVSxRR2LVGwNX6kjZ34Eb8ykcH1zChoyRcGBWejiDptbgnan
 NCMITL0ZH0AsM9wXf/5EN4rd8RLBjWs7QH1yjiMbVQEoC/dcy0JvkLgP0pAkHrpgg9Q1
 T8BUP8sLz/rd4nmOgegw01CxH110Hl5yEuBUfVtnlKJ282/W7OUlW/5BxOwds0VEb2hI
 DeFraG1am20WnKVCxYSbIAg2AdTcOUEAtHmgN8vrCdM3pnfJF3JEIpbilkejDjdccuBR
 bonrE1B3dVDz1lvQLDnZL4htwN1pj1XSwgHeAizhG8v01Xds1N8L91bZw06L8iQS7RWF VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apy0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441ArQ0020035;
        Wed, 4 May 2022 01:14:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922jf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsiuzN7I9wl7l3Ov5kxJwpTqscvvMAUcJPxOVlcuurvmQPEDLy+AStHAHUxUDExbvx3DFBXhoYEWsHzVHoXLBVdDphDZe+hfBMFf2mtOf7bwJ95xphBenT15pg9pGwncMACZ1zybn0uoQ7bPcf8dbIYKvBxOawaO6Bl8z25GTJmkkNGjGt5ggtG6IpClJLAc1wCaJWECKXoQciFXibdhepHU9+DWfaVnbxkkyx7W24gefrb9OeoFTC6ZjStw4Xhjqns2oKI4pVXrY2DbQcOCw2JrhPO/JBBTMR6RIQStmvFIpHb9aj3fgcMX2a05Zk0dvg1cUp0EFmk2Ju5qnRTveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHYq9OiwrQfsdBG9rOOWiNjAOBhrQhYxo34Y5T2TPRI=;
 b=IDWz1/WKXgU2bFIPX58Z7lNdA2B+egNj5UtlgFgIFFS8XLnXiZkjJSNLrhUcXxYYn4EnVcEq6+McolBqVXlCEbD1SqX+WqPMGDYQAg4Fv0drmrEeGjO+iXdP6eCuoOxD+P7T1nSjthmO2h5rYlmtEJbNKcbuASEaJsLFCMjDasOT628xg23831gZG+duUFAdPd7tWcsIIG99+uG4Bp4xpVQKW4Q4bXXgVlepJHhq4AO5LtuXPWLO7CeC6XoDvxlTNPmCiaZiG/FsmjqtHNa+SYeL2/h1Rsl9pdMmnTgAR6hs0NSUwkE4ztsTFnB47ICyRI3PzZG5k72AjTJjKJtzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHYq9OiwrQfsdBG9rOOWiNjAOBhrQhYxo34Y5T2TPRI=;
 b=g6Uq3BNx4UPscGgqNmWDnpH58O7zp2SuSCxDZF5C5DcCJO3xuh0pk2wQZuA+xQ4PRXZ9enKdxbG0HfvwTeiLvoKW10shYG1Z3MxgjN/2Y5zFHqXQ6u6whoG5wScIRhp3hSCvIlV+rXPUsDLiHAoVVtWRYZtBy93NrPBjMdO1dH0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v9 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYX1Q7yAtaJnaxXUmhJlZFpjSlpA==
Date:   Wed, 4 May 2022 01:13:59 +0000
Message-ID: <20220504011345.662299-28-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5505adf1-4f90-449c-2a98-08da2d6b6056
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB37282EBC0F0FF714BABA98E0FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSDqrjMQiothZjArOcebV1c/VGPcUZEvOsWhToRb0j+M/jkUexhCvLh1BOUjuM8eXCniuimYqr4d5+XiFBE4++BGZpd0q4tjS2ANaUCGVSyf1rUz67UzrVgKeDa0abw4l0FzWfwBOEg5S/QsJtbvBGWE9G9eOiJKrFotGL/UfVWn2kG2JuCZhKeRRJNFofb7R5/RDjNwbmMJTRGAa9RS4ITDe6x6nV48YbzvVPmGGFtrCRnDcmPCdqmwh3smTZO5hyOy4d9qC2v5awIOUpwNFpyQVykXHTQJ7hG/t9fJdiKZqY4VvXxqARCpozDs7oVML+yxjlidmqXrANx3ZKdK7rlxB5GcMfO6SdHUcKdlbqrFUWsXZ8fcU+nrp+ESMonYl3fmMZxkvKu3ZcZ7NL4JhhQKLGPlriiF6/4Iz2wTC82my+HhIC2jxQmfZMUEH8eCXZFloKulQO/KNmrz7ydnMJCtIQM7qaF0NraR44C+w9yiw4ziEzv6MomeM1TVI2PaU0+B/1nZkr2kWRfzDo1hm9p3kacqK/euxWOL8/JBAWMFE+GPPTeGdcW4Ub1c0UYggR0jM8Tz+/nHRHQm5tAxBS7m1sWFaa/RmZ3t3jA8iBOBb75LY9oLlM0psPYrzFlECVaVGz0/LMtDI7WoMH+4QaBnLYZHV5SleqYoFvxr2xEdN+Nrebk5L+11PR4hIYy6t7Hr64K9LVIU0vnaorTKFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ovs/bN0lJyQ3oCEA16JP9SWhU7h6gbgWIURIenG26y9LYE0HetLlOTIKXQ?=
 =?iso-8859-1?Q?zL8GIgraMAKKjLBSrtkP0w6+UM0x8WmHG8CgbPB0MkY90KVgffGEI2oFb7?=
 =?iso-8859-1?Q?JONPZsXe1ZrzOVbxlbzJj7NkE4GI0yMXwjh40E0s3/JrR2cgcQ7g78iFll?=
 =?iso-8859-1?Q?l7vnvSCxCzaFV4a6ShwCJbJ2niOEhyhd3R8g2QT39YsNNjrgW7fTwycRPi?=
 =?iso-8859-1?Q?w/zx7ogHDPfaPJ7Wx3gFNqhRmUoHGbBTPfU8uS8ReecD5aoozLzwhoOSei?=
 =?iso-8859-1?Q?1ZlqzMPmMieKsM1dRJiWOeoDouivNiFKVfYZ/U/Cn629/GL+zhuto1IxI2?=
 =?iso-8859-1?Q?qy2HOujwq4BCdxN7q+3cJUTxMPhK6fOmvyIq0PZlxDgRq+2PcoviozcDu5?=
 =?iso-8859-1?Q?2ZvM0zOiW3yZs5pbDomYLRIjjDC0mnBVtG4q4mTBH/lrY+vilOlpUwnyxe?=
 =?iso-8859-1?Q?NJqfQG6mOlX+z3J5l8H1ywqkA6fiMwUyumg/eyAhnNMnfGaZtA9EnqZrQD?=
 =?iso-8859-1?Q?mpi//f+4XbpKAhvIR61lxoSCNp/EQKNzu+osOTzjJ9rcJE1J/bPKHhuTHA?=
 =?iso-8859-1?Q?X8OGxHqsjk5vyBUSrASgsWzu+61xn9DwWLVMD4fn5d7UOc2UFslzVOygLB?=
 =?iso-8859-1?Q?oVCAYbj9/mgESbthsKgunJmAP1I8werl3Yoopti14JBaLBs2wTZWp8A1bZ?=
 =?iso-8859-1?Q?g1a/Or97W/92h3PP1BId/vBYtfpReHwonRNEpGeNqB+jRNfqErkSvbhdNm?=
 =?iso-8859-1?Q?P5LwlBA/zG6+wXxue3b+TNoSkrDgjcN5XrKcx7+VVhzwoJeYe1nuomVFqx?=
 =?iso-8859-1?Q?8DOZk2j5MjqI6CrCNjoODYxw/rZllfDzSLOdYeU3HGJbqIdcNNbzQse62S?=
 =?iso-8859-1?Q?2G/wmz7xdFoNdO4Y5GlcmpPNst7hwR6Am+olMGHmQUEAkP5WhvFeFSU2tl?=
 =?iso-8859-1?Q?/QA94kpVGAiZBA8s8+U9yukVR+F7w163YZJhGBwleOG3LdFCyqyJ9IHkmg?=
 =?iso-8859-1?Q?ETfoDUNJQTy4YVw+C600sXmOrQGRLinREg7BLvgNqzTloJiPxJpyyfqpQx?=
 =?iso-8859-1?Q?F15QH4CQ7cg6aq9Gq2XVU2hHjHY9KGQUn81UqvRZnBhPVGkViyoKN/ilR/?=
 =?iso-8859-1?Q?Xk4zYo3NSUVAwfft00s7WOuFPbJ9qCzVO5mcFalWGO/TgJnybLHWgxWXbV?=
 =?iso-8859-1?Q?8YskRzDvNdftaroASKTAs3BtaZTbIdaY/4u4MzgmgiSeXs++EpKjEHkwhf?=
 =?iso-8859-1?Q?deWpjPaarofeBZ57XhBi2zOH71JS297AP94nuhToyhWoqpWRSlWIEwAKi2?=
 =?iso-8859-1?Q?Sv6LeMPm3kcTgx16XMZAxc2WsyKcVhjmd4JjJ6YTdiMI4s25FvWpkMBZnY?=
 =?iso-8859-1?Q?/4HXH8nnn8s59+NYNwuw72r0UoMt+dBXRXEDhPAp3qfWZHaXsryjBK/ZBF?=
 =?iso-8859-1?Q?eAxICyYJY3WQZE0IoCH3idzdlY4RA4vX1ZAA2X5qpeIOUmrAvt4G+9LS+o?=
 =?iso-8859-1?Q?nW0eKsuMnvNUzBEC29qVcTLx3aT4EO6Obcm/BAWwf6AJN3GymEbB0i748R?=
 =?iso-8859-1?Q?pmitT0SLQf4i3QwzniB+baTKej7ZBJtby04e8j1JwsGrgW8jSmayRWDZFc?=
 =?iso-8859-1?Q?ImTzErF2hUgYrqq3E8eRbH8E/XBmYZ5mq6WWUX7wzI0harpZpQOmxb2HDY?=
 =?iso-8859-1?Q?/hO/kzsMOoUVLryQ8Dkf7ra1fodSQIZb0O0xjFaZlHrsU9paiNlCb5n+VN?=
 =?iso-8859-1?Q?cU3rKo9URSWQyYqj/1rZ/VUfz8BS5wm+mx3znfPdv41d0q14JvInMOIweR?=
 =?iso-8859-1?Q?lgurzkp8IFGMgrcI7adqK9jpprCHHqk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5505adf1-4f90-449c-2a98-08da2d6b6056
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:59.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMHXB7WkjAiuDlKzfUtEZxqBwUKCEJ5PyOR8JLdAFOQu4YidkU/L1ohrqzIy/D0BM3hsIehTdBUCUCgfcjyfhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: ztJAUJjAsZuf_uemfl8LoO3sefnQfznO
X-Proofpoint-ORIG-GUID: ztJAUJjAsZuf_uemfl8LoO3sefnQfznO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b940b969b000..b59b053e91d4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -872,16 +876,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -894,8 +898,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -904,6 +913,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -947,7 +957,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -961,11 +971,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1258,6 +1267,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1277,7 +1287,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1289,8 +1299,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.35.1
