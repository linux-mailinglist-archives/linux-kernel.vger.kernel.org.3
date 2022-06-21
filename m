Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59F553C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354596AbiFUUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354734AbiFUUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98C2DABD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5hUi018658;
        Tue, 21 Jun 2022 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xtjvl5YWmlEdka0WqB4owoRmlLwdLiOBHl+NG7erKfU=;
 b=OBPHq+GTVQvcwtsyt1Noe7bc5gAsschFZsex9ZqlerI/JEvImTczq5dmTafNRIELHoir
 C0GsoJuW82CnTp6neJaMX96sE0ouEfMMwOldWCZgeyREi5Z1mrDm6IEYJjyZ3qWXJBzk
 Jo1LoH0CTfQ+WLgdvdpSNK2n+9WmR1C3WdZrQIINUhI6+qH5+dOjZen7m6OL962sVqyY
 NvqtqfpWgAl4ZfywyvCOvH472M5cCJpU6JMftvZaXlmNUsbFnILqXmhPEwu7mdAxs3k9
 DA0//Ij0xWvqP0oK0PQnM7ljhDRnl5IvCVOfGMpVceyYIkaOBMGrFylLbcDbUFilRiHC tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdvMG010099;
        Tue, 21 Jun 2022 20:47:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvuke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va/YR79qtih7HWNkHzstEUofxPMX+U7ahEhdWcq1b60iPEdezrScOk/nJR9klWAF1L1+Y34LQQEoUwSi2vj3QuFK/Y4yV/+KAIVU681S0slpev79c/AnOKuV+fCbMVu/SExpT5xY8fQDCiBeBde62FLh0FClNs91nvtZEVHK82f/77shzk5uKc83r5trHHUcqNp8ZUn7f11xRbx676MNiy1blkGvfdh65lSvJSm2QxNGX+XFqWcstw+tsuMx+QfUOoHAArt7NGLbQEB7m5M+QHEvvt3m/MuHTiP8+/xAZtXXwyVFDhkI1geG+5xBAJWhEPGeECkV4H0qk+Fxi233uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtjvl5YWmlEdka0WqB4owoRmlLwdLiOBHl+NG7erKfU=;
 b=Q6t++j/2jvI3gIuTGlSVcutJIFPDw9g79DG28acWhpM12aipAS9DkQeKZBOQh20DYD2Q6uABKbnFLWEoMkJnJESFndALOjGhGSpl3SOkwOtIJegN3tqYLEuVWJu4rt8TKK/phTP4yGs6a5lRb1gth2b9VhX7KpFirKYz7zEuAmFFJkqBaLG8V6pHl+RfAxwBGDPN1DFe1k87cujCxgHchy1mDMiK3hVGiNFxMwPDeKzXyIPrQu9B2nzZmc3jlgPxXPd/nss1AeeGLNeHKthbo+bxq5KoPeKM4AfbByPMFnKgxWTyWFTrv6m3lqfwGXBzVRwb4NyW5X/NVTootNbqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtjvl5YWmlEdka0WqB4owoRmlLwdLiOBHl+NG7erKfU=;
 b=QtEptfBdrCx6hC0C102kJipB1j3e5sCF6KA2D6BjcGy7riuo9W0/oa19/ZXJ8w8CRX6+rDLex7kKzqIWvA1D10er/Gg3F9qjW26nhkow2t+9Zrt2TLLSaARLqVWGUwpwpmxbuvrf1B8ZzAJQvRKTrTNbNrVaFZlpFTrhrSj3Mgs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Topic: [PATCH v10 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYhbAUt8m57drfLkGLMcdw+w+Nvg==
Date:   Tue, 21 Jun 2022 20:47:11 +0000
Message-ID: <20220621204632.3370049-57-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb177e78-6062-4396-03b0-08da53c75118
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392CDAF660AC67EA66EF924FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MleF8/ouy+qEQIZo69IvMAMEM4BGIpOikGzIfPiV6ouJEMNVJhAIDL49cBx4bFilvCfzG1FqxCgvo2GvYxn6BZ4ZqGFI3PR7qDL6q2TNT91WTQriJ/hpVrRXioeQynMw1VlkjwPoPGiGuqByn5rxZWs+TjrAvpLqoYuLksuHiyTP3Dqa2+Qs5we2DsTJFQzvKRxCHl8LaLCVugvkqh6U9igxu4XoFbH7bcBCKLDB/MuejINgYfRItMo7oDePLtxPLvHeyogZXdQmnysfpLY9oFwsBXK4U/cJwfXZGzpOqzIlBAvI6Bc22zwe0PvfHI/hYPpkPYP74uMa/hulYYZ36gUIbzwYBG6PfLCA3rnQ5zMbq9023w5PsCkOvRY7Hiax++rRD50x3l80Wh+e/mHwVI9/aACJrFxaTM7GyGL4UF/tzZlIsRxlr3V90HwfvN5ee4szTaAJPjBgGxaYy3F+hb/oTGYH2eyVH0flMBGpkR+5RZmRMnKnsJ4CsUK3XEVaGMWwIhYTuokcO1T5w7Yp0mWwZsNcu8BTEOksvOJG2MQYo3SiRq4Y9nnR5pGZopFBLJ5h5ulyx85HqtGps3u1fzCVi1eCl8UfnaLAJp4MjwxpBK19LrRknbIqn4X7qc7PEwih0gPTLYrPEkGTs7MNd/0p0Dk8fGhFEc7ZDE6L2sr6zGjm6Sprzg8U0AlPnScaqY5jTAOZi2i8riaT4nApmDpcig5hOLHeamfbOmE5FdYFpFBHhccvsLVLUVK8oU3ZUjbex0g+YmLv+J23hmRf/7oN3HNwWowSy1xQmikeI8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NpbYJV+jHF0m6awJrMqp8lkBbqnqYQqDjj5Dk/b8hyLDT537KAbnuz+CYR?=
 =?iso-8859-1?Q?mP1Sy3aS++YyoKUewu+DXoXeUpyQikxHNfyyMAAKx83TJPamp3Fnnmh3bg?=
 =?iso-8859-1?Q?ithT+G0UlJocRRn5iV6tukrb/JaRfsK20GJNITK+kF+9qb/XWMd1yZlkNe?=
 =?iso-8859-1?Q?ec5Hw4emPiSeseRd4ON7EPaHlTU5zeN45ucCYjvvH4fcct7lCXvHTkNWzb?=
 =?iso-8859-1?Q?Gf9XWtZ4s+CQgaTpyzCTPS11jnEjFmksTtJii5cBiV2aks9fS/SmPb6Uoz?=
 =?iso-8859-1?Q?TaLf+J7gKupW8CBGonCXhtsKnNTuGJnJqt+HlHmgv3kRt4NciWzMjPE1mT?=
 =?iso-8859-1?Q?LQRLw+hmwmvsEkw83AI0RVNoO9LTHob2W1HU4NoVduJSl0hLN010xFZrkh?=
 =?iso-8859-1?Q?xdT9JHHgoYPH9Dt0WfqD354WaznFD2Gmb1+J3oGLf+F2FpopQRQ6Kudg81?=
 =?iso-8859-1?Q?a7hx72Oxz8B1ShDQ9Ol9/WTdn+MhMLywmaeu1TVoF2nx2B3MPKc+JDv3c2?=
 =?iso-8859-1?Q?XOTD5atvQwrB8RJhhBpQrYfWVsQoWHFHh+didZ0vpoO+COjfkMLuBIgxcd?=
 =?iso-8859-1?Q?t3kdVSyxSi38TKL6rVyXtkOjqqKmm+1Vxj6bp+GxyBruEBXmws6pBTbXDn?=
 =?iso-8859-1?Q?D0ganymoeswmS8t5hZeIHAi6rWI9qGzr78pKp3qTyKsAgwD5mEUSkRvkp1?=
 =?iso-8859-1?Q?1e0MXW7NsostDpDZQUbSPVPqRLRNwh9ruwh0nsrfV1wnM9EpqDDffbDEZJ?=
 =?iso-8859-1?Q?ILbYULg2a2dXq5dFlt5FDv43CKZ/9lcvpiemcOtSmm0uuhMYG2YVY4J23f?=
 =?iso-8859-1?Q?7VeiDN4RJURroZwswT/6gwonnsJgeE4d053tvlQow9oqQdHjV4f1SH7eAS?=
 =?iso-8859-1?Q?ALxKnpRMRt4nnhwSrGF/6DetgVzczZrqzFgwrJg+3xpLpymWw8c5zzQDmZ?=
 =?iso-8859-1?Q?Kz+CDoHh59dNcME9Ob3ngRfr/juVn5uh5zrc7LTEwJNQKi6H09ez/rVx9Z?=
 =?iso-8859-1?Q?l7BeIQfK2Jg5kBnSz2EUUF6Hy07YjiX5gM665aQYVb04LyKochTef08gmN?=
 =?iso-8859-1?Q?ZubqO/rlryxEfdLVIOPtH6mAwsKfLQ1NlCwb9EMFFQjklyv+yiqO1XYY9o?=
 =?iso-8859-1?Q?CmdQdtQIrRdKI7q+37eO2atGxicpILvMwXlL6q3KdE+K+MWJqn7sY5SGIY?=
 =?iso-8859-1?Q?+sEwMpwluaExFintmlKqIbG5wijGLo9KYVQByguXjLJH0B1y27zTldQnPV?=
 =?iso-8859-1?Q?TaikzcuDBGCEiKjpBqGTUTRgfOpUJuvTHm6qLSCycNckxnNxTblgBaPiTL?=
 =?iso-8859-1?Q?jWJGqmgygj9rq7ZJgkS/jTmQRIV6rda2CpNXYxSprEkfhyQ0/RttKtJO7y?=
 =?iso-8859-1?Q?NteNIjHV7glNlCx5f/OazcaUm49zZ5hBPWxZKEzyYKcoKxgVw8v5PEHKSO?=
 =?iso-8859-1?Q?NAj9DRaO+KdlY/W9ucjMhBuk/kVSjTpwe1hC+NMj7Njig2gWIHkjI+pXng?=
 =?iso-8859-1?Q?JjInFmPRCPZ24+4/peEidfVDCFq/0Z28i2ayLOWdPUne44AG85Zb8jV5BH?=
 =?iso-8859-1?Q?B/Y64Q2rkbNBggKkrzaZlU4TyueIrdgOcAiadTA0rLZMT9crfVet0IXZFi?=
 =?iso-8859-1?Q?R9RwCOKKL0r79dcvAgr7kehRg3v+H7DvkR2X0qOge2YeuO4UWOrvAYdCMD?=
 =?iso-8859-1?Q?qsX6WYbMZKVkHOp9wD0HC//X8Cv/YYveoXF5ZzJt4rYhpsZLWRY9Xj7ath?=
 =?iso-8859-1?Q?9DSs6hJJKTlnxUKMk5BcJHWBt5Zjx2uK6uTybhO7VIJG/Ac9+wXSRaM9h5?=
 =?iso-8859-1?Q?hTxf3v/erhIOswWKzv6/npHmdbPVqqc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb177e78-6062-4396-03b0-08da53c75118
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:11.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkMl6OaQGrUSVjeQDk3EoH/mbItGwL+tvuoMc8rlqlD2GZ9v+8P4K7lwSfPFh4kEYyzLQOi3Cme8at6dzN0u6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: Pkl_D83FrnOcqVfOnCfQvPBG6bOhxBln
X-Proofpoint-GUID: Pkl_D83FrnOcqVfOnCfQvPBG6bOhxBln
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

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should be
no functional change to this scenario with the new code.

Link: https://lkml.kernel.org/r/20220504011345.662299-41-Liam.Howlett@oracl=
e.com
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
