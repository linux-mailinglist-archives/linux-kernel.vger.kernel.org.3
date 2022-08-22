Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB559C22E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiHVPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiHVPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:08:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CD3D5BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:06:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVbg022022;
        Mon, 22 Aug 2022 15:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FcGVhwbDnBijRpeStOb/mLuCkPlBUABhxRbb/3ylf9E=;
 b=Q0/GXtdlY9biVOt8646gdHzhuNnlZ4HPL8nEfbBRslhS4E3a3oI59G8Fa78nksq/SAH5
 Vc9uk0LcPQzkDtJrzWXTzeGdbQtb1tnGDsMN/vqcoEkVNNJ4MeBKy8Iyo6VM9bSk6eRb
 y76tT70WlvapnceEAWGu4sfITq47cNut9WQLaLkpSgFQgcUmi2bMY/4PJz+31KBwODyF
 eFdnEVqv5vOai3bIL1vUyXyAv5uDiOuUpI78gPRXnj2pucpMvxMZhnK4G7O/gHMRiYa9
 Yb9FRUI/Iu3ACzgwipunE28LSzqqHTx7YldOfSfaCIRAfzUSjva6zBuC9NGpzMQyjROL 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4N7j026668;
        Mon, 22 Aug 2022 15:05:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bdff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID7U8KKeserv+7lss/w4kL5pRnVIiwkXSQItgZJLtsmvD+7dHeuanYHJcNz6v7g5D4Fc3pdPP+UhqZk9r3xUSq/aRW+eVISDL+dE43pOXmsr5rxm7PfnlTojT34l0qP7XQZvJ7DbbcCxYQQaa3h2Fg/a3JDy9PhVHvqbM0jNmUb3uZjll6kxp+kp/fRY58x7HjafzEMbhWlfRppWFFopexcBdGvPIo/zrvMvVlIlMz3ulglhNBHDu22/Wnlf0T8M3v0a/DkdHJ4Ix3XKUbIdeVqRXvXI4g0rbTdMB3W7W5F4Vg2i+k8/KShlsOKamf+ZuFP/IeVsUYNTrxmBXl5XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcGVhwbDnBijRpeStOb/mLuCkPlBUABhxRbb/3ylf9E=;
 b=GO9MwAYp54lvRZ5Ht6guMKopn1NwN6UXh37v3noHD/+RkdmmYzmYJu36k6ZnNCC4knxAcZHBvGgAapoxDfcBPb9UTiJsfagRzLRO94Ww8X5QcUg31DCSoqM32p96OWMOugsNLvb6N5wiHjMtZjOXmkGZBW34iIrdCUKFPkb5KuF3NXUsE61GlFg11IF+64AVWavyetACVx60CCBKL5POstoO31r3BdzxP/17wnMuIFoVa2ajKKQSUsCdZwBiWjJQWanCbE4IPHlzMg4TbzxESAmVS4KbNPpNqaNvENtzx4bbYxjSyO5CQIIW2yh3w/VG6zV+qbLMSxEnt+sacMR/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcGVhwbDnBijRpeStOb/mLuCkPlBUABhxRbb/3ylf9E=;
 b=F2AGfRv8rbz1+u9FawH5/tMdTQeNz/g7dDzHKGDrwt47ffrOPTkD36RlFfSqckp3+Hkox+XpJtunGmR32FxlMYphyaU6jbqeJYSnYghw03NfO9Dljhmr2Kdzweul4wh2t1lZvzOzT53G6H74fhsYJF9xiPgOMxDse2u7tbE/H7k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 33/70] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v13 33/70] powerpc: remove mmap linked list walks
