Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9745AF517
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiIFTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIFTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094E19013
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdLcK014155;
        Tue, 6 Sep 2022 19:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=CAokBuTRDZ6ezlRp7wOx8TR+ngRWgU05N67Yh+GPJiMkeNWc6gmT9nkq7cGxqDXli6We
 lpVIMXnbagrr8ly9Skl5Ss8JShOcirTj7RkSXVdqDgz88wRKaTn6e6PhchszlKB4O3Mw
 4x6DfaC+yW8rXLWwQH7ribiC1vU4cqUecq02ue3rtb6UZxwDQpRGvcLs8+3MIOta0SDx
 o7hZwUwuzaT0yI3kJzxtQRd7ZOMM3JXrxOODuoEZzZQa0pJ0BNwQkJWBm/bet6pEjIzw
 KivwZYDKow3RTehg7U2QM+jwcFaWAKp47foBbZPUNyw4kL52I7EpNbkepnBC5yYlQ+vL Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WV039711;
        Tue, 6 Sep 2022 19:49:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz6Z9d/iA1iU/P4EGb/zqfi/ZsWEw9Rqjr6YF6T6RWxcPI6SqgrB2lCnMB5mFWs3iwgXY4hUhPVLqztBdg+0SAhxmuuhjMrPAo6/89ueA5zl+BpewvpL93wU9Hw4AZJKkgOdE/5oEqGFLlWegIvUsa3aWyYpZqBBVSBqYqQOMj7Srp8nu5BYWPv9hGmjLreM/zTTH82Vn67JDHc05SpfESBuKUPgen6pgMxVmMTwLkIzJVrQjM7QMRjIZXJiVKTUIlne8WDpPagLepX394Uafd5Zuz8O/62in3jzacQBAv8BoK72oXFpGzyOZjvzmKNS4MU8DQHx0znJ+P6tk3C80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=PZ/zM8sq8hSspBFZtirSNi8xcCPBwNjNaovLloMFim0vb3fnJ0wsKnofPOA9M6InQR+TGw1GKpsgqEfgyhKgLGRlnq+rVMfhMipG50Ir0rwcgtHzIZ6pgkDtIXQFDfd2yXe+MhKs/XQ/H9bXi22EFVvDT9a2tI5cFreOgM3DIZK4Ei5vx6ZfjLvQ38d/wtq0JJOXAe7Po/6qQHq3AlK5Fe6rQwyHH2kpq+kc4hzT/kiq4rCXslytgiiVmu/CUkuy4w5DZMa2bG3j4EB4/niGpk3oPTG2vxlwbfh14+xjwC/XnyBohPv+Qg7npSFT4gOP2zmlsp5BCsvCWYF0PbDhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=v/20hO3uz7t2TCswUh0BvznWZTActV36uIjp4EK03iK0oefsmSaV/sqGnJjtnA+wMGA3kc7LxlNUSob+ZZ8VNGg3sgcZxntx2X/Mr6b34VE3VBSjGzMDwGdFI+UHCgFtFNmLTSx+C/zKfz++yeeV+LSb60hnacw4IDid/0VPwIA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 41/70] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v14 41/70] exec: use VMA iterator instead of linked list
