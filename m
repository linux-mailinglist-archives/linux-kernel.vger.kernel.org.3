Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D2577336
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiGQCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAF019C06
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8mWS009468;
        Sun, 17 Jul 2022 02:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=QjLOoYjPrB+kQ1m2FfhXLcdPBcR+jXDtFVH+ekN9vXykrA4FSA7aDbChuVxm7Hjs6i11
 qp/4TAuC/ODjbnAVeDarS3krxdrw2NXBgvcLBBioATEMFT7VoD/94R/SMZQDWj1jmLnN
 7TqX+P6O/TlfnkohoL45rFNBA8GLNQQ/rJnp+WIQR77DjRKoEedrTgUuVjJXJxYX9Zvn
 vj8Bx72XfNbqO/Nsy5Li03jVhE3r932e5/011k3MaxQoCGKMLjvST/RN/cAt3IFNj3m3
 EIluc4oC/MsAiKZK3mApEltJLtGBGlyjiGYcmi2NtOhvTldAo2t2Jf1wB6sV2UjxHDqN 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3EC005901;
        Sun, 17 Jul 2022 02:46:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2cgLrVLPuQmgzohYMRY6JJ+RhHxkBSid/qnzFRTB6lb+IwozIUMdf6Ttm2ZM+xVr+fiBbN+IpFi8DVISa700dRCIv20dgASJE89i92/oszEM4FBWkGuwNaSVM4eIHWB5Zntcqw2POZo/yaJ00eB9944r4mTfk/B9oTfsUKBceiRJHBDr5JI7v5YxLiWjOCk3a/YO0Z1fXr3Olqw9m6JQzaWwVevIKf3EvTuCNGNBIk8ahgkCJlMi3F1DHDhJ7X3COABhKYXYSsZYIbf/dPF0aM++JZYzx9kqqHJ8rm9NRtB0G1hXNgJe4I2NXPZYCPBdUZhFpnRay7yOKky1mqLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=Q+braAXNn+g8wb6qsXSh8feD/uHUg3xtrvVHKlTbCk8q1rqwy+dl87hN266CxN7Nws1+rSBL0VvZvnrV6EGzHJiZUVRPuP2lpapOprWuYah4UAewSjz9TyYY23rAtp7ZSpHEoR3QTR35CAqpKguhuPqcF6Q9qAhOwX6QaCV62Gsm8E0BbLPND0kxkbwulQoQF4HQBCqB6kedUcMdqMBHCOtl3B66W9yT+YKjZzIlMl5IOG1sCNeAuFNLp3/0TAJ6e7V7Maentf7coDDmYrzIrn6r9ahwMNZI9xZkvi0SGBTRHFuqDU16+EgdvGwqbNymb2pHGtx4iNWULQddTCuoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPnUc4YUfuaGtUKTX+zTMZ5LFuL9w74PMBIBon1j/RQ=;
 b=tH09uTLdQqBKQjxA6F+RS/eOgxDD6kbjx2MDGoE4KHo2OszauGEtV4ZiBaUi0iOhdhqNS2wj/BilEts/L5d4RvyKR4WpWxV1KkkYe9mfmWxnwFzlwGAM1xR7/Dl9WwQzEXdCg1K+UoaWzXNoaziB9Mk4sEm0zIbic2CWDYV86Gk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 02/69] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v11 02/69] radix tree test suite: add pr_err define
