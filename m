Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC70577362
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiGQCwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiGQCwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A24A25C58
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMOljF026163;
        Sun, 17 Jul 2022 02:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=ZXbeHhWGB1BBOqOWwG5AxCyMtlNMPg8qvtBiuRT7wRsfCcfCFhRfN0LlMKL03nesEsQN
 2ZtnnCYyDh+FbBLmje4ZbhYdhcFmfzOs9ebgmCAtd4cCKIkiBQ6OeMZZi1elDXxv5O7p
 Rl3NWHaIZvMXtP8TCoGu01eRpBjuI3u72XfgOFv6UGascMEHRNEC1/CFj4MZttkrO7nr
 WFnOHcAx3V2LSMBCtIJWlxv+Yhvr2HDhsfAiTU/N0sE8Ym0Y/Fxc6oWqjzAqmmBcRu15
 bBi1CJ7i3Ucah6M/FzgH5otquF7ZPp4BT1aRJvS48c0vCKzteqPdwCuRrIDFutiZIbgC Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgId021817;
        Sun, 17 Jul 2022 02:48:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1n7ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Doiau4+gOVNDH0DKMPH+YuvxzwqTHNhe4PEq4ANxXNjOWbkuJEJRFZ8uSg3Z9oZStXTMvzufaUKN88gPaYjri/ufFTYIT0rKqAMILcp9GoriqWyGlTGzf0BsagS+0CY1SNnCuCw+yEchycukqnfjHS0AemmHVSYtSOW+MUyyfn81jxyRBxYD8rQ2jLiLh+EtCbZwGvQ62BT7rVuT5C8boZes7YvoX68oGmVlMa+HazVKjWkauoXFtW+BJ3t0Wq5eR7Z1eSlV2MiehwYxyU66/SNK46wLa2cuU0RobNXuAGeTAaK+IPPDm9/AGNHC77id6MGlB3Ow8IphIY0eWdwKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=QmFRMPxXMFQN97yqXk0M9ow/2JaAP+RZMrVZkcAJnuX1666xkFbPv3Jxmt9IKaORSSOTcEPHBcVg3j9YqvnH2v9BhJXeEKVQFPUBQJqLONKuGqRzYZMpdnArvFnqRY6D2hNvuf83myZfsJgsCWT1p7uPeouLPXRsgxhJiYJngpt5lFBEVtQW41sT9owGYCymzYc1zyVFdIpg6k3kIKRgAVSo4Q2kNGAo0KcUsa9dAkh+SSDRSnERAqTAHyRdVYz00kgIvVHn7ER6NCt/gG0euJJFJL4RXPqdQXktYNiyAhfc+GpxXCWA3832REqb6Xo1jChzPt+4WAAusfScudKWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+F2vYURpnnED52U7mCycaVwvF9TOYJxCnnI5slxg1s=;
 b=krboD01pcFPuL8elWNjPivGzwcVhHUX6FtFdUqlpryN+KNBpc1UydTCelH4zM/fDevD8w8p1JbGdEQVhSFCRj/KzhMqRIeF81Oj5cOwvN5ktLkuc5qr3iCoD8zTVl4LRAEJ44VF36ySHEEpOGjkgabBWtlDfgCqddZjaUfWiGcw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 60/69] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v11 60/69] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYmYd6OAT5ESneUUmIcox9vcbYCQ==
