Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADAC57ADBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiGTCVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiGTCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA26C114
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKlqhf030726;
        Wed, 20 Jul 2022 02:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=ztX+/C9m+wdypwB+UFkNqTixka4IChjZRZVsPobuFQZLgTR1CJaKEU1diY8Dd+OA9iDu
 nd37jwnDI45NgpU41JKGW/Ed+DPYBPRKV5DyyICcPJT7iQo7nW5hU7ZWfZFCELbqQ7v+
 mACeEb6r7y1oGboLgST+7XUeBKYWo9bo0WFTb7GVIFIS5Vw1doVgFwPXlJAGhd0N2O1n
 gR1LSF2lpe514ILebdnxIzB0bt9MglCo+FVZsVsi6EkKtbiy35Tq0iYFb/OqVtG2Bxio
 IoDBqU4UeUptHWz22uJzF0B05Xhlf5Mg3fPfIhQalm2XMRToqgNsDBPeDqsWORywgS6X Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7yw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlc002689;
        Wed, 20 Jul 2022 02:18:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkAlE2LpMLcyQ8fFMXxKA9HH3ENcCh314naqoeGVv+94t5p4RTGKqpZXE6TpyAWhKHl2qbb/KI3rg/YRZ79q/a0KvfpFK2ZpwxEgo4iEV5dxTq31MEmmR86+HH1nji0xCDfH6ahu6y/1ud0GoBbPgAsbTpV7jXqZOV4dtXCqGFSFsaL9I7MkXnq9TOxQXOE4WvAIXXWW2azuEc2v0MxEH0l/zYlt9Vil1iGqRvu0hmUr1fWh4001b8YyBFm0UL7Fb4Ul3V85ruxS201OD0RtnHVCjTGOTCfd2KvN3i6nKW4aX6uD7bjFj+D87FXt874d3ofZ8oTUplkrvW6lUPWaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=InPdQB9Vq9vE04KUsJKEEH8LXUnqkUOOVsC+NXhrDdWiDKkghWG9eZGlLmFWa8HKFmFoCuZIOiKTkO5qNhJe9TLrUttjKlm/p9uTDu2iaTWkQW/8wSPs7UeDWpJdwUQ0zqLB68h/tHt83hS7pfneq9CE5D124a+Ne/7uQS2hwlUIhW0hpCXKuAK69Dd9fBE9fZYGelUtsEy+cgGQkijvHS0JJybBwjrMSqs2RXyo0IDEi2QFyqX0xycP1LXF6Zfr2915aLuY96vTurbXm2uU7Xdtn/EFYlsQJLwIQmZk46vXfIVARkj/7SMPLE5PZkuARitqnlgEVqdHyCiE1oKzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=PggaB8krZJyTOThYcaWeZenMaPUiMeZuR7X2BRf11R9CweB8cWIh3ZxVaunGn2lLIpY+hcMKFGsGzak+QlajO5odDQA6NdjCbpsodS8sdou1NMiqF3PSZnpDZLH7bCB8dtvyCCP5gljOfctzPE5nSwZr4YTJPNb+FAfPv4m3hRA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 31/69] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v12 31/69] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Thread-Index: AQHYm97rG1IFQaek0E2j6iFq4wTw1w==
