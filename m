Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9657A6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiGSTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiGSTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:14:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC747B84
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:14:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGccR0031777;
        Tue, 19 Jul 2022 19:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lyfc72GZP977oxFlG43zetRhmzihEcX0Xnq9e9u/+Ic=;
 b=CVSktswH3/CHZU/S5LN8yEL0ND/YRpdPq13lba/wOfY9HI2t8uQQiMUGvr9U/tyI3xsX
 QZB3Dt2GTBUpa5mLo4LH/Ykoa1kaq/l1U0w7Mslf/Orjxtx78QMWoJmmy7Ef2NYdTa5x
 uwZ2nVyK/EcEaNJl8WA1F9wSgnzFxiU4GE25EyPBuwcSA5jB7daZn9KcdiALDxTzYwoo
 t0443jUFOuZL2mvf8tWhDWE3WArwKHBqeoZbBj0oJc34oD7bxLNyS3nWd25WJjvrYdPk
 0kys047jiIaIQn8y1Bz2EDyL2qaqgoLrg4e2edfNXdeIOKbb26I5FLhSzL7kZ7Dzu26e cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtfh5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIShfT009880;
        Tue, 19 Jul 2022 19:14:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggsbfr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er7GTCR1Lv5az2trj3+bF8W8abvOEEhJwelfxpre01RjrFT5E/wRsoZCvaLxN2MKfRoW4Tnd5cThB8e4Y7atQNXu+UGrs1oIjizCF/Jbt0Ul6/wMWBHyS1c1Ivinfjfq9nZ6ssoERNxMh8KwGCUlvE7x0ATgy1Y/6wV6+Uiy/lRmek8gaP74ZFCWJmOxRAomuE4g1k5KGpXQ/idsCmzAG3at7wBfwdyJx6lIAobdJ82Pgw88YAgJhC8Ae3fFh4yrLeGqN0LPppCGu0dZr4zI4LZWtFU6RBjbGIPnTv9oSlx+G75BXcJDftCqhbrznlX4SwBsF6NWb2k76P5m2KbCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyfc72GZP977oxFlG43zetRhmzihEcX0Xnq9e9u/+Ic=;
 b=m3fHjIW+coqJXUouqpFUMmLjRCVG1s9ANHjMSN3UUE/a1eFkL6MhW6ZnI7fghy5apGTvEuaUs3Vr3S7z9oLdUgXmZ6nwtdPN9bYTOpK1xCr6efBXl8bprsuPxmCcRIu7ePnfMZ7WlAAFFaO+mpA76TrMOzrtHjssDMxY9kJDbVqBJuD9J6EnN/IXdsyBWXXDTQjnjquxWBr6sPX0bwl3fpQ9xtHEKmVRPNTAJZAamUAp+q46U0AGG+20nxaMRPfm5DX1RMvyGgfVTGP80PE7BCWxQKeHhkrsn4qS1E4qjSyas0KhA76bcdCjjf+Bxm3gdBJemRfcgmFa3BL+3qEaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyfc72GZP977oxFlG43zetRhmzihEcX0Xnq9e9u/+Ic=;
 b=IbkOd/n/XVU0vBmy6Y/40XF7KvicooNIFkDFgDl9DNqLWrmdaxyVvI5X+wMtkDkCYUvUHJZuQ0H4NGyk5zEc+GaVbSzzYQyZ+zVlX0jr0m/fZRWyOaYRZrNAXQ7IrTYp7R7WtNM2w25kkmmId+744zAFpRuy8GQnZfi+vkc0TTY=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 19:14:03 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 19:14:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH 2/3 ] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH 2/3 ] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYm6O0ToLuGWSQFECVDRaTevEw0w==
