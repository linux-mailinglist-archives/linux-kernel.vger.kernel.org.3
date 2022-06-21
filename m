Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE62553C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354832AbiFUUws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354820AbiFUUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D4E0E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJEdKv012601;
        Tue, 21 Jun 2022 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nAuoc13iRJi6Lest/AxsGpMwubD2BbjP9/T/HOQ/xXs=;
 b=awtbVBGFddg5orxfrLTC8Oopl83dYA/6O2973MsNw0pPWx/Dwe6LIiee6jvjYnmY/OXB
 ioOlJEimkFC2YAPm+ii0C1QIIjzrduEoPo8f+j1UMMl7n3EM1Z55OBric5hPENJYP3Vm
 Lae9+elZFh9IMk6FTx4LROPjGytieXUeNhYdNE+pOotC/oQDSkExKb/lbzR/dQVEVEFW
 XNGvDRSYxj5kwP4u1IqKhzYFot1o0Jbl2kd5GA9ky487R9fuQYWqYpW6j4GsQoJ3lHeh
 SOfQIx0yN3VR1IPjtrUMBfH8kQJ4DMlYqHXhiF13DzdSTUeuNBMjZe8JCtMZGP+M47Fp Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkO010169;
        Tue, 21 Jun 2022 20:48:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F56IQETCLVzmrxS4BztibgO6exeCBDSfLUBu5LmZDcC1OVdu+RpfD1GY/4wKSNQMCpCbJFVXTCteZlPZq0zgWlQnPq/Ukuv75yRlSiBtckd1DUjbkp5DxQTLOi4B3BYZBXcs0zs3Z1EGNUm5A8tsAtnPCQRSHO1w5RFnXkuzj0m7/4BaP7h616QmxeyMNyIifXdSQUe2L+zW1ofSfasYRTys4fV0gk4jlveJGcJngspgBcw2GP7uAH+tBHBaTY+i1u5KYjrNzza/wgfXzpwW7KdYvqWqR7tvX+Q1K/nsFlDN2BaynM8BVmzNMrdT4giBAZfJo/tzVeG9cKnMTWCYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAuoc13iRJi6Lest/AxsGpMwubD2BbjP9/T/HOQ/xXs=;
 b=giAcG98h+P1qYeZanK7uTTgcqOfijfDXQLAF9wlmna5IEWOT4wzCULyzd94Dl7aMVEyuyJSH9YzAQqbzj+qZoTx1WmsT37wv1lu8in2Vkrqe4l94VmskqQI10oY0KKIQ8X1xvnMEIhZKPES/ejQmN4nRkYacMd5S8xZOCwY1dNvmVSiXkXdVjTZTBp4F06uPeJiKsSkWgShAabkWw4rFPmU4jUKsqKZML8MCKWfUqel/mEA9xF5nJ/vEQILZKbJ5qJC7amccoyh6AwQaMs5oPr4ph7e0nPPWMUOHhqdZjsMiAWfOeOB/75CC+vYAc7Jc3rUwduZmj4HD7pSHhuv2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAuoc13iRJi6Lest/AxsGpMwubD2BbjP9/T/HOQ/xXs=;
 b=G74hNemmKQxsTQ2c4djFonf6dw1dONKk+78KiLHEK+HpjIoXpLmyBC7TdLALL5EcmUEyOZUd16qVd2N3/xReiVnZAcYlCzUlnJ0KpOnow/2Fp01lHW3lAq6zfEWoIQQvP3UB3MhBswL55osWXosatD6TVtNXpjN9RxsemozSO2E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 63/69] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v10 63/69] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYhbAV7kbD5ihspkaLGstc2HG84A==
