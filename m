Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE35AF4C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIFTtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIFTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C68A7F6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAfC020044;
        Tue, 6 Sep 2022 19:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=yQISN/wAXbh3mLiSuG1t18OVsJ8AlVVmKHT3hQY1R9yxpNa5ygXrG8p56jFqzvD6yNQN
 soy9nl9yUYdpygviE1JVp8w7GdEGxfef10Ixj42slbDKETDVwtQflrW/XwNsAntWDZK3
 Q1+QPe4MUdaYD3ET8r01k4hz2kiJ72N2KQqC0R94fNHVfxlvpchsE2FjD0CB0jVzUCFr
 m8fPkzCUPxLAa/bqrCr7SUgsqwenbNtJflla81G8JTna0Wh4nNp6sSuotoxTNMcFSCN8
 8U9663DkeJCHgIR1OTtc9xsbWfkBpzkcfVff6NbEvdjjWfAoxdcJhPuOHk7aDQUMBjcX wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HHdKJ037489;
        Tue, 6 Sep 2022 19:48:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vns-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKAv/xRvrCgVX8ur7bIM4etNEiVwp0rdDo0BP8xKr+MJBQ5zCpbFbximNDJZ7bMyVQMhOC3TrYefVlOFXn0VuTjvleW8fHLYYLNOzcg6gV9uUkd/JqYV2pOdCB8GWlMw2RlDpwNQSNeh2cuQPWIQvce1vsocXEOQBEEA9JoQuv+j4Z07I7YsK5hHoljUjgWHvmi+LCcaWtJZAwdCEd15U641+LWtHQTKmRK8rnRIgtiNoD+VDMTcEBGBP6mXcrWklnRkagiG298yVP9zukCIIbyCaRV7NIpqeHRhTy+W20QtWUFkRNG1BrIGXqPh0f6xxeI/uve0EB3ukinllWH7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=Bf+yZIX/JGQUUwAe4oGgUIfcreGWbFxJGaF3pBF8Srk/QmruRUPahPVcKfUa/TCoXyfUSWnGwChpxBxNL2dVk95wLpW0FXuD4i4DFfmb2soGhyAmUmAOENk5FIRdzSi2iNfgaHm7+LtfRKlIAS3NfkIW3LTFzcQDK4YzDH1o1Q/zO+yp6EMnHI/5w6zf2FBu8RUWaHaNskYdwP0Pb6kZZlZxt8nGJXtcnW7dZleCN1zHb0kruD8V4g9rB6z5KwMczHVgkbj7RQNxjIyiqy1pR3xNmNdqk/GvgohnXnjBGHu57AZY5iejnqbPiMOHUztrbBet7A6UEGkLf48TAZ+WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=Tw17boocl7SYXxSy3kTQDykDGd9wVx/l/9qTSaL7O7cReu2W+BbGOQ+Y61+Fm0aJOUEPyKh9MIQp9/mlVs4oPPyZWlLYqW4URBS2bAZI8vW1tTVREaaKS8mH1IfEWGsuQ200FbDTiphvvXDPvJy0aikVGqsreF/4ol1/IKfJb1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v14 03/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v14 03/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYwimpArXaQR/fYkWPJADVIA2tTA==
