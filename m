Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43E251D1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386567AbiEFG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEFG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:56:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920866C8E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:52:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2464QGTQ018680;
        Fri, 6 May 2022 06:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=6D3xsnAKwQDb9Sv2nj6SjN3iLo03SLsGX6uYlzytmzw=;
 b=B9++Rr7VXfEL/JtM+rKVtxrs5LOKFl1kPrg1gB9wDZODo8z8QwGNS/pl2BFMNg9y9pEd
 XC0/lyXsxqBo0oH7M6o64QMuhdcxnNmYJohnJx416yj7Cl7EUqWTaGDVFORnd7xJQEaR
 uGZbK6nUq2gxGKu3CPRMSgttNeZXoc/65G1p1eSSNb6YSF9e+xrmNdQlTEWdcICoRhJI
 060bA6N4XDPDYrN6MHKpxaAEUiw25r6xl+QiBgvsNK4XEK9LfpvKkzTd6nVIPam2NLhz
 qaP109sMh8OtG9fz0DewYYCOC8iIZ5cnXa6U84cCnyPrun0wiRjtapPIHJYxlzErGLoO Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwntdceb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 06:52:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2466ocOF011858;
        Fri, 6 May 2022 06:52:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus9007tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 06:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt3qWyhqIFIhWPVhqE+Y91S+z9DaNstWaEfuP9PGjR2gzldcJUhXdngQ32nviWOgbqqbKQWnvG+DtUCm1wSKlLsmVWb84R9cshDRULXotob2tbSOmRErrZHuId5W7PnRBTHadpcZJG1Y07HaQ+n4tpD3E6Dry4tkuDR3YLAUb9YqeucuQoUn7yS9zeg69JaQ0fQhk4NrYc79oNQygpDX5PNG6bJwildIW2HdbTGsAkqCyhPkYmtj3t51BUe5snlj6DXgOyxzvZ8HilXqJ3gljRtH4Hwz1nJbj0RxEH1lQN9Jz+b86fV8gHpeeH6yaLU3omIOSSlHjeySb9zZIm2Oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D3xsnAKwQDb9Sv2nj6SjN3iLo03SLsGX6uYlzytmzw=;
 b=Hevy+zUBJNRGs/LR7pU+Sv9NjUxVQQNtO1FM1S2wVWBnsG/ZivXVu08CQlCH2+UbllVi6WVcI67WhOBP2uFI2hEJeB1ZF0zaJ2IdLIu/JteNbFgwvI/EOucAZCY2Q6boWY4/4KdTlS4/oZcU3AmySiehkNsVklORlKN+wqmnH7ifobP77Vj4ccaxaqdtQ+E4xqsURBzZjIrXex5kO4c/YgE2aZSdbjq3IXHm8qEVql5mPZOS8cI7auOzXV6wjIH3syiwVnr3o40YY6/dXP0wjxl7vwEVUVYONwQVhZ1r/m/BmzD5kDw9543AHb8txdhkXe4jieyx7l6+APjy/LhWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D3xsnAKwQDb9Sv2nj6SjN3iLo03SLsGX6uYlzytmzw=;
 b=Zuq0e8X6kbIMLrfSqzxjELj77zGa7/vv8yp+mmJMcMH6BFfEKUHWDSZQxSizVgC3t/7sBSGsBK4C0GeZ0V2dcFV40a/6cjIgsufsd0K1Jc9RUzhkuehBW3TPw7GPzsBUjrjT25LqFnMDAYfTgDU6Ox74fNXInlcOr/qDRPH6CTg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3747.namprd10.prod.outlook.com
 (2603:10b6:a03:1f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 06:52:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 06:52:42 +0000
Date:   Fri, 6 May 2022 09:52:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Chanwoo Choi <cw00.choi@samsung.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chanwoo:devfreq-testing 5/5] drivers/devfreq/governor_passive.c:190
 cpufreq_passive_notifier_call() warn: variable dereferenced before check
 'freqs' (see line 188)
