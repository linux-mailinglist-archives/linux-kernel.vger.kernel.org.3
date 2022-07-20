Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16357ADD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiGTCUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiGTCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:19:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CBA66B8E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKlqhd030726;
        Wed, 20 Jul 2022 02:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bKFuP+3dW7fs92Ghv/h4rChVbJ7mEYVyGfyX5Lvbv6I=;
 b=uEoXjBS//EHNYK0AQtXcwcE5sDJvTq/r8iHl2rBxge40mvNx0vlj+vX1EkEmo/ITCTen
 2iGOxGCX2YVsjq5ezS6X/c/6ZGNtLjrIqoX35UB1CHfvXc7zquikeoMQTeeF5xWdprfk
 9WfiFEEQthrNde0N600TWqdtdg20W0CWKo3pYvKjaqTmBmH4j+5ZvK52EE/HGglwyFEW
 MdrqvdL3UTTXRsgvxrlfq1W1CsltQ/i1nIlHw4NdICJYCGIfBxLCSwt6nHokKFU8B5fI
 bgn2ydiLZYgT7dIEDertQ3UQiIJ5y/EpCpz6xRnCJ+kuOLcTP0I4zGJjskuNjYBW+YQc FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7yvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bGE0009891;
        Wed, 20 Jul 2022 02:18:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ng-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmcJFIYdlE+jhhtfq/trQKmUEIgFbqRGnca+4Bj852F8gLGGQOdHncSGmzuPcCJ3Y3DZ+7xF41Rsg9HDSpmPmxpffHQXGvY7I2wwdKxNnrdwSn8rlZnWcx9CErA8yVj1KuPEim74RDKxZffpGjvv2a2FRDVO47N0hdbI2XdlDl5TGDLQejd77Xi5tG4zw9nkzjPhUD47nJLTSFIYLdG9vYDJ/cWBfSV9DewILcBQmqVP0So0XEcqoZ/UJunW3odE2b/9I4crotg/u6CkDFatl9c+6rCK0Gg4he4IWe1wF21CX+gPJZnXniAoCo+im43NLKPiEEcC0v4mWHwOjq1HDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKFuP+3dW7fs92Ghv/h4rChVbJ7mEYVyGfyX5Lvbv6I=;
 b=f8dH/OMD6HJDFCaiMJV+YIl1AUGHCYkY6ki6TYrrE5dfq/yXCq5IfNqDuoe7HsZxMSrdf1okfUifAlweo4R/Adp1YTKTiYdUmvRmyp5dXve3doDWcZmoI4Q6BdLg2Za9j/6kE/3m6/q+CJGteAI4LrA1qb0NM/WpsN0FPFydQ4qy+i3izAX2TiCHR9J3tUqlZrIyiCBTlefKzQErbSPSLdewJsoR46GYRjPzuu9IrjkXa7icOLSMXrnruYRYgC0cE/L4EoiLckhNPkZRWMgoc2i0szCOS48A6APeYw+bByDpViSn9qPmbaHQAptfCik9ehA2MEJ+HT625bmSufz4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKFuP+3dW7fs92Ghv/h4rChVbJ7mEYVyGfyX5Lvbv6I=;
 b=S8zkyMVGgkPWHm02Q/WluYvDC/4iXzuZGFAeNJ+JUCYqy/nAjyQP9ZcbM1AgX1nuJWuHEJKoYBxeD/vLdQj30BxapnhE4FECZtie8S7WzgN+15fsATHan+FWt9xya4cjqPshmUbpmasdHMHPL03BJiYAxRxiIgh9W4N1nLd3Itg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:17:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v12 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYm97qpt1z50yYfUWjLMsils3xrg==
