Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3310E57ADEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiGTCYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiGTCXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F570998
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPuw031784;
        Wed, 20 Jul 2022 02:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=pQEeKg8ebyGcaIovGwms/IMDMxr8XsaUdzoatqYm2r3mLb+CZUsmbaK7MQWfeNxrvRpc
 jhNXwvq6wqaK09YwIjYj8bRUVhmtUA7y0GpUS2rC4+aFrTAqwXojIHjexAiMaMFnjfLb
 5gZeO78+joc65tLBqbmGsw+IrfOyemTMwlS31WqwLT77BTHKwmemPgEQ6FN8WH6QsnS+
 LQtjGKAS81DxKiMi7UIfcWWmH/ZmYTNFAiGz3iUhsY3pgZKXCN0OO5cKxO+LGiWgiJQ0
 4KjFtsI/gi3cewLb3daT4uAw/S4U+ouJEMXcv0KEZG7zmZtmpfLIMENb+DxSc7wzO/8g Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNeDsQ022213;
        Wed, 20 Jul 2022 02:19:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseb6k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCRGvmFqEYCf2yUOvqO0mJu5IS43C94ecPiepPUx0lMZWb9VfYylyZPuc/Db561e/qNUUhbL8wf8TH7zCMDj65UQleYRmN9IvGtWFudTMmY2mWyjQOyaijxyvZ0or0M7+XJ3oXpG1Su6HOO/8WN7b9UdgeQsDPDyntxpInQXG8ks8DLXw8kAkXHIrKBIKeQM54BbO3/UKRDJ2MoHgyrzqwvntrN6FxJkg2pwcgR747uFWst8hO3qILvjtot7MV971mi1GDzakdYkxE41+lZc9PMOlyZ6LZZKiqA3kpy0CTBrYmAZJEjZVQw9SWnrVW9Y5W5V+JV4U05Gb3uazNnPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=B2Q0+zyhcEOzpGiUOAno2stdR3YEOiW8VCJgNSkOaPPaBUXjGP8270xpJO7S9f4JMnIyE2HFfTgBGmU3OzPySLYjvPdujazyeTtLvMDTwCsIYVbifQA3DLO6Palr5gdfCGhYb4NHLwLVRvJZ7uQIgVNAEDO1Oaho6bKvyuRLtqpr2g/i36jEJDQfUCfGtoAVhNtNe5HPhz3rCatvq+bFPDiu8p02c11U5EYFMkAfEP1E/57KmO2VdhUpbymv18zRK2C/GXw6HB8sq87jv8LJ4tILYAI28IeGvjxDmTsol33oEMKJhi1EO5OTaLs8rXAuzdDBjXCE1uX6TKo4Hq3zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=yUJrftAjT4UYYpewh/BiikEsJQ2jDZxE78sQeuQS/I+WQDx8TfeE446HnZJ6XTLVp/4v9MSd+1Tf2Z1+qOJdLvYobP1NDMcc3tiynXnoW8fnyKBfHf9h6t0u69iAdm7M8EiiueCuLEWEWT7sLUV7z5FDwVtXpC7Cv6tOEGM6SKo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:19:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 63/69] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v12 63/69] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYm97wsJwgkaFk/0i4jNCoqKancw==