Thread-Index: AQHYtjiqW+3rEwPFK0y/nA6kx3thMw==
Date:   Mon, 22 Aug 2022 15:05:50 +0000
Message-ID: <20220822150128.1562046-34-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4f12d5-0f62-4a95-3fe6-08da844fcce9
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5R1BmR1HMH59C58tSkIPn0HTqU0XKhKbj/eV4lW6jFvfRC0/84inFUAYS1C3JsDAh0jcuiWDTI2WxePaEt1mXDbWR9iN/BjnKTlBeNkplHoxB6X4jwMexiavX5qGFpaj7rLDbeumiVVKQNPqOHfAI4CHg+P28bnX2afU+cAEyrbXwhjhUnYTxKx6xPSLjr2KrRn8xKgO0FuKRlfM0FnNLcHkLNtWNC0s453NMBYtN8cAQzWPKqPoPhwHn7UWJZcM7e1ejOccBm7CEvb8PwOkwe353WDyFyXTj/nnhj3gHf+d/n8iuWHHMguMnXDO4HhFrWcJ/5ss5wvqoZYuE9zLxJ6gHObexv/raPkSQJIkJ8A3aWNy9xFH/tlFyixyDFEzeGqdny+1Tpa3sQqxmjQwORCOG/tA3cjLlksbhW/20dwXCN+eln+ifFCBmxdx0JjhgIV7TjAC9uTi2i0ynsiBcfnhTbGD4g/MTWTrILTLSUkr9FxisUjwwzuUfZekogSSc69ILqZP1426clDxqsSkGb+THvm7pGjdfRrpWU31DkhCg50jLG2Kuz+94Y4W8K5X39o8CJHYhDZ7CvsEbypKxoO4PMk+eCBJGXLRwYGb4aN0Kp+aV3jbqUBoKAsPRlQlqQVMErav8NfCpFY795bygwcwxMeDf9bwRT8PYOFYIIDci1gcnd+H27X5J5InEY9noqRBV+IpN+E6CKycvERDI61Iut+D5vNLZptwjCMFGaE5QeoCCn1fP2zmLHj3vQ2i0jvPLkuQbnEEVWo7NvRSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(7416002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BkcD7JLj3PunvQFkRU1dvD4eSW4U2yTyDMlyaTu4mlwogetxU26OssmDZB?=
 =?iso-8859-1?Q?LNSlX9onE9ysGK3bYDtElPis5nMZKbN8rnSjbFPfMjHsoyS3hhVFj6/6ud?=
 =?iso-8859-1?Q?lt++lekw4605O9/+g4j/DQ9U4Eeu58R8EkUrsJuUbRdhtG10gTyt4tfa7/?=
 =?iso-8859-1?Q?m0A+VyaDkmLQmPx0f3+V5a/YH7ZybZCH1enseXWBQnBCZA2nNkrZZuSh95?=
 =?iso-8859-1?Q?h0gR2cj9fHBKgdPk393K0CAVOPbW/c/5tXCHpIcK0WIFIjYjCiX4cUpFzK?=
 =?iso-8859-1?Q?/GFfH16eSJoo9zzqODB1ooKgem/NFqS9VTfc4TUhGj5cD3AT7r18xGA2Dl?=
 =?iso-8859-1?Q?ly5zqST4i3hl8LVm6OaY4WoGJd2llU7BQOGxvYoUgEboA6RygBQ+dnEAl4?=
 =?iso-8859-1?Q?xHG2oAEfIKbZc5Te1DMoChMR8m+kybziIcvqxNhSMOseMozwIsL5Eun3yn?=
 =?iso-8859-1?Q?lwqoxwjUyG2VYEA9VJ5GdUxkeMbSEjK+txHcZAK5SeOYYuRz6iKWT12Yhm?=
 =?iso-8859-1?Q?higHcAfSMAgNEkQ4O9OwXBh0ezynhDONWhAJlk7cHaSH+OAcgHgIXGZsg9?=
 =?iso-8859-1?Q?pHZkFuL6CIuhrl3XBiV4zfo61aMa/m8giAbx1Xfy7buejG/l7fnOPXFB6i?=
 =?iso-8859-1?Q?Q5Ljv2y6G56THXO102etKQzGQV85lpNTy5u1A+jf6t4oaGXUgWNORe28JV?=
 =?iso-8859-1?Q?obFNXF5ywJbD/w1CL3Lku++6cAxcHrf3uchMTidVexDolAWn4ldkNFlTxH?=
 =?iso-8859-1?Q?kRC1Rfal9+Nx76S6QJnUg9RKJvDxdDp/tXobN3JLCFoL2v2+vNpWnHe8Ac?=
 =?iso-8859-1?Q?1ALWrsACax6Trg8tnEk0C5/45uIDpbRtlDDxncVMw5ymo2biMzSIbNKhPT?=
 =?iso-8859-1?Q?+d17mgjNZ0IFqHho1Evj0Te1gIG9o/JnpdMV5/7fmZ7mqHs8e1oJByxrn6?=
 =?iso-8859-1?Q?eHZ42YZAEXEpalSmtFjrbNJBSMtYaje4CxkxWukrVCV0IPBzEmqDOKhFKZ?=
 =?iso-8859-1?Q?3ZnJ4V5vb/KKBfbrod1BRzqeKz8OSvG2wJCH7VTHfE1yJB+si+nc34hDaZ?=
 =?iso-8859-1?Q?TDXe4NkIZW0Gg39vCNDK3Y9RaL3Il9Xk8iKICvkfO6UU5svSv40kHu+oqQ?=
 =?iso-8859-1?Q?EYNDrY8L/laB7gpk2petpO7g5YuxeVCtorbEi/2lEfvcWQgY/XHjkIsZl5?=
 =?iso-8859-1?Q?dGFJks4QYg/59xWh8xaMAjyxMN9mVrw9LVedEcwNdCyi+HF3jAF4xfpt3O?=
 =?iso-8859-1?Q?pH73Q8Zu3ayA+Hs1JmUWexmIUKZrqU8VOqk9Npir8aOS8nv9XEiO+5vkVZ?=
 =?iso-8859-1?Q?Vvaz2CkLfqF4l5pcufGnMfYnwgaxIe8c7kIJNWsx8/0eQJc7RgSJhSfZkG?=
 =?iso-8859-1?Q?+DEAcDxXVhHVdXUbECnyoNsSCRsNYXrSZ4uAodxZCiPU0YBEjww6inZxPz?=
 =?iso-8859-1?Q?Fi0GuPZWPq8lzZKGwwUURE1pWg4iytbpVReDT4eXAPhnoHkN4ez4lGIk2b?=
 =?iso-8859-1?Q?j2NwUSn/yUApV0uDNWaZtjTnXwHQUQr9tV4g5vjyd1LbftezC9DZAJH3cZ?=
 =?iso-8859-1?Q?NVMS50L6r5VpK29QdsdfxYJKcjpoEKDVWUCwJMYYxzcsdD85LBS/Suy4gc?=
 =?iso-8859-1?Q?YajXGGtOhNij7SUwy9Il+DUN3YDTqxHh43NUhjDbcxW0UFNCiPO8KghA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f12d5-0f62-4a95-3fe6-08da844fcce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:50.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9i3rbyHQEBomL18d6mnSaPW34LO4jvrN4kOLICHINNiF2NSAOSl+hJfrlGMJPXQcNjVB4s66FivslXmkN5Kqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: cJ0lCxJkD3klCEzlxP_ddatAiuKLLChD
X-Proofpoint-ORIG-GUID: cJ0lCxJkD3klCEzlxP_ddatAiuKLLChD
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 0da287544054..94a8fa5017c3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
