Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECA57ADC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbiGTCWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiGTCV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1C6D9D9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0tcCW031787;
        Wed, 20 Jul 2022 02:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=xy9nzexN1y3fW4sWu8+SEQ5ajAMuhfaajhXQs40e9n866eqS1OeE0qFX29sCR9/cNz1w
 i1vKqVLqlM0s4aqsFIwZHzUkekNZrJ8HCrusoDOWt6/eLapqIHFEILSw/0L0wTKL3d5Q
 /olm9zGus6v0EjQCg1W7qmenILVcoI6JA0PkA29+daj05En4bH87dcaUzL1gFinHkoBp
 l0dngw16WYooygp6/Xema4Ktv1a2dswB4+OGLZ40myUCfu9L54XBhBv9wqByGj0jvNyC
 vSJRwRcRtzBCwCacv0i9encpzSOaMT63Ul+AcwumQ3VBESecJCiobS65ckmnTqPDGGq5 Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMh039258;
        Wed, 20 Jul 2022 02:18:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcpuva9S6wrZPmfyOQ0NqovfVIQgNlAgIk3FVHeHDrgRH0xz9q5JGvCesG35LW+Lxsz/BIH2UlDBnPqXiZSb6O99adw/CV0ZGiZsk44Lf+8zKy+Awyfq3oeEEAjO68QgJswecqbCVluzawcfadutS2yKHFK8C6PYnGKK36fCkzTr19OcLuy9yEB4OOt+hKL7FbcM2vfOBEintUHgiV23sShyxAMIwDipnEWv0ee+88URhhBKRSzClMO+53ifGbPsrWxNUhUfrYI7PUoW7tAxpB/PqdmqeMYBPwI89bWGqICzyyWlb3O+sbsaVBYYxq1iYo7F0VWJgcuYnTji719J3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=LS9C/xnb4vXycD2uxDxBaHdYhf2zKdhZz6hmULHpjML+ke3v3m008Axn80+6OjsmUChDYyBCJhYKB0DGWSR5o/ngnWN/qGv1NFi1eNPAkqrK49/WyHkGOoKdandrIopNawp3eiNju6C+G0YIPNPHpg+DOssYUMM3FDqQSAN3mwAPbUb/+5ODgUcyzoAEVNqohEoph/oRwsxdxi73I0mZlQb4GSH1wpMrFU6mu80lzd5L2L/TCJKUVou9JomkZRrKvsLjTXtOTpw4ZbiQidyhnS40Eaa+ExxGsDQMTqZ5z3N1mqDfccqGzK8k9XQIEVj24H45lr/YP7NNc0LqYMZl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gJZ157TUr3ZvoKL7Pi0m3pd91OTiAKBNfdaUi7n3Ow=;
 b=GnBpqGpGY8IjsRA8lgBY1/HejHEipGJHq0Sej+DXXx5MzY2hnWjYI2AWgB34wRwtGAPZAXRzerAVJLDZ2K6LqdT/+0LzW7Wwz//CiO2FUE/xlXGhSRijCosqpEf742MDZrL7tb6Epfd9/LVv/0AxvSHGKRAoOf7SWvbqJIOdPP4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 46/69] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v12 46/69] acct: use VMA iterator instead of linked list