Date:   Wed, 20 Jul 2022 02:17:53 +0000
Message-ID: <20220720021727.17018-29-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8883dc4-15b5-41b3-18fd-08da69f61044
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/5zzAz2bSwpKmafzTqFU7gdHh+9PDTZjS75FtteMTeyaQK8pQWiUksVP3ZSZt753jQ/nv6I3DldxOiYeCg8iSVQl9GFtvbFHB5mBZD5QtCHjViZFILgI5GozxFAcxIJqsucDw/BnQRFtuCTpf8MTkeMnM2OtTouSAwtZrEwsOBYyEUs/nrwzvJMOJph6rrOylSZxLkgouiJENMnRqlkicJyyhWoMvgrjKfqjHqRxhS6yvvAghOwLdcUjr5m1doNTg0xEaDOd9gwG0T45m87LNH4PPY/+EexxRnRrEVHW+fw9jphCqQiBBaUQ1D9RbfJV84fohBmVeRMJnfutDmvMavkSHXgFCIvf1xOJkf9FkcFxtD/q5hXrUGN59dTYHMP+33pkifL6n9vD9mMDK5qphwKlqi4asfvjb8DwpV8MeY4SF8BzEs/Cpj0uTXYZ2GNMzLUpIla+r831MuU+Y01IwAmiOfal5enQBeOn286PH/vVSLFtkRqopKqwFKVJAGsTu3KGYxdtQwS8NfIPDbCNr7p/ys1fWJ56Icjw/9xigC3Rdz7u5otuzlt19azlzeOk+zHBrJRMg8hr4r/HCcOTTkHHI48XY5Ls2cSTrZ8qG4QkbrI2MBiaZfs1uslVWLLxm9G0PfFoYRflPtwVCsHpl5CT1W/kr/M/GkcrOnCA9epEM80ZMN5R/XBoQ87LCRhbFY4u48WeynwSfUnJFBs1WTkxTxSEkemRz5m9qSn2b+QLVB57nqprGuYDAQeAHT4mgxuRmeUhNDyldHA2sY3vy3ksu9oLU8UZVb2QQJa9/3V7ByoYuDwi/UVkf00BC9YN3Rm9AWsow3MD1KLozBfNKAksqzmvzRjKz4MMgLYVfpnTNJdzX88tyVVcLrDjUb7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(30864003)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O2xrUaGi3K0GEN3h2zQAnC3x4JFs02SjOCmxyNCgq3Au1a+w8Z25aUL3IA?=
 =?iso-8859-1?Q?3TZ47mG/0LMfZOtRFNhoGCmhyQetwpsRZKtX1lx7p8M8HiV5afJUMogKM+?=
 =?iso-8859-1?Q?Y5ymBPQIXQ6gOA+wyQdj++d/bAr4xPtt6CeE17fcYr33ULsrEeb2u4nZ1Y?=
 =?iso-8859-1?Q?OpyZ6qr3TmRudaQ3CONrcRe2y60Ioy4IZ6T8cPrQpVzj4aluCHvSgwg8yB?=
 =?iso-8859-1?Q?JXRp5U4RyzlccXs2azpr4mMQKvcgSksJQQUYhpAoZKlhTgsaMP8pEDuzOl?=
 =?iso-8859-1?Q?qd+TFp1tnvDGka4V1WPxC0uZhnMWcXxnFjF8qDA8feXIGZC/3JO3GgOlwg?=
 =?iso-8859-1?Q?0rGQr8kw540A9NWT2Cg0CoO5QMiwuy2EEb0oI96g6IRuuDkr8lFhurfbcZ?=
 =?iso-8859-1?Q?82EF3V8KA8AtjXRDBG3qv4JOtNXNVxC5icDusqtuW0e/rI5Bmfz0bVfwEx?=
 =?iso-8859-1?Q?Qt0B7QNxFBZL1yzIjEZc0/KEGn6AYCV9sbdSJBdEvNIPk3XDwbCoYCqoVy?=
 =?iso-8859-1?Q?McKtyBkuGL28rUh1wuiUwuvJQUFyXA99mAH3xp+IFr4/VRi6gcsuyAI2O2?=
 =?iso-8859-1?Q?9AoEjElqXWy2YfKRRg8bJwOg5ft6FtmMs23KvSeyS+2e98CEDGCtzceRE4?=
 =?iso-8859-1?Q?5TvaCrZhMv8q32aINYjs7yHo5eAbppt28qFd0gQBHhW1UnVviXiPg1lPjq?=
 =?iso-8859-1?Q?4dJrK98nTW1FPJ4RLdGDdYWUPb0wxexnUSPRr8B85RVJfLxDVATquyANDd?=
 =?iso-8859-1?Q?LoGH3H/L57K4a90jhJxCTekjYW+zRMfs5OI56O528zmKBCUI/cBUnKdFPT?=
 =?iso-8859-1?Q?PEJCYFj1JrvtQjfmIlHO7GDoFA98O5j5U2uSrBLYgOhQnNXpFK9uAgU/r/?=
 =?iso-8859-1?Q?NZR2WmaedaYDxaicGUoUXwLMxMtCVqTQ8OWNG04i0yL3Lzd+5OLmcZH6ZX?=
 =?iso-8859-1?Q?v5u4QWpG2RcdeJuCewKRVEj7SgjlFpdo0VgcvgqgjqZSRW5xtxWTIDDlLq?=
 =?iso-8859-1?Q?Q8NXJdgZNvE6dfBhDowr6svcprC8BH/yeTxoWqsuS+e7FDIzfMz5afYPuG?=
 =?iso-8859-1?Q?Isf4dZ4D+snWcpsOEmyYoFSU0x/En6Nrf6Zi5JdrgzjQJWvX70mB+uIggp?=
 =?iso-8859-1?Q?HpBHF7CXUB9CVTv2c/JpS3CRDVJ/mb+zrM10askJmX7xpcEN5vdx8P5TDf?=
 =?iso-8859-1?Q?csAF3dDnLc8yeYY2qBDKgIdxDs08Od6jkZ1DNM7c6X4mnj2V9OkPrsvyqo?=
 =?iso-8859-1?Q?QSunweZ+gAYvVJ15Jf8wCTU3SDO4mFDYUvDUBHI3xD/i23gLFzYDriFcNX?=
 =?iso-8859-1?Q?rII6FrQoJ3itPEv3ODE9FIEZrgl/zU4Hz0bV3fO8c/cxT0ooDCJDIeE5fF?=
 =?iso-8859-1?Q?/BagbxJ1MpLk0ovdk1vB15RkeuwvKw26P6g3bcIEq2lx2GWiW0hnPrCzHH?=
 =?iso-8859-1?Q?V0vcok6BGhHYVmQoWZFPbZv3DmJ0suqxFKr/m7Jo5TO2p/2Fgq0VZjFdbf?=
 =?iso-8859-1?Q?Mdbfwft38WsMrlBi8hHfdf8sSFUN00Hu9DPliFmd4/UmaibEtjYpa1xMJY?=
 =?iso-8859-1?Q?83CoWTMQ3uAA3bw1A9gAk48o6dfTYVylDG338DGpDzIQAZNw+ebEjcYCPv?=
 =?iso-8859-1?Q?90ataQ6wBmCAoMBKIVGgzc0IVcrPChQH+IgC32g//kch4/17QzHcgjyQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8883dc4-15b5-41b3-18fd-08da69f61044
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:53.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2zuLYXkVZ+/9VtobMjGudPM03rOmSLv0l4JwK9SYwPzm3N8u9kAB7vXqpEk/sYc90Ky2/3efjzRoSW/eOE6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: ggsrv1euvfSz1gEFfLVSoGUJ19sBHOx_
X-Proofpoint-ORIG-GUID: ggsrv1euvfSz1gEFfLVSoGUJ19sBHOx_
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

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-13-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-29-Liam.Howlett@orac=
le.com
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
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 228 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 92 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a250fd86fde9..75ac5664af69 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2724,8 +2724,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 0cde534a8f9f..280fc2d2854e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2404,47 +2404,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2527,40 +2486,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2581,17 +2551,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2604,16 +2588,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2627,14 +2641,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2668,7 +2731,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2888,11 +2951,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -3021,7 +3085,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3161,9 +3225,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0..e0fba9004246 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.35.1