Thread-Index: AQHYmYdsYYdYeheyv0y8XPjway1Y0g==
Date:   Sun, 17 Jul 2022 02:46:33 +0000
Message-ID: <20220717024615.2106835-3-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43e49e31-5742-4089-7fd0-08da679e8fac
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ld2py2uxcl5L97ZxNxB5Gk6/L3TVgzixEjdUMHFJjS0+wg63XZRKbixo0GvuZKZdlSAm/lTYC0f21ySUDmpOJqgZwgNf7+FRkgQmccr3nU9dIpyl29PrN5ZdPJ9uLsar5MgfX+Rt3mKG0RLybTqAKTb3NzLXdhQ1fRz1Tp9MCKX0uvbxy45jCbvcI6HBqvyHhL//SmO+uYFQlU7ApL0P12H3D/a181Le3cDFfxjVau4hu8NpDEQemvAHB7306n1HsvlHi1OrJNd25FJjdT3PEBF+6kttLmXS5vFgSkvRnth0HcDGgB2tRbrjP5rF4sq0cPmWD8iNaWb3HIby9WEexlPV/4eXX5+mdG2J3GU/7mcKeqOTaYFpffjn1Tp6g83TYLPPg4ZmdR6eUTWg6vNRIZrlLd2BvJ1GBRzysDm1lbo0j5ZcZN7oEYM6IrZivm5p6Bsgqelolz9t3NEobF4hb9l5EI8f7jlNUZzDd9hnp36oE0Mm1o1zgp3TMkrhTbRBUzrDuRWd6tq/b881GrYBP8EGDujfSLOHr/Nrj4gwIFLMMxYNpxoHxW4jH7lCpK1Ol9E1YfV4MKKwlg85M+RlGNDfnjFQ6avvrmBj4dqDNq1ld8v8j3HFrPPkbYj3VRq0RlRxWkTjeJYApTZQPfNLIpGNCD/z2MEcLmgoq0M+BIQjYVZEzFnBalZ8ZOcd5cx7yC5j9s30ocdmRCf1667TYhYxXCatQ+nD7G+4Vf3qfmNIWdbWtULnXJb17b6Bh6AG5WnfOZSIxAfEHmmYhEPBmaSqdYdE4vbCcGh+QEHnswOtsW+RplcikhnkQX0ZGkI+8nUsnFmUySXg3wlssPkKgc/pujnipmRKdx12UVh5ZPwesZYqSI9EHU7u+hEnGyh8xtAD6d22R5bROUj8TCykWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(66946007)(36756003)(8936002)(2906002)(5660300002)(4744005)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GIxCuWlteSrc9XGDfgBKQ5eOW6VZI9GD8mZjG+BPlXc3slAvJRw7Kyylp8?=
 =?iso-8859-1?Q?YPp/Cg/YTgLjXRpGn9OWhaCHZkMC4isEA1oZmJ1jyqd/+rD9moG7L4HPUk?=
 =?iso-8859-1?Q?pPjdLuWfwsXcCwrm0Dvc0mouvAZmfU3CAfDxfmggryRI6jEi0wwxaZQL2Z?=
 =?iso-8859-1?Q?IBqfGHBP31ry7zT/6NqWjoABQ/JqywECaiqNRoopWJK3kOGFQ+XDXcgRab?=
 =?iso-8859-1?Q?ajYmBaIkFYPRp1jVUD87JXqH4D+aqfgqy1USjcgU3mCM7Bc8zXU0N5WUYH?=
 =?iso-8859-1?Q?Jgtm64tDCd1M6xRzI2VUe1djlkQBxIj388LK8wm6JsSYRrFu/k2RHZa66C?=
 =?iso-8859-1?Q?1vquu2SY4lFWJalQkE6MT2OLt6at7KDJYNsHuTKJhtdcO0twZ6pVL2NF4v?=
 =?iso-8859-1?Q?v1SKNNYIp9PTIyN92FP/Ny8bX0wIYrHcmvdr40qzWD94sDmmzzvY0kP2C6?=
 =?iso-8859-1?Q?AMg0PlQkS3gkMiCkuDG2sf1snF/N3IsdLlX/VItsw66FVbZsEqnLr7uRLI?=
 =?iso-8859-1?Q?R5bhBPynT3755gB2vUnRcXTCXKGc8CBtzYDqHm/0qVdvFzFx1ZLe4HA3XD?=
 =?iso-8859-1?Q?y6v1rlxT8B4y7C9Bh5C6tJktGnrrgr1Ry5QIMsnWaSYgfuDUg5XTD9Ttrt?=
 =?iso-8859-1?Q?6lgKx8Il13as0scKliJ48CveU182vV3du0F9UNYyFSqdHNOuGo54Q+Fxkl?=
 =?iso-8859-1?Q?mho8/qC5k6v9fTliUaVVpuXcsFElf51xOJ8Hwk1GYNAIGQm77wiRefvrbc?=
 =?iso-8859-1?Q?PNdOM+0gZskei+x8Ql68eXG9SWqQtD22GHVZsVx3kyd7TIFvCBEjaHhm2M?=
 =?iso-8859-1?Q?yTPRzlOIV8FEXZpSy8r5AbzTAwVvJ+bbdXKwRbOx3nzfyq/rXEiPrlGZH2?=
 =?iso-8859-1?Q?iNsg466ranOo/t4z+kTQz0hbbKUUEB1sESn+AQrKHhffbBpGzsh8LSDXmL?=
 =?iso-8859-1?Q?9CbKkj0fWI7iC4LofQMlWnJmK2cJlyUF03h5V4qLyNfljZY8SAkqH3ZMFg?=
 =?iso-8859-1?Q?sa/yKg5n7NN+gjMNoifKL5kut3S+styalLnsADlaDMaotLqCFlKiui5CSK?=
 =?iso-8859-1?Q?osrBep2fN9nR9kzDkSyyT8gN/Yg28oSkfbolZObOwylFTaj0IPgpNbg3FJ?=
 =?iso-8859-1?Q?dmx5wH/eJwbDvwdOAB0s6l2W/5JBImqqOPbUpsoO09wUlymZnKVCdZLOSU?=
 =?iso-8859-1?Q?Jq2OWQ5E+2Gkb1Yd53JGcJ+JK6JSPW2kKsn1Y/PuPUUEXpet2FZ6r9gyzZ?=
 =?iso-8859-1?Q?Lpz0SqXEsDPpUFW4SVWJLcN785h7XlgQG4b+3Ic+DzuJxA7w6yqa7pZeXv?=
 =?iso-8859-1?Q?BAIYfT487+59dj9wga9iE/1T0Webbw4vyKpVkbGEkazEavVrCx2rnp5+X0?=
 =?iso-8859-1?Q?NBFbV+GSHJqNzlbl6jrG+jEb2HNWn6ozsXxeh5kPoz0pnq3jPgvNvKAnDF?=
 =?iso-8859-1?Q?DVJtOU0/3xbjfoia4rmpSQQjiY+M3taF/1cy9vcO9YnSA/0LKdr2w2Jfmy?=
 =?iso-8859-1?Q?t/lsK0fM2CmzefmwvjNvgQJfLJT0a3zKE/NWIHCas3+z+KFUuqIJZq3uNR?=
 =?iso-8859-1?Q?V4l9yeovbcq9+5yLJKT0+TYpZ84WehHT+8DmSxaX8TkUy/pSVYWUb9WQUD?=
 =?iso-8859-1?Q?9fEawoxu39+GeNpljc8NT3zSRLbIa6OTN1CS5UZ8LxM9myRBg0505o4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e49e31-5742-4089-7fd0-08da679e8fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:33.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/2EQaa87iMzOD5T0ZTbL7lqzVZ3onKuQwW/v7Gy/AlYlgJ73roCgINCwu8ALHNp3irc2zF+8QmFnatUOhuicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: bcR98wQ4h4zPdNffyCeeKvDzJwtbsrzZ
X-Proofpoint-ORIG-GUID: bcR98wQ4h4zPdNffyCeeKvDzJwtbsrzZ
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

define pr_err to printk

Link: https://lkml.kernel.org/r/20220404143501.2016403-2-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220504010716.661115-4-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-3-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.35.1