Thread-Index: AQHYwimz3mWvcah5ckKRJIk/Y9uVaA==
Date:   Tue, 6 Sep 2022 19:48:56 +0000
Message-ID: <20220906194824.2110408-42-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a27911d7-2c5a-4a90-ebd9-08da9040efd9
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pK8pHPAf2ecLtN2WQwETN23VaAOxMd7x6BLNyt4JDbDFmtQPMB2n80tqvuo4EQOMg+A34f5sj0U1xEXjKa/xaY9OcHCRZts9oPruvFblxxfVdoIJZ/fgYoKlutJmfFBv82RcRk2Vx1c06ZEE2+lxXHUyzpVcF3CDQ4+OnMnbzW9RtUQCbCKH0fv1ODbIs4eJ960SDRs1Ln7X11nBAr24DcoXdn68KwrmKfBvvYEKbekvesKtfvu1x8HZuJoCwrgb3HFy114KA1uzIw7mAoLoApLhOAYptr0Mwwp2JftcwO0EgDgn8LOjbpyssCMz7F/66zwz5+bzN2QDe2RNCSh3k6ZrxPhDkTMyJAS6slrS0Eo+ENI2FJho1QUWbQya9qYnAcev1FT9foGgW+qJ1ExB4jW8sHfoUlKPzniSu4uOw6U+qKmIAeNBBt9rH5MXb+95SSyDQAhNt2o9bWAB5wXBVvdIxtV6WLTgA0bg3lRieJgI4Sd33x/m3X9EnUHPrg7kqLgCrvWPqSjFMTA0ibVwJIAUKcPuQsnGveZRFGAFALshAncYENv4W0NEFCPAjnhJb2HNR4XGD/slrwGSxfreIm7OgZlhj6R6cz3rvPiaC79Lgg+09CiO+YxDtvkUEfWlljtG6UxKt/MLph8TlA44R3+qWfrg/ewlpb4ErnELNrSVIRq+uwx2dCXdOim133v40icMzIRtGNYvUfEs7JAoPSshPGElwv1r4O3K4HKOMBkqKgXUG7Cc+5ww39FeS0QDAEWCQvbso93BfIloLfFcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(107886003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lINBddwF77QF6vGC/cXquTtJQORPajLe8IUtZ+awG5NGBkConnfZCaIry/?=
 =?iso-8859-1?Q?7UQ9w6OOPgcsYGYv/BLcCpAH1qpDunPuE/MK//R90ZkjGMbVCpV4EJRmkF?=
 =?iso-8859-1?Q?FFWnCc2yU9hX7LJPlmNtyLq8nMDjKDzeZUalvBVgLCX0LfF9TlvrtAXPC1?=
 =?iso-8859-1?Q?jxeoL7ULXeryqSSg2DfAEIfkdGR7iPK6Nqm6o0HFA+5AaYG3wqB/K6zvra?=
 =?iso-8859-1?Q?KFQrjd60XYEebpOWW0aulef8a6do6xdEhgiDDMONvoCzKlf4wEnxhaTvFn?=
 =?iso-8859-1?Q?TpaXpTBpzsoiM1mZ1il8KHO3SHAPJv1MUPistFSOaI3HSJQU6yr87337g/?=
 =?iso-8859-1?Q?b/eGq2tkffi+Ejk2zWiHav+KPOTTiLjHE7EVpPWd/hPUSkABCmr7sHV/PA?=
 =?iso-8859-1?Q?UlFvMJvL00jYR9eDN9XeLnQLGzkr55zHneYGdqOAAbgIq2BAAcG5IbKZzT?=
 =?iso-8859-1?Q?44VhOzE1h5rLxW61Ppi/EZ1aBTo+VLCL9SJlx0mJ4wBEP/krQr0WHFfZtQ?=
 =?iso-8859-1?Q?Y2BfE4L1W3VwuXGn1qro5Ow3W+HATt5I9GFEnmHIr4rABI9cddeoVFk0cr?=
 =?iso-8859-1?Q?JIyz40GG81LdWUmhr6YqJOJX9SPgi+0pkxWaNK8gGgXnP1ZGw0gN5ueLR2?=
 =?iso-8859-1?Q?Hawmbfjy/tMQrKGw9XB9WCM4gnu+ImKeGZUBw9Fml2BjLswsHT8nEm/rVv?=
 =?iso-8859-1?Q?imB95Nzb/CwAu9cWzWuJ+zOB2IDj6QGDVbSm6opeTkyEi465h5PvMZyLGF?=
 =?iso-8859-1?Q?JoqxVUdHLmSQ0LDhLMAPogB8ODTZOErNucG+qMFhYwdr/l+QZ4bSefvJMi?=
 =?iso-8859-1?Q?8sZqsFd4zv5hw6n1rbRQ6H0fq+SHP1tfCNhxOXR7ZMybGU76UdRWYOdp5L?=
 =?iso-8859-1?Q?YpK9gSrTmYVbdZA2EfPaxUnQZnI6ZYxqW6zfPStEPBxr4dOI+29UmifTLf?=
 =?iso-8859-1?Q?C6VAoFK4YpnnY6KwOpt8Uf8CoGVRvN96qYCm3Lv/ZO0vsbOUJ16M5Ib8Di?=
 =?iso-8859-1?Q?QSaw0HqHcZnrDa6qrP+K6eUIXgcBe58C4P/nhCjHqPk+hrfB3YzOciScE5?=
 =?iso-8859-1?Q?Q4PJZvga007bHA5AtjjXCmNc21odyW6VawOoYNyTY/1R3RJz6DsmVCKEJ8?=
 =?iso-8859-1?Q?b4EcdYsU7ZNr/Rg6wasyD82irxKfzjqReMSSG/N/IppCqiBxNRgUw64oi3?=
 =?iso-8859-1?Q?dbleJ5KNAy2qKVt4aYh7dFVhMnlp62y9M9mUOz760wka/2hYVJgFPCaUIz?=
 =?iso-8859-1?Q?ul53id8btySwHH1Hvb3/9/0jNJtf2tbNzJ2c0K8xGrkDis/X+FN5bcYpjP?=
 =?iso-8859-1?Q?Hpw+jsKh33u1rDhUI7nA+7jpvHMqPiHSqHYOtjmloJcfcBVK8qzviZ4cK0?=
 =?iso-8859-1?Q?aGrInJi17MCzpPAkdqINCjQKvrHQBPvyWBoIGjyttGZpqW6P/ilFUX/VQ0?=
 =?iso-8859-1?Q?XlYpVxlSfpj+wivgGiC5Jea8zDLBkSu/plamEPgn5XY0VcXIwxBMH+sCQO?=
 =?iso-8859-1?Q?Y5Zm7QJlSKtYIolhejvdaUvw93v1VFr7ARFn/NGPUy//TOnxZMllTPPkGs?=
 =?iso-8859-1?Q?3NBrrlXOdxhRuH4iLLPbSUu4esIDKrMumf5jBgHznpAgbKyvA9BVV8Qs6Q?=
 =?iso-8859-1?Q?axduOcVs5uXmPF4zC09BG5bGGQjbAkLHxiL6VYn5ueZfYiEeVVHXJHFw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27911d7-2c5a-4a90-ebd9-08da9040efd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:56.7250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAUe49uFfdOU7EBrG3+xoIuJeWtopk0YlCaQ43q4Wp4Hiio6vC5I8tdhOnNjb14T9lYVmGTwJIwiR4Ukujx4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: EmpM6sm0tsy7873RMbGzD-g92JQLzuxj
X-Proofpoint-ORIG-GUID: EmpM6sm0tsy7873RMbGzD-g92JQLzuxj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 55879fb1ce46..dbc61a4d4c62 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -683,6 +683,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -691,7 +693,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -710,12 +712,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -724,7 +727,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
