Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A19577334
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiGQCqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiGQCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09E193F3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMPmK1031700;
        Sun, 17 Jul 2022 02:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=gOuiBsAXIZl50ZDGBSBaiBLuufP4ELpqmKytySxVZwvFbJ6fyFCd4MVVy4PxrwRyHEcN
 JIV6LkGhHhmaEB7+WdhpVUdxfH8hAhdGx4bzVud6TIGFcP+PCrWUIYrhvr3IOMcvGNfT
 UYC9io3lFLaI3pG+Zchoas3LpGCdGKF+wbmv6I36hFqawNHW9sFnQjtDs7Yutxrp6pUq
 BVOvNf6XZXAEalDHjO5akQqOT+tpWgBaOSYaHsaqyfPWc45VuzwpFEFLVhgcfZPSFl9c
 E0secABwSKG/LUKGxV0SJBZ7EmNatuS4ouL3NK4WcXA09HC4jr/nIbuQUtnRrJJanjpe xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3EG005901;
        Sun, 17 Jul 2022 02:46:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DViBGiG5FW00q5Uxp40r7cEjgE4CO775WsEdJzHiukyR3tqG0QViY7dVE3WZo9wQunBY36GgfBV/LIwEItPJ79UQ4wos8J+nwDtd5vJvD3CPBcPnpZmOmrXmAbSekkYFkoOaR629xEbtw8GZbORCiNrvZ2R09uTaYj9eP4a0bnscspcL4c2UWwiOabW59QDbvEoZ5o8j+H0zxJp82n1RFK9F7Gl7M1Q65aTPtWxnSJoCS41RFn9+1ANjRisR1Y0FmjXibv+kmq7naFDXaLHtibqLf4VkjcYw3qQrsU8yqxcXnL1NrG9F6uXmtwA/V8MoiaZnw1O6xLY20vX7cBco3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=JLLrkTV/S3QA6K5SPsR7+Fs4WzJlnQbVcrbIwQuW/IK0UOKGDDNWjxs35l6MYNZJDaeR9j0BlUAJE3THmPar4hyKVuJGSi0ss9qfEdTBOzJnvHCNYJTKN8SAryKRYg7SHwJfBXCc8Wrzb2N4M+xMXVBIxjt74LEFgNZ1HzKPbRz5BsE1yIeiDAhuzjT6MFKdRuv0Y7mTeAV5WGI9aYy/QeD1Yo/tUwF4WGQEm6vA2DhoxV1lWy49wSumFfVYFdqzSVibs1X+1IC+nhjuzQgs1rYVboeli+Lf1HiYc7aUfdMsQ0ZsxfF3egDRJKnainIg441+iLVay8NAQmbl1lqnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXQ8/+Gm32TX8vkJNXf5IlhQlb1Ipsc/UTSB2QMltKU=;
 b=0B95WMTjbGhhSMXY8zRKPeVpzvh3FToNgcw5UlFaUJ2yaM21K57TmjdO7uRScufQbY8I8QbpsKvYx2EavxQ+u9mlcKGr8MuY3lluD+awEdKlhAg7qB6j5LcAewrhPaHCkweICaSXQLAUen1UgP3e7cNF4wpTjLVlBQT4jotE1iQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Topic: [PATCH v11 06/69] radix tree test suite: add lockdep_is_held to
 header
