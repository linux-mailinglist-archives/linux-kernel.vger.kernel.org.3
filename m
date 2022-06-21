Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973FB553C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiFUUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354721AbiFUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809C2D1C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ40p5018707;
        Tue, 21 Jun 2022 20:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YAQGAkZ9q26qDPOUTzyqOdLPKUSLZlfUAvAuOoWOyIE=;
 b=m1H74E0b7QBSpiqfw/qPR8VAUSpgVgv8Pb7PmKgxLi8Ukmc0iXaJyQRlIwMWeWoT10xJ
 981EjNtDXlC+nC572/jzzu4DwpOxtJRWICHBEois6ldWdWmGvyGMLAAJZTTjCZn7KfCp
 Wf8Y4PEG4G2ml12cNHpamNzz+E9JxRSmkhrVoG3fhm4inWgBOGQa1Fqn6EppRCLIGCqj
 H5ZYYiLjZn+ob5IsCn0mVkwQ6DfcolZCJtPHs6DZ+s8pN9KkAnBn3ZLOneJylMz+KD9G
 7Nce3Xag+zxRz2JXucPcTYbVYt3VsA8QI7pqaSnQLrtWB1725qinpHlmn4zWpr3xtKxF Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKelec037913;
        Tue, 21 Jun 2022 20:47:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPAtTkFeb2n9j3yNTpOYhb/gBNtUqEW1T30MXdOXvi2CRvDSqB8c14xP+R+YWIAfZ8mVghEuAksa4XGDzx+NOBjAZkGdwlKwxN9UwK9LwZNgrt8kB4AHtkXaaUprXJNTcQ1W8xW5U/ZdHQUR0aY8iGlM4gGFhEGuLdC0oCeT9RF1yULPWP1AmwxHHtWHVH2C/EJ5vEWXW3RXuOJYR4zR8G/UwnDMuhOL3w5RmQufxGZfohE1c1NhxVHhMD/QWqOLxlV54D6uO1EMf1OjWgdCubk5l6urq0rLffDgTIxcJjEDqPPe7OiXTqXpAHgU0Qj3KMXH9Vbsmj2RUPXDPiarcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAQGAkZ9q26qDPOUTzyqOdLPKUSLZlfUAvAuOoWOyIE=;
 b=SgcxwjlRfQQbnReUiYt+55vHItMAcae7hrDDzHQOVijf8V835wQJzm/9nPmv5VN8vM9sFycd8SjIu6kDMBqfXw4EvMhm0VoQo3nE6RxWDbf3nRgnzOxWJsG49qF7J8jWHa3hiGnHKC6rS3pDhHhB3ou+HgkIK683ofN8hRe7zKNbesQ19lvFTx0rM+pCT45R4YLGG5ZtGRO0fLOza8ntJO0mLHFp8imStUgbWTPzAKoXI72c9LEjIZFECoPAeMIZyXuaXDbka0bpVtxHPxkCKp5Z8StpypD+6nQEQCl7U/5rO7loxED6SshxUIaCIUFJW1GxXxzF6GFvzjq5YXyauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAQGAkZ9q26qDPOUTzyqOdLPKUSLZlfUAvAuOoWOyIE=;
 b=LrgVXcFsH/newxfzqgbqjr2gSmetwUCvyoUjg34PHwATpgHojqt18F0RnISa1SMiV3f5kro/wpL01M6E7/RvcUp0xEEBerumqvXWlE7QzcXaQh3fHG/5ha+nXLedq7ga2+3A+r3zJHzpdcW8qvkjTGDEium3J6lmcvwVwH6gdsY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v10 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYhbAU7pl9Ne1RO0etAK2gObWqfw==
