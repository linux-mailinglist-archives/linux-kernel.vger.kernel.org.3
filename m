Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B954F87F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382320AbiFQNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiFQNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:47:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8637289AB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:46:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HBo16J005223;
        Fri, 17 Jun 2022 13:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=sJL5lYxVbt087FCBHOOJA4fG/PuoVH3Mh5YSGxc6E4s=;
 b=LyVjTAkkPcCrq1bDZTl2oxT8m1mnZEZRhI9qbmVSkRJoB+H9v5BMOTly2zwoxtqaVai7
 WazrD6whjsx4UhrHu/oVB81ELqlXsWfBabEsPlzqdOL/sXeVr0dgwnwQ+yMH43iG9XJf
 SslMZbfkC4U0xBQnc+JGOtJCNiCJwteGNvC4npcr/zEiXC0GHFPcmt1q9pH38tHzk1I6
 RbvrCT3AXt9YAQABZqHqZC59z+Ab8y6wkKD3E9VJsoP+NDcB2kAVy9X7Fg4vCIjBA/Io
 mgNqYWUzhMQoGruuyjEI8vBqvQ/oZsOcDkfvRvNjKwd5HecXUrGYjmPTKLufbt7P0mU6 Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjnsdvuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:46:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25HDWI48004349;
        Fri, 17 Jun 2022 13:46:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7rb4ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckBou32zOnqSFQdwVrLeLgFtnKco2vIUYiAr20icPn+MWg/PuPwddNmv+07GAgOT3xy5RE7HAOLwFahkS7VPS2O6Bi22aUDMmTmordjQ/4DsTU2LwQCnKskjAwUmNiHSrXL7ddRtt/UfZ3qb/+SRfcH7al1JTK0bO4QmJi9OTAAfdhrm1djI0Q20TZrr8o6npu9f8bDEbcXUcXypBPNseuSRUPqEaq29wlO9nX0UVIerkE8g0sBFYioTSSvHH6bwdTv1+vSFeH9gHxEOZnnm4GaE0wdBu1m7AcL4F6vC1t5fAkL6wOLSJDr62/dLuHK8cjCyj/ujs3RmpAz1MXgf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJL5lYxVbt087FCBHOOJA4fG/PuoVH3Mh5YSGxc6E4s=;
 b=ksL4TJoW7gEw8OMx91kDCec62PRY3USeBpzalTs02Q0mz+PpS7NKdTfnHBvCa2kr+1z3uk2knGzLwYs75dmbR/B1IH9DVJAUs3q+Cnsd2h1FdWWOnxg4QKXFaVBMQ5ISs9NxLPP1vDJ+Rh7AN6ZTVD6k3PaQY8BQpj5uKRHvOxom5gRcaVS41V+HZd0bSS4zHrfiNbCNO4VyUapZ02usgjmSgic7aWbTO+0OVa3tPyJaGHmV/srSTpfJnzoHwvKjGCRdUDscaBT2r/KiwlG1FjViOwkFX6uxirtWHNM/VJRt1yCxyx4olaAB/T6zmlJayYIS9nT/WR61mXaXy4EiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJL5lYxVbt087FCBHOOJA4fG/PuoVH3Mh5YSGxc6E4s=;
 b=Ah+A15T+bR3jzAhtwGjYTNmmah3lTA7js5xgR7WECEY0+D/ODK6KVRq6gR+UdpMShUvQ257pXsGbGJU5asF3ErsFxZB/o8B42POLcp99t9rDFrdCkcOmZZ/Gm62jGUFVZM/oVGE3qX/WcKXspxe71Rnch370mBS9fGEqjNYtm+k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5232.namprd10.prod.outlook.com (2603:10b6:5:3aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 13:46:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 13:46:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/mmap: Change do_mas_align_munmap() to avoid preallocations
 for sidetree
Thread-Topic: [PATCH] mm/mmap: Change do_mas_align_munmap() to avoid
 preallocations for sidetree
Thread-Index: AQHYglCtquJsqUXyT0WT7EnXXLr4Ug==
Date:   Fri, 17 Jun 2022 13:46:42 +0000
Message-ID: <20220617134637.1771711-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a46b59-2243-42f0-5b9d-08da5067cfe2
x-ms-traffictypediagnostic: DS7PR10MB5232:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5232AA604883EAB2EBFE3DD6FDAF9@DS7PR10MB5232.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwRle8xSvHzzCzl6ZFkYEubhNQyG8E5GTkkwuXZhj18MCDfdEWVM9/vRQ/mTeiW7UzjAWFExAx8Iq2qfJBUrLQzODZdTijpIVjJORBqbT/XXipYl1pdn9Y/dNyBNtIo+RkqxEeW7HY2O9WjP9sHB9btT4AFVo++ca0CgSoVF0JL3aDkA3+Kp6B43kvFWcV6suxghJLxGE6/2NAPZiq1QStir8ngEv1I4dxKnt7aeVIOoQM/5U5W6mHvUn/TGPVY1TiTp99HrZzi+rNZQYlK5/5Mv89SrQcTlWjgBneWKsWIVh3FkjUO0BCWL8L7kc7+/C8JSwodUSaIxo6fG3eh+00j1C9DAWgFkJBKa6nANWLo1S0BlA/SRlr6AFb734S0hkb1DdigxdBajnvEPJVp9rvyVHyAS9a7rM9LlkcLD2fPe/d95cOA2Ccj2KUz5lN1dbqdkby6KIlXSx/Sh18cDDHTuKra+1740BRvRol8LcS68PsI/5w7DnewxRhohVnhIKa9gloEdosktKW/UvwLKwBoBlGWKOW6wWhPC/dJ5JtOSZ40sfIzR+xsiXyAnFLxGN04nSKco0lOYwhU/sS9FKBbBODFVCLofMnKouLGWRpPHprjwuy5ZLI5H8TLgZG5FwZaHA3Gy+oHtjX4lg+I92EFIgd4KLMugJ8h/rHEqpCVidfkjfhyQ+EpWkpOiVIO4MDQrXRiRB7r3jJDib2TXww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(91956017)(498600001)(44832011)(26005)(6512007)(316002)(71200400001)(110136005)(8936002)(6486002)(36756003)(76116006)(66946007)(66446008)(4326008)(2616005)(64756008)(2906002)(8676002)(66476007)(66556008)(5660300002)(83380400001)(1076003)(186003)(6506007)(38100700002)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1160k1z3upfU5trXX4fAJx5LXacQDa5WpCmCSzRJNNj0aAq/n+w+vAY2Tu?=
 =?iso-8859-1?Q?ziwnJ7tBQKnJ67kOwwBXn29ZwiOZVnjTGGDLXKtPgw89SXb9FYtBmripn7?=
 =?iso-8859-1?Q?DM03rc175ofexwOZ2WfrL8cGLhywMV+Fs8paWdeI5/PEm10bgtZxaWrbyn?=
 =?iso-8859-1?Q?AJkh2osm5djDpRnExVQIhMLqSzo/MTaOrByMCpFA62rPYIr+5Z+jOMHFaI?=
 =?iso-8859-1?Q?U4MjzevIQRFKulaOzeA2sQposgFMG7Jl7kgIZwTVtXdKZ5fZXVzd9rltNx?=
 =?iso-8859-1?Q?K/KQjET9vPjL1oYXtxyWTJVqPtbvq8snOBaGKYweincqm2Gl7cfD1gxkdt?=
 =?iso-8859-1?Q?MVISJSu/HZ1yy7XcE20B3Hjo0sCbZ8pdKKeA3RghXhaBDNmNp0U5huixuY?=
 =?iso-8859-1?Q?JpVHwclQaLXbKebG6R6r8of98EdEXsC/ALzsE3BNk9pxV/pXd9Cr6yQxdh?=
 =?iso-8859-1?Q?lUSekheqnVnrhWghF9iBQoz5MJepxgU70Sbn5OQA8pvMiDUd/uxd/9tk+9?=
 =?iso-8859-1?Q?X4+H7UUx8A52t6YjJLvXG6LTfJkEmNpjp2mNHDyZbd+PuRwnTWgmANZDUu?=
 =?iso-8859-1?Q?3El4gazI1btV4P3LfQT4jXLirMBenbdv9vQiuxwuJzibHHHMi/nGOuI5v8?=
 =?iso-8859-1?Q?k3le05YqCyZDZaR1gtjkIBbfFRVabNbRPitgqu4ezfAlYszSRrFR/WlsDO?=
 =?iso-8859-1?Q?eVrbLrOLhqlIvdWo1Vr1baCBB09Zar6CxrHR5lqJ0tYzlHqEpVk6h3ocXx?=
 =?iso-8859-1?Q?CeJKF3H/O2LxHKgDQYb2RZbkU1/gSStZZh1CG7zoOs92LhE1ZdmeTv23tV?=
 =?iso-8859-1?Q?ykMAQhJ5pVACtMz5awrS23l8CTfdeZwug9ZHSgJ6r2oi/rflnSjYGr8Kqx?=
 =?iso-8859-1?Q?74GzTpRDa95MTFEkojhqmXJlvi0NjP6YT3LPVQ2F1z45ZvFQAALLvHfhXB?=
 =?iso-8859-1?Q?9qyQB36VyHjQOaZ84YpkahmpMFqYTq2p3meNNUHC7nLvqMPZ6TDPAByHBO?=
 =?iso-8859-1?Q?NUCU23ncPT5J5PFcyFnjW8nl4KU/uhWu+ej1Lc3kNsY97wyCEOlmvQ9Ato?=
 =?iso-8859-1?Q?CSvM3cMxzc++AvrGhu933xCq4r+PG33QQdqC5NRnUsTj8gNjLOV9iyi0G3?=
 =?iso-8859-1?Q?8/RmaBM+EZgBmlnFFGq4yPUuQAHBjccqJ+VbAUtUUgSP1WAo/fTCWvM6Bd?=
 =?iso-8859-1?Q?EsgmwO5sgWc5CTVGs2bO6xnFciDlsgpc3I0LTSZ5/hjWKdkLyG6wkkudPC?=
 =?iso-8859-1?Q?Kcjz+3z6Dnvx+L7tTSHTKtqu7GW28e49ykshPofiDKzEnN31OgNU7qgJTH?=
 =?iso-8859-1?Q?hGvvE+fT3t+8I/wxxk4j2UbwYuVrbIHbfwtkIYnvvr878jrhi4CwxdU3t5?=
 =?iso-8859-1?Q?OviAVM5Fw7NtopwJFRTcftQT1/0+6wdSJGQVXxy+lR9N9FB7kSS3Fp2Glv?=
 =?iso-8859-1?Q?ywtcFtN//c6e1zerNBlbJjHj5OSy9YZ4ykehyAx75U0KbNQgJCg79QTvsF?=
 =?iso-8859-1?Q?1IUfoc2XQDQkK+a6n/ZlWw4B9fcThZPA1Phh2SrAkrWo69AwQUHM056a8Z?=
 =?iso-8859-1?Q?Mqs+cOocA5dO4ZsMnn5oiGZHqwBIJPXbnZtf+KxbMol7FADzUvax6GJ9ZM?=
 =?iso-8859-1?Q?a7+BQc2SmbxF4MlKGz/0wOgCEgekiXPW9ehAiisx6PviA+m/e2MsJds1UT?=
 =?iso-8859-1?Q?6TlRSwvIhTdiyAnJer2C3Z2+AYXq6y/81RQYi8Bv/+GTE2I2jU5/nwwSnp?=
 =?iso-8859-1?Q?6d5wHrVGrzFvSOdLnwELgN1NiyWR5RG37hqNDJOnhvdBw/tCIwcj3B5+oK?=
 =?iso-8859-1?Q?XmP5V7LxWUcRiSPakdrN3B57U88t+sY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a46b59-2243-42f0-5b9d-08da5067cfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 13:46:42.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GgnRwXxgnL3p1zhxL5kLYpXZtdQFBB+x309vhUtxZzy1/25OXI7utl33rD0iEMaNq+uwezNtuEgG/djohDNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5232
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_07:2022-06-17,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170060
X-Proofpoint-GUID: fsP6hvRi4qnkRBpuMmPSkppOmUzlThCD
X-Proofpoint-ORIG-GUID: fsP6hvRi4qnkRBpuMmPSkppOmUzlThCD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recording the VMAs to be removed in the sidetree does not require a
preallocation - after all, split allocates with GFP_KERNEL.  Changing to
a regular maple tree write means we can avoid issues when there are a
large number of VMAs.  Using mas_store_gfp() instead of preallocations
also means that the maple state does not need to be destroyed (freeing
unused nodes).  At the same time, switch the tree flags to just
MT_FLAGS_LOCK_EXTERN since gaps do not need to be tracked in the
side tree.  This will allow more VMAs per node.

Also reorganize the goto statements and split them up for better
unwinding.

Fixes: e34b4addc263 (mm/mmap: fix potential leak on do_mas_align_munmap())
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 315c3ca118cb..58efd5723df7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2335,13 +2335,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void munmap_sidetree(struct vm_area_struct *vma,
+static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
 	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
-	mas_store(mas_detach, vma);
+	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm -=3D vma_pages(vma);
+
+	return 0;
 }
=20
 /*
@@ -2365,16 +2369,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 	struct maple_tree mt_detach;
 	int count =3D 0;
 	int error =3D -ENOMEM;
-	MA_STATE(mas_detach, &mt_detach, start, end - 1);
-	mt_init_flags(&mt_detach, MM_MT_FLAGS);
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
=20
-	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))
-		goto detach_alloc_fail;
-
 	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2401,7 +2402,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 */
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
-			goto split_failed;
+			goto start_split_failed;
=20
 		mas_set(mas, start);
 		vma =3D mas_walk(mas);
@@ -2422,26 +2423,28 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
=20
 			error =3D __split_vma(mm, next, end, 1);
 			if (error)
-				goto split_failed;
+				goto end_split_failed;
=20
 			mas_set(mas, end);
 			split =3D mas_prev(mas, 0);
-			munmap_sidetree(split, &mas_detach);
+			if (munmap_sidetree(split, &mas_detach))
+				goto munmap_sidetree_failed;
+
 			count++;
 			if (vma =3D=3D next)
 				vma =3D split;
 			break;
 		}
+		if (munmap_sidetree(next, &mas_detach))
+			goto munmap_sidetree_failed;
+
 		count++;
-		munmap_sidetree(next, &mas_detach);
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 		BUG_ON(next->vm_start < start);
 		BUG_ON(next->vm_start > end);
 #endif
 	}
=20
-	mas_destroy(&mas_detach);
-
 	if (!next)
 		next =3D mas_next(mas, ULONG_MAX);
=20
@@ -2502,18 +2505,18 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 	/* Statistics and freeing VMAs */
 	mas_set(&mas_detach, start);
 	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
 	__mt_destroy(&mt_detach);
=20
=20
 	validate_mm(mm);
 	return downgrade ? 1 : 0;
=20
-map_count_exceeded:
-split_failed:
 userfaultfd_error:
-	mas_destroy(&mas_detach);
-detach_alloc_fail:
+munmap_sidetree_failed:
+end_split_failed:
+	__mt_destroy(&mt_detach);
+start_split_failed:
+map_count_exceeded:
 	mas_destroy(mas);
 	return error;
 }
--=20
2.35.1
