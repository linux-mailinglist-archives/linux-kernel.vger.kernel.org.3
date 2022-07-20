Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5457ADCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiGTCW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiGTCVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B696D2DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K02wnf031777;
        Wed, 20 Jul 2022 02:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=m5HabSwH4u7pjneWER0YRB3omC5TT1lnO9lfpS29SN0wktSc5VC2Q8BQt+Rb91xQMT0T
 JeV7EXISB5jEPsjvBohCUQcRpAbdHsvEmEOgvrUuqd7CavFjZBhMYvVp9kTtaJK0mNg+
 iGswnenUYwXCSYR4lNuni8YFYrElLJ4CkiP4KBy9kt6QaNanW7ot/VqEb840OeiNja9K
 ZGK4vbLLhIUUEhwE47IPu7wOKW8GVVtIC5p4DEUlYf0Yyo7YHflOctDernF2GlrBVMB/
 cWOMSTqF0GcbxDjCw+AYMtGUrf83v/rVczM10IWEeVwS23wph9rwAeWwmm3/wfD3c4YD ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlm002689;
        Wed, 20 Jul 2022 02:18:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLYD8cMI546+Wn+/9Bs/VGRErUD7HGQhMBeGjKdE5clYj1POlfLxIBi+80NQYL364J8NSafkHQWr07X85KiR6aEEvpDcdmUf5bM3Kyl8qxkSeHCfkCf823tIa9U8eE72dI8eVffsz3pYF0xxz+M9bVrNjtfh6+0s6AtdPAfT596Ae9sTy3tUK0kWLaO9P+1eWO2iSOQrvTVQYFFkTNuJ7ss+QGRXbMK+G5pYKeUDqnTBZSVJhgifBmMC6Hr/MEpIRmdHYgN9pAu1yOXtG8vIcHzqootL04WmXUGW9iNDh+o6PFZm+kIsxs3hex8YjpMIG7GURRBAIYsxwHJay/W5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=QqFxzRx8Gq+pyhfTvSBsPn146LFMoeBQke80Nw2aFGW4X0cfjbKHquKVNKcZPtgIe/kYhuOTiHQ/gxD1ul46DMEUlo+Q4peu6GJ8pZLqZBXMm+QzJlp4CZI3NUoKBY8BSdKGk/lafXrZQWgep+svG9DeRXGBvpQXoI+AKenOchQmjYZgffBKdBkD7RpCtvJMBYwFQ99p/v54zslWc0nPSM50D7c3T3tQ2vd3Xc9qqJ14HDYdxoGtkOvP8wn4WFfFXWJmON+9c3v4wonj+9kF5MtYk1RzC5Jh86eGcBq8SBw4SnhlyjLo3/8EEOsTiL0kwFrSvJe3fo0tBTu92ZH7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiLiM7crgpaN8tDarv9bwOFUte49j3//W/vVsup8Pok=;
 b=LG/MbcJ9Yu4tW1g3YpipwyiQCjrR2wcHY448QEvdzOmQa1Ccq5lk1LwsNReHbmNfNUibVFDqi1Tes2g6JjrulB6JmKDTHWR76irQ3ejeUEsAGpLof7dZ9Y1vyrV2GaD8hK9/4w/a83CAK+9O+xsy5NZ/u+bQrGViBQJpr5hrl0c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 41/69] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v12 41/69] exec: use VMA iterator instead of linked list
