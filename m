Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411551015B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352058AbiDZPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351894AbiDZPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A312ACC1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSuSN018608;
        Tue, 26 Apr 2022 15:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=GLyec1KIB0M/hxvIMDmAabCChxz9yDoyk6Zg64vT4WE=;
 b=Pq4PeVS/DuPJIy/3QFW4eSFZQN/LwdC3BqTH1YVaL2IuaUSU1KUSZ7KA3olyo4e5BlcQ
 zymWjVFaXZnTPwjXx2nBdEqG+5DHLFjzBgVuUXQ38ZHciCh2mTEA++j67o2FYGiG39OJ
 VOnbEeJY++cHmoaxdWRgFLB10H50m+N2xAsMprn0i2xPXvJ/Ac3aZda48sWUPzofXnxb
 Zp33PVN9DFllh6fy+2LcAsLBjLouoAVnwx6JycdoTwy0bCLimIsvaf5NNhl8Nf/8VLFJ
 71M4z6KRuvd/d1ywWvuPhReel1wTo+c47ZBv178Xhu2DiVR9C2X5fwf00tImv1ECHtHE aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxef4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63EV012545;
        Tue, 26 Apr 2022 15:06:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuH3IkuKfeBycDSErkYxtIPXWvLN54ib6zNbjOP1CV2td+NTaVeGTQQSYX+HylfH1mfVo5VQz3PJDu69WNuJIxofYoG/MTDPIlRSKhnTznT74eId8UXzXYnmJeTMn0JpqYSayYLk7ctBaLNeIUZPYoCxj4qW+pSSmkcBuHKonquIlwzbgzi4WayfY9E9DVM60b8Pa5C2zrChEVeaEYEaNdQh36ONNpEFV3XlQF1KBxXqfmkpo/xLvInfaYEjl+V16ukL3Khygc4p8z+sHL4D2BuJ0eX6GxTC4eSEIGzaeJ+h39bFuyji3fl/yDASaK9ERJHmZQGmLlppuJ5yhG1KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLyec1KIB0M/hxvIMDmAabCChxz9yDoyk6Zg64vT4WE=;
 b=feVIHdf2f/y+rtOyKGuM9kGm0HWhjyRb8y+UpwGxac97xZRJTMqDDxFWJw3YDsDn2wXb4PfjuGGtPgBv+R3pcCzFNd7ofClTtQFuvzSOoCAvQGpbqcoPGGQfdlH4a8uVrWMU+BC5By/rHuzHWUiWiFSscWSyz8ZOlspo6xPMHRWY767jGVSXT2VI6dj6g2yBkUVLnKFQr0i+j5K9HXlZRzx7Mrn48n2I7orjcCAYZblLxMhjYrkDdfgv58kp1zDlYDqD0wxiq12cF77PmjyLGaOyWct4XyzRDCE4AppYnnIMXutB8XJ+ke96FprYRtYaEAVvCI1Qu3qjYUvcM+SW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLyec1KIB0M/hxvIMDmAabCChxz9yDoyk6Zg64vT4WE=;
 b=GvXnu2pHGelAcKUSVStDiZg5BuBHXAM331OwKgpTaqyJJ/dh6uIt1Upk9DYg3NpvXZNJc8uDU2NngahbGM2+cm7M5/yjYen6esGQ5eMPTfMTwAP21N4VIZdDArbyoi+HJURwDkWAz6p7/rQ9wjn70EZXXYSJJtqTFU5j5ycvlyc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYQ==
