Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51159BBA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiHVI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiHVI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09217AAD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:29:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M7xvcB018889;
        Mon, 22 Aug 2022 08:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Af42y77JkzMWv+wCbb7jXo8kggHOuTjD7/FfZEZ8Cqk=;
 b=Lke5C3GvaOx6JE1ESMOU3dz/D1V+bHM321oxFyK+lLFVNDKntyWwmRAZ6M+v0u6uofvI
 CQgTuGVoaPCsmUgIGPalqoJ6bQlGiXwsfwUvEP+oVJgFOZkysn+75DZ0eqPKxxs3UovQ
 Rp91P5r6IGwciFu2+XX8IKu/nNNRcWcZjUJ1fRs+ykNWAh2MKyqO9FsBnwUpNycWXCxV
 xcz5LImL+6C0sI4G3U66kUO7bxalXnD3JZIKLtnSWiklyYIYahxZM0jrjGPeSPAAs7Kp
 8BkzkKMjUJUG0OXCt6D5TQLkp4DV2y6GoyA6wmnfH0fYYx6ShnGt9OfDpflcGEPMYgc/ UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j45wbg2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:29:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5U28t038092;
        Mon, 22 Aug 2022 08:29:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfrstc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:29:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRJ9oYSE5YE0l5MlM/OwS1jXuBx6Adj+hMubuPtox+j3MHypLKzLj03vxNugsaz1hgJFzAqy+9y3afaj4gT3jQd8ccLeT8oRb1xXTRIGsR9hY6Gv5VoU8vDInEEN0RIffTVDagwBCUOSjQNaY5P/YwtF3AFW58EVPjSdL+0C2IsSbWlwSCaiqWsw/60BlC4+Yvd/BaBQHMMXRNWNAXpsJmms7L0L2XB6OjBZEgyveuc9LOv6BmbbdHgrdhrBGFcSKOWslo52uinBLZWI7l0sKPM0F6SRASYuYA0Bclbbk6f/ALBBePOKiN8xAHu4kaItA4oNAE70qYRoBe56yEAYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af42y77JkzMWv+wCbb7jXo8kggHOuTjD7/FfZEZ8Cqk=;
 b=HTjcbLbbQxXzkgMWnbSALMLCLOrYwytLCQ6Dg4n/Gg5vwcbqXxa8wTAoJtbZN5RuzNXRGqBgPqzTqlI91bWpHIkRKTOPr6MzUNSTrl/8tv5AaMnoNlTYoKKqpY4U5cLKrle+1IkKYSTRYinjaU1eCbw3A3/pXagGmY/HSN7+n5LYwbFpLETvMTQOJJhYwuzX921YrOXm5lEAyBe15qz9FtZ4ku5NaBU8DbhxgG8+I84e2R7L+7L8RsRFVM3LqPUkt6FJT/RCbF7ZJ+qw6ZpglBNKs84YXLrhcyZO8lJffdpCRxjacDXRazMKuh62psF5z6CFPnMYa2ev19HgqwukiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af42y77JkzMWv+wCbb7jXo8kggHOuTjD7/FfZEZ8Cqk=;
 b=LHNekQAcesePTWi8zKqV8FvOWGdjHNmEvieU5ui0P+svsfOSejhsQ3+46mr+C/Cj0TSdIZ2vTozs813Qf6Cv4MydRqJdrqyUYIRh5vNZNcbbW6jMyfqbhGyyWvICHWl2Vhxt0PjP4Cq0iEnPno+XR6cnNDpsqnf2AcOnZt+5mTA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4903.namprd10.prod.outlook.com
 (2603:10b6:408:122::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 08:29:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:29:19 +0000
Date:   Mon, 22 Aug 2022 11:29:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1948
 dpu_hw_catalog_init() warn: possible memory leak of 'dpu_cfg'
Message-ID: <202208211344.YIwVJkR3-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18525894-5981-43fe-58c8-08da841868ad
X-MS-TrafficTypeDiagnostic: BN0PR10MB4903:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7RBF0wBXJ6qzCYlIs0atYJ0RA5bZN0PN0NHe/i+lQWKfW04KabG+4AZISHMDd4cqJ4SDNtZCYFHVe7Ghvch8247cdM4yLUlly2807Dfrs20cyBoISy0aWmnvDFwp5NL/2oGz1mvAV0SEptMHabsbfGz0AdYclngGZxi7m1wMo+R6Ye/IvFnFSF749/XN+QviybqUILxPS0epiSZO7FmH8sH1raxoNUWY4idnpfTbe5KB3jQsYni8EfurE54eoZKNygto2cC1xJLx+uqnfEAQQqisRSiC1vCEJHvZdmfNi9JWpiacWi0Z6wR+ipDHMVSW2Sw7lZ7nWaTuwckSht8GlqyC9q0lIvnmmhIzgGt68+io+SnzEaroLxv8MGO2FiFm5ZOlMNWtIY3eC2D5ND3B6LWFwosuPI96fGEvSRdQigrb7KQtsHXne+bnxxCJGavxSCi2wG3HNhp1duDynPnhbYA+2J+9ppOrLlbfitx4RpSC39uvWTR3LVCLiUNwF/C+H0957fbLje0vXuCbPnKlFVYHP2iozF0GKqXvY/r2popAJgH0QXAvIE3OorXV5YuvZSh3iDWokBUuUKF+GbB71GgVuL36l4C3yjI2oRqHjUw0BdjqZvDHUxrOsD3qXZpDSzq6rUd8UgNrCXSGKW3rMb8v+KGgN8NFBteSspmb9lQ1rOwjYvQDRJw8m6+Y3z85rsDegd2J39kPkvCkG6fWKd73izp4cAWeLbl2MDihNSCCucahqN73S0MBB4rJxn0lb2QBygnnPtGHs/sz04Mg5lji5j0h3iXoP6VJy/hSIUKqMLNvSWVPzs3FfLfYASZZgvJewhPufRJ7WUK2rftWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(41300700001)(6666004)(6506007)(966005)(6486002)(478600001)(1076003)(9686003)(52116002)(6512007)(26005)(83380400001)(2906002)(5660300002)(44832011)(186003)(8936002)(316002)(6916009)(8676002)(66476007)(66556008)(4326008)(38100700002)(38350700002)(86362001)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OOphC4BDFnZfcjDKRRBtJOZDMv6w8ALrVdH8zhKqwdeYi5ARoLQ7Tq1dwW4/?=
 =?us-ascii?Q?EQV/jPs/7PoOO2WrHR+2MTx78rA+bdc55tau15KX/VwCmd8kV/vLBurasyyM?=
 =?us-ascii?Q?qUnL9FtJoBEfYonaFjQJ0iberNVB6O4dlo/KvR3iId044aEgkXDMsZksNfOj?=
 =?us-ascii?Q?DluJl5X/wiTGyUG8sLwBkc6w9hPKftgxL5dfa/Gh0hcc1wA3Xmi/QbSLSuis?=
 =?us-ascii?Q?42SVB98Nyaa5pMeUULCnNAzBs9ljz9npX2qvX2HCbtv1SZoQXW7MoPWBZPzt?=
 =?us-ascii?Q?BMS8icCNNzIBfTDGA6Flnaj2oHvQnWcI3YaD/5o9WofOlMOplxubbvdlU1Bp?=
 =?us-ascii?Q?TtqTNHRXPYPPTPJqVK4ho8eDu9FdDaX3fW9jdlq2kKmmnzjUshBTZOfeDgk6?=
 =?us-ascii?Q?kr4Y7XIreluSFPU27PDfthFHmEPZkRRezGUwMkuwQwWk3GupZiMxajQU4sMq?=
 =?us-ascii?Q?lSQX01w86vrbPeLu9sL9p5SHsIPXSahErAlpquJ699gUlQopQSbE/lNZ6Shq?=
 =?us-ascii?Q?SGdMj7g8CTCtNM1BleeEqWDZ9sZsFL2FIpZfctpBaL/iMrW42KSRT6ehljKk?=
 =?us-ascii?Q?FcXyRHgxnym808tVyDyrAjo29a1jPmDOT/kfumgJAkujNX2EG4K+N4j5ACDB?=
 =?us-ascii?Q?tRHx2Xu6jrDD0Xy8DhI5Kdn41Zh3GxMLfDnLLZyg6fpncI3z7QK8EfgOqntk?=
 =?us-ascii?Q?nnacbbQsFJgGOYq6MLx5qe8uhh8xJVzmvq7ESAV+cy0wZwFH6YG7zqMEgxNU?=
 =?us-ascii?Q?DWNw6IDq6tAC5e++z3fnnUgSIoqmBg4ymqIKgQwO4Z4c42fV4DhH+2HM6keq?=
 =?us-ascii?Q?4Ek2tLnLrohNHjjEziAB0atbFpdAmM7M8PIRcjVwkE5hToteiMs+mDTW43O7?=
 =?us-ascii?Q?v+A/zWjaTbyX3wEUSApjXzhV/Rahv8DZh9o/aAaTnzc/14HULxoEBy5i1oqO?=
 =?us-ascii?Q?AlSXEfQ/S332ZYIYcj2+XVEyPSUA7foomQBsEqiRmHX8ZEM+PCNbYn7+k/VA?=
 =?us-ascii?Q?+je/zPt7IZGvJh0/Jepig6ofty7QHNL/Fan6i+OuAaPoL9YQMNZ0iyC0DXE7?=
 =?us-ascii?Q?EEAvP7IZ+JAtQSRPyODcxCP7/qAXWtqxFO6KqbKtlh5F73uqYFAL8drekILe?=
 =?us-ascii?Q?fmTC/j/ExaQwOjilERJBZ+JrrdiAuY9w8CUjLVd7SqPO12/fyH1650uyD8TR?=
 =?us-ascii?Q?livXS6pj4VkCGy4pU/+uJXn78iVW/VE0YPvyITZ37HiJagZmTH9gsBV5kaDN?=
 =?us-ascii?Q?4Yczcb8stSA8MKZ/TLEBcm/71C9fu3BItZVSFNCtdJeW5LVfJOMK5oRCeOHY?=
 =?us-ascii?Q?jfU/aqT1wC/ePwqT+rPkHOiu7L6KfUR0Ogfq86/Dfh4t+Zi0FuWls17jxKq0?=
 =?us-ascii?Q?fQPmynpaJzOi4NuubMkD7pZD+l4Cx2OvwlQUT9YFpPxl6TvDb1l8oPkiFMxr?=
 =?us-ascii?Q?pjDdgorzHPaEc2vSc6qQ/ZOAPgQ7YVKlJcAfEM3fn04JA25jeSPuR9G/QoH9?=
 =?us-ascii?Q?riBRcj7ekd9W/LgkBYnWkKB1nN7s3Cepcyl2SSyPHoMQacyC39keHiFzEwOk?=
 =?us-ascii?Q?kmS9q6lOewUeojgMvg2kLN+Wac9Xaj5cz2t3VJzFoQinHrNvROPgTBqdnDZt?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18525894-5981-43fe-58c8-08da841868ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:19.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Cz5Th664SOn47KDJFk9hvZGU3TeI3lOnS9i3qCxJb+MTyd0hjVnYtzee+kYkuQYx6IQqhX+kTYJyBc5K7xi8T2pSzjdSx4arAVkYntiU3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220035
X-Proofpoint-GUID: o3rb_rq3K-4N6PAYjkCSiqh9VUgoz7QO
X-Proofpoint-ORIG-GUID: o3rb_rq3K-4N6PAYjkCSiqh9VUgoz7QO
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
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: de7d480f5e8ca6eace02a725abdadb9ea13294ef drm/msm/dpu: make dpu hardware catalog static const
config: microblaze-randconfig-m041-20220820 (https://download.01.org/0day-ci/archive/20220821/202208211344.YIwVJkR3-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1948 dpu_hw_catalog_init() warn: possible memory leak of 'dpu_cfg'

Old smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1953 dpu_hw_catalog_init() warn: possible memory leak of 'dpu_cfg'

vim +/dpu_cfg +1948 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

de7d480f5e8ca6 Dmitry Baryshkov  2022-06-02  1937  const struct dpu_mdss_cfg *dpu_hw_catalog_init(u32 hw_rev)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1938  {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1939  	int i;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1940  	struct dpu_mdss_cfg *dpu_cfg;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1941  
de7d480f5e8ca6 Dmitry Baryshkov  2022-06-02  1942  	dpu_cfg = kzalloc(sizeof(*dpu_cfg), GFP_KERNEL);

This allocation is never used

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1943  	if (!dpu_cfg)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1944  		return ERR_PTR(-ENOMEM);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1945  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1946  	for (i = 0; i < ARRAY_SIZE(cfg_handler); i++) {
de7d480f5e8ca6 Dmitry Baryshkov  2022-06-02  1947  		if (cfg_handler[i].hw_rev == hw_rev)
de7d480f5e8ca6 Dmitry Baryshkov  2022-06-02 @1948  			return cfg_handler[i].dpu_cfg;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1949  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1950  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1951  	DPU_ERROR("unsupported chipset id:%X\n", hw_rev);
3208496720a180 Dmitry Baryshkov  2022-06-02  1952  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1953  	return ERR_PTR(-ENODEV);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1954  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

