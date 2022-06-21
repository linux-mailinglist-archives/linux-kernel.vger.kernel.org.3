Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF0553C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354968AbiFUUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354631AbiFUUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:49:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BA5FF7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2axX011598;
        Tue, 21 Jun 2022 20:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BWfykhrohtkYE9hNGTs21RTVHRUgXeWsvuvrGqWdBzE=;
 b=sqsOKwSIv9HjzEKelbXU7SeiW+PYQa8ITu6TU1TFFtiBknnRm3CD4Dkh0zs0vWgXLLu/
 YFdxMMr4TJFRBZSl/5HvUhQZykV0RMagkHeTG9p1saQ3/arHpzaBT0XF9GZDqfJ5YzB6
 Sf5zTBjXmKKJBeiNyWiR7o4nQBaAZzIMnbtooU+8xqPusp0qp92hxxV8NNOBvrHHTezv
 oCXrzcBsi4dH0GyDKYvG7Q8sL+CT309Ox6UwHVYTetNb3vbMhY1VfIuZ1PvLWY1TGbrF
 BdFviqXMisy2a8Wh6z5SYb+TC224XtQKYf0ndP06gWbkop0nMb7T0Rkxff3MALUS/tof Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeU9N027844;
        Tue, 21 Jun 2022 20:48:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsq38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XetvNGexpMkGzYzeUGs8tPE6VplVB0CW0qb3lE/MVeLE3AQsjBSLlQBj4HcuDuetKIvlaQyNZpQVknWdbYnzf7nH1nIBWyp7fqkqdgX2co7xPTAXnycRu+J6t1ZO7F71cvqwGBBAYLWCndL6wcjJSQltJSC851xpKr+q6Nx0vU5tpghUt+q2Efo73+CpfMiD9/CadvV6/bZMcmtSxXAviFUAE3zE2u3u+A4SElY+Kjjp++aM+bZDROaNTT1hANJA8figpmFyy0Q+9FaD+4SfucR0HA8UTWVIoZEdfFBmd2/95zv73QhgKRHveFcrsxUjUhTnmL1XyfzXM4c8ouVbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWfykhrohtkYE9hNGTs21RTVHRUgXeWsvuvrGqWdBzE=;
 b=U4hdMDyedQ9bQwrqsLgaAZKesKjo9Ad4bxyeSR9Cq/nJtLrsHFSLj3K2rWQa5XddeTuP/pOJUUwiyLumO2QDGQPKRr0nu5CfRDzMHH1ToDe3ssmIFcTJ/o72DnHdB/Jt1jrF0jLczD22WpSMeSO6tDs3HnR3/6/HQ63On5eirLCW+EBkfbNeZ8fXdLvNCL2/V4uGhf5fUOKPzn75O/tfjsxX12oA21N+qyys/vjaAS/v+/Pb38vUjJvDe3U3hskTX57YxSBWnKRRD8zQjiGRU+W8PljE2AaGmmQOojOMAasiKc4RYcENJpXYHuGlShFKJ9qGgpuoIcBJTd1vNIeb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWfykhrohtkYE9hNGTs21RTVHRUgXeWsvuvrGqWdBzE=;
 b=k5RM8CUqch4i3TrjwYxVC6794jB9V9l5RGfC8J6RTdn8+sqXeFt2Icpu0QqfCPn6ddS+v8Teu5BwZ1xgkA/ko9+X3+zBOXZiSQjYCyan1z/ftQxEYXbhjZj2BmgpxkELoYZeGL5VyfjQa7esakQi+BFZsAKXhAd9qZEv8zyuzh0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 61/69] mm/oom_kill: use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v10 61/69] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYhbAVkAKf5Vrnwka991xx1Q9cow==
