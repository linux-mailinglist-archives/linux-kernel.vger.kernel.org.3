Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB8553BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiFUUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354429AbiFUUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1B2EA1E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ8opB004752;
        Tue, 21 Jun 2022 20:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=33X7H3Q+FJsEnEska1q1Vjkz8EoSeVHkoUOVTrO/GWI=;
 b=S+uW+jLq8dk2niS8kXsBbICwwCvzRewLUWogOt5dzCxzKVEwL5Q8T6+2qfiKYuN3udco
 gL/yugaoRffO1GWtr3JaxbVdv8PMS9xtKP59jz6UiRRJ/4otwrSAknD0xhJQ9uurMKJA
 98saIf98XuYUr7PbjQGpz9hP5rXwpDUFcNo8CwXV3tWwcbGRXpPHtSo/dCnXdKN8whO7
 Er7ZiTcl/JC+VKDKhE4lmbS/3SEBJrCoAPtwC9Snr0yYguMy204bISHEH5jgxsbIW7Qf
 uSQwE6vzouUbrz1ks0jILHaN0uGlSosN/PHY/iunEhLAYejHcsG3xQ9Zje9QbbTovGHL cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgo027828;
        Tue, 21 Jun 2022 20:47:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MymYx/4+iAzt6/Cvba3pPBApxtezvdNukE+9Dj9S5RNCarkPzrUh8uNujzcROgK47y3Yr3HsleNVSwQvioE1RXjSiKR7/S0wha42cSpivIQ6pVLrhDm+IoKYeetcMVqqJCLdY40n73TT6qGXOp+8Au22VCO3P6fCe67bo+LPm+33GJEBq8qU3HonRKjjOF1Ej8MWvP3zCCmEpPRUbfwd/3iH1z2KtxI+xpHPCHdTp3L7P9U4NKZVXMkgtLPEtnObFKXQ1/oqdoZY+WbogYO6gvM3xNEqcfMELNOR6/4BTe6H+Klef6G4vpu/ELIdplWtQFOtsEu+kRlcqrUvzw4wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33X7H3Q+FJsEnEska1q1Vjkz8EoSeVHkoUOVTrO/GWI=;
 b=nhr8EC/nEraZxtPP/1qBuCTk6IMSkQNKZmsmQmC2iq+pNDJL410ZT5WoKNCz9pXRRZIq4qpbNWoAmMJwPpk1FzQeU/0Lfp741iq2zx2fOmb9FPWG9zz5RvpAd82yOfZWRPJC2cw0nwx330xvo08FpDC8HvCZz514/f77Hy7engIh7w7wEmvIdNcVW67EaF9G63KgmT3p1zJTs+VDXCUQ2UX7Bpc8HjAwbS3AjKehAI70HbXgd8M+p0h4p84x6kLADdYwvhX6QfRYp3MsOh8HwRtCrnabSmtEwBQZiWakQMnc+pDJukGmMlMtW0XbnkP9lXizlb2QpmhdfyGjxHANAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33X7H3Q+FJsEnEska1q1Vjkz8EoSeVHkoUOVTrO/GWI=;
 b=Lwte4PrF+FyyD46Eyi5j6GekWKj/XCGmP1uaaS0K4gnDyhDKLOS+J6a//XeWZ/sw06UUL2C+c6MBEOhn0WFLxqh9y7P65FwE5188UdSt4XW4klAfgDLU+131YF9ENbkK1KHNU42iwUEUKo2eTtK2wH2FbgiwSCRBdQLXbxoGmtM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 22/69] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v10 22/69] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYhbAMesyTcBG/5kWM0pmPsmEFfg==
