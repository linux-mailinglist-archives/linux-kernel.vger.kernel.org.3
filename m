Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1194D57ADB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiGTCTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbiGTCSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB3D61DA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1lw0B003839;
        Wed, 20 Jul 2022 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=YmCK7BWFFEWdawaBg1PEKXlySaHcLDUp8Ackl0oNg/gNjEwzbfvUKvXyKELVtnpcJ6oT
 6/gCnxE9H5rMFvZONM2/a9A3H1gUDLai7w0Iwb+bM0YknBzz29JxhBPZWfYWbM58bgcR
 sYhKvn5iVDiE0QEHtiJKvXF3V9p0neMjIdzLZE0nWl/uIuZaLldbNf/gYyPoyysPdJ+Y
 z6GIkX6Z0/wy42rwUzKULkTTD/M3QOUcJOe6xfoJMUKHz2cviBRP8wiKUGADwvOnG4T+
 Z9MPhIoG8FNMCVkJ8cnjbB8Dn/OEVSuskiTQdPNASKnbCAqT++QC4QkMqAdCgSc8QTOU Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bGDw009891;
        Wed, 20 Jul 2022 02:17:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDa9J/+uakal0S36ggzOb8eX6gEAg7R0MnQXRECgyzbmu/+LNGBulzmV38o6k/gZv4RUZJf9WrVazvCQ/eRSDQwxYlxg4HZXuOP5NawJxtnDayVOIx80q5gdrmbih8LaVwmv3tfqaw9vguo0aGvVBJ9oha8t4a1ACIhIOsCwY5Xwfl0H9nq4/xuntvf903jR/f371vxdY8hZYRop0hwJ+VtWDMn57AroY1w0IwEt93LYTCf799WKuAYIlwl7/TVXnk/1vSvUhFP8wm8jWxn5gkApYNsuCPY9qNwt/h+JC5r1FLm69gqml3oyiW97X5vKwfGIm3+ipcHlgymlu7aUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=E28ABKyyJF8ACRu47JP90k/NEGtlcRpDWCW3aKBOn1AGZCYfrmCxnPr78PnaWPHz3Ukf3K7KtRLshwnBoXNiLcU6JCk4f3kN+po6IhLeOXbe0B0uXktVB0F0k+OqOi7CtU0Dv04z5mYf9upu+/TG5UlB2gHSdEmt0VEV7SmXgzQPGIb/t6cUl380kGUbXZHbpJUNGtXKLTOHJh3MUT9WvQi8TPi/gxYx2bcpbnavHI7iSkFY+px9V+j60SFaJD55X6yLBhJHEaNPNX2raMKBeWGkMFVN4F7Q9TMg+S4vz1LR6ZemxUZKNEGwnJN/XJIaKYFTSzVlyPxp/3FXOYxlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=JXaUyP4aiTRcj4JPJ9iet6lWbqyrj02Uqy2D5nvlNd+LjbxOKByEerCJ0HJc8unjzgO9BjXGKVTEsD9RPeAiz12oRnsfYtpzrwXUnZilgqIEQ/L+GKReeoiD8KdOCIeXNa0QE00gjpAD0olS6oxQKAh4LdO310rsnP0mwfjLhg8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:17:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v12 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYm97qlfT8EBtGYkatBi/tVGRK8A==