Date:   Tue, 26 Apr 2022 15:06:19 +0000
Message-ID: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70677ae3-090e-4d66-e15d-08da279651ef
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB465990764A1D8633ACECB8F8FDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IozClGwB9k/TD9YUwqP7xk1RsoBAOG0HM3w1y5U8jeeBfarKTfCwCnTirsOpvzi0QA7FB3ai9gNsjDW+yg2qkGzMzfZ41feiTzibvUKEya/vwprC9cREWl/eLLaNz8DZwpo25nzeeLJCARDzJuE7gqqjTk4qwIkT5+khdlw24OUWC6g1OpTd7sBu1BNCes/GmyGVqgE92uQDbc7abrUSSpOABDqSNGl4bRXXdK6ZPSQVkGPSotmBBtCbQvYK1ehJ27EU8cewMjysR2mgu9mThB1TIqtyIvIfwGjzjU+xvHg3i8ojZI+n3ur8WFBTQyddo/3KzG6Nvgn+QeO7jhh+ONhvQ+mMlBpss4IwSQcEkZtgv0mmVDmXY8yXauNPlTJXSyAFJHZxejDvL+mTQf7fGIbAl3tcAx9s2X9jEUZ+mJggrlFI8htnLI7UFIOcAZC9HfNKVRB1YDSUFPIL6gR/ajiMUXURLmVLMHay5lJLZXLwe/F3S+v++N4mI2+9y7+BYk01LoVObNYwUA6ymrLumVTjLl4PlM6WEEYN96RDYA6oF/7zR9aCt4+lpy+v/+lCNYs7rrTKjF04V/jnWA4sT6t3ebBZh+t3tvRW4Bs7nIKxp5bX2kFrUwYXSwffORCyZKEM/NUF0kiLYqp2QUUIFOim01sJZXnoUY3TIk19QA4WEokZ6FSqRmGy0W17LZdjSrT4dbeaOWnZ0ggMuTuf0rufGtD/IpOVvLnn5GEw4psSIbcChUzbWwQgw+DEwR1ynt0ADRkbr0lGEis6Q643GnMi1LVRAHE8rZlrKf676aJKe6YZ5MPmuyZBCo3zSB3J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(76116006)(508600001)(966005)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xm4ZkU+3bUhvGgWNaRjuZy7lYak9LY6odDTxbPzfuHTA+OChs5ENrwatH0?=
 =?iso-8859-1?Q?CgJhFMa64k8mFGbb6+Wlln3nQaWsNZQxYAqmBqfdL0ytJsXAV7KsOiZ2bg?=
 =?iso-8859-1?Q?ca/7aN16gcrpsD4XB7dj4spMaUVgvdtr7ylLaot4XErrE42HxYEpVRWYoL?=
 =?iso-8859-1?Q?+E+Eghud/NGie7b+d6PgEqU2aDHv9wOXbfwqCTN597F1GMUKO09vYn2D+E?=
 =?iso-8859-1?Q?jZAnDDAkLI8GXsJTMFFCMa2pPnJSwQ3vW6rRima2ocTdfC+0ZCaSOVsYLu?=
 =?iso-8859-1?Q?sgIqKqZnvCZCHFYhdc1FSbN/j6SFbMasB2NxGp78IREG5z1809F5OvXJS3?=
 =?iso-8859-1?Q?qKPk/rqMDv+4xmm81SUfTeDadZns3S9hbzI+B0nIZ8XnduZwELkGZe/MAK?=
 =?iso-8859-1?Q?tOVo72m13O9rZjnIgxL9BX1TWLYO4+1btPa6YDymzX7aXgkX8QbOzN1/K9?=
 =?iso-8859-1?Q?mnm9I7Pnv7dy1Yh0mVTU7anFyCEQ7UBP/w1Q13Z76RlYNfp0AtfbV5zphW?=
 =?iso-8859-1?Q?Eq6hKLyRk4Ee0D2Nn75lgqIyJq28yBF0ILGh1hfMVRIOAvc6xaJQ5A3hut?=
 =?iso-8859-1?Q?4LQcN1HryhtGySBoHIEypH98uG+l+wcNvtIT8lUt9568fML1/auIZ3bWP2?=
 =?iso-8859-1?Q?ViGlWa/bvTazPx0y+LGvlsXc4fTig2Dirmb9kQ/GwuHw1ATask2DgkK56i?=
 =?iso-8859-1?Q?Mt+JoKWNTxpAdoOGPKPGV2tBpIkXkpzO8TiM7yzrYNmXfu6wi7LSnCIMJy?=
 =?iso-8859-1?Q?x+y8Ks7+TO4DHFiHCRm5NR2Rg3RKc2WrB63yR16H597aJLoC9NjJV30Tls?=
 =?iso-8859-1?Q?mZKFsxWEBPvbCars6US3k+IHEi+OdNNqsoCfE/9QKxBQWw8T/YDrORHwPj?=
 =?iso-8859-1?Q?y8k2/0kUcTJWzgVOzRnk6STLSbnUZejqY592NiM7e7AOuJruTOdhRwl8ky?=
 =?iso-8859-1?Q?qGDRk/BFgWSydOvNPx2xSe5x4qJUSCeR2ubPZmFjRMUpI29QZO0H0a8h61?=
 =?iso-8859-1?Q?HilbbaHcbeYSLvQ24RampoJw+E/cJ5DQgXXrf90o1Pfvbe+MRHI0q3G74X?=
 =?iso-8859-1?Q?8//67N/AbWZ6VYtIRV5tjXqdI1VrucaDBOylF1s8A7YIXekFjnf4AgEDon?=
 =?iso-8859-1?Q?zujeW/vqGNvH6+IMBy0Y1HpQmwrFVcL8dlcGibtNTgEF5MFCqBv0wUeX1c?=
 =?iso-8859-1?Q?HT+J7XR/09B2uJzCj1po1WBwAFZty9QmqVuM3metq0tQFTYLSK03wpDhb1?=
 =?iso-8859-1?Q?JfsdB7XyPn3PeX7Fab80U/CMUadgl+MZ1YUWu161cxWsFq9/Mfe7VHJWsX?=
 =?iso-8859-1?Q?HhEzBkN7Wg2X2gU5PZxRxt8Fow6F4AJCz4se09z459SaWPt3uSaeYFU2cR?=
 =?iso-8859-1?Q?LfyMbLN8+yQi301QUkKIWn6ocj8y8GUGF1R2Ddlr2V062qhnO2/cKjn+yN?=
 =?iso-8859-1?Q?PuYEEf7iopmMe3P8SUI1tg5qUJcLR7ECtEvyfx3ZJ4Sxiv+ACnfSDQZmcW?=
 =?iso-8859-1?Q?jOyIiZYT0bcGghuxXFTOo3ysLxCtACowqiVc9SO6/ygTYXom6rTm/O0DhH?=
 =?iso-8859-1?Q?PgqBxTPgawjsHcsToHpBpzMBVBUFGfm+07luXvZ+JHIEZkBkMxrVFUw2+o?=
 =?iso-8859-1?Q?G+X3N+YJVuqBgisO9xEP8ugtMv8mKyz+J0ALFkkI/dbOf2e/QWERFWAYrP?=
 =?iso-8859-1?Q?rO/pjfWSOzzGDvhCIkjQf73AO8YtTucJsOTVl6bTzuHNifH7ea33zgbjDC?=
 =?iso-8859-1?Q?muaIiugBkKjFgXcv0F2utIhNFnWG0H/jC1zZ/cHol15hJuXOl+SsVT8i9G?=
 =?iso-8859-1?Q?q+lSaRhPXTMWpHS2QtFn0bO2izZiPUo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70677ae3-090e-4d66-e15d-08da279651ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:19.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDbWfmqGqW3BiltMZl2ZN88L6+U7uWLp25Hur/tTxtaHFhVHJ0FczaBKYHWHfJpM66YZ/8ANOm8aSZAp7AEkTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: w3Ssqv1aIvwIu0iyVM3apk2tFzB14yho