Date:   Tue, 21 Jun 2022 20:46:58 +0000
Message-ID: <20220621204632.3370049-23-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f7c8ae-055d-44d0-901c-08da53c73630
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3085726E5E238A7F6CAB7297FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RC/y4Sn0MwtGFGX5w0vS4FLllBHQj02CCHOFlH/f077/OEZVOqRDaQYLE25oEZSBbWxoXoqWITTqfiRFSxAaJdMtt+YPlJp4JooruN3V9f+RXs1fwF2p0OlphuI5tzwloNbHJAOXTtIfqY/w6OOO13gdy/IKS1Q+pu6f0lPHAxY71egm0kcSH0q7ZGoULR5EyQGh+cRlksTdWQh9suhhGD3529t36LG/qpGKksqwB+OSAIPwJVWdT9XIfy6BDXB00sdPmfN6FEvEqmeU+NQ2ipSGksh4ztYKzomt+kpU+ZSC65ltcZZiXzZwEC7bmWWPyBqPAzliqgTEFNDkO7lCcF01gMMKan3fOHRG+xsaxzzhyu//K7MZ7wITnVzLd40LcmwKqC4zmwQUeiEy1S1KvHCDrqMNstKuIuHlh68CoOTPqzdlGUNqw0aFe18a+nbv0kGY8BBQf4UUDHs/w9UT1CFA6vNmueDlZAq9WSxFx5Ag/3xcUo5xXcutEU9Bx9V7GnlcO1IMJI3FgE6s1sKPn4yKglVTTvoue7wja55YZK0XBDXiDn37aYHFhnoxr5c1KPYoBw1sWGgKW3SQDAw317VN9KOnJFRD7Ki8rwtAIo0gdNjdBAOUurpvmwPht91coXSi6oPARXJJ2FWJP5oauvQSF9dzP8MgZsZqZVjnu9UUMm2Z32RYlI/ig+pbh8jQ3u9yvPdGFAYBNgoacN9XVvL3SJDBHT6Y/zgGcw8i0ZwMJ8UCk9Okrp7fsa/PM+4o7WBx/0cwP27ixiI5a86X5Rm9ntmdgkpQ+p3nQ7euooo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(30864003)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e9OzAJqktVaa4rcTzzNMKghxaPdmdgVTPc8z93TXAojCF2mr2eWEyXXRzP?=
 =?iso-8859-1?Q?hHFX25TPiq4sjT8HScuO4EiExPmnw/BhuEnzB++FuRtv55ASnCB2JJosua?=
 =?iso-8859-1?Q?uqZ34iy99z4GMYX/98tz877HFOsMNcKSdUCUXoIJUiCTBLcWRCYeYnDo8/?=
 =?iso-8859-1?Q?23lQK3q7cX4OuMPbZzAGLMdQy9xqWziBAKn+tJd+/+54F4sZFAJuo7R6AE?=
 =?iso-8859-1?Q?jVhHCyaQrR6P9Drw0kXbwZhs0hQ0VWO8MqsTtKum0tYV0sTAef1PNLkFqC?=
 =?iso-8859-1?Q?ZyaCeOfHwJfXMzWJSO0De3CqOlLrqswryoA/H9lpDf5u38ScfebyttWHN+?=
 =?iso-8859-1?Q?q+I2ubO4Fvy4qK6UM76RsHzG10t1NFQCnkfyUzAyes+9rEU3nmpjhJZEDG?=
 =?iso-8859-1?Q?6t2TtwAI5Q8tdpFq9QGmpApoq7skL10Ga4l0RaG1X5Nfdr70Dgq9DO/cgO?=
 =?iso-8859-1?Q?6VniFSMlECAX3uD/g9pFzrv6vdMrhfn7gHzheeTnNvhWWC/HSrP+Sp4Aw3?=
 =?iso-8859-1?Q?4qtBvyQrw3zIlDgX9S923extR8vZWfevUh1Z1Z8gEDcWHW7BaTaY7S9dhV?=
 =?iso-8859-1?Q?STMdQepVXz32uF7q3P/u9sQgrZPhwOwHx8o+jUmXejEoOM5+c65W9OTWu8?=
 =?iso-8859-1?Q?/j+lKPLCgPtFDuxfbDh/9ynUjLvhteU0E+8qOXUHjBN54feC2NOGklZi+O?=
 =?iso-8859-1?Q?EEhQMrcxgNsobiTa8kbAVlzxHwZb5BvHxOJKTNiirvacWg2P1ceyGrKati?=
 =?iso-8859-1?Q?z/OQp8Nh+xu74bvGPYhjzLIaom6/D7KH/FweIZvGGMvRZ2bBeZAJpU0Byg?=
 =?iso-8859-1?Q?YBP3uhuRclraj+SgPAfvkh3krZdSWf27aAMXhhKcuJ5cKw79AT8mffI/0R?=
 =?iso-8859-1?Q?O6yLlwLq9PXqmCOTP3M8T2EW2BqXEIHxTpabP4v2RIQ4BcbnHl+uehZBpW?=
 =?iso-8859-1?Q?XJbPgq5OmUrblqaeUfz+fV23Vif+pGkVjVOdCuKVBIoeN7PO7pfD11GX6P?=
 =?iso-8859-1?Q?pjsxxECrDW6kKvbqCKvY7RWxzwXHBDdsKwkcirT4z7hjwiTkrA73m4TEz6?=
 =?iso-8859-1?Q?RKj5rS5j8cco3Zltm5uS0SOmT8uj9vI6g8pFZEtR5pUPVIO/nZjGBUkkwD?=
 =?iso-8859-1?Q?c6X8aDv+C5aXLLXvpChz+qeAI7gAgHkyYahsizQ3cmVIVxQ7xlGkZFQub3?=
 =?iso-8859-1?Q?w2fSA1RdnmgEbqFcjzkpTAZ+q+/O6KrlnYlFLOIzm9TLK8sswne9h/15QC?=
 =?iso-8859-1?Q?maTyR56R3lejYI8bu6aGqmypbfFqGQgyQxsDfiB8xXgmRJHKIFj+/52qXb?=
 =?iso-8859-1?Q?fjshtjOjnpWd3zjZduvP5Xeul2bLVz8AlLJ6FqnBGJjNl3JoMAchW76Wnj?=
 =?iso-8859-1?Q?8qX8/8ADKU0/v0bGjrdeXaqCMdLtOA4soYZjL1ItBUY/CNH2dWfn7chsYa?=
 =?iso-8859-1?Q?h2YBlZygCGyeIIK1Jo5Na+MFIKDIsNPgW4oxg/DcJALXeKtQIM619kmRpe?=
 =?iso-8859-1?Q?YKC1ketWJgWu9acP1wJ41Axk2p+oH1ZMaD0zhqvYDf7wQf/lglFSD9WqMt?=
 =?iso-8859-1?Q?2Og9VGdRcjGkECKzBYoKlV4gSvcOkjuBLTaB+S2D+4aig93aFZdzbxUDDw?=
 =?iso-8859-1?Q?mMUU5vEpR8D5e8L+Fi1qYeX1sAcVdaYmSCuyVaLqBzMvMCjHuDb0/kXIgK?=
 =?iso-8859-1?Q?bB+8oLqbmdwaiwnkjhoLopeiQLay8p7jcIgaqY8/KQfD6dVQ37r/az2eTY?=
 =?iso-8859-1?Q?+8CMijcp70qOeQgYVYnurIaeo/xS+UyAdg85HSv9fF0Fr84RNZq0eKnoWt?=
 =?iso-8859-1?Q?NsGrfJORuIaP/miJ4wiCzjGCHcsWkoM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f7c8ae-055d-44d0-901c-08da53c73630
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:58.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWmr0II5VQiWa1Yucs7uARjQW6WpzJEfguT9Lib0r2b6ly2GFTQC1GNrPv4WcwXr7kRw+WvFST6hy/oSJqmoDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: 9b4cxYc82ZX8tIdB4eFr6XooKUU42sFo
X-Proofpoint-ORIG-GUID: 9b4cxYc82ZX8tIdB4eFr6XooKUU42sFo
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Link: https://lkml.kernel.org/r/20220504011345.662299-7-Liam.Howlett@oracle=
.com
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
 mm/mmap.c | 286 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 228 insertions(+), 58 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7d6b5bdbdd1d..784d38ee8d94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -194,17 +194,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -246,35 +269,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2791,38 +2831,113 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		return -ENOMEM;
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	vma_mas_remove(&unmap, mas);
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED)
+		mm->locked_vm -=3D unmap_pages;
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
=20
-	/* Check against address space limits *after* clearing old maps... */
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2832,30 +2947,56 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			return -ENOMEM;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if(vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if ( mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
=20
+	mm->map_count++;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2866,18 +3007,22 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2888,13 +3033,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
