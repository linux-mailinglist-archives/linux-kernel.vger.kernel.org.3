Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA658A880
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiHEJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:09:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C22019E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:09:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2757wuEN016039;
        Fri, 5 Aug 2022 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=tI4i3EmkfPiHq4Hr9lATGzwZ+IbA/XG5UcAAkjCjhyc=;
 b=0D1iOrqa9LQiB7TIwTBHN4ytEm8h/S5S5kmG666YI4qrZmwGOxIYGlHA3tM0eRsIN8lR
 yzkJ6Zp6k9ePs4ylj4+pewcOKMQbZIhX2tsS7X0LMK91tnYsZFJoGmsGSWhlXwTQVHR5
 2YyMwUOpG36PPRoSJ2gxMIUKYlVrPjTj9ZybtfFvijCUmdt0eMbt6c31t5iLy/ypzxoI
 XjdsigIrXIaExJdF4H8p4qnJ3zxQ8hdra0XAIGKeJQ0dqAH3EddQVKNr2ECqP0NpgCa3
 cZhEPVuT9gNRy2B5RSPsgCpynBe25fEI2Ul5Bd95hx+z5+xVCwSZnXkqjYk67+2ckMGt HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9xwxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 09:08:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27587vUU010195;
        Fri, 5 Aug 2022 09:08:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu354fgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 09:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuSTprWEb13lqGnMGP8SjnRiduj9yo8RjxOjIJq1iZvAp82B1XEHkC17Voe/GeuR9he+twWArg2DjBAB7KVJVMaeKOf2lyeJTeNPKoNo9tADy/Tyr1E6CzK1fcz69sbA9ioGkTPdacDSyFCTNisQaXZnces1BfbBYI4alg/h3HdrTGrghPYcuBd4C+fUjzjLkm87fsAxo3uPhhLSrOkNJNkvDSS1ei6KQ44z5eW53iOVOXL9M8ZaWjin6884GXf3PKfjyh50KrR789onTsZWaZStErtLT9OqYWliAlum6S453iOIRSL0AFnYcXkzUr4RBGwdA9H3l6KH1aEtKGmKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI4i3EmkfPiHq4Hr9lATGzwZ+IbA/XG5UcAAkjCjhyc=;
 b=h/dHemhFUxNsTAiZ8k8BeHO2UG0V63ZdVRq5HXU/JoAikFRqTPN6gM7nZs+K+tYSJdtPj311z6Odf3xbEoab/DhsKApLUKARyC6n4h7Ln0W3FZsxMtb7UpBkFOEphXLTblyMWumFrGf1Tu9Anfe89lI1TiT+4NmCQcv+6Vwm0G1YIv2lT0LoWVLHuM4cDTkY/fa7YxfRbGBRvaE+kHasGUHv2Er5jOmM3hgQQF2ytZkgZd13jcKmSU/V5MUq5GeGfV3r/jtEbrEkhTHRUznOwPzDgM17ZqyTBL0+fk6djcJbQhV5tLj3EQ8i6AhBmGtEw6WtygER/yHVjV+BQ2xLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI4i3EmkfPiHq4Hr9lATGzwZ+IbA/XG5UcAAkjCjhyc=;
 b=E+jQHlJk/WKDnrDwJwuF/5zmr1j7jHw5pf1iHXgHfZIwIDfF4fw0/dAqITSpJOo5ba/olpkCBujn/RWE4ETxAgGVZmv0trCBxOSFWKy/O/DDazsT8VHYthM/+Z2Vw1lIPtn8VX2zAHkRc4J45z6PkgeSyBazd9SYbMaTp13AKog=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5458.namprd10.prod.outlook.com
 (2603:10b6:303:138::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 09:08:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 09:08:56 +0000
Date:   Fri, 5 Aug 2022 12:08:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mikulas Patocka <mpatocka@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: drivers/md/dm-writecache.c:1554 writecache_map() warn: inconsistent
 returns '&wc->lock'.
Message-ID: <202208050301.roHRxc6O-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46555cbd-6488-4a33-437e-08da76c21fda
X-MS-TrafficTypeDiagnostic: CO6PR10MB5458:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEx5qpIXFY6HQxt5r09Yd70wUVKPZYpD9tE7ifRT4NulOIsgwekNsTj2hi9MzznjRiqgFOMMdsJqIzPC33/KRqM2MkMHALSZMgxu9UeGtLjj7MuKAB02NYJPiTJoN7vSCdadxvGPG1PqZzvqvwXCe6SHxKBE8eeoT3wUVNtkh8GMoTxHpFjm76YRJxQyUyS8xJA7pj8gIObeHVR/R8S9zlN62FLjywCiYLctC8Ayub5GzJx+7aDQ/TEDA/q1q93aRCg+I3iLz+ijm0KN14NeG49P7jE/Wj+48w5tmfJdoP71pCp9FTia/mHCswyxCji5W8Ys89/KDkG3V1flO7vB04CvLOTHTJoKC8qqgLi8NPDOA9oNGxBM56otByfTR/hpZYT2IMSO8XYtKPYoL937HZAZA1TNpxF9dWWMcZKnH1SwOOUS+bol5OkxgRCJoNCy17rLkmyVX7hKJohSX0HX4yd5wk6TlZjkBQWqXRp53XTCPdImq/GjjU8Gy7Bb8c7r2Nu0vCV/UWGaNRC6av6Zz5RE+SGSv3/fKnXi7sRt0aCrsHru+aB3N8IDdQlfg+T5imO7qduKzcbEJtGM1OL7k7EZ2xrCBS5BmcUU99UEhOC4ZYEZIb95fRBd/1wLObkwyzLPu8+jS6GKngLUCSLxmSpF63qncdAHjJPZVQockB2JGp3yZirUZRiLzNlKdgwrPlwCn44R5JZFZau0XwQWYeV5iBCmvmEiMYz8Q8XQJ7PN5yCf4+nGLG0ocnQR/BslUp/v5g71fzbemLRZ8Lp0wVLkiAnGG6quqvYvx7yXEyAgAcRHrQ4HFoR/3E6h2SKRyOLIisnZY5dgz8FKBH8UaWlvdDrXMZnmNzbN8P7qnnmVzKWoK/XoUyXsyf51Inlq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(366004)(346002)(376002)(38350700002)(38100700002)(1076003)(186003)(83380400001)(66946007)(8936002)(4326008)(8676002)(5660300002)(66476007)(66556008)(44832011)(2906002)(41300700001)(6666004)(478600001)(6512007)(9686003)(6486002)(6506007)(26005)(966005)(316002)(36756003)(6916009)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbGx1zh4MsVPGxxcA2p2t/xvYerTTeA/LEJl05REPYh5TYJyXl1ETHGyb8w/?=
 =?us-ascii?Q?21HzwdtCSvV9BiVyiW/kCBSoeC0atNW2u4R3v0/zEIxOCjADvcsvjTUWTAhM?=
 =?us-ascii?Q?2hFE0H9DNH5G+ylZ/ZC7cBqq3u1ruCPB8Z9ClvGOcTl1uZN7/U1FZMyTtAmL?=
 =?us-ascii?Q?TxQiOxurVgjx0Pm4gkGW8ymlRSFrdkhu2SY+P4dTFQaNmZE+/aNfGLJs4MZ7?=
 =?us-ascii?Q?2s8jaJG9uIH904g3GsijfyCBAWY2iUGOW/sUsmgDrWNIUuNtCTDuTFft8ACL?=
 =?us-ascii?Q?ChplYRz4yPYjnvqxHB0ThhJJfJlTrPbwIeWGIM4r5iQ6zkYB7yuqd0kpR4Wg?=
 =?us-ascii?Q?6+hEci+vH6hMA7sz4IsCDm3XUxkhVhee/lyaRCrmVunTtw7fNE/VxdJg+W3F?=
 =?us-ascii?Q?pnyy4Q77z6cWvfOrCa8vqP1ZSbms4sXrz9zdGPQBtBT+0hLVkJADXjht28/+?=
 =?us-ascii?Q?BlUG04c29Tu4NUmm/cEyl1JVBeDPyoI8RMPwU7hKorM1/W1/+aw4UUWBEIYD?=
 =?us-ascii?Q?FA87Q1ZOD3w0IqsaJJpLu8GvIATVynme2sl7VGYqOU/W3h9jIt5/c1DewgO1?=
 =?us-ascii?Q?CnI4RlVXmRLVTSOO4IvGjSoWpKuGCfv7/NfupHljDnl6x7+reTG+qn/hCHIH?=
 =?us-ascii?Q?0FEmaUbMDWwNZpa22jn6sWwtw2VtJJFZgwLlSYBjtaks5TOCiN20W+liJ1NR?=
 =?us-ascii?Q?+zTepwPI4TtqmhvAWFrCw06KKkm9xnsbHxgfCwQSMhs8QIpJIBITjvx4AtXb?=
 =?us-ascii?Q?S2oV4lYQYKmwfxN5UciNrHTNii6mf03efjy9U85Z1CmxNUwk2iPscG4XioNZ?=
 =?us-ascii?Q?NIx9Gqe76oKod96wjwSBaVaAmR/LWZV6ncTIJdKec0tdHwq3/eEYOfz25eiz?=
 =?us-ascii?Q?BlFxrpBEmlUSP7OHYYLB/qyxuIpgk824n3pXExZCpO2bD7JXB/U+iWy49Hqj?=
 =?us-ascii?Q?GOtYcczQ1rUJ7uA5zPcaeZbcdKbMRYOihFK3BmQzw3qvyqlJTO5B9Sal7bqy?=
 =?us-ascii?Q?3OWZ/NTNv2gZKZIDNR1/J39hYkr9eDRJJ/8p1ELpR+XNXRXtDgUyHCJXgnwz?=
 =?us-ascii?Q?JYlfWyAkqodaxD2SBwgeW2zwxCfwJUsslFFnMwk2cKCrXFpU06FB3wqJ/zDt?=
 =?us-ascii?Q?DB3cwqeOp3spRhyUMSp87eHRmIJq0FjdB06HBcsbrGluJmENgkug4zBCfmub?=
 =?us-ascii?Q?hkvu9gmnE4SYblJVywCWcxKI89uklGm45xdkKv3FRcbTSdJads7fx+NT7cCi?=
 =?us-ascii?Q?9sc4aPvFLWcalNOY0yOy0cdQ0HZXZ+Oo/Zn8sK+B5WpUbzVq83JbkZledVVg?=
 =?us-ascii?Q?Dt1Q1dNFvii6dpaMmZ9hpZrgRbzyEOpM5+P1Mq86j1Rb+GmHSYgFhbiqUSRe?=
 =?us-ascii?Q?ra70KT7D7wN8QIV0oPipnOZ5HpaYET/RxT0N/QPzMRO9stH+6nNQ37spm2tU?=
 =?us-ascii?Q?Rc7mYxSESrAO3FwnvBssGHIdlSZ34yiO/75WMTMWvAmKEGNfDkSf+UBi2dvw?=
 =?us-ascii?Q?9UaypCAkpuu0K8IRaEeJj9S8jFoVLukd6esYZ/SbIOfUKJ+0BjswVW87dTI8?=
 =?us-ascii?Q?bhBh5RVU4f5IJsG+ijbdM3oPOYFWvbYkPvaQYI/XyiVeGdNG1bom23f34iru?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46555cbd-6488-4a33-437e-08da76c21fda
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 09:08:56.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chuWL3fDoz4YrYSoiKDF/oeG8SstNtJK2zI6S9J8yZwfWn6fmvQKq05C4LExAZ3YQKmvXdCVt084T5ltFz/gtFbuNyWcmKD0pQGanlsu6GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050045
X-Proofpoint-ORIG-GUID: MLPSMzjc_3Wsz-3UiczQ31GRGF2g3QF8
X-Proofpoint-GUID: MLPSMzjc_3Wsz-3UiczQ31GRGF2g3QF8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
commit: df699cc16ea5ef93a917676dcdd4376e02860ad5 dm writecache: report invalid return from writecache_map helpers
config: arc-randconfig-m041-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050301.roHRxc6O-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/md/dm-writecache.c:1554 writecache_map() warn: inconsistent returns '&wc->lock'.

vim +1554 drivers/md/dm-writecache.c

cdd4d7832d51e0 Mike Snitzer    2021-07-12  1484  static int writecache_map(struct dm_target *ti, struct bio *bio)
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1485  {
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1486  	struct dm_writecache *wc = ti->private;
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1487  	enum wc_map_op map_op;
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1488  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1489  	bio->bi_private = NULL;
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1490  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1491  	wc_lock(wc);
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1492  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1493  	if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1494  		map_op = writecache_map_flush(wc, bio);
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1495  		goto done;
dcd195071f22d4 Mikulas Patocka 2020-01-15  1496  	}
dcd195071f22d4 Mikulas Patocka 2020-01-15  1497  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1498  	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
dcd195071f22d4 Mikulas Patocka 2020-01-15  1499  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1500  	if (unlikely((((unsigned)bio->bi_iter.bi_sector | bio_sectors(bio)) &
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1501  				(wc->block_size / 512 - 1)) != 0)) {
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1502  		DMERR("I/O is not aligned, sector %llu, size %u, block size %u",
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1503  		      (unsigned long long)bio->bi_iter.bi_sector,
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1504  		      bio->bi_iter.bi_size, wc->block_size);
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1505  		map_op = WC_MAP_ERROR;
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1506  		goto done;
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1507  	}
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1508  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1509  	if (unlikely(bio_op(bio) == REQ_OP_DISCARD)) {
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1510  		map_op = writecache_map_discard(wc, bio);
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1511  		goto done;
48debafe4f2fea Mikulas Patocka 2018-03-08  1512  	}
48debafe4f2fea Mikulas Patocka 2018-03-08  1513  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1514  	if (bio_data_dir(bio) == READ)
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1515  		map_op = writecache_map_read(wc, bio);
48debafe4f2fea Mikulas Patocka 2018-03-08  1516  	else
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1517  		map_op = writecache_map_write(wc, bio);
15cb6f39dbaf39 Mike Snitzer    2021-07-12  1518  done:
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1519  	switch (map_op) {
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1520  	case WC_MAP_REMAP_ORIGIN:
5c0de3d72f8c05 Mikulas Patocka 2021-06-28  1521  		if (likely(wc->pause != 0)) {
5c0de3d72f8c05 Mikulas Patocka 2021-06-28  1522  			if (bio_op(bio) == REQ_OP_WRITE) {
95b88f4d71cb95 Mikulas Patocka 2021-06-25  1523  				dm_iot_io_begin(&wc->iot, 1);
95b88f4d71cb95 Mikulas Patocka 2021-06-25  1524  				bio->bi_private = (void *)2;
95b88f4d71cb95 Mikulas Patocka 2021-06-25  1525  			}
5c0de3d72f8c05 Mikulas Patocka 2021-06-28  1526  		}
48debafe4f2fea Mikulas Patocka 2018-03-08  1527  		bio_set_dev(bio, wc->dev->bdev);
48debafe4f2fea Mikulas Patocka 2018-03-08  1528  		wc_unlock(wc);
48debafe4f2fea Mikulas Patocka 2018-03-08  1529  		return DM_MAPIO_REMAPPED;
48debafe4f2fea Mikulas Patocka 2018-03-08  1530  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1531  	case WC_MAP_REMAP:
48debafe4f2fea Mikulas Patocka 2018-03-08  1532  		/* make sure that writecache_end_io decrements bio_in_progress: */
48debafe4f2fea Mikulas Patocka 2018-03-08  1533  		bio->bi_private = (void *)1;
48debafe4f2fea Mikulas Patocka 2018-03-08  1534  		atomic_inc(&wc->bio_in_progress[bio_data_dir(bio)]);
48debafe4f2fea Mikulas Patocka 2018-03-08  1535  		wc_unlock(wc);
48debafe4f2fea Mikulas Patocka 2018-03-08  1536  		return DM_MAPIO_REMAPPED;
48debafe4f2fea Mikulas Patocka 2018-03-08  1537  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1538  	case WC_MAP_SUBMIT:
48debafe4f2fea Mikulas Patocka 2018-03-08  1539  		wc_unlock(wc);
48debafe4f2fea Mikulas Patocka 2018-03-08  1540  		bio_endio(bio);
48debafe4f2fea Mikulas Patocka 2018-03-08  1541  		return DM_MAPIO_SUBMITTED;
48debafe4f2fea Mikulas Patocka 2018-03-08  1542  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1543  	case WC_MAP_RETURN:
48debafe4f2fea Mikulas Patocka 2018-03-08  1544  		wc_unlock(wc);
48debafe4f2fea Mikulas Patocka 2018-03-08  1545  		return DM_MAPIO_SUBMITTED;
48debafe4f2fea Mikulas Patocka 2018-03-08  1546  
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1547  	case WC_MAP_ERROR:
48debafe4f2fea Mikulas Patocka 2018-03-08  1548  		wc_unlock(wc);
48debafe4f2fea Mikulas Patocka 2018-03-08  1549  		bio_io_error(bio);
48debafe4f2fea Mikulas Patocka 2018-03-08  1550  		return DM_MAPIO_SUBMITTED;
df699cc16ea5ef Mikulas Patocka 2021-07-27  1551  
df699cc16ea5ef Mikulas Patocka 2021-07-27  1552  	default:
df699cc16ea5ef Mikulas Patocka 2021-07-27  1553  		BUG();
df699cc16ea5ef Mikulas Patocka 2021-07-27 @1554  		return -1;

This only warning only happens if you CONFIG_ the BUG() away.  Hard to
tell how far we really care about dealing with impossible situations...

48debafe4f2fea Mikulas Patocka 2018-03-08  1555  	}
cdd4d7832d51e0 Mike Snitzer    2021-07-12  1556  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