X-Proofpoint-ORIG-GUID: w3Ssqv1aIvwIu0iyVM3apk2tFzB14yho
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please replace the patches in your mglru-maple branch with this set.  It sh=
ould
be a drop in replacement for my patch range with the fixes into these
patches.  Adding the preallocation to work around the fs-reclaim LOCKDEP
issue caused enough changes to the patches to warrant a respin.

The last patch on the branch is still needed to fix vmscan after mglru
is applied.  ee4b1fc24f30 "mm/vmscan: Use VMA_ITERATOR in
get_next_vma()"


Here is the pretty cover letter you requested last time.

------------------------------------

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  The first user that is covered in this
patch set is the vm_area_struct, where three data structures are
replaced by the maple tree: the augmented rbtree, the vma cache, and the
linked list of VMAs in the mm_struct.  The long term goal is to reduce
or remove the mmap_sem contention.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter th=
an
the rbtree so it has fewer cache misses.  The removal of the linked list
between subsequent entries also reduces the cache misses and the need to pu=
ll
in the previous and next VMA during many tree alterations.

This patch set is based on v5.18-rc2

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220426

v8 changes:
 - Added preallocations before any potential edits to the tree when holding=
 the
i_mmap_lock to avoid fs-reclaim issues on extreme memory pressure.
 - Fixed issue in mempolicy mas_for_each() loop.
 - Moved static definitions inside ifdef for DEBUG_MAPLE
 - Fixed compile warnings reported by build bots
 - Moved mas_dfs_preorder() to testing code
 - Changed __vma_adjust() to record the highest vma in case 6 instead of