Thread-Index: AQHYm97t1O2eSReL1UKykxVFnGc7vw==
Date:   Wed, 20 Jul 2022 02:17:57 +0000
Message-ID: <20220720021727.17018-42-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0922206-fd7c-4ffa-74a9-08da69f625aa
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9YXx75uQ+r7HR2keZ/XxzZCsnk2iA30eKjQWadhFDFu2iGRcdh0x1AQdmFZCBm9Nf1E7MtAaBWBkHU2zLbV9uy6hHUnCflHVW6lWz1GPoo3/nuTXztznloN4YWtZFa+CxPO9x7zw1EzmLtdR2My+ZUlt6IH0bW6mcdsuF7kZ8OpaeAhl46SZ/R5dIVvbi6/8mhHvGn2S4QbjXvDA2xYPnh+ZDqfH53YOHpByu6sAKuXJShZFTA6rfx3cm5aAht1rywet3EPjEQTAUNhRRQvG9JyM2SIyLHpv4pKW7OJDCPZCLIcHoq4dOUoh+cO+yIDSaXFfxgij4FbKos5RGoc6RvWq6wVUvNWT5PmqPMba4DWyk9bR3Zf6BNsWelTsLqflmLc3hDr8w5iymocE+MEMGXIxihCc7eTAEJjXhONnMeH4Gp1Au9+M/RnSHSL06PbusjFbbNfLt9tI1AdbKa3J3NMONhhXD3kQIr7eDyKoklzWATwIsNpaojIKCbmzNTt6kUGmTuuxVVueuMPYqpI7tFGqBNceHwlIesRiJVQxGVfThVI314nQDXVC/mkWxszzNrW5tzTC5lxZUD++J7j3ibf93eIqpmGIpAOlOXsiyT86bRiNmuoEwg/GNFp1/EEET9TvXvFAA91MdFt29BBBjLF9gXbWkGvh09w600xdvakCUi23T2I395SbIyeK+8+s8bybBdaabJp7X0DwPK3DFXas0c02VAcRKIBRWUCcA78JkdTSdc1NHlOzzENfLT/OPN+uBHc0h4MGp44YmRLSY8PmV4UWINJXEH/0LGMxhkV7Uf/7RdzkKxOnaNG+ctwPBWJe2YWyq2NPpW9zBg+kYO9omIqWv8sFA8MEPe47Q3Fsfy+QXY8JQh00KRGBHP6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y8Qe9owSY9zFOd/53TwERNfDYXCHmyKq3BJyUqokuwyU2iegiRbVH3tUvP?=
 =?iso-8859-1?Q?ozSNOnXoJF0rjWSVRpt+VOZ2IYpYv68ifo7SjTc3v/9z7jQwRbhYFJvzEd?=
 =?iso-8859-1?Q?k2WYDKTcCuGjKtLqN/wZNGJ+djPmnr40M30vJxIC0uJULBZhxIwWjMBt1P?=
 =?iso-8859-1?Q?kOCu/Q9qSiQuWDwMAFwDbQ2/CO3AYQwfbSPXOqMMJAs3ufxSw7ZbKB808y?=
 =?iso-8859-1?Q?U33KUs+SJjM/2R42yD5fRkWVQ538h80dHyRjBo2v3uqu1SzpL8iCbZ0mpd?=
 =?iso-8859-1?Q?WupaEhGCF1kz0+3voQeTIPvR2ucJFnncy6tJMrgiLK30rbOe236hy/gKPs?=
 =?iso-8859-1?Q?HN1lO0NBA7xkuK8rf7imuK5zog5e14hiQzXa8VTJwbSHfonfEwuhRXmYNf?=
 =?iso-8859-1?Q?s38FM4fsLvndMiLVCVNwCViNpoqXDsiZij03ObdQKWPyr7HewsmCEabm6L?=
 =?iso-8859-1?Q?9S1inh4cPbh/1Hm9CjVUywwWqthEnp2hUoEIUCmMg9pzoWkid2JKJ2Ovcd?=
 =?iso-8859-1?Q?uqjrO6C7VlHolR2SpG+7Bl3ntbq66yaGi1tb/FusvfWygNqsl7IxEaQr9S?=
 =?iso-8859-1?Q?iOq1q5qMWg3Ym3mZI7GjFaEqIlK0i2A2sQAS9vMrkIAgEQVy2207yTu+7U?=
 =?iso-8859-1?Q?cYPUpgELThrkmUbS1pMnzGmr3fW+AYE24iUZsEoJWXX4PO78BwLrZ5F6ZA?=
 =?iso-8859-1?Q?zZtr2nG/H9aB+OdLIMPnzBnHDXnVjS3HtUXHPYj2k40frJlR0Yyrg9hqaO?=
 =?iso-8859-1?Q?ntbh+8nTqRlhKhPaKKgqf910WmFTLYU51JWtXHSWfneBHMSnF4ompO4t4a?=
 =?iso-8859-1?Q?u3yjIKBbJ4x1zCC1i43longv0tZvPMxp1QmXvFQfbyGnLRhTC2GQBlhe52?=
 =?iso-8859-1?Q?3/vACM/yeXCbAokxrzduO+8xCCGah5NHUlI+XLhmxuIV78bgOyrLOnOlDO?=
 =?iso-8859-1?Q?iHxZhDdC+EL3XVcPKo+OSy1czE0TYc5be2/H8waXGfNsIaTpqnhGy6NIYT?=
 =?iso-8859-1?Q?udgrzqYpnyPlL0q6Z/cCFR9aipa1UwPRfI1Yd5kUqLfzdmONXkcivKSXiz?=
 =?iso-8859-1?Q?vcOz7XpJqb+h4D//i4Ky6AqiPXo5RP01gg/JdDFojnuVWNbDJo0dZo7LQ8?=
 =?iso-8859-1?Q?niIRcj4qTADWdbJweyR+tHDb41J47ssu2JiMH1dvygrFZM1FvF8YRisl7q?=
 =?iso-8859-1?Q?PH8uZ1HZx2hPrh2ijz4LBk++iV52Oc0TwvmowsHjdC5q7ZrXc4XH3kyKeG?=
 =?iso-8859-1?Q?vRIc3+ii8s2nWwdVwacEugC0y/Siq2GPH1mOZ4fHIddbOGL1PXTG+f99Fa?=
 =?iso-8859-1?Q?cD0uW5O/a1wktr/beg93GLVFH8yDht4ziPvzKnzwx3IMLN0WfV/9sRNdGn?=
 =?iso-8859-1?Q?NbljZqL/f85XWUe7eOtNae3AI6SsQk0enZZTKfg7oZdJ5QvioNPpUpWyfa?=
 =?iso-8859-1?Q?WfKZTGi49/ZauSVA5dewGZ3WeHHQ8WdeNux/zKBhKjacJBZPy76Ztrki2B?=
 =?iso-8859-1?Q?F6mjj6x3xC15yavdzIqdFMcPLQTGYxnvLtcBrdCIFS19gkyNwrsz4kC+qk?=
 =?iso-8859-1?Q?vsj7TeXfHOawEMTrVoHETUVFFrnwtBA1eUz+Rp6oXYKCdtoxjxBeGkOkvx?=
 =?iso-8859-1?Q?zzVr6uRlZ3iID+pP4RQqgLjmfLnq5wc6TcTMpJs/9XToGHHLMeCS3lWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0922206-fd7c-4ffa-74a9-08da69f625aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:57.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE5lPz/I6T0kKVd058HJkHkZcGYPC80sn6IJlRXE71QhbQtyORRPp3x/AzfXxa3KuUPH1u/ZsGi+A0McFeqFRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 9eJcNVNE5yVFPV0EpRKiaUpwa9IRsuTO
X-Proofpoint-ORIG-GUID: 9eJcNVNE5yVFPV0EpRKiaUpwa9IRsuTO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Link: https://lkml.kernel.org/r/20220621204632.3370049-42-Liam.Howlett@orac=
le.com
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
