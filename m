Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302657736B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiGQCvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiGQCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46A222AA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OWt003733;
        Sun, 17 Jul 2022 02:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=SAvbVdsc7gPA40FL5tF9sYLbA/INBFLVkV9X2VTUYoAreVvEKQH6yBX8KxANN6JrG0H5
 hQOoSBhhrIO8oDuHQfzEOBads0ljORekf9sO3Jn9HRkSYKQmU+8XoXHmjHcz6cPH0bCE
 D++cY3G8HJi/tdWKNmENf1Myzf9FmOptM9Vd+QGUp89KenQnQllmLSKDsm7Yw5UoOQBK
 /bDy22DL1lm3exCeG99GPuJTM25K60ZHlJpjFYX7XSl5TuDXWP1Cs0OcuIEGxopBD35+
 e6E5mWwjB3u23bQtJ4yGJYBMpwBOBH/i+G71gfavkdo0hjqPZrKPUa3nqhf4frBVG9Ai sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYI01036125;
        Sun, 17 Jul 2022 02:47:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+kZH40Yo7iyRp22UeqcfDOvqwP9N03/fRnewB2DTvuAi70QnjYewHcbmzuLHkFTns8UlJZVTGfp8JjErIczJuP3X1Yo2hxhruWjF7MLYkPUOwEdfXeeDBAtrCgi2xTaHlVGuidRgDnJw1BdVCePo7NlPaDD/WXKRy/3F4ZXKPJdcHvGSkZ0zIJkEXTmwaaVhqZR86QhDr2MJDXp6A8Y36berdm6mVartK/W3EucXVQuhV3jzYRdsyZWXsLkR9Pk92F1mK74EauKZSAzdBofegzEcvkWAUs9MPfBqmxgDHb82E8oYc2N8Gg2RpMEgjLlBZdMniqUyRozf155qhEZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=A79iRKSEq2bqIk1Yt/cRDxKw2aohZJE6On1pZggHVqevPyYT8zJW+Li15T+LuMvU4+0mUmqKaV4oyCjudnyHkKGUKUSfWsX+4KLK+9DNi8NLjo+6/38LZaa0DyRJPRDzZXZL7nbfhARxazzRd9ya4X6p9GBfBYVJeICoeQ68gFs27+emWDAQv+fxcXefpoDqSt/7OKcSYki0Macf0jOLjH/RfyAJChLpo+reWyLDo5dOrY18KXUXOIWtL3sUQ9rHCzVLUrW+UV+EvWlIF+QjzPcd/U4jEfmAdySeIzBV42HmffI5gIuhSKzEbYnQiNZAQzbeIDtd/LhnCIz5oL3Qhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nsetbPUG+Xwkl6MoCoLG2SLaaPoxrF1tK2CDVotcOQ=;
 b=ldSDz4qxbDByZGSS1hIHKq0M4Jo90dew4jmmKKG6tojj+R659AlY5QhqcqpBiWilutJD8Bl72sse0C8bthlW+7bW61NDFAPtoZ6UcQQcxcguhs9qtcp8rtytX1wH7ud2dDjbR3n2+nM4CQE5FurmqW27KLUMQ7VAReUOU3hpQa8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 59/69] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v11 59/69] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYmYd6x9qOdX7cNEm9S3+J30Bsug==