Date:   Wed, 20 Jul 2022 02:17:54 +0000
Message-ID: <20220720021727.17018-32-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ddccf7-1a52-402c-417b-08da69f622fe
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+dqdfCCRH2yitRoCWCbRICi4jwwQthCMCEZAmiNjXE5/anMX8JfxF7rkzu6RIDSRghLymyHOYDdKGcY0Z312nmeigipbUXnKWPbvKqih7OodKzqwXGaIzBILrIz11kayRSXkEOw+b12KbpuJ6mGg5T+Q/RepDUcMTd9+k8h6f73BBnWj+8eCQF8m4TnmciWDvkW30QRrCu7DDMEQIZdVkCXd0nuq5+SbPe/TRthC+AyvFL02YpDcflAZUS3IX6aAEamta5gF3XBT/fWsSDW6QtWH2NZeEUUzibN0RksxC1XRpoVATKqaIw9lytioYR10FpBjHLWbTAlwfKlvWExsDOXIyVvxXbhi8UXVhLKgUM/I3Zib8ku1VEFl8CL4qGH0ov9hlwORIgUP1aTYBBEmC9WEWaX9M4CnmbnxBDccEBqjRjU1CmkuhVJtDGBWJYfJf95VuyQan5Ig3AAR4rffmPPBVnEf0E0lPBnfoNRPAEYFqF/jclB6FZWHqBihuolRSMv7wA5R88antlkVIskx5VRFfI0M97RXP5/TiRn9FXxNMCDBTKyPSL213NZksEdxy33e5MnOqJ4P8T+JOWQ1U5SGLz+kOuy1k1lhfOgwwtcBb7mGhcfpdZXe4Mv7ZWbjtAk9VaqXkNQQIDn04cOHM7KirBFd+ktKnIDp3c0owKiTbXKdB2FX2tsKg+l8RQFGBIUdGz1vstmd8CaRTgollHrEb/40yIIAW+sW8vZFBFuapUnz3aIBaE3tDi2kMRkekthy3oEbfHT56yHslXqmm6Dycza9pyjXXgXMRhPFdWhV86RJNARsb+ZScUDrddOqF0rX9vg+GC7ckS8LFZU/KaWch15u1yqJiLYeY9U/uCQ7U8F9y6DF92m+m0wG++b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4XCW1QfSa9zjy99kFvr4sgRZw3DMStNX0DFQxjjKA91/BjRabOTeBCK/dE?=
 =?iso-8859-1?Q?enfBgbmmWrDY5m9Y8/IzE15dkkiMsCUX4AbOvfuhP/p51UGuzMmXoLkd5F?=
 =?iso-8859-1?Q?RLdRb27E0ooUS8xT0cEQuupsCcMixC7uzKduZPDnM1gtm6zeB5IK5A4zAn?=
 =?iso-8859-1?Q?IassCNdyJS6WOGfG5cOQ4X0EDBV7dO6qc31iwADnzhp3Vkr558qnyzzHzC?=
 =?iso-8859-1?Q?fbp98MEPbRs3vkyy5n8iHsTRtywYtjK1vJDUES3KZ0QEd9jBUyU/vB0X8X?=
 =?iso-8859-1?Q?wc78gxUlb2w9s/O3a0MggHEV87cFz54Bwska2P+/2BQIuKHehyroFr6RLS?=
 =?iso-8859-1?Q?Ua9sdfHnk5CeRSj3wU7obtfXCfJP7foiq4yBK338KGTQDwalyswUGORZck?=
 =?iso-8859-1?Q?+KkTrhhtinLl0hyQC2pVaUS4oM3piHa/gbIlsukoTuQfU+Jo7Wm/PA41vY?=
 =?iso-8859-1?Q?BWROJmxTSzy+yhFqmQyqR+FuGedF8vUjsB2UfROItrYSXPa7ciQQ4NI5DF?=
 =?iso-8859-1?Q?6rE9o6ul8sLRY3clWIs2yD/eEB5zu/7t2/fx1/AcVJUm82tUbod9y7xISj?=
 =?iso-8859-1?Q?ehxDO/PQx7BZ0WfmGz4MXyY7l88Xirk1+bGM9e7GrQ+8de3V3OlHvB2yKd?=
 =?iso-8859-1?Q?b1yVh+5Sgo3I37p1CPqK042O8DTw4LUAIBx0Xl67QKXXAj7IKMR2vCxbei?=
 =?iso-8859-1?Q?YldLFqzxufvP6IHWeWsk6apBWpCppIHEAgL7k09bwudm7EXRHYkgZS7lhr?=
 =?iso-8859-1?Q?RVoQpAvDwErJXJjh+jI3kDVd2KXjsoLeK6ab6pRLG4LjA5tt2/8KLazzOs?=
 =?iso-8859-1?Q?y6XX3sAyAPMDRTMJU4kZbeQ3hFcAPj/XuFv0uiyVDBeqqZzAjmAPgbw2tg?=
 =?iso-8859-1?Q?b7r8AJijHd/Sr06IX1Uq/OF5HUUOHTZfKG+K3fjtD55Ufyts67UrtJnlX4?=
 =?iso-8859-1?Q?aH/1UQE8FoNhT+HyjgrXsMYmcDyMYDURoY7bTSniqAPJIYgijI/WPDLdDl?=
 =?iso-8859-1?Q?h4YGiwtYtWIHFWMrbVVFM1XVhnPl5Sme5aZJ9Shg8bzr0Lae4ioTZbBHa5?=
 =?iso-8859-1?Q?KaVYvOh2JxDp+7x6HlRtW7HoGo7EbgYDFMcUFfz/dN7KsH4jYNrqrtudim?=
 =?iso-8859-1?Q?bMRD8WrIwZmHGI4InngLeMTMgXe9Xy8LYquOR3GsY1ZFHlCyXFAnrtjkAq?=
 =?iso-8859-1?Q?gz1xFs7Ljd6f3iF+1qlGiYwLWHvMHFDvKsXYvbwYnz4muUQds+tZep0TtM?=
 =?iso-8859-1?Q?5pH7oXrWe5iFn5NLPXDcrVQTAYBTmcLUO+hKbqyl36uJg3GttAXyBg1J4g?=
 =?iso-8859-1?Q?lQAqBb40g0xS589GS200JoqotHYPUKMNXrdY9N63s55B6qjXn27uNWBUUK?=
 =?iso-8859-1?Q?0/izrLQ7W3zyz2kvdKgrkcmpAFx0NeROaq+tTY2aH2CP+elh0/bo5qN115?=
 =?iso-8859-1?Q?2Q4PUBfuTk5CnHGLKjTqI596O7RlXabewZKfesmRYIn+su9+V0RY4Fi2nN?=
 =?iso-8859-1?Q?bL6qGbrfSCYK/7hzteVeE2LALykwoq7Nw4jbmKi0x3JutOJ60o5s0ELJGW?=
 =?iso-8859-1?Q?T/k1DgqWRByQwsajmGtOusswaTBtA7bpNolYCLntXOgH6NH0N2PrEALqLn?=
 =?iso-8859-1?Q?dMX/b13iO2ewOBJq5Y/TWizqBUQwGktGfngh9ZH4pkV5aQH92w9goKvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ddccf7-1a52-402c-417b-08da69f622fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:54.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVMYNEYgtKNGA1b+PRiPxpCHqSHC4iq/zG2zYiE38gSBVmQNSNLMo3qJnZcNZNjqIRMvAhh3MERxZkq+QbpnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=877 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: ZNIDv_V6fScRPb3QZ2dM7ArVRRQi1grr
X-Proofpoint-ORIG-GUID: ZNIDv_V6fScRPb3QZ2dM7ArVRRQi1grr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Rework for_each_mte_vma() to use a VMA iterator instead of an explicit
linked-list.

Link: https://lkml.kernel.org/r/20220504011345.662299-16-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-32-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20220218023650.672072-1-Liam.Howlett@oracle=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 98d67444a5b6..27ef7ad3ffd2 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -81,8 +81,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -91,8 +92,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_AARCH64_MEMTAG_MTE;
@@ -116,8 +118,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -126,8 +129,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.35.1