Date:   Tue, 6 Sep 2022 19:48:40 +0000
Message-ID: <20220906194824.2110408-4-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 893b69c3-756b-4766-90bc-08da9040cc44
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmJ2tgRgMwnaCZbgIFnvOjOyhmWiaVNmmIQxcmREmJLOqN9enVVfHlpvpEA6WdluzoBCN6dYrhG3T1CGn7dq8aosYhDFkAZEU2/smprsLX9yz5YXJVJcprIeiq9HtN3potuqImObc1EEVzClM1REvJ3rVd+H0xcb1dMipyAbBFMnxUpPgvjg63ZrY7VqzU8RY1vc5DcyatpRyQ3+GRW4o8T/xOXlH1O2P9iVYXiBZZfNG0VcsuZrZUbxKDh3l5LeLCkQCUfzjd5pCPcaj3rKdh8j5KgvudDw/mJixGP6rN/Fdjh8kSU4kfAMR1f5vhcsdzqsN52hDY07VkFzq/N8Q9eaPds9IRfb/RyAY1PmirI3rwuJ1xqAhRzH+lfpL+vhSIbIU8zwPIxMlfyipyZmTfm38v8zAEk+qQwPVe8mrrGqG0rUi6tw3rxAHUiwPx22Z6GRhONdWQSPA7PpgUaAPNDC4ZCbE/H0U2MhThTL8BqiRvSj2wTGsusnG5S+qBIWBjdMyh4oBTnBc7Wue7ZtyEKepxMJbpQTIiCZ7RtkPZCCcgl/icxq6+WXnnWh48MdkN5hZwwtk53WHwxSJm36ZhC4WRlKCS54uxCIEB7aAwD2549qKlmmPPFieS4TTa9D+e15/Z+afM7YtZ6nNJR4g+EllxSSGlsTRlICvdgxEq1boCc44b8MKdKL7dDlhUTqWT+7y3HCLXIwTHf/pLzMMntD0LLB7UTsQr5GhlnLe2ExgC6qlyFFUuPpFYE9DWjB93BnMLTRABkxqh5AEoTZhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZaLwD4MXZF8Eo5gHiegReT0B+BOtNlq6zm0ZarnuCXzAuTeAYrIKj9qH0G?=
 =?iso-8859-1?Q?CspqaKJ8QOcy5zUSalffE/eUMNfQpCgqLOKw0nX9DbgNW4efkvZXFola/0?=
 =?iso-8859-1?Q?qik3ihSKsk2YRF6TFPMezn2uXhw/5Q3kphkYF+fvgIjvJbj0gFv69TnCWx?=
 =?iso-8859-1?Q?U3BvhRqecOced48MN4zRbqYxnNyTP6A9cPPNmfMPBF4f7F+6vc8WM4A2OP?=
 =?iso-8859-1?Q?qZBGwWRw5BtyEYheN/ROS3EKYFbeqi/sEwi6N5mWTNylrbi4PQVeL2Lom4?=
 =?iso-8859-1?Q?4da2Xn7icBpKDWbCUEVPaHPHtaavFs2tRXzy1hvWTLuf5TvSr6u0u+w8jW?=
 =?iso-8859-1?Q?wxHvvgzPoeK509o6YkgbnA26UxG+LPXxrAkflNQEHALnjYTUBgcrRuqCwE?=
 =?iso-8859-1?Q?d+JoD99jjhYByIYSfSXVtGZi1ipims72VVo0HHOZkC3dsrWHVDBDBPzWVb?=
 =?iso-8859-1?Q?x6v2YieTlthLdH7NL+IaTWc0Tv+NG2idyFps+B9GpLEgiZK6p3cFaYDrLI?=
 =?iso-8859-1?Q?tgYJwxE9yzU0mb11/GeeJ0ag+bh9YQRkEQK7jBU7I5Y1NKsDPliQUAbP9k?=
 =?iso-8859-1?Q?rt1DbxlGZ+c3amCWAvgavvS1Xz8jaeuA/UczxE5XiXB5lLK5w8juAKSPJw?=
 =?iso-8859-1?Q?yiHTv9nQWaU0E3qcFPw+XhbMRAFPFQsGQqTO9G72vkczVLSYwCznEUREPm?=
 =?iso-8859-1?Q?1gE7OZTD5jb/8ObQuQRROnOCnMFAJwIApYUCvapFe3rIDbNVYW7/NpEIOj?=
 =?iso-8859-1?Q?3JYXLHjBcNiXfvi1t9U87uUEG9xFeX+8XA8A2vppAPp03q+9Uih54YmaVC?=
 =?iso-8859-1?Q?b2sKQlNfeXWBc0ANLUO/sMtlZzoAB2Wbo/YugvSaVFbJg9F0b2rFxjdqHD?=
 =?iso-8859-1?Q?Gv+oIC0jTBw7PhwzbgxhfPxX+gEQE3Ui2jXDsw+Yv2VZ01UO0aJxQIkS1h?=
 =?iso-8859-1?Q?oH4jdHIBj63miSGcaLepbDyS32IbRs8B01tLzeiM1Cpzq2KibxBfHStSe8?=
 =?iso-8859-1?Q?cH4iT7ojDlYTZAm5uqDjlVA3MOBxlovhMFYhbiSX3CuTTSh9C88nPqmaez?=
 =?iso-8859-1?Q?olvL9WKXEBUWxSURFD7KYiDPCg66Ypmi3vOjRPX5bTWPOTDa6x867o1X9D?=
 =?iso-8859-1?Q?8TVqWrPX0+Br4fBCHwMfAnyOSZqi+bQ9KqKZdyZ/tsgEr06DTbQeHg42Dq?=
 =?iso-8859-1?Q?2rza7fvtT33YSk6J7twMvVOQJa2w2xtWFjjRpLcmBPT1TGjDwbYITEaiu4?=
 =?iso-8859-1?Q?+/tUHIq+gIBV5YDwHe0XP6PcvA0HhAb3yEGkPf2g3uaJT792A8R6rAOeTG?=
 =?iso-8859-1?Q?TwBx0VMxw4dCJB0bkCuVnoJBpVQzyfj/R13B9DDAzjBCjUi2rSWEyAV3Bm?=
 =?iso-8859-1?Q?O2NAjmnP/l0El4IrqsactaAUIVj9cLWDIuPHqAemqRucC4luxR2tNHSl+I?=
 =?iso-8859-1?Q?ReX1ryWVJSiYtR4HayS+Vsz3qFrT3sOsoogOF/mW6Dv5caHoQPA4LRnJCc?=
 =?iso-8859-1?Q?np0MVySPjIXIjyJwARv84Mcw+Ut3qNFDuk82eOAdC/GKIy4r3DUcZsRrJ8?=
 =?iso-8859-1?Q?UM0CZwgDrhb8ymmFYDxozd3wHwRDhiIylrCfM4EvAvH0oP7R42zZ80AsI5?=
 =?iso-8859-1?Q?Th92Iz5EyfIqRZ3JWe0YT4rQyWWX2/CSuxpkcCk1tLTmFnNyHfiBoBJg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893b69c3-756b-4766-90bc-08da9040cc44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:40.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFxC3HKMmeOkJUE+5TN5MvXV4JjFGCMhPY7Kj8Y5qoGj+uBvgc0SW9Yprs4ml2zvbscSjXoCdmnfBLp/F8L9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: 7XPWf0dXsjNFRhpJdmvQb3exR6I1QhDZ
X-Proofpoint-ORIG-GUID: 7XPWf0dXsjNFRhpJdmvQb3exR6I1QhDZ
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

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d5c1bcba86fe..277aa8b70abc 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,15 +23,26 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
+
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -90,5 +101,6 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.35.1
