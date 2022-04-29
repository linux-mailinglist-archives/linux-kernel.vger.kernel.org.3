Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F65146CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiD2KeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiD2KeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:34:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC325C64
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:30:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T9uOTc025802;
        Fri, 29 Apr 2022 10:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xI8rVN+t7Eme1am8QMkZT1rZ9HfFaFIGyoN3LmpYd7M=;
 b=02hH2EBWV5iOwqdWUGhcnk/Ux1cHYVHy+Df8GfMAkIwgprc8vesU6ueJ++sl4jC05qhq
 zKgO9mwhhhPXFivp/XcAV4OaFZoUv/LW/VxOle0CGQWxsVySW0RqHJhJQqNErSstdL0T
 kVQ+URBVNmYdKbZSrULdB4FpC44EQMBwE5v/0wp1l9KJ33iHFi4XyzxaDTAwKnlTL9Z7
 FXqBZ5vLQU3H1nap712KqmXY4kC8TK40+zjlOSmR6xZzJJe/RW6FY4FBXP+BFEtI5dkH
 2CiLLCU7TeFAYa4Ju0X+J6Jjb7OUMuPdGEzK9ZuO7VpA9Gav/f7tzRO9aQe/gpx50YlO fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mxgxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 10:30:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TAUZK0033589;
        Fri, 29 Apr 2022 10:30:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w7v9tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 10:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3s+z3wQLkoveGJdv+7usphapyJEkeHtQgykKt5JcwqPTA1XSw/PWw3+xo9q6JBGFlW77PFcxEhevuvMMUyHWeQQpQ8RkStsINOP6EMePuMdgEU+C8zoo3GlXN61I9z6Tt+FqGkw2E1PFVK0aP59THICkvELT/+cXdFd0Algtt+yMKNkw6t1Hng1G+AWlEL+x9XpOT4o7D+GcuVuSi16XNYjq1p0VrlUB5dVMNsONQgmEd1Vo/JyI1XCx6yIwh8HOPYKtOnsJhn9OwlTGfnZZFag4yypEcXYMncWMffrjEBmAjh8vv+F9O7BiJLNsdTSAovPOsM0UPgbuRNpq6plVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI8rVN+t7Eme1am8QMkZT1rZ9HfFaFIGyoN3LmpYd7M=;
 b=J3NdATuG6jIv7QyinyK0lBrooFcyaIgl0Z2HYSgC5PlrlhVlqUHlFCsujhUk6vBfide8NtT1h22+NtSjMGS6QVAC6j7/ahAqIpI0dZJYRDuBf2WUikRAZGehvw/mmYXVRRiV4X77IKWNIcEK2x9Kx+r8+g/ND9MviaMEorCavJREpKVkDZ+Xgr+iXRDiTqY8DGe5HMSW5iNKl9XIZOIiQH4TIalmF/OWy+ClzvMba+RHO31h2VO6IvrplwqU82GyJsp8mUukNye7HElBixYdpR9Gf7W7HsK2iv7C3TdldO01tLYfDAIXx20ek17ockGJE/zX+KZdBim7O951/HwBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI8rVN+t7Eme1am8QMkZT1rZ9HfFaFIGyoN3LmpYd7M=;
 b=lBJGi/1caY1cAfRMb7Fc38jYgTDOsb3w2i06kN0iDoFZFlunpTsADV+/BfBlO1x+M2yVY1dQ2mn0SNnDMpAlkrfRIvY7MYCQnae4qCPyTdSyYJJB98Y13DooU0aXify/okF2iN3SqKJ/oLfierxtobmjF1j/PfwJ2/9Vl/oacbo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4674.namprd10.prod.outlook.com
 (2603:10b6:303:9c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Fri, 29 Apr
 2022 10:30:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 10:30:33 +0000
Date:   Fri, 29 Apr 2022 13:30:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Fabio Estevam <festevam@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [sailus-media-tree:master 55/60] drivers/media/i2c/adv7180.c:573
 adv7180_test_pattern() error: uninitialized symbol 'reg'.
Message-ID: <202204290610.SVJgr8qV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb8cf68-26b9-48e8-7f1d-08da29cb4a87
X-MS-TrafficTypeDiagnostic: CO1PR10MB4674:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4674F666B4BF73AB461948528EFC9@CO1PR10MB4674.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+WYfFd66jMBxwD75D2ebxm96DOT0yJNWrDyuuojEXZhSwKiI1gcA/Rij+ByJbrYqMNo9AcxqxHMXJFs59ew3/ugCrBa289zZMsfG57jSm4/FGi+tjZnPLnNhTmlCmbTbt/a20r0tJvZTvr4jzd+O4C3TwyUfUxB9Wmn8fRJCUnJt87mFKd4CTgK6+74LYukYlxURhtIR/4cBVOZghlR/WpNLaV3aczozjjFsCF5dsisjcSsveZJYj1HGlPcXz2ghQ9W7u3844jpzZjUf0U3Vd9fcMM3fJh0huKFkuNBb3dHsfDOb9i6+9MDWBiXP1sJewnwpo3cG8A1WMbUYp4kEEYbdLLBZbJf8g8Oh5fUnRWr5cOaEKeIOoA4I+g9nhZPoksq80K6stlV+jUEL2IxgbhsCG2KvekC8KXwGGXa1LbXxyW7WCbrbulW5x0t46Fa6bPmcPpe02kjXdDSYFWpf3sYtwhBXtLlFT93G2sLkBh04cmYocdQAUQ9IhiA4JSkFqqMrnvYK6WQTCJe49E3H5Iy5xVNoff5Jonby5IFt+2cMwY9hzw6w2LzMhxzolzH3nc0W8rbY7THwETY15G+XoeGZewD/lF0pOrk4V26yrRObJwBjOBUnWRVpfzIqFqM1dcbVCWrSGgOHgarrkgqSSbUBLA01lQusXn5UnmXBuO2dACKAFL7WIuCU7ep0yg+gCPeZgLSuOlLlI8ssxjRToI55GCA+pxagRohzOfiv939mFdpze8er7IasXRymoSSF2fYD33hYRmUtZTD0Fd9C2/3NziY4dPpqfPsgpqyiFHYdj8nFj8PJfkOUUjQp/65EoQKSAVZxvQJUwmY/WDPFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(6512007)(9686003)(26005)(1076003)(8936002)(2906002)(5660300002)(6506007)(66476007)(66946007)(66556008)(4326008)(8676002)(36756003)(508600001)(38100700002)(6916009)(966005)(6486002)(38350700002)(316002)(44832011)(52116002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0JJqrSQ+rVTbzFkZLL9Gex5ayD2c4VQ0GI2Yv1C6rKpuD+JRjPhDKfmZgzb?=
 =?us-ascii?Q?yIa7PUDOhstnehIIdsbUzgabx2F7YioUOjjOH3K5JkDJ03Lmw/hwJn2uU30I?=
 =?us-ascii?Q?Mq1QzFJ7IYy71YLvYUSBx61hz0OVF39mI3YjWbNodhOiZusgQctPTal0yZqV?=
 =?us-ascii?Q?lKIIb86BRynJTE4GvC9B02pmGNEk/rFH6Bwv3y8BUgYC3W4VjBesn5Rq5LWM?=
 =?us-ascii?Q?MQsQjtzEBMDwDOojLC9oZBaOkqSNI5DJ8tltO6snNv+WUs/OtDqGVuevMPmC?=
 =?us-ascii?Q?mBrDuN/bXuvGYEwDJep5ruZRK3NJym4mgb5OTZuCdhNM8uzzNynzo12eO+Aa?=
 =?us-ascii?Q?+h90yzjbJutqKvDCGZwOfQUPqc4+4pz4rAxTdwsjR9PYp3fw/8cqngB/l+gf?=
 =?us-ascii?Q?H3DZACCK7kqkmlkpU2fNCa+BBL+Sn+mcEkrl0i//NCV3ubqeVMkvyWspg9tD?=
 =?us-ascii?Q?HfdOjXCuRss5PtR+lOF/Za5B//Qb30lMU5+aq3XTlHqTiYnz+V3ICAQRUg4c?=
 =?us-ascii?Q?TIE3B2tyakPDccaAR9kpJSalTS3ZkPwatFNlA8BcCaVJMwHMl5VVc3fNmgw3?=
 =?us-ascii?Q?5qDpdMn7VebBxTPvM7WIERxeGe46MQ4fpXXkV5yoFKEf8tRLxdiEaM54pegE?=
 =?us-ascii?Q?vjGrPQvBFAx038PtRJaMpDCc/IihGh7o85lZcRVu7I86zh7K62nzYC7uUvxy?=
 =?us-ascii?Q?x3MTbFUiJ4d/TvcTg7WV8FQZYR9xh+9mF47j9P23qcpa3DAw9915p0tAjLTN?=
 =?us-ascii?Q?jwF6pMrJX/v+eSAwzWHBS+PRnAzFHWUDsmd0wuWtIn5dHCq8G2EBIz3xMoSO?=
 =?us-ascii?Q?vPVHucD3CTM8lNPJ+TDYKKq2Y+tdvtWUat4X/ZzFI54xYc8Y++GQ9+Nq4nb7?=
 =?us-ascii?Q?Nv8MtUL66hIS7X6JvuJThqv2N2wboyON4ls50eXLvCfKoqZBMFuRkQaMW+Is?=
 =?us-ascii?Q?zahqwCO86clI5HAl4lsxhsrjUJSPNZoJKklKL+dJ/KbCog6z7z6O+iiQ58TN?=
 =?us-ascii?Q?bHzZ0alnxM9MLeE/vbtVKQ8gXLHPAQ3A8y/5BkKR3TdAaEzRPazZqByGC65h?=
 =?us-ascii?Q?bYL+1OiMFjfnWYS59rtE6jylYqGlyTe+Ua6004D6HDWZrthKK8Ms99SfFcx3?=
 =?us-ascii?Q?zWzCncy/3RsaHmckosGBQz9NqJNIO3E3snF3Wrhf6GfNOLRqOT9pMQ9bQFAi?=
 =?us-ascii?Q?OOteQaYd16RGzwrrASt+M3Dm0ErV6uJelK/EcBzl9cIS5TBObRqgtXZp6XJq?=
 =?us-ascii?Q?DzSqr8aOI2oA6DKuY+mI/GvEPfTVN0Kp9Qvv0y8pku8N8zNXbPhey5RFrWqq?=
 =?us-ascii?Q?xVfgoP6rp6tcIYLET/vIBcPAl/O3bRwl+1asP4bP9rfUCuCII/uFAEWI/Kbs?=
 =?us-ascii?Q?RF/6EHR8pc1zBLE7raThuobjky1/rZUa22jJABUX3VJ3D3sVwH/AyKogfgri?=
 =?us-ascii?Q?1n/tY3tQ0HLUNvyTOxJr4SUw72nDlSLqsneYFJ+O94h1Ubwa69X6sWep/yz4?=
 =?us-ascii?Q?EUg63WNek0Vf3xr2EsGQsyXndp28US443P7jUYs47SWvGi/Bgo/tccn/lEEI?=
 =?us-ascii?Q?JL96LlkbrbVgXq5x5u1h05g288002VPtVdh04+LzyFTJl8JOBrYx6N0I4Mrz?=
 =?us-ascii?Q?t5NNVWNL97Pbaf/njg7VYQUrW+ditfgGW/IKZmtqAGMYNBqPKQFKdfT6wDvD?=
 =?us-ascii?Q?B3PpJ33gWXjtH8SRJQqWV2fsTkEfluTZ56PC2yNs1dKYYLHIcy0irGcqcTQL?=
 =?us-ascii?Q?NsAzJx0FBauQ3q1MwMHOB5K3TofpVf8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8cf68-26b9-48e8-7f1d-08da29cb4a87
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 10:30:33.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur5bXnMaichmZZ5itTWc7a2i9SMhNMaNJrUeZbgt5Pu6HiHk/G/LGiIIMGt0Q86WPGRF4Jwr377YlCsZPqYsm5dZZu9EUGy6X6Q2/WtGeBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_03:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290060
X-Proofpoint-GUID: pb0nB3Hnm3DzL09nWAyRq6HMh2-vx3ll
X-Proofpoint-ORIG-GUID: pb0nB3Hnm3DzL09nWAyRq6HMh2-vx3ll
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   ea1280040a678f38a4ce6f1817933c04cfe74552
commit: f3b4b140d87dc7f256229f20a8d70429a7549aca [55/60] media: i2c: adv7180: Add support for the test patterns
config: microblaze-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220429/202204290610.SVJgr8qV-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/i2c/adv7180.c:573 adv7180_test_pattern() error: uninitialized symbol 'reg'.

vim +/reg +573 drivers/media/i2c/adv7180.c

f3b4b140d87dc7f Fabio Estevam 2022-04-27  563  static int adv7180_test_pattern(struct adv7180_state *state, int value)
f3b4b140d87dc7f Fabio Estevam 2022-04-27  564  {
f3b4b140d87dc7f Fabio Estevam 2022-04-27  565  	unsigned int reg;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  566  
f3b4b140d87dc7f Fabio Estevam 2022-04-27  567  	/* Map menu value into register value */
f3b4b140d87dc7f Fabio Estevam 2022-04-27  568  	if (value < 3)
f3b4b140d87dc7f Fabio Estevam 2022-04-27  569  		reg = value;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  570  	if (value == 3)
f3b4b140d87dc7f Fabio Estevam 2022-04-27  571  		reg = 5;

Just write something like:

	if (value < 3)
		reg = value;
	else
		reg = 3;

f3b4b140d87dc7f Fabio Estevam 2022-04-27  572  
f3b4b140d87dc7f Fabio Estevam 2022-04-27 @573  	adv7180_write(state, ADV7180_REG_ANALOG_CLAMP_CTL, reg);
                                                                                                   ^^^
Uninitialized

f3b4b140d87dc7f Fabio Estevam 2022-04-27  574  
f3b4b140d87dc7f Fabio Estevam 2022-04-27  575  	if (value == ARRAY_SIZE(test_pattern_menu) - 1) {
f3b4b140d87dc7f Fabio Estevam 2022-04-27  576  		reg = adv7180_read(state, ADV7180_REG_DEF_VALUE_Y);
f3b4b140d87dc7f Fabio Estevam 2022-04-27  577  		reg &= ~ADV7180_DEF_VAL_EN;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  578  		adv7180_write(state, ADV7180_REG_DEF_VALUE_Y, reg);
f3b4b140d87dc7f Fabio Estevam 2022-04-27  579  		return 0;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  580  	}
f3b4b140d87dc7f Fabio Estevam 2022-04-27  581  
f3b4b140d87dc7f Fabio Estevam 2022-04-27  582  	reg = adv7180_read(state, ADV7180_REG_DEF_VALUE_Y);
f3b4b140d87dc7f Fabio Estevam 2022-04-27  583  	reg |= ADV7180_DEF_VAL_EN | ADV7180_DEF_VAL_AUTO_EN;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  584  	adv7180_write(state, ADV7180_REG_DEF_VALUE_Y, reg);
f3b4b140d87dc7f Fabio Estevam 2022-04-27  585  
f3b4b140d87dc7f Fabio Estevam 2022-04-27  586  	return 0;
f3b4b140d87dc7f Fabio Estevam 2022-04-27  587  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