Date:   Sun, 17 Jul 2022 02:46:56 +0000
Message-ID: <20220717024615.2106835-60-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2a94c4-bdd5-4c51-3e6b-08da679eb344
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKg3vDRSO/15v9jjEGGRmqPDqeqkBqQeVIoxA8kRWe2VioArDeJG1xldVEGujbeVPUe3Mq+vFSCB2vYQXzYP1pM2g6/r+F4FZF4kFaujxJzmZ5kDjYnslpDtViMLaMusJXWGmuhdZObnWtcNV9gLiQxpM7PrsENAc+hLk3iyVyw1f+P625U9zYEOgTZjNwJFk4J901VM5ijQUdTTZpuC5sghaOHHXOodtnQnUthrky7wyFpQEfNdyjz8two20Zj69IzGjw3sl28x2injERZqaopwZJXT0Elg4NXBoIiJ+oUoPFg+Z2dp+JkRzt0LRtgqCU0SZZL6Q57Lg1jGPfzLyuaYC81m/BdljwVOsPJ2A/+PrSD/TV3M8VAcwY/3XBsNqnkzHJtAjA5pCAtBJT/KfwB8rqLBQiyDsQSQKg6Ig/HK2rqs2JMKZ7YXZRlzPAJ3SD6Px75DfTQJySdle2/MfNqFOt716k/1vhGiwT6oBjRXmBb5eawhUQLsYy0tHsmO0HB+JXIzLJ5JplLr2InJ/F52h1GQFrMst9bD7nSHeZrnJ2xwj/NssJSGuOGwEGsQ46gqGDSxH5JwiyvudkAYlsOI4ejLX+FJ2V8abQ2n9/RmrQp7Xt07Sg29xf3s9c1QQ8G/MEAmyTyB+JgvdANhWGv0um6f7AUaGTO8mv/wX4yte1VksBnnF1iOYBQWZ9pRp/NTMgIm91uq3UofiAOxbSaTQHDLVB7t5XySYcQaFBiGbABg1SoS4x/D00drcsj6V//U812Sdy/y8YeCKButc0AB0K6QhIP5Tp9IsXMAmQtDckXMPwR/cP18moNmR6/kJbIULfniuRu6bAGEssXYcLIg+bgVziiHRJVGSghSstuVbCl7447g0fRWHL7qVj2X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xh4GOklukEE2IZaoFA04O3ENNlbRYp+6nVYOz9LjbRjSOY6pthb5S123xE?=
 =?iso-8859-1?Q?wCZze9Cc1ZIPm/VmbiqCZmAl3qc/BHSRboxYtlKfyay1O+imF6YBM8mcN9?=
 =?iso-8859-1?Q?jzZWno7yi8pS7uFUFf8OmGODcmxIdim2cNEcC6f6qMZ/IyHyINbMAYbYOW?=
 =?iso-8859-1?Q?oR/J4HKGmoYFWYS0moC5aFGfnsOEJDaL4I0ZOnQB9cMJRhF7uASRiksdVw?=
 =?iso-8859-1?Q?KPCSmplSiuuPLRUhBGdlJXuoOj3ufgUYG0I1EZxOzc+sjs4uFSU1QGDHLN?=
 =?iso-8859-1?Q?hRoIi2rPpw1+ZaoyTacjquzNBqQnl0cTBTMg8qAMIq4LaH1vTODhSgqOjD?=
 =?iso-8859-1?Q?rY2/I8KP+/i05p/jzbCk9nhktxXUthaiGsRVDCQyZrKQAYEoq6Wqc+B5lC?=
 =?iso-8859-1?Q?uKgPcaRMTAGVRQGu1NdRdEfJhSBEwKRB8nP3gcFW+JgdZtUSYwxqk6yq7r?=
 =?iso-8859-1?Q?sEpWwwreyXbl89BngERmQtKxcvGNNbSk5UBVrccUqi44IRqLYiOYbmaU3h?=
 =?iso-8859-1?Q?c2Kg8QW+0BwwmzSdVUDQk5JuxXemJa6G0BD4j2pxiEEWetbqBHqZRWam2f?=
 =?iso-8859-1?Q?E8w46/GusKJdERiFpY2XfLCmGmY22UoPIjPuI+azZlUnVQ9DzAGxPPeOLA?=
 =?iso-8859-1?Q?AWMKXlEWLyqAXuxY6yoRJBAu/m/eHq0OzKxdqEaQv0TX333OHjGO5kLkHC?=
 =?iso-8859-1?Q?DgxHk7OCUd3eK1KiJwCD7xhqKDQVZfWrVMmbP8lhUQiY4L/bIjD6SkW8Gp?=
 =?iso-8859-1?Q?mivlf93V8puim2XFHIfm4yHPxT5gBbf2IGSG8eLVnPGO7mtysYlo0ULp2/?=
 =?iso-8859-1?Q?4TPdPDh4etuUycZ54qVcTUWTXpgPqveqSSAY8H+1GU6taF05Wmv0gUbquR?=
 =?iso-8859-1?Q?PHwNOyY5Ac5Gd2R9nRqzI5/HskyscHZMb6fPcCj2bu63zxQVtI3SAylwk2?=
 =?iso-8859-1?Q?6uZ9exJkinPHIHjXHyghjSKKMpjHdS9J0WyHV1xLpZskpWYqgVjfZGBw5j?=
 =?iso-8859-1?Q?oSAZkGZeB6JCfPce7jwKbezIZk16IxmgHc1dryhsCqn4XsqxsCNVIUVH64?=
 =?iso-8859-1?Q?aAmcSZELGI7zcgSOTTsc2PhiTt8XbYn9nGEr0pj6SZKrfv6zAv0SLMXdZX?=
 =?iso-8859-1?Q?79D6D4wVz/5/fNkkOpA7ifs8a27v3e6C3d3FFiUOo+CPzy++cn/gE7Q35f?=
 =?iso-8859-1?Q?R46K0gWFvqR/IU5tRKVNlU/k+3EeQRmNJs3vNDHISkSaNEhYAX4E5hZFE8?=
 =?iso-8859-1?Q?urJAVsyfSwYk94kDFiG4NDBZotJZintAIu0sAaDX+cecHmaBzVysPLWMlM?=
 =?iso-8859-1?Q?pbULots+GTevhSx0+nQ0sakf+XtefZTcJI1J++wZa1TyH1nre1ks0nJyUu?=
 =?iso-8859-1?Q?3IRUiWl0Qvp5xXXw5324Mi/1UuRIcznja3qL92jm/3B8kgz7n4Jb0pho7T?=
 =?iso-8859-1?Q?HYCMlkTocssiDJQYILZ+0R9X4cjgtIwRlZ7N0SHz3M2qGwOt5ERMkMKJyL?=
 =?iso-8859-1?Q?6ro90Dg8b495ECBViAgyF2upILoKfyMLF3+nsr81J0imdCFC4jstpdwxGi?=
 =?iso-8859-1?Q?TdN74pLFC59/+ArIkFoAHsjBLauPCqMfiOjgNXP6vuyf+FvxaPBU3QkbiO?=
 =?iso-8859-1?Q?uIx9volzUFQCo6f/JBS108byI4vd4zlZcPgDg0CRzWJoPxiMurO0kG0A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a94c4-bdd5-4c51-3e6b-08da679eb344
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:56.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyeQJVI2p4Re+lZvkf4zrKpHaQb5vtKba+TX1odLpL5v1GfyQdUPscd66R/60atihU4lfzJ8I/AHYB6zQv4OrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: qV8NZs9_Wt0fjxeju9D2HZzgNsDpNZ_g
X-Proofpoint-ORIG-GUID: qV8NZs9_Wt0fjxeju9D2HZzgNsDpNZ_g
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

Link: https://lkml.kernel.org/r/20220504011345.662299-44-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-60-Liam.Howlett@orac=
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
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e0fba9004246..8644ff278f02 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
