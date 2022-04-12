Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDFA4FD3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390118AbiDLJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355576AbiDLIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:08:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABEC7D;
        Tue, 12 Apr 2022 00:38:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C5I0qv029741;
        Tue, 12 Apr 2022 07:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=OsyD57IUF2G4b6dlbeAN8GeAT7/eSM+jMbxqmrWDAG8=;
 b=F7gYMOIgidMZaz8GI1c/ZzDjl/0kDTLaxnSoxPucuWM3X7tCMFi5u27JjmoamOTuDx5Y
 m/U4XVOCulu6ASNOetF//J67CKKZtsQL/bs07JAN1zfK7IgqCJ8awyjMxfY7lbSHmsf9
 oMhl+XpnIF2rT2EY318UU3FzJteIXy2wLrzNDVifq8FRkcvnxoKidsE8yrRSoUUKXdaK
 TaZ1ECLub7I/wJ/HHT0OHqmcmS6EWOscU0v/pyCxZi9cVcHOwPXhCk5G+PtQVC5hHMI4
 tCIxozNX7KzVdN7jjC+CS6FZsXi8HbC3FQhzijPgzj1wYPhJ+UOFmgnhdv0oJ33PcjUu 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd5rwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:38:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C7PjUR034390;
        Tue, 12 Apr 2022 07:38:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2m93w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig0iVGpJCYaTV8kEET8e6loFwX+jXI4yTW5XauR894LtEuRhhrP7GoSoMkK0uRwZi1nJXNaj/fXCgrUX/22ruV/t1LBBcIgJSrAt44xo5NnMuieiQe0AJpadcEE7tIr9XBApXxoolbpSa1iQnge+fx3DlsEXeD1x/uEseOrHYvKDCFPapNh5mMYiQhx4hZWL+fg/XQKOUNsGatTKIIqG9ZV+yYEeSw5MUH0MufVbh1o1YySSLJKtEam45uQoBnqH0JQ6NCZh3NpqTRqQGQUpgSSt2uzqsZu3y+Vc0H6MITED5e7rrsQc6LAUxFQ6pQA73oALgQmHrdMHTqVDzrxD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsyD57IUF2G4b6dlbeAN8GeAT7/eSM+jMbxqmrWDAG8=;
 b=Ycheioe4bSbdLaozh7bVgNvF/AL3pPdoIYWbPYzPz4FxAdiN9SEzaGPcqC+iNQ2+dapR8pGvY0arszkJ40KWE4FgRHNzDTyOtXSxf8UH7t0RPtIMseKV2Wf4ken5lpg2dXKOnKa5ItRBHBqdJN1PuN/txbVX29floKq08ZC0ybmrFhGkKdI1ks9vyxKqKv0FrZ3uRotltuRwXi1DMNquCKwYg3UyuQxp2lNKZuQOTQ7ShgQ2JhRzzAY8GCnmeto02hF72raI4R6joZ4sXwgVckxHbDVvUJdyIQqt9ov3CmicRxGQop7J2e+YcF8jKApqu7rFI3KM46D/frOczqMg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsyD57IUF2G4b6dlbeAN8GeAT7/eSM+jMbxqmrWDAG8=;
 b=ImY6J/3wFTcsayL01toPiI+QMFWb0pwyOY1odh7T00sVgtbeZSNR1i4gepnLXH0TPIb12RH9lqLXrb8IL2LrQo4DVDl/zfB+cTw0Og5fUlKHomdfwPQl4DWmAfNmAujQefC2I0TU4hz/JsmUBzvbMXRe+WIWvYHupXW1EvQt7EM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3875.namprd10.prod.outlook.com
 (2603:10b6:a03:1f9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:38:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 07:38:35 +0000
Date:   Tue, 12 Apr 2022 10:38:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jagath Jog J <jagathjog1996@gmail.com>,
        dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <202204121411.snZVqiMy-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411203133.19929-10-jagathjog1996@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8223a6fa-2347-4ebd-001f-08da1c5773a1
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB38751F229BBB28B93F7EF7C98EED9@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1Or708Xj9wc9lEYPc6px8SqW6KEoOtxOxG9VKPT1c6xImMRetkYPM11WLjYtbfiOJusku1Qoy51lZ5/h42VEWt550lXrMjPBs1sYUffQbigUCW8lhk0eFNEIdh6kIoJaPho2nBhY+45Aq9dxbWiiqZaxQoqtXpKwc56Ey8h3DwlrmxjBRqyf8HWtixDAd9jgmfLEsSUIozgnsRczAyh7a36qZKf2iuBL4ru5caaD8cNgyOKT5ky3fEtA4sA/90jsy9Cttk4Yh/aiFXonTUrqJF88pAhpQ6e89NI0UY+RncnRFzJ08Nlet8R8ZaelxJw5hGw0KWjgqWCKQKg9tXO9KcXCQTStPgdUuQPqIzIw/tAqxUr32Jqz5K03UJRkNKQKo2UyurXNHfh/yNY9XCZqrVdZmVuNeKT/a11TdJw+IlWwh+eYQQjWr+x8CQE5bP75mzElIkicWkCk6b3e+eNAWUC2eqqN2bDth3eDYiJP0viLLaf/m4pE9VMf3+uMHpmek2+Tb7/AKow3hx1Sq/BMUZdVMH69VfsRqe8VNq4FT2ZhbmU4etySKAt1NYHD5l+fgAroo6hdgHwuGjsj8RCPHK4hs0KSDKmqnli2VbGTAy6KoigIvdEBVijl41be7cBXfE9Ez1ZyYsXSrxS2P4k3H+OWwH3RIQcmyXC9uFG1Yi1OGhrNbPd6cC+/zUcFFTRQZ+ShmOp3giAae747gb7H2Ln4HsDsh3FCfYa2mKTegFmNYSIYis6tvRiX4cD7kIC/P7jGKwQtI1NhKLR/d6M1pB66MHY0RQ5yDeRhFxXGjXrN4ElptQ2bJJRB5JcDj2tNaXsPLvGw+3yh7k+WSU7+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(4326008)(8676002)(66556008)(44832011)(5660300002)(86362001)(8936002)(2906002)(38100700002)(38350700002)(83380400001)(6666004)(1076003)(26005)(9686003)(6512007)(6506007)(186003)(52116002)(508600001)(316002)(966005)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+Ucu0M8zgpBR7Gs6BrvOigPbbrCKSks2EB44Zs+EMUVF5EYXvyiz7548zwC?=
 =?us-ascii?Q?jfEJ8qstqjJlp/fSGIMJrn9GHFCPtqkdf2I0XiQ2ECMT5Rqlrlw+v4hgFnuG?=
 =?us-ascii?Q?kBwWdB/gX6R09d6Ab1dUtSJeKO5iLmT6yrS77w6sVRF9PJqFoWktGbR0ipMP?=
 =?us-ascii?Q?Jpf6t113J+lHovJxipAI10INqoV+JtDtdZt4FxG1hhPm0HqhzBodQkD/R0jm?=
 =?us-ascii?Q?WuelhEndx1uiPgraYgJ7i3y2o9mKlhZLVfq2zaq1J7Pce2rH893cqhJOfIdj?=
 =?us-ascii?Q?RV5QnUPfTTHMxNdrd6C01UXfPGTghpQQI6f8kLKIFvfwBIZS+SaH3lbWpjCl?=
 =?us-ascii?Q?okgUq6GbTiH4Mq1waQSsnV00ecn4dNMIf7dLHH4nJ1qpo7EzZBUtoAiSKNxL?=
 =?us-ascii?Q?G0iNf3gRBcoQRIAU8jZwrK4NVTTlQtiptAyX7VbysAs1bh7uxtZE7kuddj99?=
 =?us-ascii?Q?WSbMnwwjzLJU8jBrrs+oEdMWrqrStS/enQAz8GAfyBVqdOq7pdDG8jQzgzlN?=
 =?us-ascii?Q?ystlF9SVf5xha8wklaf7GEriO1Zu6kLkjzQlX9anD99oCawDsWhXJXnhHtf4?=
 =?us-ascii?Q?gq2nH6U9owWOBoSWeVRhO7ijA9IVGg10kYVijhUNXyP2vorK8BdN0wMICqVB?=
 =?us-ascii?Q?W3sV/6AO4wnGRbQ7Xh/eu9wYL/eAqn+NoGmf1hpN2rxobMJBJAFHP2K3gWi0?=
 =?us-ascii?Q?mWUdBiiNnO4n9bbRDDuUXKN9gtht4VxGAGwbTw7DbbsT5xawch378qjDRv2+?=
 =?us-ascii?Q?HC7TY6CchzyrF42XeaP+OGSgiuuKGkLyhod0erqUMT+1DZc7R1vuA7713SmQ?=
 =?us-ascii?Q?RqEsa09rUik5ArDp4NF2m3/oNyNdyNsEJftTLGj+mxZ9y0j4768qp5zNfuYm?=
 =?us-ascii?Q?4eojYz0OzyyaF/ujsxfw8O2tDjfXIpACBCwobujSmpZl8KujIB2q3sBPQqHO?=
 =?us-ascii?Q?xbZxlRJCBSb8Uvdhjqjww7a0vksCH/gKPiRUi0B3AENZCjcLQHUfHHkZuQJH?=
 =?us-ascii?Q?KdP8982GfbVfg61pXTlpJr70QfjW2DPzVkOirXSvBbaWx2kotImWQXTSr7xw?=
 =?us-ascii?Q?Sxm+bbUFeiqRJikagPAKGnFTUeklYgVDnp6yL5MQruYBziO8FqVJxyNLYXtu?=
 =?us-ascii?Q?iENJiCWWSIBiO0nD+ly1RJ/j5NIcCvspp5j1lM+mL0YLO4mECnabZrvMToeb?=
 =?us-ascii?Q?eYTGWKzc2hQ8Tf1mI3vxtahoKg+hFG2lZdMa2DUsYdxakE+8zGrBupg6oFx3?=
 =?us-ascii?Q?NfD/j6Tdx2+ypVN6RNvJQOY2f+5j+KDYnof+VVrZIEpzMjEIl99ItxogeWvg?=
 =?us-ascii?Q?50G5d86vzcRsy5YKg8oH9/z3qEw24ZSf+KJKHF9JO6KDXd6wqUb5STh1O8xF?=
 =?us-ascii?Q?lpuwgND/6W/80Lf5IrS1mhoVyTaV2DyqhchXdSX/hK+0Dteb1+Mh2bMbC+T6?=
 =?us-ascii?Q?UsGYyyXeJ6zrHHcH4sbR6ymsoBK7gjemupQDvoFJfpXixDgXhJ8F1nyBJRCz?=
 =?us-ascii?Q?RhQmclxrPq/vgJLW9bo7qASKFbLb1svnr1RzPTD5VPy9Y9iuTS3lSgjM7u4S?=
 =?us-ascii?Q?8bhdCJYwhpXD8rzwnwJ6EB/HVHLLQxOUlv6exKZT8YGV4p5XgKf0+F93LyGN?=
 =?us-ascii?Q?rQs8SNK92J9VQHQ+E+EYpphf/THXw4JjBZriVBFs0yAKwt8BX5MhvhpjJ+6Q?=
 =?us-ascii?Q?AOgseSL+uHDr2qbaan4zc4JB/bShT3ENWDzV6I2FBC6y+AX+8jkmxgilS5BM?=
 =?us-ascii?Q?RrtF841weLyzwy0jpjnWAfwlcOEacmE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8223a6fa-2347-4ebd-001f-08da1c5773a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:38:35.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S9GMVJf+MUBUszGuIoxcedWWnTCNaRtqmH7/uxzzBbDM7JvpT2O6o9AGuhPxr3ABFWa9MOVoTmFsF93bEaP7pq1hn9k2Y5FlfFqtG49lrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120035
X-Proofpoint-ORIG-GUID: XipyNgmqh4IyiKFDUz3cxFrwiTh7EJ78
X-Proofpoint-GUID: XipyNgmqh4IyiKFDUz3cxFrwiTh7EJ78
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagath,

url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220412-043436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-m001-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121411.snZVqiMy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/accel/bma400_core.c:1154 bma400_read_event_value() warn: impossible condition '(reg < 0) => (0-255 < 0)'
drivers/iio/accel/bma400_core.c:1202 bma400_write_event_value() warn: impossible condition '(reg < 0) => (0-255 < 0)'

vim +1154 drivers/iio/accel/bma400_core.c

15ee6de45ed7a02 Jagath Jog J 2022-04-12  1142  static int bma400_read_event_value(struct iio_dev *indio_dev,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1143  				   const struct iio_chan_spec *chan,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1144  				   enum iio_event_type type,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1145  				   enum iio_event_direction dir,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1146  				   enum iio_event_info info,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1147  				   int *val, int *val2)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1148  {
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1149  	struct bma400_data *data = iio_priv(indio_dev);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1150  	int ret;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1151  	u8 reg, duration[2];
                                                ^^^^^^


15ee6de45ed7a02 Jagath Jog J 2022-04-12  1152  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1153  	reg = get_gen_config_reg(dir);
15ee6de45ed7a02 Jagath Jog J 2022-04-12 @1154  	if (reg < 0)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1155  		return -EINVAL;

Condition is impossible.  Also propagate the return?  if (ret < 0) return ret;?

15ee6de45ed7a02 Jagath Jog J 2022-04-12  1156  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1157  	*val2 = 0;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1158  	switch (info) {
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1159  	case IIO_EV_INFO_VALUE:
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1160  		mutex_lock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1161  		ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1162  				  val);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1163  		mutex_unlock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1164  		if (ret)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1165  			return ret;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1166  		return IIO_VAL_INT;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1167  	case IIO_EV_INFO_PERIOD:
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1168  		mutex_lock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1169  		ret = regmap_bulk_read(data->regmap,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1170  				       reg + BMA400_GEN_CONFIG3_OFF,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1171  				       duration, sizeof(duration));
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1172  		mutex_unlock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1173  		if (ret)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1174  			return ret;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1175  		*val = get_unaligned_be16(duration);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1176  		return IIO_VAL_INT;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1177  	case IIO_EV_INFO_HYSTERESIS:
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1178  		mutex_lock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1179  		ret = regmap_read(data->regmap, reg, val);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1180  		mutex_unlock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1181  		if (ret)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1182  			return ret;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1183  		*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1184  		return IIO_VAL_INT;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1185  	default:
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1186  		return -EINVAL;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1187  	}
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1188  }
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1189  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1190  static int bma400_write_event_value(struct iio_dev *indio_dev,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1191  				    const struct iio_chan_spec *chan,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1192  				    enum iio_event_type type,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1193  				    enum iio_event_direction dir,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1194  				    enum iio_event_info info,
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1195  				    int val, int val2)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1196  {
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1197  	struct bma400_data *data = iio_priv(indio_dev);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1198  	int ret;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1199  	u8 reg, duration[2];
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1200  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1201  	reg = get_gen_config_reg(dir);
15ee6de45ed7a02 Jagath Jog J 2022-04-12 @1202  	if (reg < 0)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1203  		return -EINVAL;

Same.

15ee6de45ed7a02 Jagath Jog J 2022-04-12  1204  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1205  	switch (info) {
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1206  	case IIO_EV_INFO_VALUE:
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1207  		if (val < 1 || val > 255)
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1208  			return -EINVAL;
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1209  
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1210  		mutex_lock(&data->mutex);
15ee6de45ed7a02 Jagath Jog J 2022-04-12  1211  		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