Message-ID: <202205060340.kwfOSVud-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4106d5d-86cd-44b6-3dbe-08da2f2d0441
X-MS-TrafficTypeDiagnostic: BY5PR10MB3747:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3747EFBF459DF7B23C299B008EC59@BY5PR10MB3747.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbccpN+wT69DmxyWmEUgdWvkp+qq2dc1pYiItdMYKFCEUIG6d8s74Al4v10jhpH9/vlj5W+6021GfSPO53jFRrtzz64FOjpt+AfWgnk409+/SJoHD1Wup2hfHy4o0e81qT8KIl5zjpVCqx+5WPzerj9alyv3lFYApZzz/ymRw+FhD7fpIVEPKqQ6/GkNvWAGeR/osDzJ4d2GhH3TflnNVcuqaRNHQyk2O/qCX/lqPYWIWean9InY6rb6hTXeq+N7qum04wJOI/FnaOqw5ketOc0vK7WJe5DpXVXEHxEeG/oiFK9a2i5fI4uUvz5g4/Y8L8quqC1VDPfw+wxcmW7zEPYFoPJIZt+E4zMsE1/XjSOIoMMXdl3ab6O0zIrReS4eiImMBMzgq/ojFBxe9F6cUcz/DsVZT4lNdN2pYrXtC3ddIJPXoPY7DJopHmRDc6taYIltbqruvtWEtRFdmeidMwOsRzKVXetVGQcVQx56HmFbcBqAl/sDv7jMsG48MK70Co4MVk8HJO31Y70tUD7flYVq39OPsnccvIj9TiOIuz8jcnrDOFOzPDceUOO7/KSfbWrkyZ8aJDXDtiv35+PaY63MFoem4obOuMUrKpoXfbAAvzTqTzKPX1OF0YtdGUJONlxnpd4TdPxC61JZXjLR40lFG7SejnbgNWmnnoPKa31fG+HwuEQ5nlw1IXJvufiAjz7pWc9xWG1U06yVawbFW5aeH5JXSO35CvSkPorswqmzV1KfnrdQ1Ob/kftzCBEQG6Bo7UrzzqOyQ9XuZNYgnakb9oCdPqdKQLgiNEXtfJcRZwQOA3nyjI3goI4gBjlZVG8yrDPr/TykfYIlezapmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(8676002)(6512007)(66556008)(6666004)(66476007)(2906002)(9686003)(6506007)(26005)(8936002)(5660300002)(44832011)(966005)(6486002)(186003)(6916009)(1076003)(66946007)(316002)(52116002)(83380400001)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GlwwHUIDU/S+j9brzAG9GuXZAyIXQ94gZV3J9zT0CFTLk7xZ2+X4EKsSaVGD?=
 =?us-ascii?Q?PutoFIHhltAvK3UwNd2LwiWCSW3LeEJcnAXutujr0JqFuvEkZH6hNBuMHaql?=
 =?us-ascii?Q?OnqH7UThGWtlXfWiH9dbYSDamH9334FmyV+vq7IqyTCMHz1PHcgv4LkOlfph?=
 =?us-ascii?Q?yAcmr3rESlsA95kFmqKczUWpZDQBwzfZkSUx46UwTLE0jrE9/jPwvvn/1Q3U?=
 =?us-ascii?Q?Z/xW5myatypFwturU/DtW5VxdwWvcxSdfJNiKiXRElr44KZ+fNFSupLj6qDX?=
 =?us-ascii?Q?F9+VtID+hTAk7UTpkET7VlilobYm9o4ubv3SVSp5tbFdVqJDdjyxSowd82cL?=
 =?us-ascii?Q?WurmiyDPT7kgmMI95f5sQlo9hp8LtI9LTJAag41zzxAJoUuK88qP1jvA6IXa?=
 =?us-ascii?Q?oNAgbGAMD90avhLCjS8rTabNNiKm19sFixd7XGJb+/itH2jURz/+iEndzFMq?=
 =?us-ascii?Q?Wa7RIlK/hDFzgPYOFCtXlLZgsHxp0+O4ZLDwdUJDwls7ndhbuXgh95Cwy47T?=
 =?us-ascii?Q?Za192d7EZ0rkPBF0o8x8NWapH5Hq7R/J54mbhOGnAEOsjA6i0Zebqk+rYziI?=
 =?us-ascii?Q?+92V08bIi2Gf8uu5avjUPsCuhHrRrxJzYw147x5XrN/d5KOhsDKNbUXaJg+6?=
 =?us-ascii?Q?3kqpYkJA2JUxks9wTcd3ExvevwHhZe76piT4AWvePKK77WIXmACEqJMUsf1P?=
 =?us-ascii?Q?MH7gTciepJPquy4pqN0d+YqGQbKPji56TkSSoWVjKDtbjpHEWzOl1SY8Mknf?=
 =?us-ascii?Q?UmydjQ4dUjjdJAw2L32y2aRwUV+OIC+asTJGMKEaTawjM0mWoEjdDfWFI2S/?=
 =?us-ascii?Q?AntS13b9G2XQTgRRqtwvx2NUmvNb5gBSdkO7tWxqThEikYkOky6nYIXG7zIf?=
 =?us-ascii?Q?2Ttt8uQY91gaAieb+DFi+MFy32E9s84Juba7UzVoWZWbyKWyy/+4miw7TAZX?=
 =?us-ascii?Q?3t+sKRj247HmC7VMG8rZJZHoiZhV9d2XPiLWuVPNrwqcn4++R6C4kywt4oUB?=
 =?us-ascii?Q?ghn7OPL/p0oFrdjSMGXGtwwa60CEykQU5M8M5TrZP1cWQEnH6DKtc//HIeBr?=
 =?us-ascii?Q?o5vV7CjB05OfhdaAZ/FqLFFoMVBGmjPYROtssF9Vz3RHFvOlxOEHJKrYPjJx?=
 =?us-ascii?Q?/aPM2hnErcu+b5ElsBXgxEvBP2Qz96dohamj2Upw62QJ2wepRHppYpuZcEN+?=
 =?us-ascii?Q?Df8EAFCHWBdTAgNs/LNxrHXV3AC7l6bt194KR3MaNDMMCYll119XjTWS70Hb?=
 =?us-ascii?Q?CGsHfeHuJmPIAhFEoGKogT9+cvj5z4Yu2Zxpi7qNu/iWfL27xrrpBH2Ib3vf?=
 =?us-ascii?Q?xNFhvjpKURdvzkjcnzaF7cH8PSTVJWuxLbYVv1Iq51sqXPffWFL1XOQvmHSm?=
 =?us-ascii?Q?jMpY35oU/XcWdvvO05xxx/pSvHiW9iE1e42CHa1MnouUZRwP+wGE6UFrHnbi?=
 =?us-ascii?Q?A0253CwBsgT4JWYl+Gg+zHHzJxlX4PpMZYkTwF5xfxjX8Xrse6ZDL4jY2HNb?=
 =?us-ascii?Q?ikz8k6rxFmBQ974SQ5cqn94tuJNJZjqTVT8Et1JRJTD3RQxSoZHZYHBV44Z6?=
 =?us-ascii?Q?O6T/sDqKe0HjhyF+HOublASBUDNx1CveRNyrL3nIsZbHhWVajduiCTAXQ5ks?=
 =?us-ascii?Q?a13jh6UEk2kzK95RZJFaem4a/2Iqvaf2NBBEh5Jn5IE0He/XqJSwl7DGKedW?=
 =?us-ascii?Q?OwMp6ADJTFq9kM24UXWKlTznSJcAbTByp2BB1ges92cdwwbLZX2um915DnpU?=
 =?us-ascii?Q?Wv1y1dXdTUpMUQneCHh1W0qjlOgPZ5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4106d5d-86cd-44b6-3dbe-08da2f2d0441
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 06:52:42.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrvHtglxE+33/dFVlyvqBXE+F2zPo8qZgdtSFCEJzb0u6ECd/E+zRoMbOTCUH2ScelEHza9RUuihRD4LcWFx5cEqaps/4mmE6lo/JfIme6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060035
X-Proofpoint-ORIG-GUID: bUFVcZhE06clGDuBy2EN1xBKqRBRRjsF
X-Proofpoint-GUID: bUFVcZhE06clGDuBy2EN1xBKqRBRRjsF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   f8605f8ed725beedd71e89872e49178b930250d4
commit: f8605f8ed725beedd71e89872e49178b930250d4 [5/5] PM / devfreq: Use cpufreq_policy instead of NR_CPU
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220506/202205060340.kwfOSVud-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/devfreq/governor_passive.c:190 cpufreq_passive_notifier_call() warn: variable dereferenced before check 'freqs' (see line 188)