Date:   Tue, 21 Jun 2022 20:47:12 +0000
Message-ID: <20220621204632.3370049-64-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52f45b58-6bb8-4fbc-e6e2-08da53c76518
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38699F81A85A74A779ACF0F1FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5CL4kZSyyRnsPoFvCwElFTPP8371RlYmxyCjrdQKG6dVLgwR+FI42aSv3WIC2Y2dHlMFdtwi0o5RgZCGO/oJRRYmyciT8vslQKtaIukHhRN4Sdg/lYlyZ/wafXk7r+DmDw5bfb/3bXbcxi/W9MTvsgbss+KvhlAPFfWwlUMoOHlQSBwN2Iiv3xoHGmwkMuQy9lUCxKfSYfrS5J2KfZ63qSbkSA2tP3i9G8UkTaCyHE5gSrB8w90CHuTi+hX7+v0S7yb2gn5awD2gG0kwKoQKu48ef09f3IFTeWguuDkNNF54f6eIVdMs4ZXbVWxlt3YEW29LticyNS85gGSPhMLkN0xp/1KuRlR0W/y1yZ64C/8JMkzuGBYSthrbSrdB11g1EKI2KEGz7fhfHdCggjyzAFjYiEwySoP3NajmoATE4cK9HFCe2nePJfPOUCZM4vSf18Yy6JxKeXvx4UyCd8KP1saIEEpDd2Lj3OVrfIYmdvCGk1C8izMel8oE6AzYUDvIdpjR9M3phKXBI8vNSU7T7XxWfK+V78OV7pZqhYgzpCKs6Y1L4I8tj9lqtKJnzelfaG7xs7iewPbQ03lT4MfIYfKlCeKu8JW0dIYvVbqGP4THURW75/xDySIKcusn7wgZy/xs61OTcMtPNps11iVWbe//ItTxqCXfVYlfKmsR9H3xnOXS2mQNgIU7iJS9b+Km3PTqoV4brLOtxZv05kbB+aGBj5QOxgLhXB0zY2pgvTwuajACW+wjZnVLqV/5zcNAzswlX8HrUAtxU3wUdmxm1BX+V9rhTGpaARrQzF1eqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(4744005)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aJbIHZnJgzp6taP4cQjVu/HB8nZTdVCUNEVyRX09q2tw+EOvtn5K63rvSW?=
 =?iso-8859-1?Q?J4bMqSrrhOr4fzNs8WT/jXrWg1iBhoLbt6X5VNGIFOWYoSSZ/On1xxL2CF?=
 =?iso-8859-1?Q?pqJmBGy5gWLdM4upfAPwtKE2hNofOr+Gj+gXhTaOmrrEj4C2rJN5sK8qet?=
 =?iso-8859-1?Q?c3M6StQ4f664bC52fv5ZoSjkBHB2neKE967xjMs6iCBkmC2Xb4Q63kAPYc?=
 =?iso-8859-1?Q?FK7HfvmW92x9OVaHAb09vDEPru0NwwmVzFNLJtBYg4B8fEjgMYsMig5lWG?=
 =?iso-8859-1?Q?hb1ymzqoQJFrxufJXj+BHq/vhgfyUfqs6GliRkMFbNTATnsUtmTud8ihkq?=
 =?iso-8859-1?Q?xCYOmQWA4FKVHs6BIPJAKw4vWwqzD1jJAxbGOMwPjc1U9JA2NgxI3uFcg/?=
 =?iso-8859-1?Q?7NBy6a+SHe3XOa4N/KchCdIBHAfiX0Lu3aosg4vWTc60D57CNmrKom+VqE?=
 =?iso-8859-1?Q?w+eF4sNZyoSHO3+WlsoQDwZRyIjWgRZFYXbMpJNLefPMJvILjfLOw3A90D?=
 =?iso-8859-1?Q?KxXMuUQEV1ujZ6dcwEtxSSemuocmlZVv/sXovHYiIm6iByDWD9T2MSq26W?=
 =?iso-8859-1?Q?RXvK6Azo41cXwc06geH8raVeAoEtv/gHf2leB5wqJyvv+8MNDx9AvsvKnD?=
 =?iso-8859-1?Q?7dW2pG+QCanvFOY0xkdghjxGpaMpCywrHjPam7sY6ixQ8iNI3LLb6/fZq5?=
 =?iso-8859-1?Q?lU36G0SwHtVSQub6aQiawsOz3/qt33Wusi7hPrdBMkMk8kRiKMzTEdDejX?=
 =?iso-8859-1?Q?4QDxHav51LCapQghl24qEi2msxcCYJz/hmv/Wo5n7QmPHlj0FSeTh+lvYq?=
 =?iso-8859-1?Q?/LNOuznXqgpYeDhBpuHRNxOko/uWtoKQfiAnIf4ImeC5RoxrZ84BYLNjz+?=
 =?iso-8859-1?Q?u+/8Slz7AmHkp1aKYZwfRC128jaUe/1MeRsmxynHN1MHNkU8Du0cAWp9y3?=
 =?iso-8859-1?Q?s3QmI7x3+geZ/+5DHDUq1fDHzn/8lroRteXQugrFqH6juyZhQu75lLm1Tw?=
 =?iso-8859-1?Q?cQ+nB8Sx9Y3HD4+AQckMJYMz01fjZL/aEWoVlBpdzbWThRyOluxlxid02l?=
 =?iso-8859-1?Q?8H0GQX37Fl5mNuH2IPqaodYM5F9fW0ZvkrUY+FVMUKHwrx7XHNZWiOLSNN?=
 =?iso-8859-1?Q?NRMB7Bnbzds22UwZX0uNBPiOWzllERm4V9NwDbyp1nQPQbPqS7UGFT7GhF?=
 =?iso-8859-1?Q?pIxImHhxulGeJogoUg8Zbbe0R7wOswrF7NLTGqZ6Dqx2aUZCbFUEvLR8GA?=
 =?iso-8859-1?Q?4CD7XLvicbYR1lOphDXH3ymSVY6hGGJn6WZEp6tJ718aH65yuZCNwhmEaE?=
 =?iso-8859-1?Q?eCvqj4u5qK25+f0DWBGPKU004dfnQPSAHawRLsP0hAJsehFwyPKtvnBwuW?=
 =?iso-8859-1?Q?5GRO3RKnpxeB9lnH5PuX9MmqL9S1E/rCAjJ52M+/Pj9wTfjnQV6JuLuTQQ?=
 =?iso-8859-1?Q?DYHpQy0tcaO7pu34m5EBPc0MtTfJMq0hMo7EznpDWJUBlMsq8RBvLNWx7a?=
 =?iso-8859-1?Q?JjQLvAaYzL1iLL6rZxatvA6R+2kU/zD6M8MSEDTOj0OLxa/zwB7Gieh9/f?=
 =?iso-8859-1?Q?d9RffUjFcc0WvXGW7EHvH5eLOd+PLkAMkSx4fBXcFrcrQXMy1K6igpz9Gv?=
 =?iso-8859-1?Q?N28Wb+aKHSmM+OKqQMEzZiUE0z8Qhew9aAKKF1Ko3GyZny2b/WEo7KuWA5?=
 =?iso-8859-1?Q?cKnNzPNOBaZOaC+rB3A+M32pddM9Q7yX/bF5SeYb9JvjHlWjSjF5NVA6WZ?=
 =?iso-8859-1?Q?u+teTH6oZOmsed76033YrCCuR6eG6P5/hxgi+H0eJbOKIyQ60OyOTh9RoV?=
 =?iso-8859-1?Q?cuLP7b88fndJXxtYZy2Duv0ePEI6toY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f45b58-6bb8-4fbc-e6e2-08da53c76518
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:12.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBdUU7sfRuIDRxTbR77v8e76ks9H8sAL5RNM1WrTVYQk0kYKGSNatPkTLbdPqm7/etTCJnYOdOOpA9gPj/3hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: mAe_r9RJMwCxBVLyiWxz7u0xD3QuoDGi
X-Proofpoint-GUID: mAe_r9RJMwCxBVLyiWxz7u0xD3QuoDGi
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

unuse_mm() no longer needs to reference the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-48-Liam.Howlett@oracl=
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
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a2e66d855b19..ec4c1b276691 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1991,14 +1991,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
