Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D50553C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354740AbiFUUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354611AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3C11472
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5LRE018710;
        Tue, 21 Jun 2022 20:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4EzfVzcENxg6MUNNmlr4i8I3Cj+DuhDDL9/vSplB4es=;
 b=YjphDqpBTh0hNG7POdUb5dgkHykTPVLBSNEtqkPDYkqO/b1IKKSJGaXcikBW3tfS7rff
 5KM27Mr+boGmxFAkvls2+uNYZSctqPLoaG9PQNlzfqy7vMsFRdttn5mUCZMAcJ5N2X/R
 rLxSew0JQedfXlhB32PNEb3llZ6h+mDpEZMFUrYbmAabYwlXag4LecaOMfE3BU8MKCoi
 Zkk1XfEg9wfRK5+ezjbkF5zoXKZK/Z++JWIP6Uxs/GP0Okw6sQH87/QZPm9vLS53Lkub
 W4Iw1IG/b8JAfEFqloZHMBttU/a2+yesyqZtOmYOXnyTkdOomKkFJaPJZA+8RV5TZhtU gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKehRF001620;
        Tue, 21 Jun 2022 20:47:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ+c+6rKyqKlr9nDWNFTSk8T4fRYEECyhxO192SWG7Pa4nHHsiXq4O8ir5d9x+fc6Ei3bIGc7AgnhPtgnTPcLFyv/PzFpoc/OQgdYzJ+FtQEbh7fDTa2taSERcCF80BhUqOEFASiBdkE53AMeTFH7k16zEc9b+ssNVabqIsTsYF65dyx52jRqlq4USnMXG+6QDID2O/2PLzHUPVcX/Qtoh5VsGwmDE9RNpWSmQA/ltfX2YiNqaVqtENTfaMHMumW38C+YZc89u+MtanAiGgp5LzpLHebNaXi8roDsBCNsn7C8hfpnHpdS/W9mClKTjBZsAcyXK26V56wwFAQPvSB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EzfVzcENxg6MUNNmlr4i8I3Cj+DuhDDL9/vSplB4es=;
 b=Es9r/ckoJDzAl/m0cK1/4Qgxi+z5iedFJrFw5ySAwJT+zQKI5MZ4iZa+/k+JAwUAP+OYFsQwwQ8cH68lz2gftC7vORnAVfTREIuKLEWTdJq6Cf7vm8lImhO1/+bZadBaAg5Jlw0hHZpOAZZhDU0kCcJZPeWYk5glsAaHJjOC8TQ6Vu2/tUx7bagL+dYIKTywsla/Iu2CkNOBpf6VwUufpyevoQbTZphRFi3snFvgWacRdhOBx7hytfH+k8PGoO6CKRxXUt6wH4B9MWRXBejcmwrUUxTnoP7QsVwArd7Ge08MvPiHyoJ8MB6Q/0QvmJm1gBI4s7X8/BQnOdrKXDbVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EzfVzcENxg6MUNNmlr4i8I3Cj+DuhDDL9/vSplB4es=;
 b=lY0C0RWnkDur40yBxR1U9WRKvC6Vgr7POWDyalet5GeSvCO719zVQtydjHn/JdMShqNglV99do+C1kw0d+uChqFUMe0bp0sK9TAdUeDL7hIxFPK2tWKWUOF1PMt1CIAGykSQgYzL7FXvMHqoCL27dVxFk6gPpQNi65mmeHXCDG0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 41/69] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v10 41/69] exec: use VMA iterator instead of linked list