Date:   Tue, 21 Jun 2022 20:47:10 +0000
Message-ID: <20220621204632.3370049-56-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 949084de-213b-4149-cc3b-08da53c750de
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53924B1747A387BF0579755EFDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /51I5/fQB1kyhshmdzucAw6c4EQAXqy1kUHTMG+rKCvi4LQ58XUMhunG1Jz6VCrC97Nx95MatMNzW0rjHbz9krrXljaqgyLUo7EPbiIj/lFXclPiMllZYP7jFD/cLcvIQIyDJfArSQafOWeHI035CJHDEzQM8FebG5GoAEXg20HDEkq3WPlk5W7fTwUyq3UgfCU9wI/7lVZQpEPeCHHkKoJmeNYiV1kTGyeNT34R5P+pULvPKtd2cwst+pyAyziM38sMoL8a7Zp2/hwDDS+fZkaTubu9RYIUxD7js61/Lxao0WUmFLK/MTUVOdVRtxQ4XwD8NKoIRnKSyt4XrHplAqnQg02tEBjbU7rHsRg69cJl+y+s7Qy3MqmPAb4c1sdvepWcZjltDcI1krHT5PNECzRT2AwEJV3muiYDq8zm321/8mugnpWhrFm61UMoYix/Os2RnRY7j6TBP1/bXAdaElBjb2J10eAtx3+5FwWbqBlpQlmBFfX5ozNZWUlCa9QInbr+oZgc7arudEyDGoeM+iua/Dm4GBdcDUASihecxy3ti7Fb8LAux/7idhXTVbc6iVIznYNZFLHGNnBU7raX7dd5/cwoztK5nfw5uQ7TyVHC5k1HtNsK7/lqC0W2NirKoj3BZeDrxUGD/5Cj1OTw6h0K2/mm8FhUvecXrtBgNxRwKciKSFIHFeuhE+g/UpMQg7WFXOW+VpO4dg4/Wm5RasFbkQDykEwksD4EeBNzl8BzvmsK7caaLYeReE58OyAzozURM+1o62fUJW7AecycM3XYMJyj0DGWEIJocKJZkP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EPoeMklg6zTFaZ2vF7JsuUpZvyXaEp6mlVdNer0WL2pCvLqL8NN5/ZCFJ4?=
 =?iso-8859-1?Q?ckK4xtzNLUCdL3ShG/sXNLMcfZ5JtiGfBNAeiPSdNCVUAizX8vrNacoFgJ?=
 =?iso-8859-1?Q?imAgss1CWYk+ANSgg3Cd1snuRDoY4ho8Yf5jEjeGMCu7rYTrbT9bUA0AUe?=
 =?iso-8859-1?Q?Cvga1AADmmZ09tJHjVN+92FqAxBjgZqghwdDp+lIKBWfuGv7lBs5UOXS1g?=
 =?iso-8859-1?Q?lSSY1kPnYDwAwYYZKY22SCi5xPC7lrVOMIXB6DzClVVjTWUvyON9SF5Jle?=
 =?iso-8859-1?Q?9THcAVWvtMFX7+AL1kdr1Q3rfBRXyQZkKsz8jMBCxzeug9u15K/kIShGP4?=
 =?iso-8859-1?Q?PSftSEQR+Gzmg/RJv5TNsrrEJfLq4ITYUKDA9mQnd9QAsulf7Bq5LBgWa1?=
 =?iso-8859-1?Q?qTFqsewNSOEDPnKcDV+jmCdAFUSOaQh33nnCoqdxSfXxyylon/iLjn1JOm?=
 =?iso-8859-1?Q?db+G/41P45FZa7/TUp4aU2y8VU5roAL/fqhIrYexeAh0PHzfUQeAudDqOy?=
 =?iso-8859-1?Q?RXIgSACM01Yrseif/bGFuFHBQ9kX0jxqgBRcObOhaZAFuGtedXzvbpScZx?=
 =?iso-8859-1?Q?NVKztNtEQPpDnJG82OlwRxfjcjpQtoSStvZvItBe2QlD15hRdn37hR7erl?=
 =?iso-8859-1?Q?YsdN7d570Caax68htKr1JyJmOPcUTbE/upAzJG+uP0i0jEjkjtA71P9aFU?=
 =?iso-8859-1?Q?CedlT1P0d73+U6HYDQaGElIqv714bzeIL4ODyPN4uqIqe+6/RiJvng3guw?=
 =?iso-8859-1?Q?kCyzRi241luOkgmrNZzemweWxOrbRmuiUhGrzsgS39w8SJyei3FmrOujpb?=
 =?iso-8859-1?Q?hvAigyhpD/XvsIJLxpxtlB1EJA9lLR9aOdn8XEwgUe5nEyknAB52dG3IFT?=
 =?iso-8859-1?Q?6v0mntKRP20lIiPZpzwwsdUMG2Vci0EBeFtm64qTEkN3BKBptaHFrAyEtE?=
 =?iso-8859-1?Q?ifZkHTqljr4L8wAcUs792QkA7r7ufU3XiZRqPpxBA6TgPukGphUCRl25Q+?=
 =?iso-8859-1?Q?DLWGV1YwWDqTU4h/Rw0OwSitu4CQm1P+tPoWdIaT2gKCp/OXW8nIadDCGI?=
 =?iso-8859-1?Q?8P023QwMqWzI7MwAYu9JeNEFtPe3Hpcg5rAb5sa3dkcny97+nWLEyqkcj0?=
 =?iso-8859-1?Q?2M1gHTxqFp7Y5GQAG2YNZNSev6k9MTy1qjX2kWEkuMOdy5XntpgU238P9C?=
 =?iso-8859-1?Q?1BOYeeZpDpEZHqX0EW9zNJIF6qgfF3JCCz4fNdpMrRrxRwe9BvPATYKsNF?=
 =?iso-8859-1?Q?kT1Xq3xuEScHp58NLzcOZlIWqgDZumqZaqSvGR9o/q33000eYKQzU6+eCk?=
 =?iso-8859-1?Q?+9ioQ5+pVCTivfAuXaQeCOi6ooQtMIWAn4Qjai7x5VdAF0KRJrU9RWDrzo?=
 =?iso-8859-1?Q?na9rpnNIwK96At5yll2FpDPOtXPhDD4hGjORAbDevl68ShT/9Fop+dMg8d?=
 =?iso-8859-1?Q?zRzYXkX64AD3BUr9TxT9YWP2y60fYv3i9UFl7zO4wTxr42biYD1o2nyVxv?=
 =?iso-8859-1?Q?phAaihFhh0966hvqks3ATCxMhR8k/GARXsOksJDmTYCJOQulPc260z0rlL?=
 =?iso-8859-1?Q?Epl6mBhHQy/Us8fH5K6gwCA5GfO7t6FupmHrJJSOAK8//YHg0/IFxdzXKM?=
 =?iso-8859-1?Q?NYEa84QRHgGE7X/StoZ75KigBPmXuN0o2fHjVbbJ47hgZzA8Kt+NtrMuv8?=
 =?iso-8859-1?Q?SbIEKrJPiwiqsoY4D/NVL8gBn0mv3Q2qGK2c7OVmlnd2jGyL9P6x622AeP?=
 =?iso-8859-1?Q?l9alLDpMkETi9GGs+FwyMo9KL1jh6VKlCOgimscbG8xdYCb4oIwjeHf0W1?=
 =?iso-8859-1?Q?zCVwDynSz9fM0Qkcv1L2iQpCUdbApgE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949084de-213b-4149-cc3b-08da53c750de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:10.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FixhRvNRuLs8zBzPL6ZbTy1eClKiJm2vw6dEbA6fyawVb8y1Z/03xz7sDpT+8HdRfL62eD8mFgxfGSN42wOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=976 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: YRtckK4uBimKOwDnzvyRpPTWDEnII3EB
X-Proofpoint-GUID: YRtckK4uBimKOwDnzvyRpPTWDEnII3EB
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

Pass through ULONG_MAX instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-40-Liam.Howlett@oracl=
e.com
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
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..4c97c6fc54cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5805,7 +5805,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6103,9 +6103,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