Thread-Index: AQHYm97tBQNavi/qPUeVNysI9cHMUQ==
Date:   Wed, 20 Jul 2022 02:17:58 +0000
Message-ID: <20220720021727.17018-47-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac9c446-13d9-4c70-a6a2-08da69f6274b
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbGcfngfZpsTUkHeGdeS4zz/ZbdFS0q6jKryJECSc+GF+PSGmEsL7H7jHrbV/FD9eKdUW6hQNZrd6zALDsAu6v5oARoas9Kl+Xi9HP2+RtX2XHIGwzSUJkP2jztTDeGE7dgoTUCR3MTkA3vqOds7x4/JRCzvtyDWZIdBzQBr3gXEKoPVE1v08v6PZJjVKBIbLAk98SWeS5tS7yYgKw/NYW3yjV5tnp5vgqGAoEVQoMN9FcKmNnIWJVAb/+M3kx1LLzhOe8W8wNZSF4WQlLQztHyM5JW5L6QD7aWcJG8Q5ThlMaGXGDag5kIvknyWGOXopYQNNTTYI5xLBxfnf9Ak7NsUQzpQ8x1olVX6PFNkv03+i+dMBPhLl6mlrG3lG2MXYlbfqZohK+2AhyNmMkK19pmhNacw6+OBLc2Ae6HHKQQsQ5lHm+DbT5KGEbRV8fYaoW7MB8SfdEpZKt2DzpbhYrfB+2tzbmIq6ISi1Bdk74DXtbtJTx4ax0kcw/eAsjCjET6cNEA/Pag0ed/B6wLyEV2plE9gUYGBoHvLkZ2PFr0dcHoIJoRkMBCqrIxYKKemnaEW4V3A9ii+XdvDKVH8qMDUj3cSIaLaF5hMEc903x4SyI1TUfKJJ5DVG+JLtjBOc/dikHso41lS5zjSrwSgzNOCU3OY4vvVrkwu8e3VTl4zDH1mUzBS9biChdH0DRBrf47DqPn54c/XvNsvM1FCaIHKQ04afvkhFLAOPZARaaZdX3LTHIsCCERYL/C2IGCrpD3mT1OBziXxmMvbGqipG7pvLjYp28u7PmrIBa5rAvWo5W2g2Exnh10s+5LeU6KdS3yDLVdhYik4/TzkdfRl282OBVx7iASuHa8aZBKIUfS4AGRKvkxJR9ioFQbkt0/a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ps0LvIIbRM7q32jydNmiQzPcIBQkidlzJdowyqsVNzb1haF95Tiymlcgdf?=
 =?iso-8859-1?Q?AtFtTq7uP2Vm/yNF4Fjg1jgQoz8S9IAuc8r5hGHIATICil1kyN1E8jeNqj?=
 =?iso-8859-1?Q?x2aA5tTS/e5F4lJeKs7N15Y5DSf2/jmTF/1ABQQC0u7ukcrUWjkYJ2vPLj?=
 =?iso-8859-1?Q?EGQ6JaIPgJVz2DWGdQK4C+B0qgdeHQfiukt20GFqepLFISDvBz7n0wcsKE?=
 =?iso-8859-1?Q?5uE5M1AUgaeEMMuaCBG6mt1VyQ2j+YlLfsQuXTZwgEshL0OsakIw6q3f77?=
 =?iso-8859-1?Q?Kik6CgVtmIMos1Qg32SvVGLeKqgE3z44b7gnJ7xPqzsmllhSqx2kNNzPpp?=
 =?iso-8859-1?Q?s4KxYgQosdJahBIkW77gbMCLC1FxAj0Fhc3CUFTxpMsPKwqz2vZwPkYR8D?=
 =?iso-8859-1?Q?iopAaOxLbLQHxcMrvNwrVFOG6QDhtIcKGkA8qNNTI8RVWy3fkpHJkTPVVK?=
 =?iso-8859-1?Q?Lqd44IY3sLgXCTnvs8LPMs+xTHyPgRLT0OFtxpiZQJUOdai13ItcX5JhM5?=
 =?iso-8859-1?Q?Rih8IblgieAWMKUq999Jm4dC+UJ+wSaObgS907+VdpPK1E9n/Hvn6mcGfT?=
 =?iso-8859-1?Q?6XHRQZqevd1DxfmfE/poymc34kPmjcZcLMsd9g6kHXTd3ma8YnwxGyrALj?=
 =?iso-8859-1?Q?Kyw5/oRUTTYKEKVRbmNnoP6dL1Jt+bLL4jOkx2REpATPmHy0hdHXpc+4vJ?=
 =?iso-8859-1?Q?TATMWTECmkCUXETSS6HNsSOH3Ptu5hOqm3toH8FYaOTryMgOd7BwB6AHvs?=
 =?iso-8859-1?Q?auq6S56P3d+L9d2n/RdIVfGJ4a+g9pNcROJfOWY6uwZkWaEy8DsiF9mAGm?=
 =?iso-8859-1?Q?RvhImlNFB7IfZn7p2q01PFdeBupXbcDKx89U79ihcpCgnQuD8nupr8/j3M?=
 =?iso-8859-1?Q?3oVLPF2ulDy1a/CGuCyIfDGJTaXxdhW5DwlPYyeji5JSIEnA+UEqMAcszO?=
 =?iso-8859-1?Q?4oeT0GbDOkKZkgCmLcMdckQsANrwX0Pj9stjqZocLWq648lamtW350y1L5?=
 =?iso-8859-1?Q?LcfeO2EibpjDdzBnYNvrDd+aNJaXnBQ0jsXOFyWI4YXUfBBZeOYGmwwKFH?=
 =?iso-8859-1?Q?aKkh1Ji2U9TmNecpnMA8DFEvz7rAde/4CxuQHQm74339X/1W36t0XUbpoK?=
 =?iso-8859-1?Q?Ge3xwJdWvW+XYtS/ZHLTLV5lP4myW5hnSlkzOb1y+SKdZOUB1sMmKSMRMf?=
 =?iso-8859-1?Q?DlN8QriJhvvEnjJjBUNv45YaDRCkv4mlnF9HQ2gsRryIqctPA5A8beMkde?=
 =?iso-8859-1?Q?O9i2qD5VW7gLcarDUzHFjIj7pxsocpAhMhO0gWTPOAJxTw9zGOMkzB6zaW?=
 =?iso-8859-1?Q?FO1LXHM2W+Pf/oUzqY/2/j8O4GaRTtqGQB1obR/fUUNHe+eK8GcxiJzQeI?=
 =?iso-8859-1?Q?Yf96wBgfCPuCZGIy5GNV/mqp83pksb8f7JL8BHdCihB/T4mYjj0Q2V2Dug?=
 =?iso-8859-1?Q?Pi3bwpVipjbr0HXdU2HvR9oWrdTxRdD/zbEa95Iqav3hTIUYxukYKXrmvt?=
 =?iso-8859-1?Q?o3TgsfXJWQD8OFq3wg4ZP+8FmkDnHWl51ubZDCWjIgJ3brgJPO07prB3Oi?=
 =?iso-8859-1?Q?+SQjYYKbDPzYRjl+kj4Ju7VXZ1ezLK+idoiEEOghbqvdVbTmtMenhNa8A1?=
 =?iso-8859-1?Q?exiWU4SigWXx7sGF8teVtvH2+gxmSV9DAogbBfqzwS8qEmfaR/lUp6bQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac9c446-13d9-4c70-a6a2-08da69f6274b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:58.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO8YhXRmkSKA3qp4HcH6FsDgIFVKsZASNANvZs+3ftM7l003iSvvCTadpEmwT5AJKsfFmtbcyXcKfHQM0Rjp9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: RLeBMJ4De0RCsD0ZP-PfckzNsXD8ntTU
X-Proofpoint-ORIG-GUID: RLeBMJ4De0RCsD0ZP-PfckzNsXD8ntTU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-31-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-47-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 13706356ec54..62200d799b9b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -555,15 +555,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