Old smatch warnings:
drivers/devfreq/governor_passive.c:315 cpufreq_passive_register_notifier() warn: possible memory leak of 'parent_cpu_data'
drivers/devfreq/governor_passive.c:379 devfreq_passive_event_handler() warn: variable dereferenced before check 'p_data' (see line 376)

vim +/freqs +190 drivers/devfreq/governor_passive.c

009cb1af01de85 Saravana Kannan 2021-03-02  177  static int cpufreq_passive_notifier_call(struct notifier_block *nb,
009cb1af01de85 Saravana Kannan 2021-03-02  178  					 unsigned long event, void *ptr)
009cb1af01de85 Saravana Kannan 2021-03-02  179  {
f8605f8ed725be Chanwoo Choi    2022-04-27  180  	struct devfreq_passive_data *p_data =
009cb1af01de85 Saravana Kannan 2021-03-02  181  			container_of(nb, struct devfreq_passive_data, nb);
f8605f8ed725be Chanwoo Choi    2022-04-27  182  	struct devfreq *devfreq = (struct devfreq *)p_data->this;
009cb1af01de85 Saravana Kannan 2021-03-02  183  	struct devfreq_cpu_data *parent_cpu_data;
009cb1af01de85 Saravana Kannan 2021-03-02  184  	struct cpufreq_freqs *freqs = ptr;
009cb1af01de85 Saravana Kannan 2021-03-02  185  	unsigned int cur_freq;
009cb1af01de85 Saravana Kannan 2021-03-02  186  	int ret;
009cb1af01de85 Saravana Kannan 2021-03-02  187  
f8605f8ed725be Chanwoo Choi    2022-04-27 @188  	parent_cpu_data = get_parent_cpu_data(p_data, freqs->policy->cpu);
                                                                                                      ^^^^^^^^
Dereference

f8605f8ed725be Chanwoo Choi    2022-04-27  189  
f8605f8ed725be Chanwoo Choi    2022-04-27 @190  	if (event != CPUFREQ_POSTCHANGE || !freqs || !parent_cpu_data)
                                                                                           ^^^^^^
Check too late

009cb1af01de85 Saravana Kannan 2021-03-02  191  		return 0;
009cb1af01de85 Saravana Kannan 2021-03-02  192  
009cb1af01de85 Saravana Kannan 2021-03-02  193  	if (parent_cpu_data->cur_freq == freqs->new)
009cb1af01de85 Saravana Kannan 2021-03-02  194  		return 0;
009cb1af01de85 Saravana Kannan 2021-03-02  195  
009cb1af01de85 Saravana Kannan 2021-03-02  196  	cur_freq = parent_cpu_data->cur_freq;
009cb1af01de85 Saravana Kannan 2021-03-02  197  	parent_cpu_data->cur_freq = freqs->new;
009cb1af01de85 Saravana Kannan 2021-03-02  198  
009cb1af01de85 Saravana Kannan 2021-03-02  199  	mutex_lock(&devfreq->lock);
009cb1af01de85 Saravana Kannan 2021-03-02  200  	ret = devfreq_update_target(devfreq, freqs->new);
009cb1af01de85 Saravana Kannan 2021-03-02  201  	mutex_unlock(&devfreq->lock);
009cb1af01de85 Saravana Kannan 2021-03-02  202  	if (ret) {
009cb1af01de85 Saravana Kannan 2021-03-02  203  		parent_cpu_data->cur_freq = cur_freq;
009cb1af01de85 Saravana Kannan 2021-03-02  204  		dev_err(&devfreq->dev, "failed to update the frequency.\n");
009cb1af01de85 Saravana Kannan 2021-03-02  205  		return ret;
009cb1af01de85 Saravana Kannan 2021-03-02  206  	}
009cb1af01de85 Saravana Kannan 2021-03-02  207  
009cb1af01de85 Saravana Kannan 2021-03-02  208  	return 0;
009cb1af01de85 Saravana Kannan 2021-03-02  209  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