Thread-Index: AQHYmYdtzt1bHRcW0kew2pEkXe2Vpg==
Date:   Sun, 17 Jul 2022 02:46:34 +0000
Message-ID: <20220717024615.2106835-7-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec04be8c-2f5d-492a-32b1-08da679e90c8
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p58bAEXSmLEOkIEEm1HtCCYeXzwTU6kcfPgx94o+CafgTk4Ypr8J2hxwf4MSHgjTr7SCoxxinK94pxG/HPO/i9R1J0Vti7XqnNSkMcJGFyPgkPSrTGMzkVqFEUv0LW0vExhS09h2m+zSmvza97jjqwJhayiMfX+qwPBG15aGY2LnI+Cg0w6aMBVi8eLLx1HDSAWlSyKR9aCy1g2zaLAM5ALF/mhboZiaJGlD7/WdEEgCopAt3Z/oWQ5KqVDJ3XAgXRDsH/1GVidCRuwyEYnIiEo7GbtvQ/cfF+IcnKSny0ErQFFvlomUZYeOu3T6BiwyHhiyku5Fnw5m47pXclqaQ5uJIVRwL0BT7v1C0jAfcviZilTg2wSOrqY5F7j1hXiGfP6nbLjoXxi45dEefCO2tMZxadahlle4R5emsn7Mn0cjnmOhNsr8gvyNgyN1dy/bxqiPGoRD1Hq5ls/yimZfd+DCmxcEDtq/o2ByWTKVvUtd6Jj1jHSSqAMX9VvbZW5eSb32kHjkMOjJ/hz98RLnaFSKPpHG9wm8uOOouLGL2sEq0tFQ6PZPda+o+yaJwQ6NhAAR5Xe48ZBUFvt+luYCEnjYbYS7QhVoKfcN16GOkev9QBZ23IAZql6cFRZ89dtwFOuYfFwKfWOx1MUA7WIDrDt4F0aj7ehIb847vfMCRvcbScBIpP8bGhIcjUNT3BPDfOYyQjs013rKF47rTpQLhAWyBNWcGJOmb7bZbid8+gAU2B6nEABreMj6ChP9L6xsWZQq2upKtnz7GhnoatZW64mqDGNk0R5tS2EBAoLYkW8afnSDRQlChc7KxHN2RnOjw+7vMuXfxw+bl/QGFLB1xKmxG6hmFD+291LYQlIuRSzs2U4ac23ymAZv1aHASYJrZEaMbfS8yb0rJAijucAcgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(83380400001)(66946007)(36756003)(8936002)(2906002)(5660300002)(4744005)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jurP7iR0EoA9dQSW5ABe8APR5i2sq1HIJZWczpkGAFBkFo73oXiFtFNwZl?=
 =?iso-8859-1?Q?LtYDRdg2T2Lo9TBIx55o+hi3VTPKr5D3wMhfmtotyGaHZpfeEaJTM7wuCC?=
 =?iso-8859-1?Q?CwuCOSOYfUDU3XlRTsw/eq2yq0ky0NcGW5DX1RmRQZmiyU9tCyvv8Rqroj?=
 =?iso-8859-1?Q?o7YmivHk1urd9RkejhfN529o4UMXqahBtQN1lX35qzXNNCy/r5EblEsFDx?=
 =?iso-8859-1?Q?5GVrmm2/VTyfWZpMVTcGoIf61vR7VPVhXoeSrbHDGgd0uNgbbsjqFnD4j3?=
 =?iso-8859-1?Q?F+4zJr0vrd05vFGQdYqiyKFG9Stg5mwhzbqsuvZ79ZqeIh1dfanI1kkiVO?=
 =?iso-8859-1?Q?NtFC7wPbkFAFXZ+lFqO6IypaHl7Ao4H/KBEu/McQ4IyXwlCnxCKPOZobBC?=
 =?iso-8859-1?Q?ZISPaLeD8ZcOTr84rOwEg2iefYZBb/xHQzk6narV9wnI9+oNSkOEDRdchc?=
 =?iso-8859-1?Q?6AQt3sWtS4a5SEXQvcZlrQTANgO6avaC3r3yGtBpgc7yh673LzskzsmEVb?=
 =?iso-8859-1?Q?oq1ghPVjZSY011Qp4f08pnrJ+5LMN5blAPalv+FresJOefXDYvzWdC+OOG?=
 =?iso-8859-1?Q?GG9F+N3Uh2CvB8dmY7+pRAdEE8mCyb1+TSQeGOotzRCbG22FKrYHI19upS?=
 =?iso-8859-1?Q?9zOC8MS2wKZLdpaykwhCDs1kmSeiNwCDIS0OO/pJBF05tFUxlm44hxYblU?=
 =?iso-8859-1?Q?UC062rRs+OtXiaUeqo/MAyBF8DUdsEVRBggRx6RVMNmcRJjA6sI7E1dJli?=
 =?iso-8859-1?Q?nYw5l3Tnw3yYTrQ1UegasJ3jRBIKQp1T2FOILhE/b91LbyLQS6Jpk9ZZvS?=
 =?iso-8859-1?Q?mspyMzWiK7N1qpHnrUQJ8fVcqSTa4Cunx6cVpkAisxuOzZa3qB+LQg2/Vp?=
 =?iso-8859-1?Q?yMrBbk01Y28FUATTWiBS2amdJHHwXlZwhPS6r7TiREyGd+Co5OfoNKfarw?=
 =?iso-8859-1?Q?Ktou34h8DoubbuXF+WVJ4ihkgvJ9WXSemHdyDturHQJz3Hz0BNIlzmrTgF?=
 =?iso-8859-1?Q?/IM82fpB05sIVtUE7ErIfFR9EwiUnPrlvOq9rS0uHv8rtE7gX46UMrIwjt?=
 =?iso-8859-1?Q?J0e00pRbHHIu1FrgfWfBfEhFdkpKrysoJeqj4HFEL6snNglRsKHlpoExRy?=
 =?iso-8859-1?Q?pfwPxnUhHcPFVtA/2GXA/HbSUP+tIM2nkIvgtUlbnTfloGciCU3uSAlkQ4?=
 =?iso-8859-1?Q?39mAMQREb18XMtEEu/fbbDIu7TaX9xzWPlOnNPyb6yymUb6lip7O8e9wIc?=
 =?iso-8859-1?Q?dNw6gn/YZi366mDlw4tEfz+t7lupoSO2fn+Jwds0dMVyfrvFqN0k4gCIMT?=
 =?iso-8859-1?Q?pZxvkuy80bYjwgqt32sPpHKD40mL+d2BEvKvr9vQ2Fiv67it09W+gIW4v4?=
 =?iso-8859-1?Q?zYLklkIsa7d/b+LYlIiNvjLkVBPK0ArR2pcs2C+dtNwKv/y9z2A/GdrXpQ?=
 =?iso-8859-1?Q?q7oa9ciYecMfYeoI3YlVkG0seEpktlW2wOFgm3InLXNqH9ySZzpAswgfDz?=
 =?iso-8859-1?Q?rTDeQGuP5shb1GCYP5Cz9/OYWn/oMlPzIPEyW0yc55tENd1YKqv6pimGGt?=
 =?iso-8859-1?Q?pYgd6Vw8mYouyQRLKA0Wkl8Ilb/0XvcxHeAOvcxmuJvpue7R3JPMuNSOnA?=
 =?iso-8859-1?Q?UxzfcjaiamvY1axnIlB6BiZWMNDrNPamSZsX8bQpEmPm77zG8TukSokw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec04be8c-2f5d-492a-32b1-08da679e90c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:34.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2SduKUpAQ9ItxMcZKTPz6t9vzb+YwOEQTALPlj85QWzAPOTlVbZWZToZ8CUu+v7z98l/sc4bXKDVneEiTF7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: T78XeSPOf1Qm2UhfdlTswyWLuh-aLZOS
X-Proofpoint-ORIG-GUID: T78XeSPOf1Qm2UhfdlTswyWLuh-aLZOS
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

maple tree uses lockdep_is_held, so define it as external in the header.

Link: https://lkml.kernel.org/r/20220504010716.661115-8-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-7-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.35.1