Date:   Wed, 20 Jul 2022 02:17:52 +0000
Message-ID: <20220720021727.17018-27-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a6ebcc6-0b6c-4857-1160-08da69f60f96
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQn9qnVQPtHadHXEKYCJXPGmJd6GCD1QjFTeqchavGQk940g9z3YK0Ib8atBJlddZsiqbIlPB9oVQ0GlvRicKgo3U5+Nkar3Yf+QVBktfXTkcAOXL3DbMVihfvHn86IMd735ySfyqL/fhNpMh0uIB7Ymo1JzBkh6wED4+q1BsF/Yd8RbBStU/IHxNrkYYBVv/tlZpzXVJMs8TWasyvCHRukhSA7ZT1WmPUuSKosp5t35xP+FpNBOSpvVGgd6VXw2vkwLGeNv7GusaptKfiPrBeb5OWz0pTlcQU68X7j0XW2LrS4wBOtFBwC+s7P+bT4emQQkhRgEPcy3rpBPj1zMbQ5/rYDi3fLPWGbzRjUQBBYcesBv7Zomjc9wD/EIagPRbn8BGhrXPS/G5r3JhqIbbemflI83yCld5ed96S2K0WjiUj2R/8I8OQWhejJIo/ecULw+c13mdvdv+HyYtKJjwl0uagjvw2UMj7814VzfrQw6g+tMcvyrWkVwr3YO66ZtanOKg20k5+Q+x2qLAomdduNr72uGMTfjfqZBm8AEZ6vJ4bXweKztec0RHNE2kLmcb2rdLmc15CqQ06m7qHmmUJVZ6DYmTS2ld52SJwjWoOrPZvosBLv1aQp3KZRODKqgGBPOj9bFdgcXk4wkXAEnTiNOShVOJns4q9tEf7rj5rRjaYpWVRaxwCoqHg/Up0itQtI9g/YSqMjauD5Xc6sPJzhngT0P+MEPuxU1N3/r5zkXsFXZTQcK4kN2RCDieKveq+IxBZW13goDvPGVBgYOK9TNjwcyiuHEA/o8z/RgMkXibnZkAt0afh4ST7oXuCgivVbN6zDLy6VfgMf/jDbCkxzm3T8BleJE0XOTN5jYGoFRalq7EFwdiBNvHhTsnh83
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5h/7oDwS2v+iRee/15cQ34df5DbrOGGwMjk5yTpDcohehlU+AFgs52PJ0D?=
 =?iso-8859-1?Q?QTXfC8DF7RSinb2mnRRWTwwYW8XUTx0hkwnWubrHidnd1WB8kyAbLcpH1N?=
 =?iso-8859-1?Q?lfdFIiWCfAjc0+KLYTSWgb4ff/fDeYZTPLEXWQMEgcv/t4o8/LUHs2aNO9?=
 =?iso-8859-1?Q?cDfWck+ebPyWvYKDwS3HDHiyewhVXqczM4Ga7e9jh9/LruZZaDvRkUQw75?=
 =?iso-8859-1?Q?lJXaReDmQMyftJ075PMPt5fZTtZAffRakFL5jWei0P73oZu1L33f4QBOxs?=
 =?iso-8859-1?Q?A4rdlgxUsmBQbC2h2LRk18XMOqa+hO9XD02vycK2zJr65cUIioftW08OHy?=
 =?iso-8859-1?Q?3266TwkO0XHhQg0wu35P9AeUeabukLKaCqe4Zv1au5w/YZS75ibTAwNX+k?=
 =?iso-8859-1?Q?ARhllH8Qsh3nTC0Lpet3j+T9RpZqnQMT/2feXrWC6Wyvr+0EINtO0XVvVt?=
 =?iso-8859-1?Q?Nq1NrveTCJV/sTb3S9ct0IEtTXxEfVa8gsjnmD8DrzrFyxXkimTzxiMrrF?=
 =?iso-8859-1?Q?Gy7CHKsevjjzBhYpqD2nhlPKM2WS8E4UbRcDnnf+I5dwSM1iok+Ofc2VUi?=
 =?iso-8859-1?Q?W+sFln21bMZf/CGBx9qTQ8GYQki2ZlBRNazXex6P/ep1uopDsVo0wYtqEW?=
 =?iso-8859-1?Q?qkMVrb0VVtn8AupvM/uIvI01Quc7hvbDXEUvXz2QjyoMak91BZ06hhVh7C?=
 =?iso-8859-1?Q?f0CIjJJlYuvjL+H5LaxbOczsVRrqq3TiC/dPdlnJCLtzlSKj5BoYZNmEeD?=
 =?iso-8859-1?Q?t+TdOI+VAjJ0bTgZeO6OXqIM0WGjM5nf8zFrIRNC9RuF4BjL2CRfoHUZ+T?=
 =?iso-8859-1?Q?QbEadH+kOh4mBJ+mYflQLrD439vx69C2avfYci/EgfxD5mkIkL0QQVWi6M?=
 =?iso-8859-1?Q?SU3FDhmSU43QDZzLuCS9HXml54P+ebi7o1aXQ+aWcmOA+qOXsIjdKKgFyD?=
 =?iso-8859-1?Q?41hy21cLF2ZYpi1UMqkYjIU9I4rj5FBBZ0oOhiTmjMFne8nioqd/fZRUeS?=
 =?iso-8859-1?Q?dRzGmkpx6C/3iXDvH4lmjMpPM07Tknf8M+MVPw2ztjwhFSOUDz0xtrcMkS?=
 =?iso-8859-1?Q?K3UQj1wSfkisQkuVQsoGabeuZBHsE3sYYJOzV7RMh1nbAucB3YCbuLU0Lo?=
 =?iso-8859-1?Q?g2SbANePAM7c5rPS1UTKJv31DrLs8hyhS/xxvPvtUB5TMXWynalj3PpPc0?=
 =?iso-8859-1?Q?KU9heNqMLKt2YJ1AozltzkgIwzAocKxsLSRX+EbftlJz7+d+t60WhxQa7n?=
 =?iso-8859-1?Q?txGWY6LEw7AdsDRBWTjmvRXyfosiDeAWbiigMqU3wwwn/la/7uZgMeylHO?=
 =?iso-8859-1?Q?1W30Q/dDn5Cb82iWX1vgIhogEpQwzexBIMOZXYNEMoaujmV9orI5ZK8TkM?=
 =?iso-8859-1?Q?QVJNKaK0jEsKSVB4Rk7PCDh+Kde+9RPzWrWIuSWsVE+g7Rz8ZVg5hIHpb8?=
 =?iso-8859-1?Q?jf4+/jaaI1X90qQnyrZkAok3vc0fm20rnVxY6mFznryvvVJfoouyad089x?=
 =?iso-8859-1?Q?Gvi/AHlmy4y545A51uo1ZWXBfmzSw0fPY1mTfUe4PC7MiXg3RdUBohz4EZ?=
 =?iso-8859-1?Q?tS1entnEma+FEBc2q+VeovDT4uHIbv5wnG7DEUGotBl/rXWPiqDaNN7ehi?=
 =?iso-8859-1?Q?YDMcg25uv7th4Cg9ETx6nho4SQc9ONSWW2umNfQ+LJUF85vETsWZhpmQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6ebcc6-0b6c-4857-1160-08da69f60f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:52.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfJBjA0r/ysyyorH71goBCAlgA5fH/2Yn6w15j5tWID/kbkFhw72nTNGIZmBbL+mcz/cILLFhuaxTD2h3faSnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: XXON0xEZeGdODjeyRRSKzaLT3X-4uI9y
X-Proofpoint-ORIG-GUID: XXON0xEZeGdODjeyRRSKzaLT3X-4uI9y
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

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-11-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-27-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 55b4b53895e8..a250fd86fde9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2809,12 +2809,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