Date:   Wed, 20 Jul 2022 02:18:03 +0000
Message-ID: <20220720021727.17018-64-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 406c9fc0-cd97-4890-e0e1-08da69f63edf
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQCr+hEI1gK13JsdEwyUm6BB/EPvgmmZYkL+AlJE5Z5sxIEprFVCJnHpEof+fyjW7QK1lgrKoqqUIFyLAgJ82LbB2bnNhd1o1hGYS6ji2e0yVyznceO9atd64fGwsqqrfMTfWdzpaHG+eyuo3XQRGu+pEGIkyvTkYjGjWMUeaYT1FIfC8W4+PrOoE/EFfhGUa+Q2Ypc1+cqCcm8DFz48i8a4LpOlPIKO1gD23IYRzY094Wu5ys+6MVEJWe3nZJyekGcabVxcfnrV/RK3aolkBRDtTrb3TyVMThHK7Xf1Q1Nu5lPtzyk/OTJ9UJDsrEyfCcCEBb1/iZ/sv0DRSVgFCucbhQJgWLRlHHqLRNANnJT4K5E1vz3olpp/B1KXHVDH/lSyNOH+xX72CZdBUevJHONCtSHOsxI+yUQmauvrvWg7a/ccGnJmTKFOIA5U9p68LbJhIj2u9uVTi6VAFHFGcW3B9w7EpP8OE8cjJ0zJj+N2SDuA+w6ElKadzWjrvLVgiqOOGlClH1wWxwJGZBIB3GjvKm+sfmZDnTL3ATvp9eH9ij11HGlS0MG0V5X83jSD/MA9UwObJKKQ/DNRXC52jp2veOw9hN+oadB2AKZcCOoILil31B2Db6RYii1hlwk3mTyT/lMlHovk2oV+d65hji9qCPcVEoXNjWa+JOaXZWWStL1B4F7NcW8GEsRn+PQF6sXvzQqy5anB/lZ8diC5hRGAlx6d2SXT3Iodfbb9WNVrO3AZ8uk5+vB61YaB21bnPTxHldfb9p5nRb6WzUqHsIXbsBSpvVsFjXKgmvgipru8XDDPNvqxIFiVEeRjlSi1jmGAObsLoL7ZlrAYAtkc3UPSDFGZLtK8bBFYTxIth8XbetZLqBHY3qVeLXW7vb67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zQw++9TcjZFNwUYV4LXoJJl3eFHPjW+qmKUBSkzW31BSZF3hKbC8bCq9h4?=
 =?iso-8859-1?Q?CVRaLjqTe5+b4LZuCIpTqdzAACOXuonx22yJD1dMCWgpDyzKQlu5NDXEqU?=
 =?iso-8859-1?Q?7ZkaJ4rw8mVyiZ7WhxFG3AEbSghsr18rkr7Y52/t4HS2jrBy7RppDgc/in?=
 =?iso-8859-1?Q?4Btc5Jb9EQFkCBf7RcoLSTCgI8AEULFdU73p99+IwExLhclqWQaLAH6RFD?=
 =?iso-8859-1?Q?xHp+6WkJ/VaktDz7uYMJc0UIp+WHS7zwAD5JbzlFFDtRC/gDNjw1Xf6jzU?=
 =?iso-8859-1?Q?G87l5JhQz9ktqoU4VTiW5e66Gsv0GCnQpO9XAgy72IbHmcNOBBv/UOxPup?=
 =?iso-8859-1?Q?V46xNgHNTiEjm+zOiO4nCnhl9uYw+RUJQ4CvlwOKLNAiho3xfGL+OjgPkx?=
 =?iso-8859-1?Q?tiAkd68FgJS6Wq6hPmnzXYY06K+uuuq8+P61iUiWrEyU43nrmHqLtXjCbf?=
 =?iso-8859-1?Q?Cp7ImXqKI6Op09zDi2k9LrNnJjJrQ1bfPfzu+M3EAVJtqvUcAWYyHbBuLM?=
 =?iso-8859-1?Q?UPaJKxXZovgaOXTWoEgcMIoHZETToPtSs/2ZDQimkuvGfcytxPwcso6LzS?=
 =?iso-8859-1?Q?aZS5CfuUol66QLVXRxUV6JSiyXwCR4emD1en62nMBSykBv+XvI9HlNHjHy?=
 =?iso-8859-1?Q?Mb5X4SQ/hSJmSUfkME67sBeIjTyfIO408R91wXYB+VdzBZu1fde0Zjy4eN?=
 =?iso-8859-1?Q?PMtt6jTdw60LGJmWk+e9+dLBx60e2jzWL4i8cOKMQ3zXqKyk886Ggwg4/Y?=
 =?iso-8859-1?Q?01RmDi4HRZ9OEbq+JyY73TNqZ3b/c9RPFH8c7f9KkVHmuekqw9k7yWJjBY?=
 =?iso-8859-1?Q?GabgCxPFk78Mp4K6dXr3j4sF8TLd+i2AjvqomOITUE6Uwc00A6QLqtAGrF?=
 =?iso-8859-1?Q?eXQAob8sFVQSVYBEeosV8KVkDIWLBB9VB2fb5hRTtVL4F38Urf17FWEDgg?=
 =?iso-8859-1?Q?0PxDuWx8DhXE/VrQ0DG7c2imBWSE8IdMbsKOX2TLNEdCkbhOMaVfXzLnoT?=
 =?iso-8859-1?Q?oBRtJFUkNWnecynY9HXwY87onQghoDP4wKZ360dlumJEOLt65JqrHFQcwc?=
 =?iso-8859-1?Q?vaAeBN9c7xHQgM7n6SNkT9j7HQXE3jygxtQUnBsgN6cISQA8uGmN+JvGX9?=
 =?iso-8859-1?Q?AOr7+d63/WWI+p0si17nkxEffkCTgdMHFhQkffpDZTDcVkF45l+XEEfDrR?=
 =?iso-8859-1?Q?BbdQaSVmcNjbFjZI/11Mn6m2axsoyvaNY3+tTvYAOmDD929Zz7wLuwGGdD?=
 =?iso-8859-1?Q?nfWrzAdJEOXvBpYhAP4HL6nkhVlenr8kHqwk+b/g0qm2Y5bl5v0GaAhfvM?=
 =?iso-8859-1?Q?vRj/ad6ip07mqNB0B3ubfheskTIEapxmXAyS415X7TSyJ7GHDszCSsCIDd?=
 =?iso-8859-1?Q?tAlEnuCGY6TnfMfKrOoMQ2s6AnjcUkMeFigxZjU6oDM/Nb3YKcrASNc26r?=
 =?iso-8859-1?Q?dw1JCmBjpEc0Otwy3J/nQfEZbTIGr1XHw2eB6i3WC0bgm9AhmOYYmO+Kyd?=
 =?iso-8859-1?Q?zqyt3w1g+WJvaER+QEWYrIQHXLCcnuv/qfV/+JtLLmGDFop6ld4o9/xlAi?=
 =?iso-8859-1?Q?lgEo4A0e7WW0FLXCFH/eqYnNYrP7YPXdKIZddqbeZXtpvRCuiIaVAHJzA3?=
 =?iso-8859-1?Q?eh66615hGTZktM1kEPuwqUUXyfTN3Lw/jsOWyq3x+JDbIWFTqWKl2eWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406c9fc0-cd97-4890-e0e1-08da69f63edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:03.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FK9mOjnS3OnviK4Xg3cxEGEt3YTv9c8GUr6SxFxQ/np4xWtKiZZkm7To6OeGfIC3Z2sambdSJDOXdW9FCXKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: FdHhUz83ZOsszo3yhzxJa5-cvGn1I0gw
X-Proofpoint-ORIG-GUID: FdHhUz83ZOsszo3yhzxJa5-cvGn1I0gw
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

unuse_mm() no longer needs to reference the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-48-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-64-Liam.Howlett@orac=
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