finding it twice.
 - Fixed locking issue in exit_mmap()
 - Fixed up from/s-o-b ordering

v7: https://lore.kernel.org/linux-mm/20220404143501.2016403-8-Liam.Howlett@=
oracle.com/
v6: https://lore.kernel.org/linux-mm/20220215143728.3810954-1-Liam.Howlett@=
oracle.com/
v5: https://lore.kernel.org/linux-mm/20220202024137.2516438-1-Liam.Howlett@=
oracle.com/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-1-Liam.Howlett@o=
racle.com/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/


Liam R. Howlett (45):
  radix tree test suite: add pr_err define
  radix tree test suite: add kmem_cache_set_non_kernel()
  radix tree test suite: add allocation counts and size to kmem_cache
  radix tree test suite: add support for slab bulk APIs
  radix tree test suite: add lockdep_is_held to header
  mips: rename mt_init to mips_mt_init
  Maple Tree: add new data structure
  lib/test_maple_tree: add testing for maple tree
  mm: start tracking VMAs with maple tree
  mm/mmap: use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: use maple tree for unmapped_area{_topdown}
  kernel/fork: use maple tree for dup_mmap() during forking
  damon: Convert __damon_va_three_regions to use the VMA iterator
  mm: remove rb tree.
  mmap: change zeroing of maple tree in __vma_adjust()
  xen: use vma_lookup() in privcmd_ioctl_mmap()
  mm: optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: use maple tree operations for find_vma_intersection()
  mm/mmap: use advanced maple tree API for mmap_region()
  mm: remove vmacache
  mm: convert vma_lookup() to use mtree_load()
  mm/mmap: move mmap_region() below do_munmap()
  mm/mmap: reorganize munmap to use maple states
  mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Change elfcore for_each_mte_vma() to use VMA iterator
  fs/proc/base: use maple tree iterators in place of linked list
  userfaultfd: use maple tree iterator to iterate VMAs
  ipc/shm: use VMA iterator instead of linked list
  bpf: remove VMA linked list
  mm/gup: use maple tree navigation instead of linked list
  mm/madvise: use vma_find() instead of vma linked list
  mm/memcontrol: stop using mm->highest_vm_end
  mm/mempolicy: use vma iterator & maple state instead of vma linked
    list
  mm/mprotect: use maple tree navigation instead of vma linked list
  mm/mremap: use vma_find_intersection() instead of vma linked list
  mm/msync: use vma_find() instead of vma linked list
  mm/oom_kill: use maple tree iterators instead of vma linked list
  mm/swapfile: use vma iterator instead of vma linked list
  riscv: use vma iterator for vdso
  mm: remove the vma linked list
  mm/mmap: drop range_has_overlap() function
  mm/mmap.c: pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (25):
  mm: add VMA iterator
  mmap: use the VMA iterator in count_vma_pages_range()
  proc: remove VMA rbtree use from nommu
  arm64: remove mmap linked list from vdso
  parisc: remove mmap linked list from cache handling
  powerpc: remove mmap linked list walks
  s390: remove vma linked list walks
  x86: remove vma linked list walks
  xtensa: remove vma linked list walks
  cxl: remove vma linked list walk
  optee: remove vma linked list walk
  um: remove vma linked list walk
  coredump: remove vma linked list walk
  exec: use VMA iterator instead of linked list
  fs/proc/task_mmu: stop using linked list and highest_vm_end
  acct: use VMA iterator instead of linked list
  perf: use VMA iterator
  sched: use maple tree iterator to walk VMAs
  fork: use VMA iterator
  mm/khugepaged: stop using vma linked list
  mm/ksm: use vma iterators instead of vma linked list
  mm/mlock: use vma iterator and instead of vma linked list
  mm/pagewalk: use vma_find() instead of vma linked list
  i915: use the VMA iterator
  nommu: remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   218 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/mips/kernel/mips-mt.c                    |     4 +-
 arch/parisc/kernel/cache.c                    |     7 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    49 +-
 include/linux/maple_tree.h                    |   685 +
 include/linux/mm.h                            |    74 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    58 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6964 +++
 lib/test_maple_tree.c                         | 37854 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    42 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    56 +-
 mm/mlock.c                                    |    34 +-
 mm/mmap.c                                     |  2079 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   135 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 89 files changed, 47833 insertions(+), 1823 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.35.1