Date:   Tue, 21 Jun 2022 20:47:12 +0000
Message-ID: <20220621204632.3370049-62-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 296ed114-6677-4eb2-2ffc-08da53c7643b
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38695DE09DB700F55D792860FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVk+3ssSCTHt+VuUwbHUoTGZ+jR/M5XXjTWOcSwR+cpCg3eOcxNi78wKu/JQKotPgQgDtUgJ3g1NAfRn64ZezZ3uuIeRO8LK/OZOFU1PD6KfCq4SeBaQJ6kfgJKkhPJYjwD1a2AQbPQC5j48UO84LJRlaZL7aOmRG2a2HZ3yA1qPsZ04hojx4RNKs1CcRIo/IsGJDI0xf1o5fyUNvumPGAR5KLynD0LGzQw2ogyRIKGj94UsU2pROH6vfLiFP96fzGrYiL0Qmvc1hQiyWtbhqwMyzmcWYuCmkG2L8Dm8qdXNV+CHzUXDtcCBqimZFCkO8RQD9O2kw7DKfecR4Wf4BtEUOmSC2FrXwgfnrQmuPWn74XDisAun60mnbwLJgEWLXybYgqmpSdtjCFqpxpqT5oYf+XVeLvvJPeEG1MwiSuU+XwK7I4ENHG3fVsEwu5nOAjKvXPBXqzXcfGaZfWtbJ8ishlzhv0T4nGb83PWmiuwvhOQM+zz7dXbFHgaB9KhEYnF26edY/uFHHXAeLqmpaS/4gfuBSlaQf9qpkIHoPYqw0S5eohcRxL0o46xkDXWqmRtpmlSf4f1FtXv80SOo1D+nmRgecpy/shIPGRobCWK5NDhLTLnnQvcWBSz1JPIP8994vX/q5IjrgztKFsgJzDYVUbJFRSVtcB0tmqD4rwmfFHAcaxKbdqX9QqZCxB+96/YaX5IJt87Qzl58nr3WiPto+2jnRW1RDM+rPIu4mWRZB/CcJ7g5HlsTgwhQCgqk3/OZGu67tIrq0OJE5xvMSlddUNTCBMWa5Uz5xmkpVwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(4744005)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qlncnT+aVAosBK2uva35ZrXTAvDoHSJdcpUxByeGXNPPYWVrUjAwLwelIK?=
 =?iso-8859-1?Q?7xP7TJOjiyhC739DDrScLIDUS8RQs0uEW1vy8LBbi5V8qJ/PZ9K07jdOr+?=
 =?iso-8859-1?Q?zmb89qENpoamlLf77baGg9N70TMgCO3bts+f293T10HEGwT3uyFy2q3wY+?=
 =?iso-8859-1?Q?84avTbKh4QWaBqJ275pfVppviZCDoeJAA04faW0DgcMe2yEQUFH+9vE/Fe?=
 =?iso-8859-1?Q?J7dRYMQJY3GaXnduQLp5P45ixfiUqbQcqkf5+02edJB921av9u3cLdZo6q?=
 =?iso-8859-1?Q?CzZ/oL6IBQVxjGWYimR2VXIOMqFa2dLRU8iDQoc/Aa2rHJcE6QEY+Sh8NT?=
 =?iso-8859-1?Q?gldxBc0lAWNUh67hOEiJhEM1al6oFkX9eRRdWvXBMKRdw0A9fKQNZrTner?=
 =?iso-8859-1?Q?JQnAnPzqb4BagTcJfURnZPq0iHVzCy9fHLKrLO1r8CtsEUsgwV6RHCFYUl?=
 =?iso-8859-1?Q?fK6g1cfgY9O2eMmZUIiz5LjfGgLDJD8qcPfdf88LqubJ3pPpp864vraoU3?=
 =?iso-8859-1?Q?CwRqUpyj6M23bzBN8f6qW3RghFSErzT/UIN4HdJsKeRMCyRCtOAfanCLkk?=
 =?iso-8859-1?Q?JfwvNMjGA+29oeGXMk1wjcdlq3YaasAK7n/Vgndcg1s1oC28xfmS8tJ4MI?=
 =?iso-8859-1?Q?0bZFGB6wmBTXU9cpNdKjB9A+129dTdcDdtXcyHaCAuqHfneB3jp2Qvqmob?=
 =?iso-8859-1?Q?yedsUeZbhd2efZpD6If4uclZ3aT87ZRGPySwQFS+2Ce0N33EmvR3LeXNOb?=
 =?iso-8859-1?Q?q/IiEEpJNuexyMr6qGeMqexPgVmY3+nqA6f6Fpg4qWbJqsNcTgmaPDKPTU?=
 =?iso-8859-1?Q?dPF/p2WhMIWkGPo1Zl0eHs1HOInuMkhXRnR5rfNkr86776OYUNRV5Z13y/?=
 =?iso-8859-1?Q?/BUHcvcBA80fCS8Ib4xslQF+Wfg3zStjpAaMO/ZxKAkeGGtsumkc8zxFbW?=
 =?iso-8859-1?Q?8yn3lR3pMqJz4xyILtbB1+zTisrCdgu0SAMSwttvl+oijgJMjvUhQfbLmd?=
 =?iso-8859-1?Q?rE+GQBJwwwXdLa7yYer0dhNuat3OuJNiarcV4uUlzTHnYmh4geWPfNRJOx?=
 =?iso-8859-1?Q?Kpg1nJanMqjyUiBz9i5PW/eDOm6nIEXQR3D2Pd3uXRYZBC/0qWhgkaf7pv?=
 =?iso-8859-1?Q?wNu5bmoevgb2n7LXZsaGsee9IRLuMy5cjOayBPAjgjACJgPwGrTFVGWIvU?=
 =?iso-8859-1?Q?lC8j6tYlvNglTMTLs9k554cUAOVrgZN/mKUMjbkCa71GNSk9uUgI4zopBX?=
 =?iso-8859-1?Q?SDbav+rQV2ns8HkaYJIwo36ecYoON8Whs2YE4VZ+G3Ze8oPMdSHEYT5pjR?=
 =?iso-8859-1?Q?z9J4GiSQ40jBO70XddAPtumDaPxnUaTjlI7Pwjks/iqLxVNCN39sru1HpR?=
 =?iso-8859-1?Q?JTqD/2OgNutAm//Hp2rkoEX+s7f21EwA3SSJ3h7JZH+Cpu0a6ALGuQFPwg?=
 =?iso-8859-1?Q?TqGGowR0WybtNv0ZUfiXQH0xdk8c+a66sr9spjMicYAO/XkOftrRbgzOuZ?=
 =?iso-8859-1?Q?DVh5oa9zBu87zPJQnpxL753hyhiz1xwM+GNwvEixgatPcHMankSYz/pFBe?=
 =?iso-8859-1?Q?muLNGeImS8SKa2YsN/r3j5qnDjzMgChs8M1YlkSN4NSNjcRZpC0dmUjKlB?=
 =?iso-8859-1?Q?sD/hU92pqZGI9IYpfVaLXn1PU0TZpoBuLQsVgX87roPMROlVqvmLX6ZzPm?=
 =?iso-8859-1?Q?+EUF753ufMWgv8FrXbv0W3MVN6RwtLfqrVgAXDRhfGbhFDaDa9F3HtyFmG?=
 =?iso-8859-1?Q?zxMxYnZpOT9CPIUEInxOh1+7yEPQFbyB+hLw/nX4kCdKiAgL9lOIsqsLCW?=
 =?iso-8859-1?Q?tj0B5hfRTBFggLgC0HyE54vOMH8S7rk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296ed114-6677-4eb2-2ffc-08da53c7643b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:12.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhqJ/amuhaHm0e/k/fxZG+tz7PlXaTlrT+Zun6oiSMa0pF9vkk3yk3d7TVF4t1zIZmLFjiYhXhKo1JczkU3uYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: R2IuyZZECZobhbxorvw0epgH4KVB6FbN
X-Proofpoint-GUID: R2IuyZZECZobhbxorvw0epgH4KVB6FbN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Link: https://lkml.kernel.org/r/20220504011345.662299-46-Liam.Howlett@oracl=
e.com
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
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..3996301450e8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
