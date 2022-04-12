Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5594FDF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353128AbiDLMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbiDLMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1AE2721;
        Tue, 12 Apr 2022 04:04:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C8l1tP028053;
        Tue, 12 Apr 2022 10:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=y5dG09weU4oZVbgKlUL5cBXNFP0fOjlHttvgMCgOZiI=;
 b=RSnHZk+RtyTdwvQKukCPLyRo4tktlq0F6R5WTFicIuzP3BtauSMMnOT43tClCvVzWtIt
 Lb5Bs9m2U+pgXQ0uc5jMzAvPHa/9ut+hrdeW1uD8W1Q3rFsUbU/KLkehRdiKNlLPWbNQ
 BEKIfP/So7ZRKA2NQcxw8pwINSAaKexXYmJTEDiwMJfswzItVzBI/R3ZObs+qwDPuE2M
 lZjv7OCew4+kGZa6MNNLBnQK+XqNujgOd1IYa0mpcJqPUd89rJPtA7hPRgNc4Mf/4k1P
 hn9tMxINdCdBPNP/4rXtif6gQaHhpdkex1SHbnvDDq/vGZObToaFFH0qCKei/vOzJaqy 3g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219x6aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 10:57:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CApKqn011000;
        Tue, 12 Apr 2022 10:57:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k32dv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 10:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3EGwGVKtjlsteaExbtuIguxkSYbtCLFxQ4N8z2kAQpsDRPp7GzSz1pjAvEr29JAo1hMperi/Hs4Da2PTfFSorYVJjtUZrARZeI+m044XiaCt09Wlcv7TUfAUg7XT6DX2U+EazPWzlC86Ng/ugPUWF+k+h9netrfEIDgX8oiF1WQjuuJa19+eSXLGN6WZuqFun2xbzFwU+nuOM22MN7GWE80BPdOHcFtx2TIR7MWZw4kOCN8rAK2jSsUGuKAWijnF00bIZbTm05ZUjwTpwyKCJWShMGupy6DApVPBRGcsn6j23FLYiP+QRI3WCDEB7yuFcPx+ZwfR6bL2ly4eX+ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5dG09weU4oZVbgKlUL5cBXNFP0fOjlHttvgMCgOZiI=;
 b=Bwa1whJ1NFIdru2lbb/WUYM5BXtMN18VvobUqfDjahCG3JCXoVPcmAtDZjlX9FmiUtTxi/4gqc1FpCPLR1TEyQRePdhBBbVS8/k4NmtJ7d4dHPLjd/9IpdQ9ZdB8rqQ1NrW5/L09RSdgMXCI8zI2QomyEEfMgtD9GdrHcJiJwN6qaGZpRi86ne+mhv6/M5uYf4aSef9RBDYjHiycP736AOZs7oaduJJatNw8CULaP7Osaax6yICX15s1vmAR6uMQ0KK5MRsNlQNIjKdWwl+e3EADOwEOl+ocAu8Cl/NdNoH2sOjwuGHLoFo1u3XxE3e3adJLwjUKFE2IADVmzJkYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5dG09weU4oZVbgKlUL5cBXNFP0fOjlHttvgMCgOZiI=;
 b=dd41DOt4sPKjDpg/Oi+PGHmXnPQ4aBRZxDxWnPMRuTj3sZn55LoZEwGMFSxi/YR81KlLsmrgZunQtd9CmhRF959lcKgKGYLRBkbq2PiKIaZ/9mJz3W60LDCsAXe4TR2Z4ghjfIJfqmnNGYIoXEUGT9GYPd6IU244lRFHFuaFYHE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2139.namprd10.prod.outlook.com
 (2603:10b6:4:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 10:57:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 10:57:49 +0000
Date:   Tue, 12 Apr 2022 13:57:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
Message-ID: <202204121856.LxK9kEyg-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 242117c6-1e2a-4c25-4289-08da1c7348a7
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2139:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21394892381FD7184CB61E6D8EED9@DM5PR1001MB2139.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OpnJiC8dtNT2L2KT2r5/3JR/JmoCzkQIpyrrjb5Xg2hhY7j9TLcHwCZ6JFLitISzRbnZ3lBAXnwPq/vlKmRC/wmQJd8rVpl3y2jPyiILFqHrzdeATpswWw26aZtS5+lHoOJs4m+XYBJAaqxdy3D7Pk5o0Z5hTTFPFvv8O9+QVkw5saKaKEDNQd6r+v73ZIxFqljbMON5tM1NoQFEpkU9BVAPxTweF43ODhOd3+hQuv6oz5yMHSzIRkI+w4Xusjkw/SVr4yX79mQw8jp85kZ8FIPpevnNNmschBxgPSvMSXHM4YeIMuN5dax1uVrL0aBlAQGSOJbQBg7WqxfiKaTg5L9WFmNgMu0c0dVlO09EmF1cPkPBHDbWStgMlJ658W6pCpEbJX8RrFaQ23PkAiFj5BCBfsKJVvHSN0f+KnFm8GYX0iQDGg6hBWvocaj3gc2o0cTz0FfW44kQlKBhtkuZHh7uuqVX19vgH09fdBa7NsCNk6IAGmeb0B2SHk/TItK4RkwpH4+tDxrNDDFmmOLFwSq4E4sYOmaDNCzBoGQPHTod/QKi0kNREPaSNrqyW2vzegcZVI4gudzzIpJ3VdSNPVcx/vLeXScVtYl/e2X7u7fJzsq0MoFe68SKlQ+NFfJx4LUY/x0zFS8bH2tAVdjz9MhL4XU47d9Wm5WhAru2zTnv6aVqZa/KSdv6oPJ/e4QKvzq1ZJKGpUhYOIwkVRJuPUnc8eDDCM7/eOn82c3MokZtSJSATDvBDPFvsDzU70iuegR3v8Rit7SG6Q011d762OiOktfxWwt3xz7DIyu1TQ76bRJkCRbiLdmRCQcyk7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(366004)(316002)(83380400001)(38100700002)(9686003)(66556008)(1076003)(26005)(86362001)(66946007)(186003)(8676002)(4326008)(508600001)(66476007)(6512007)(966005)(38350700002)(6486002)(52116002)(6666004)(6506007)(2906002)(7416002)(8936002)(44832011)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53ece73Ue5NvGzcePgjbuvdQlA3tKwg31pL5MgZBksKE41309XumMhkYwl59?=
 =?us-ascii?Q?rMbrSVm+kaiV5Z3bgo/OR0gMkdFewLNxnN/egJRNvFoipzJEZFFML62eNu8m?=
 =?us-ascii?Q?t19n8S0uYC75NJ0iOjpJ78uZmcPRapbPp0Jdp3PjoE3i2cXkbl8r8TK6ah0D?=
 =?us-ascii?Q?WZgA02V57mR6NBLu8b0PdFc18KghWI6yuyjRB5Ub3WrLPZYAfLte6PXXKYfr?=
 =?us-ascii?Q?vC3SfDBY9l4gCcaY0mM9In2HbBP3g0vU6crklvzn7SgpceMbumGvPdffqOw4?=
 =?us-ascii?Q?+b4J2otZc1HaXOaPgpLARus3dwDpUSc4IYgcuuv5iKPewXHELmAHJ6CF2dDn?=
 =?us-ascii?Q?+8p8NJkpxD6pRcfaj8Xx6ATnNWqaWMc7hKVVUPQ/JXI6kA4go3swmTG7VDpQ?=
 =?us-ascii?Q?a1aCprwv/XhfPgkjf3zE0Yy6mQhrNsZbwOrdxfXh7c7tPs12ZypdAZhv99Sj?=
 =?us-ascii?Q?Al4UOiZZmvxtiLlzcleKnAwVJ0rQN+v2mgweQgluRUzphcFySVZNzZIOufQ7?=
 =?us-ascii?Q?2ZmjSPISXPUOyJsbV1K7aEPrguf1lBQpxo09+uk6TmvnCpK7E4IoW4wCHRDW?=
 =?us-ascii?Q?xzvElyZkU7u4+O/5nXEWXCdtEqbuuytIcKYenqMJBMtqpyBpFgjYgHfL5OYv?=
 =?us-ascii?Q?vApFlGch8S147jeujsFgBqtNJZ9Dp+cmt3G8+mJ2LSuVyupCFRh9iFHoUTeV?=
 =?us-ascii?Q?na7Nv/UxgDYTpmshcwmvBVYBEBPSP6N5vYs7lar66oXTn8nbQNaSYmZtinSy?=
 =?us-ascii?Q?ZL+svLcm7do85KIhc/3IYTTgwQEk8NajF+ZqVrsUO3KhoW+jwyGgX+xY0Pi1?=
 =?us-ascii?Q?bvMAadpvXaGY2PpkyvFMOaHjQty7yIXP6WpO5pvPTRjfX3lvBWnONeRT8MbU?=
 =?us-ascii?Q?KMAggwLns6XohZTmchdrIciEl8uLzp/myuU3FqKpIVlrc0hkav844RmaqQgq?=
 =?us-ascii?Q?h4Md7oi22bmTEJHWmVKy4xlMDQblzR/uoiVKwMozjlqzGUW39EFn4J76zwFu?=
 =?us-ascii?Q?vgjEk5/B2OxE7E3bGylyL/Ja3/GS2pdqHK2aIcsQUpjv8Fqv9rKiYlJ1Am7R?=
 =?us-ascii?Q?5W5S70DlXrOAUodC1e3FuLA360MWzP4l4P8ST8t3+q0e930TdA2+R1Za9U9Q?=
 =?us-ascii?Q?2hMnQW696XK69GXQRnr6BCXG9KrPyZln0lYqMdhS1dAzmfIrufKHnb27MTLA?=
 =?us-ascii?Q?/C3cQafAD8XOEdwicCL4/9JAuosWh/RjUhG24AtB7MLw6wWkG86mDP9gJLqm?=
 =?us-ascii?Q?Lf+l8HK+FSLT5uw0SWTKBmW2dQB5W6+cZ179TwlWSl43mO3vmGmDmDIQYPhA?=
 =?us-ascii?Q?xKUdxQCLDn2CI2SNT8fFqoSvMHjjZUqUZOMtptUGD54osQapYQ/TPtZ+8P8y?=
 =?us-ascii?Q?LK+gTNB8oFFLP2doq8gsk8wxraM7ZhpeoBH2qxitkxEpKcSBAer+5u65SCiu?=
 =?us-ascii?Q?cPlsV7ahXKG3FTwLTEGFbmmjixSFgrRGAZRxWVknvb7GePY6TAOASoCoDWW5?=
 =?us-ascii?Q?onRIZMAX8f2dOW5YHalVrY8wrZLy+SDeqHAfOji/ZBQ9CsLOWaj9j7KHQJzX?=
 =?us-ascii?Q?ymAEGCd0tZBvb2FXeI2Qb5lhKWTvAB2vNGiH9LSFs9SVzvfMRqwl1Omkj0cS?=
 =?us-ascii?Q?grvef3biNkK+9tlxfU+KuzGh/rJeS46Lng6itFZT6pkuqg+6KaUrN8yAPi6t?=
 =?us-ascii?Q?fXQwFnAkhj0EBM353oQEcbi4j1KsBEChiyH4dL45YNi9PGt1T1OPjyB4v4mX?=
 =?us-ascii?Q?Wrq6cfTsRyfvtFCyiBwLB7oOVJXl0GM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242117c6-1e2a-4c25-4289-08da1c7348a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 10:57:49.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x65xCrLzeDiL5e0sp5PJo7jxjbwcCeirW4A8ckU0CTI3XQWJKsPGGS9PapEO7zZa642nWaS7V87NZ5XFSgx6e2BTJCsbJ8H/Pe86H4U6FOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2139
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_03:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120052
X-Proofpoint-GUID: yb1h2rD4dv6I0O77_g4QJHhsInr2h_mb
X-Proofpoint-ORIG-GUID: yb1h2rD4dv6I0O77_g4QJHhsInr2h_mb
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

url:    https://github.com/intel-lab-lkp/linux/commits/Aidan-MacDonald/Fix-missing-TCU-clock-for-X1000-X1830-SoCs/20220411-234531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-m031-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121856.LxK9kEyg-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/clk/ingenic/tcu.c:456 ingenic_tcu_probe() error: uninitialized symbol 'ret'.

vim +/ret +456 drivers/clk/ingenic/tcu.c

4f89e4b8f1215c1 Paul Cercueil   2019-07-24  337  static int __init ingenic_tcu_probe(struct device_node *np)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  338  {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  339  	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  340  	struct ingenic_tcu *tcu;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  341  	struct regmap *map;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  342  	unsigned int i;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  343  	int ret;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  344  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  345  	map = device_node_to_regmap(np);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  346  	if (IS_ERR(map))
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  347  		return PTR_ERR(map);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  348  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  349  	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  350  	if (!tcu)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  351  		return -ENOMEM;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  352  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  353  	tcu->map = map;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  354  	tcu->soc_info = id->data;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  355  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  356  	if (tcu->soc_info->has_tcu_clk) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  357  		tcu->clk = of_clk_get_by_name(np, "tcu");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  358  		if (IS_ERR(tcu->clk)) {
8c04eee82a9d67a Aidan MacDonald 2022-04-11  359  			/*
8c04eee82a9d67a Aidan MacDonald 2022-04-11  360  			 * Old device trees for some SoCs did not include the
8c04eee82a9d67a Aidan MacDonald 2022-04-11  361  			 * TCU clock because this driver (incorrectly) didn't
8c04eee82a9d67a Aidan MacDonald 2022-04-11  362  			 * use it. In this case we complain loudly and attempt
8c04eee82a9d67a Aidan MacDonald 2022-04-11  363  			 * to continue without the clock, which might work if
8c04eee82a9d67a Aidan MacDonald 2022-04-11  364  			 * booting with workarounds like "clk_ignore_unused".
8c04eee82a9d67a Aidan MacDonald 2022-04-11  365  			 */
8c04eee82a9d67a Aidan MacDonald 2022-04-11  366  			if (tcu->soc_info->allow_missing_tcu_clk &&
8c04eee82a9d67a Aidan MacDonald 2022-04-11  367  			    PTR_ERR(tcu->clk) == -EINVAL) {
8c04eee82a9d67a Aidan MacDonald 2022-04-11  368  				pr_warn("TCU clock missing from device tree, please update your device tree\n");
8c04eee82a9d67a Aidan MacDonald 2022-04-11  369  				tcu->clk = NULL;
8c04eee82a9d67a Aidan MacDonald 2022-04-11  370  			} else {
8c04eee82a9d67a Aidan MacDonald 2022-04-11  371  				pr_crit("Cannot get TCU clock from device tree\n");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  372  				goto err_free_tcu;

no error code.

4f89e4b8f1215c1 Paul Cercueil   2019-07-24  373  			}
8c04eee82a9d67a Aidan MacDonald 2022-04-11  374  		} else {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  375  			ret = clk_prepare_enable(tcu->clk);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  376  			if (ret) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  377  				pr_crit("Unable to enable TCU clock\n");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  378  				goto err_put_clk;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  379  			}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  380  		}
8c04eee82a9d67a Aidan MacDonald 2022-04-11  381  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  382  
e620a1e061c4738 Stephen Kitt    2019-09-27  383  	tcu->clocks = kzalloc(struct_size(tcu->clocks, hws, TCU_CLK_COUNT),
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  384  			      GFP_KERNEL);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  385  	if (!tcu->clocks) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  386  		ret = -ENOMEM;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  387  		goto err_clk_disable;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  388  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  389  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  390  	tcu->clocks->num = TCU_CLK_COUNT;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  391  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  392  	for (i = 0; i < tcu->soc_info->num_channels; i++) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  393  		ret = ingenic_tcu_register_clock(tcu, i, TCU_PARENT_EXT,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  394  						 &ingenic_tcu_clk_info[i],
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  395  						 tcu->clocks);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  396  		if (ret) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  397  			pr_crit("cannot register clock %d\n", i);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  398  			goto err_unregister_timer_clocks;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  399  		}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  400  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  401  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  402  	/*
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  403  	 * We set EXT as the default parent clock for all the TCU clocks
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  404  	 * except for the watchdog one, where we set the RTC clock as the
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  405  	 * parent. Since the EXT and PCLK are much faster than the RTC clock,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  406  	 * the watchdog would kick after a maximum time of 5s, and we might
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  407  	 * want a slower kicking time.
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  408  	 */
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  409  	ret = ingenic_tcu_register_clock(tcu, TCU_CLK_WDT, TCU_PARENT_RTC,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  410  					 &ingenic_tcu_watchdog_clk_info,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  411  					 tcu->clocks);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  412  	if (ret) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  413  		pr_crit("cannot register watchdog clock\n");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  414  		goto err_unregister_timer_clocks;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  415  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  416  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  417  	if (tcu->soc_info->has_ost) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  418  		ret = ingenic_tcu_register_clock(tcu, TCU_CLK_OST,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  419  						 TCU_PARENT_EXT,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  420  						 &ingenic_tcu_ost_clk_info,
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  421  						 tcu->clocks);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  422  		if (ret) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  423  			pr_crit("cannot register ost clock\n");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  424  			goto err_unregister_watchdog_clock;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  425  		}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  426  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  427  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  428  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, tcu->clocks);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  429  	if (ret) {
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  430  		pr_crit("cannot add OF clock provider\n");
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  431  		goto err_unregister_ost_clock;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  432  	}
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  433  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  434  	ingenic_tcu = tcu;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  435  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  436  	return 0;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  437  
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  438  err_unregister_ost_clock:
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  439  	if (tcu->soc_info->has_ost)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  440  		clk_hw_unregister(tcu->clocks->hws[i + 1]);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  441  err_unregister_watchdog_clock:
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  442  	clk_hw_unregister(tcu->clocks->hws[i]);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  443  err_unregister_timer_clocks:
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  444  	for (i = 0; i < tcu->clocks->num; i++)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  445  		if (tcu->clocks->hws[i])
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  446  			clk_hw_unregister(tcu->clocks->hws[i]);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  447  	kfree(tcu->clocks);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  448  err_clk_disable:
8c04eee82a9d67a Aidan MacDonald 2022-04-11  449  	if (tcu->clk)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  450  		clk_disable_unprepare(tcu->clk);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  451  err_put_clk:
8c04eee82a9d67a Aidan MacDonald 2022-04-11  452  	if (tcu->clk)
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  453  		clk_put(tcu->clk);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  454  err_free_tcu:
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  455  	kfree(tcu);
4f89e4b8f1215c1 Paul Cercueil   2019-07-24 @456  	return ret;
4f89e4b8f1215c1 Paul Cercueil   2019-07-24  457  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