Date:   Sun, 17 Jul 2022 02:46:56 +0000
Message-ID: <20220717024615.2106835-61-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3709f264-36b7-4101-2c43-08da679ec561
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEUIs7Ze+xgWDsDpeWNQRxm98an6BlSzP5B9p6ZBaGY8fVkcM/cnKQi4ahqFKCVw+ixsmmH44ccHInUrw0waCX0XuG/4nTMo0P/39ZsoICJNlgLb83hr/LVPUfwKgURqJRGx2UGuDQ8z8nmOQPle8AM5kBbIqMQc6i4mqnr7dnfiJGOEwUfx0deGPk7AiX2+I3M01vQOc/q42R19IMpQypu39HWCH5vzGTh8LEcr0uiEMaZ5y6Bkr2xiJ5fEJ5XC3bIRcWIfC1p/ytFipEyNCngeSi8t9shU3d8caPHE6D2CZVCNdWW76jETVu9g26tNaHB0xbY6Tl36hFI534349Yg3f1Zazx2kUWoLJ94UgAghNslgXC8NIc9nZn9aLrAEHanrIPN7f0z75KJXGOIienFVu7ao6BDN3pAKYPUj5fsh3cHVdF4fLURdxMEFm+KZgIKgKPe9O3SnMY7VawWI369pavWR/E6aTwioDC2RoP25fb5CgkEyaCADKMZ0SHYAQrEqLoomtWXCnRT1WfnPqGp+m4LyMfkD6O0umxQjrBbG0/u7s3aYe3wkT5ZfO8jAMF/Ee9svaKACTw64xxmAxC9oAGD0UOhXR0VA+ZnaLIYsSwlsCITEXlvQXeCF1OlPf3s3QVjDVjq8hFEoNn1QXatxaQ/iZN4eretHDCZn2wghwUZUTAW05uEHw8spGsR74C1Re9qYGi1569AkdpXR2czcNA2PT3FwAbQGMHUtL9u3qjEEdMoO4BunyrrmyNrZJmdFhWcY6SSIcCw451OI1AgVK+Zh0d92++OdrOwr2CJyjZcuJYVr28XT2i2vX2z27uPCQ/0103niRb6C6iifxGYuaaB38sOahswQjbSr9o2VRR9Jabb/emeARUsrXFVn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(4744005)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jywnv6xCFjogn9fMzR6bjlchh+PfnwKZaPp/YZbmurHnxspdc3rY8glqO/?=
 =?iso-8859-1?Q?b303jYMI3/QLrzGZ4GHmtHLkv1frw72AezrVQ/5opeaxhiN2c8HOxVuVSb?=
 =?iso-8859-1?Q?2N/SQiMgz8nlMPC+pquZmajGjiCKL9ZKhTdeJNV1hAzi/6/9UnGTEDLT1c?=
 =?iso-8859-1?Q?Qo/BMdA1wL/dQPBEWipFFPIZXz++AFcsn4slr77SVN5S7pmNsaQCZkh0CQ?=
 =?iso-8859-1?Q?T1LRnXLkQp7ymYpAokv3njHEQq+8K47jRx8CMZxP6jSJabYrX4o+eZsEIZ?=
 =?iso-8859-1?Q?NqS+x514LFRj8bG7EtISkMz+GVPJ06yRr/CyGny+RrUvx7Yduo3tOi6jnn?=
 =?iso-8859-1?Q?47WT6bS414+wsL91QAqJTXzBssfEzz/7pfJ0QIp0fsZ95HrEDlRnJ97TbF?=
 =?iso-8859-1?Q?QK/+OK25/ZTVJ9nfC8vv6DqkYOAv/tE2+9ir2NHCEKwZYifSZ8I/o4j6mq?=
 =?iso-8859-1?Q?0sWiLuiRNdQ+enxK4kozktgoc7wPXN387lEmKHUfobET/yX0xIs56JeT9R?=
 =?iso-8859-1?Q?TVOqa2OC8XnswUneXbHf3AQtk6M+0/719fIg9KmUb5WfLtTHC/YKBkv3p8?=
 =?iso-8859-1?Q?gM6EJPmMLGbDq+QEEZAecH3QSB9thC2LcM4ZOOQnN8BSeWu0DMDPjrSq0w?=
 =?iso-8859-1?Q?ZzVqTT0Rbu5NR0AnaFkLrnmDvZ+SN7NAbGBE57BQ4z1eFPbXbwh1808pjK?=
 =?iso-8859-1?Q?Kz3Sa2FXV2BuQJFJeR4x7LKfQy/qgD6WupOt9aJcj93wWaB3bo4VcHtppm?=
 =?iso-8859-1?Q?ACCF/E3Tlc9JIURIS4gz2L12Hi+sPBU2ScH1iYseZqdS0XITjv8JlzjpJr?=
 =?iso-8859-1?Q?YAdJwjbKrTnQBl8/xHPBFDnQmD4RQMRQSSkwMaK0V8JSeaMKrKWZaOPHnV?=
 =?iso-8859-1?Q?UOmrEpJrCCEb8IeBdRCt/aZmO+iVnN+bqyRDAMZc4LdhjcZojxR0t/U9ku?=
 =?iso-8859-1?Q?NA7qSBz0qLTalr1gKDIEzabFCmXRG3HlYYlmdUUFNc5KNzN/oJ/JeoN5uQ?=
 =?iso-8859-1?Q?d/YpRf/x1ZTHnIpGMzwTz3g2tugkPWJegtREomtdDT4kkReR/gvnAVR2Ck?=
 =?iso-8859-1?Q?IHtRbUdthQdB2L83pi3+VIqk9uB/J/N2rqe0KASQw5tdW0qkk7ndMTGQJX?=
 =?iso-8859-1?Q?85dnqz60ZCi5zJQv8Mk4uCqHvhrLk0BIfRLJPzD0bcM6LXgki1hXeLLRuf?=
 =?iso-8859-1?Q?DkWmw90m/n3Wxx86ytgMHR8OCq7SuORFwjEkimOTmY7WTB1G/UIiNYPcg7?=
 =?iso-8859-1?Q?qt7yZkleUx7nlhrfnk6twqrSYD8e9c5M3irly2w6AAXB/GzXgWehnZmWC2?=
 =?iso-8859-1?Q?nUlmmUiQcxhUf5LI0YAHy2ZnzenFGbg37DHY6ZZbJVnBcW4cKC9v3B1Xc1?=
 =?iso-8859-1?Q?pwt+kBph+RjIqV/lqTq0RCJvxLpd4+drm4Gq5XJw+I2fEY38cBBnimnmRq?=
 =?iso-8859-1?Q?BMZ9ULsMbboZncfgUqgrjRHi+5r7U82l0wu9tjogjlVLrsdKJnZtEC8CNy?=
 =?iso-8859-1?Q?1HpdgOQrqKPHuOodQmcJNJ2eFo//f7Rqov0TXv+ifekmNryCaas46w5d0E?=
 =?iso-8859-1?Q?4yb+uTra8jW0WfDqXnogJO8nW2442KlC6oAh4InYSscQj7trk44oFwbks7?=
 =?iso-8859-1?Q?w/4ykvQeXN2BvIDSNeQBZh2YeP6K3M8Y34G7mEBV7xjU3Ckz5nAgCYjg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3709f264-36b7-4101-2c43-08da679ec561
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:56.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuPrii7nUyPGxdWsn4yn9tFhp9C81S6V/MxphD2vngULjTNo6d8HSZ5H0dk0c6robuELs2/4y1eCvLgGz3l9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=901 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: oePu3nOVmfeLS_a645bQyOCd6i-UDYVG
X-Proofpoint-GUID: oePu3nOVmfeLS_a645bQyOCd6i-UDYVG
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

Link: https://lkml.kernel.org/r/20220504011345.662299-45-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-61-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
