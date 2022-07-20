Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6757ADE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiGTCXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiGTCWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8448CA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K119oA017919;
        Wed, 20 Jul 2022 02:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=HOOA/Vrhi/exyh8ImUntEVAlmyURjD+00EjyM7pilia+9QK6kC4MTKGqg08GGLaIChdX
 DWtECEhcvJWz4huqtCOAGQFmQUTGypwYg6d+XAghaRJgb1KP7Am8N3rQpC0eO18ST/AJ
 59zkkfz6ZKU1KmciavDAYkE2JYZ5sVvmzm0Qn7xk+kUvkQSDNEoYjO0RhR2ugkSydzx/
 mHn01AMYlVCQnv/Vxdojl0U27/liIumhr+buzYhleMxl3bZIn6Cmw+ELhDUYNHgAaF6B
 AWi+htEr/tgneIeZ0As1c5JKg8i/X0MsaXfcUZECHlA9KWW1vGRBXKIvcnZyW1wlgxwJ WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMk039258;
        Wed, 20 Jul 2022 02:18:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL/MXlknZbjF8HCSyTBxRylVxBnZASJSxHAfUd9MBwHINWVfhKq4UJdNFFl0lJbhgjTXpm7bQkHilzLrpBJMS2yn50uVBZ8Cn8VY3RDhDRpL6vR5NeEw6TVlA1kpoumFhcWQdVBUikooysFF1XwbKrTdUBk1akGXHbXtPEWu54CMMd0NxwAcHUh3Ow0yNABSlTMoLvi3O9LUByAO7/UDFucjXP3K8Mwkzs07uuSTIc2+xzIwWEZ0PPIw+HPDNA+lhPGT+6nZyJr8nAvVhFXvA+U7VGVXXtgRgJdOV3tkJqK88NcZqMJ7LN6Iim6vCDOoIyEC4FV2/zfFUpUiwv9AAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=ZWmGkoja2k7iAS1ObBpV26D0WmJEA+3/+8wsh4UY4bH+RDT2qB02N4QiHvVToH4/q/dF3LLomUK4HciJ1YDJZG4/pPVonZT95m/UCpyBYf+/znYePzdG6pDLHxLGWWLhvtQoE37d1nCRhtUwuuy+lnJ6Am7ZEp6vT2pE4Ywq+8wDalPKlSnHgj5xufauwxdQtunPYLwA5UloxogwGz7ueduCdufq2wGAHlV3igoRaNKatrOiULEwTXGPP4UAljkLqGo4hAO3HnVZrWumyn1S8vMoRVMdhA6HL5r8TEHALpmhTlGZkK/xzMGmi9Hj+rLwOa2oaqViR1SaXI3Bl2e5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5m9zSCEeCIQQmWPU3HReQ/7UAfWKP0JAXF45LVrd2M=;
 b=TJp2SSIaIsqhEifNm1vyBAfubzFytBg3TamhqUmjiiEqFdcgCbZDElv3FZvXa2spiv8buLPCxGj/peMVnAqLz1sXYuR5pd93EWg5riGYe2+dUMtKz6j9z7k0K18eJ5GjdNFiwZPbqXTW8U317f8/pS4JRQMtGtA1iuLZSNZliH8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 49/69] fork: use VMA iterator