Thread-Index: AQHYhbAR93zMxAOlekSY+zL611woEw==
Date:   Tue, 21 Jun 2022 20:47:06 +0000
Message-ID: <20220621204632.3370049-42-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56727151-d728-4947-7bd3-08da53c74d52
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025EAEDEFE8E4F12C028716FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ/5qpFpqre5Dozo5kDs1ssRMdTlxcE3rTmynvCSXNhH7SD45xmwIlTYxvEwP4KuyXUFS186C+tDebnuaEp6LcZfMXscEYVj+eWu+nZTJGeFE1ak094BCt2SKiEc1Z02V0LMhTzA2neoQFOyV/07G3z/OTbiDfnj1Y+7sp9Q5e6G7+Q6ikO6a4cazlMQcOaucQ6zLcFNJGpxcuUxLfjFhAbOZLXI0VsjrkVmBN/sLA8oY7tNfgufOcXPTRKplRYoJDXRPIJjXOgbvi3hbFSTaULbvTSWxcqVvbtEnR+cQq1hCpAOxszb7n4Qb69KbUZdzlundO+RJxHEXCHK6iQCH+/G9N1zJzCET90oSdcC46laQeF/8x5dU6ngscCjgRiEpCZ8ciw+0PO7J+EhB9ZGTA3Epo7F3ovDneyyLerorlxOrWIaft3C0mgp+ZrcecLcKV7QVACBMI4f8Jyh3+wo1g6IOURdND6iQHw5NKEnmeR9571EGCwrS6ZGzmTmfaHmd4XMOhwb0yIF6L+qxxW1xNTfn8GjjdHGAmTJB/yXnjJ75NGIW7eBYAo8jS5RFIo2bUMfPlgNVEfKFWGPhFqhNx33vgzGyBMa8cKnbwNIRuppqwkP9S9hzpBhdM52HFuQShNPEMBPvOCKqscuHJeiwbhqQPbN3q9qtfycXTW9fTfFjI+w9BTu3OZb1MvqXm83cVoqCWDFF0CSEBWnNo6nP0yB8FvL2pv+L0IScjwp5M8OggN/cnx9GLMGTcjUq+WxABOznIbDg1KU5XdTD9lmONaLaYBlj5kHmikvcfsM2fM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sZzzom7MAuetdcc99n+3BH6NSpbNHZvM4P6RSV5zyHYEFTCcg1HUsq5t3B?=
 =?iso-8859-1?Q?qSKuomr4ZaFdD3UNca8xxHJKCvQlW0JAsF4fzaXcr7jWRNOp3+2PElBvoF?=
 =?iso-8859-1?Q?um8tQDzjErfSfOa8PCK/j7vpytk2QwmNp28xUTEgtAaSLXasawUT2H1iCB?=
 =?iso-8859-1?Q?2i1TKwM8CJlZgGU4TdP55vUlrZnC8NQ/gLlPoW/3ew/hHMFMlXuVBHAhZk?=
 =?iso-8859-1?Q?0Jv+d40v7Fj6XnrvAn+JlPlY/W6OACILTlksENQ37svNu0nGM8mF7TZhEU?=
 =?iso-8859-1?Q?IXtHG35xewwZSUoPsFEOSM7FTdYI3qN4VvimJ79BT3xYulFiatua9P4yvX?=
 =?iso-8859-1?Q?9GtI5meaG2RkZDmCHMPHWGYGaPaFPEowyHdn2tl5XJG2+YI3HPOncsuMrt?=
 =?iso-8859-1?Q?z/9E+PQWgtYDNSrDzRcug1cL1mkuqDKnqu5dz/Ms+fZUFmgQhCU3nHZXLL?=
 =?iso-8859-1?Q?hNdqAdFleZx/DvpVrd7Vo0ggKE2B5HoQ8tc+buvatLSXsScn4UA4GbuKP5?=
 =?iso-8859-1?Q?2GO4N8mAN9OnYZUFLWWhhqrWTG64H3LMd0rS/IIOzBPioUHgOCx3FKSdZA?=
 =?iso-8859-1?Q?o83KcxF2PEkUIfRP6WWa/iKRt72XZoug+hxiYmiVUqblTgW8NCGFkST4jf?=
 =?iso-8859-1?Q?9K2SeFrIqD3zpvRz5ZoAhJBMt6RKppoNftK9FlagXPl81D5Tsb44pAV3ht?=
 =?iso-8859-1?Q?U4KrJ1TBzXcgAjjvseFbhmS9IO2wfu9kANwn/3cEHZi41q7Ywl4IJkTfnR?=
 =?iso-8859-1?Q?q9xwcYI3wugiSarHlQ6y37Zy7OlvaDWVtiOelNRnMNeKBgTI3yNl+OeR3w?=
 =?iso-8859-1?Q?GpuHtN0Fgh22LvykYgHY7EtqGjhmPBFdQPQWuiurWJztdR1pbbehB5xnuV?=
 =?iso-8859-1?Q?8NGHsgxMhyNnvEzGOkU5fgvUBmQmViTTg88oYNICEHTXN8r3z6peWhW9lC?=
 =?iso-8859-1?Q?O3Y+QcbLWN5lt4zi7kjn10WlCF9wA0bbIMNsW7bTo/mq33xviT1VQTNFa6?=
 =?iso-8859-1?Q?uE7x6bG7kAwuYOHNOeH86vYUwcK4j8jdTpF+meMEsX5odLhjhLh21fgZAa?=
 =?iso-8859-1?Q?UgjYZyDaylpAnowWQ+jXjdJBbB7/5V5cx0h3JvaQ/3H5I5ru0fYkx63eax?=
 =?iso-8859-1?Q?CIvG9XwyW4zND+ly8aPsJDcMbPdfU33QYrj3hycf8plTBv1+bNLXGjDAd9?=
 =?iso-8859-1?Q?7Item4saqHrnJw7nb3+XJHsMCs5f0m+Gx7hSDJh3hXz1hu7ZoUtiOXnCLp?=
 =?iso-8859-1?Q?zqIi4+UC334VbJXDxqEPqoyMK4Sp7p2j2g+CSY2aFqWAd0HnrOm6/quWex?=
 =?iso-8859-1?Q?BQgLtrum2GR5YVzuBrG2wH7RqiBbl9bo7rMKylRK4d6FF4Pp6TlJcPRP8U?=
 =?iso-8859-1?Q?iUSGlMnoDFZZl9g9ZV3NSbqJtaTsPeK2pgj/OG1R5LR9Gx6wMkL7zilsjQ?=
 =?iso-8859-1?Q?UmtosZqO++exgn+iIo4vUkqVuNhqTw5fJhyxSYK4e1BPPzU53Ox0AJ2Ou5?=
 =?iso-8859-1?Q?94kLTBViemLqRetW6MbGK71SL2adjFbrgaJ9NQsck+F+6A/qfFVlwdXVXx?=
 =?iso-8859-1?Q?6G6pvXZ1Ztr6NkJU/6eRYsiUT+nQu6HK64vc/tuRmrMlKVYdhljx1gQOf7?=
 =?iso-8859-1?Q?O/Rdel9tMnsvPmu/tjH6GKw46PFt81X+fYWETrHA6FuQj6QAA35n4XpR5f?=
 =?iso-8859-1?Q?+esmduMOaOUHaMTlmPjEkqlXjeCzMEIouX9gNyHFXTuWD7OLueuUELfu+X?=
 =?iso-8859-1?Q?YSJP/E28wh3ITQj8wTTknHev+W7tw8PPLMZxnb0svvP1FG9v0eKYybTvOS?=
 =?iso-8859-1?Q?SwHtrTWlGC1t2fMaAKcpi85wYrywHLQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56727151-d728-4947-7bd3-08da53c74d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:06.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4/RJDuG7xH6jVfjefgZht6yYVG9KpdPZLYYkPqQy3wSAh6Oo4T0X1EzEUaA5Xnpnu7fqW9Dp9SHTH/BgXYVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: -H15FqzSP12XkvY386vxYF1agaWP3cy8
X-Proofpoint-GUID: -H15FqzSP12XkvY386vxYF1agaWP3cy8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Link: https://lkml.kernel.org/r/20220504011345.662299-26-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b97afa682ffe..9843cecd031a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -686,6 +686,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -694,7 +696,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -713,12 +715,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -727,7 +730,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