Date:   Tue, 19 Jul 2022 19:14:02 +0000
Message-ID: <20220719191352.3366482-3-Liam.Howlett@oracle.com>
References: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50dbdabd-382d-4e7c-24fb-08da69bad826
x-ms-traffictypediagnostic: MW5PR10MB5805:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXktWCaWnpvrqet32w+Y1CE+wG7JkwprRlGk1c/EXyPl0PwtmRqyi/IHZq/kgXCduOv54mKcGB1MAw+dC6fqY3WECdKIw3JyjU4qPZ+g33BUk4t0grZ/Idsxh1SDuW030T8KlvTWKj8LK7jR+ph6dKEDPps0endp13u4+pHWoyO3bMM/UnO95YXjVptMzZ+mlkvYPaSUbOBK5z4IPywQGZuaTi4UgCXOpsGHRVf9rxOD/bxTnqwBEVElO3Q2GtLLDUdhpByhJ3jh1DLhm+GLWhtMacj/bgjQTvUFqeRj76pw/hOV4Q1WUqzGd0R0r8JSh9kSd46kaua+tz7YUU4A8IndhAsRo4G+H5kPfR9VsNYaiN+HazivNidkpnCk4mf0HDMAc/2NMR3oMKQp1GKzoI1N+Z04+Dx8Q6Rp2/PJbdEPoEq2FqeVdQEOdDssRQLnNJsGxMwwNqj0ocK6Dt/slMoIFJ89+B9Cu6ciijr/ETq9i8riNfOpvXUMQnXGlDvurHXOtBB7dnUUs11LiEwfJBIRJSN9dRLKjDMQz/5Ek49tMQoJgshq7m0WfDTYRVLHc5NfsZSh5LX0D6Ob8JTK7ddslUhXaH063d1H3n9Pko9CPuPWq114ZfyusYfRqWLXpIWygtW/n1wmRHYbYHKr8+lLhHfCOQWYBJbTlbwXm+ns5VzYzyd/j8XynAgpm4dL7NX1EBRjTPZR6bHfW4/7WvQAKON0Iegbx5g/hKVpJhs1loaEJkPjc/b4RZcyE/o5dHEgFqhETh2SmmwDyzuCNBkwrZt7TGH9w0Pezln/m+dG3L4mXKNTNCm1l3Z0bmnOOtFx22Q0qUf90D3dotE+g5KDnKm1h4ujJpZ0kzXgI2sDe5V5f930VUay6A1uMiFg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(2616005)(86362001)(6486002)(26005)(6512007)(38070700005)(1076003)(41300700001)(8936002)(2906002)(4326008)(38100700002)(6506007)(44832011)(478600001)(5660300002)(30864003)(122000001)(110136005)(186003)(316002)(966005)(66446008)(76116006)(8676002)(71200400001)(66476007)(91956017)(64756008)(66556008)(66946007)(36756003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XlS90+lCjBPu9miKL1zFG8Os1TTKPuiycsz6GZy0PvTpwnm8i8EjR7KZtZ?=
 =?iso-8859-1?Q?gvG/teGWa4stU2iAC2qzogZu8YLtviNVaqvR3HsvAbeWH9bNVp5nZEHAMf?=
 =?iso-8859-1?Q?Iy96R119sfgbzNJfyVmaPBifFKRsQQA3/2wIz+6pPsFBRRygX8NCrX/9pH?=
 =?iso-8859-1?Q?/XWYa7ixA6SdB4lp1X+76AUmXjWoNQ36kbm6kHOtkgL4Iv/TFMF8XpDhZi?=
 =?iso-8859-1?Q?FwgrKjaq6ZQMhf72g7TN1r9AMtwDuhilLwdptyHs44sTc/4TpHAiCTQwM/?=
 =?iso-8859-1?Q?DjU4xNed5cm0UCZSh++ETtydMQ9+Q+QPYTsSPkzaJnE+abnVFdIz82zo4c?=
 =?iso-8859-1?Q?+fvbDDv/P4Q9vK817+D5Svs5eiN5JqxpOdoD2bXqyKqy9QvtQqNFRcOcg2?=
 =?iso-8859-1?Q?ZoNN8ilfOc11ICi9SMg3w2VFYpQDQ+ZGS5UsdrZRzDHIrg8ZzxQCafQxCX?=
 =?iso-8859-1?Q?/yueEFOWHiCeyYcmN6cObUO+P3RBGJDHdM+6K4weq7n9sjlOdBJ1CuQ1Bf?=
 =?iso-8859-1?Q?wsBFzMdT1hFTliZ2DfiIa8FY6syo5tFq4gNmqb7P7XdgGTYbmBMpKU5sEQ?=
 =?iso-8859-1?Q?U52TR5G2NxVGtkxADBbqVlUZEPIeX4BHx76c1y00gpuTT7mkDp5KL2WZHR?=
 =?iso-8859-1?Q?JgayLhtMqBu2HWArafzgBMrOWZIYorc5c4MCtD/CJIxmB46xq+8IWKhbgA?=
 =?iso-8859-1?Q?AlqtDC4IezEUxVkDGFD1uRrQOLzdv+MtZBwuPgjDdJ2APkXOfRmb8lskoG?=
 =?iso-8859-1?Q?OavEibFTGwPmTbR1pl/Jcwu4Qn8YclIKWRcA8iqIs+IuCuXoFoXcykiASO?=
 =?iso-8859-1?Q?Ta1XHvSuBDDaBscuVxR3ns6GpEUKbsuutj4ZKrfh5+mt43sA94rtyIQlsu?=
 =?iso-8859-1?Q?J6WKyRidYCHShxBcSGzvwMCetEFyqpGmjhUSBCWPMPa3EuDmVB2cKnU/Bv?=
 =?iso-8859-1?Q?UcH51uQlIdniv27nJRdMMlDX5Dd2Xn99bSPfyLUjqKp4saFNrvFDM2YbkV?=
 =?iso-8859-1?Q?Ycj/0/khVrAMPI26nUI46XrAsPE1lkGwpXvm3IC48DQ8BHofemWfpiYRIP?=
 =?iso-8859-1?Q?gTtb6Aqw/c0t3ON6hSbr6P0NuAEV2BUt1PFsDf0m6pThfA2D3w+oKlNvbG?=
 =?iso-8859-1?Q?MmZ+9L0Nqa6jFFiyq9+KLFPB6zxW1WtpUeM+KlxWn/WU3BNRATTl8MzwSF?=
 =?iso-8859-1?Q?8YbfHUWMTsbgmN+/8HR0avnhSj5iXunFWgp3sHuzx8QQJpsXzoD4X92TL8?=
 =?iso-8859-1?Q?+BSlyQoCSAY6S/2EFgmtu2Qf8LHzDHkVCvDKfeCvKklCkgKYopz9TYdlIr?=
 =?iso-8859-1?Q?wudnzKRpssCu2BnGD61gDum/Aw+a1avs/HxxKAz1awihGYaScw/5q/b/os?=
 =?iso-8859-1?Q?xixl9ADLZWHLEDJlxabp5BAHcCcBNg4aaLN4eOUqb85Cw7SzQLqA4+zhd4?=
 =?iso-8859-1?Q?65MoYGIe2wpohtJnamqpBB7NALDraLbUNuEliHPxh3miIUP/imyUDLx52J?=
 =?iso-8859-1?Q?LK60WiUHR3F53h+khABvkuPDVVAt/i/5IWHuXxP8cMMkws0hIaPqbsQ0AG?=
 =?iso-8859-1?Q?N3GDAevkG/5KQYxl9RgWROiFzohwK1lF+PrWd3vAlti+KgCJF7KujouYsM?=
 =?iso-8859-1?Q?0lSTtOvb+kicMiG+9BFHUfICwY72lnN8O6GGSmEb19wookQ60I19yU+A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dbdabd-382d-4e7c-24fb-08da69bad826
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 19:14:02.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4Kw/0UZt0qTxkIENdho2Ccc1OWoMMiweYawdmJiiDFeIlfPy+8xyiSXKXLGBNqZ2XTiSBUTdI+BZUAlEDtsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_07,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190082
X-Proofpoint-GUID: HekPmvO7egrwUsng8Boy9z6uQIt_YuTg
X-Proofpoint-ORIG-GUID: HekPmvO7egrwUsng8Boy9z6uQIt_YuTg
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
index 3b67ae3ca0f3..ddd5040ecc9f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2407,47 +2407,6 @@ static void unmap_region(struct mm_struct *mm,
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