Thread-Topic: [PATCH v12 49/69] fork: use VMA iterator
Thread-Index: AQHYm97uqDNFA3b3CUaTk0eg8/iL6g==
Date:   Wed, 20 Jul 2022 02:17:59 +0000
Message-ID: <20220720021727.17018-50-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7518da-c456-4fa5-5a14-08da69f62848
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wieZ3D7WFMskrIZ/p+MkB/f92itVH7WfH33yEeJyQfUvAIsZDMZa2l0/as+vDw6qyctBPcDzevwPuWLMCeuJso0cavbY9hr70tv6QfV8i+vDERLbS7r+To2O45Wj7uWWeASgTI6t5HvunA+ufckXLnVMAxXLtciNoSmvyAY6DdGc+hxWJ+RcVLcVKCvx6RUdQHaiEfB2sFt+huIug+fLUUp1wKStihayPloKVVkiuW6G8QFJAhTXQem5eviQaP1x91lRPXszM/ax6gRcWJRbtkXCjibqe5KTYe6DZjKhEMVcENRgj9A5RiEy/GenhUPdfmoHz4lmc/JtOlDYnhVLA0lJcOhfO9Aj9EdVK4vCkSufrB6nsVWgIHC6pv8yG5HuH083aCbfoN2w6wV43sGP3kfrTl5nxSkz/XY+3+u7uwj4qQqDhEcmMeWQo9A7Uvz5ZjC/T7mpvQj59c4JUDXv2tmfUczO4MKzOyLrEL3E7BqK7oHKJcHq/z2mZ83F2/UdtIMNIjjM7zmZ4fzHt50DnP2fyMnDDGlyMp7H2NCEOHerzIwo+qUK63mgfFqcLGcUO3gL1o6gEoHwlpcL2C7/flbAgkwlfsdgxKF3AMuth8VDXED9UNSK76q9Wd9LqDt3CUzPXxceqwfeW1SBlN/co5JmPAQt4XgrM6o+t+FCrAA4xBcbH7+IoHd8EeWE4o1juKGf5Kv2vKyRF2MlQp9BzsgbI1EmcLGtzzs38/Ny4u/xnXDd7svHEDK0xHwSJSEvbpk6aaXHBgEoSD4GDRToY0ZRYAy9EN6Cl+zp4F0QQVp2k1VOjBumjXFPuq2ASOWX/WuiF8xC8M13vdi2GUkVtqLVpuwKm+KSWe6CXVet8vhpXtbBhSpvlZ9niynp5Udf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bCBanb7KJyY3/qgb7Dh7egMFRT0gWQixCJjOLIPFwK5hIB0Uxmv3R+lwAS?=
 =?iso-8859-1?Q?AkdE45I53MZomph8tPR6L7Sm3GtjtUWMr0CaDUl1J4CFoMw3AQMjrXMQZw?=
 =?iso-8859-1?Q?q0Q0itc6Qc7TNbbLhmz2V47gG2HZtvLV0Sr/ShKx9ZgY15lycZGdHTaiuO?=
 =?iso-8859-1?Q?Da4ghnUahmC8XjUkUigp1xGGPzc3QC1VRePsmkxBZ6VIuKzfNvnF8lU3xd?=
 =?iso-8859-1?Q?+ju0g2jHBgucJ69yb6hR2EBE9sp/ifL7d4reBHi3X0C90Y8H2ZdoparWbD?=
 =?iso-8859-1?Q?9g3xWpaQBunXV2E3dtDbyJjbP+L05MbKxB1HjQJokwn4FA99fFrlVzfyIO?=
 =?iso-8859-1?Q?Ewb/sWOS5bT1phoa/RSV1cJJNJceYcMjoy9Vuoowz6qxZw4/akLmVXAfJ3?=
 =?iso-8859-1?Q?iiclPCvckEhLa1Rh1bGU5WOSltmxP8IgNG52A4+aUUqj2ko2ZylXa2t26F?=
 =?iso-8859-1?Q?jpfOT3cu/VZls2Nf+Q1vPKkA1UrCpf8Xdbu5t6PdAo8iWJEFA9/wUlhUlu?=
 =?iso-8859-1?Q?LCPMC65ss1k3MDUG75RnoW7CHqHYjfRINc9vIe6H3b/ZZ7EdOT4ngUeng0?=
 =?iso-8859-1?Q?QWkUCMGfcUnzgJh7ouqnlCiqImpne9ZVxBydFkp+3B/cv5JGsYxtwSHgd1?=
 =?iso-8859-1?Q?JJ9yQk2hTs2c/d1Mvwz9kyGl4RRF7EpePiaQkgySe8EvCsb1IevL0GHEeF?=
 =?iso-8859-1?Q?Q6TqkzcWzvpKxOPQEpQGJVHzXj4XMUm2voZoNfRaX64blBM1dq+4c1YmOt?=
 =?iso-8859-1?Q?IxTQWkJb7goCjRVs1bs76ApVHk72FIEvCQ5rlFpa7TwiBwetVK0gimiHXe?=
 =?iso-8859-1?Q?iBNpiVgVjrJ+Qndo341mgRtTRlGGywxTfirD6G0g29b3Z91UFqUSly0mdW?=
 =?iso-8859-1?Q?yP4EBgClhoRD0NDa6WWuEN5eej4DlBUTf0CyC2fsPrxuVjTfm5586EZXYe?=
 =?iso-8859-1?Q?MXFmA2N5cMOU24gnGV/YEJ3PLCQhPHlclaZwxlEsdN9bc/xnfNy0nKtYda?=
 =?iso-8859-1?Q?wNab6cl+1oQbK0WA7sxJJjKADmXWhyUKOV9KCvHWBtWwTrzf5wnSfUHlwQ?=
 =?iso-8859-1?Q?DIduxHxbGcHNY451n54nwJti5365P5AexjrvGnCouCqgxiATNzKnzc3pPW?=
 =?iso-8859-1?Q?TQIXQ9ovU5Dq/NQuCejv2F+KSAl6MjmcfLkiZ4U8bYy6hA0mkxbxuazu04?=
 =?iso-8859-1?Q?EQiYEQ1rMElmc5lcGmwoUwtdEv4R02L0oRu4eALt1aS4E5aqPvCLdH9VTs?=
 =?iso-8859-1?Q?jr40crRW5rmeVFCqdDCkBGo7IBoOz5UwVdfMTzsHTyLUb521zpnR+8Cq78?=
 =?iso-8859-1?Q?TwKjmnZwh7zZUkwtuAf3bgpAYx1fXCaLpHC5Z04YoZ9a7E5EfVBhNt9XOq?=
 =?iso-8859-1?Q?4e+cu6u6uGZet8trnQci1GJZx/GhzziU+ZMZjE6GCKzD06N2kvgwozAzG5?=
 =?iso-8859-1?Q?RbTRdiXDD1igFGd7LWdfHKHFX7JSGueQR6C4/+PFFBtxF4ikQjvNv44lWb?=
 =?iso-8859-1?Q?yyLjsuMX/eySexD0kiROru1lUkEGM8ZIrFEkmT9WMqCXT9GY+mj0O0Damj?=
 =?iso-8859-1?Q?dPm4GOIPDbAWf8EBKwIFOoF/Ny2pJ6w4rvKTKaICjTM9KR56UhnzzCzohW?=
 =?iso-8859-1?Q?qriwhomDGlMurdfic+bYsjTOs8TyaXPJOI3rkYZeMvTLQ8IO1YLXBKEA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7518da-c456-4fa5-5a14-08da69f62848
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:59.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YrZYdM5cGBWhyZZ/8cqsQBa/uOtDnPOwawTNk5ywH9U/YlvsrlsEBeirD2orvWZhrG6b/Ay3rRphF1u6JjIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: xSRil919a1aWtlN0scbzqrMdVAS1SJC_
X-Proofpoint-ORIG-GUID: xSRil919a1aWtlN0scbzqrMdVAS1SJC_
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-34-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-50-Liam.Howlett@orac=
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
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4a9fce369f30..4b7b0b7dd446 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1294,13 +1294,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
