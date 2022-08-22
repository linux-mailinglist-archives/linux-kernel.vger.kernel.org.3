Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577459BA61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiHVHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiHVHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:38:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED632A719;
        Mon, 22 Aug 2022 00:37:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M7W9QY029789;
        Mon, 22 Aug 2022 07:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=SSazKvPh4pEQyUVWMX4PYKvlqn59cwbSaNc17ckWCDE=;
 b=HdPlFXH5qcn8BCS0y0lT79ah2qKMY+4HJ9g5ib0n9VHDG0lK2Bs+/2jNDhfKJAj8RxXj
 M8lFRBsuf4nMUFxW/XU+y/ywelx/O81BtWGYaM70Y3vRyhuuvjPpILk1NJ9vz7LMYMyv
 ATNVjFA3g2W3FX/VbsY+BfHI9H/vr22pv9TCgTgsP5pqvbE1JKF55cuJ4b0DWKHCIegE
 LgGyaxcQWSlPCCjGrGCiRagqd2eTh4nVE6cr2/7226lzAKJ8stUFlVfpiTmbbJAQieUp
 06JV5qAYQMxnOubk5bZfjwGnD4pPAeDpp+q0EnBiiRPYo91wd+XHJzScsZX4peqSmaiB EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j45g500f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:37:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5g2ir013414;
        Mon, 22 Aug 2022 07:37:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjcqb1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2oqlzsUpRZpSuy9IJrpOJVxwbCzbH7d/RNmxz1hfMJQlGDryP76ZbNnjl67/TZnYteomZJe9r8EW2EDqhQUGHfj2TP2EOwxbgxYYXR23ykaA7exxTna+AsXhu36Xi78QbVsiH4VWXypLt0cvN141HskhOATgTMsjfTUfx2O9JnJ0iLITmxejtAaUwHQx/E8KQTP5+015Sv+lDzV7jduO3pdjxrHhyijFjloF1Vs0Y3jFzaNDwRK2hYkGWvI4IATVGP9FX8JVEcDFhvOkKRviMVRRD2B1Du1dA6Rc0dyo+V6RoASkSUeDdfmecfuwxu0ID24kNh7IpHjT0xkOCs+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSazKvPh4pEQyUVWMX4PYKvlqn59cwbSaNc17ckWCDE=;
 b=FH0hyChVEka/OjRFbl7iJ3vjrSJ10YN+hrVzXOoiqSIYcSMFnz5tdWD4PNGjZLRvYGP23/BWK4Y7luODEL6fh3UupgaAEM4L6s2bIPx0Y5W4osv655lCJfjNC5+vn3i1dWssUEX3yVoxGpT0Lv/4b8RLtSEL/tJ6PL7wxQ9+a2A6Z4jCRzrZAC8qiUupnMvyIQSm/8//GcqBcpBWk78rhqhnAC5L/oCQ6mC87fAg3AtQKOg7oqFbda+ipLZswJ+qgepN6jrMfzJ1L28+HMDKF7NDVyu1yWMpRZVMaOO5Y50BCYLUmHc109UnPgrNPtX8G0EKJoLRjQKSmvVepnws+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSazKvPh4pEQyUVWMX4PYKvlqn59cwbSaNc17ckWCDE=;
 b=szVSyou4szOQX6VwmpndA0DTkuWA98v23abOHld/XU3akBDKe6l2sBeuE9bIoiWYzHa1rY8UdCsoVf2Kav6pQVHAtTMyStX9kZRmBpU7Pyd8XI9wS3DtIo6k9y8tsa5IjYE4y51PRMAwnZQwa3uk4aBufMS8vmd6U3oSPn+yULE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB2011.namprd10.prod.outlook.com
 (2603:10b6:3:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 07:37:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:37:05 +0000
Date:   Mon, 22 Aug 2022 10:36:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Gireesh.Hiremath@in.bosch.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Message-ID: <202208192340.m1XMlTj5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0042.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52a61d95-1f09-451e-d41a-08da84111c1a
X-MS-TrafficTypeDiagnostic: DM5PR10MB2011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlXQ4Ds+0AUuyweW/bsxKmojx4pCE2aku3XPWUSdWNykNvn5SyJOFyWuB9EKjM+8htF0dl/OSTt86EdYg8NxJ5kOX1jWnpBdi7jciE5AaToLnsZe5AuPl6LNKB2EZg8/lex5qPR0T8AfFB23sBT5JpzEeiEp2OI9CPsFrTIPPJizmorUBNqdP2hNSZzQko3s13+xQR4qmNDtrMiKVDqUIUgv1sSHDyoExPTnGKBuYG4xYt07go2G8p37eu4BKzvnrw/B54loiU50J7Yul8kCo80H0h/qduKAtes43aHl7pifZm65GlWCIyAI5mA77QGDlSDC6TeUODU7OeLBY1g3aXnxe7byHifZY3W+WqduICd0ylvwoKm45FWlAV1DXQbPiLgf/9+EPdOv+0URgEctwXaLtQt3ngp3lV6I5ySJo66uDLHxDnUMU520YkKmLAXBEmPXyvEHHTynumDWHYvcBw0qKBZsQUWZh81UV9+dDfP+PVpKw8ZQso7X8/LmIzL9kjPstKSHBszvjBnkLzPTtk8JL0nvmGNZTP3WKKkS7SHDMhJjF3iXYLUkFzUlN4DKtwpihWEGCnIB2LuKpEVtjj+FVJEja+xPnfKiToCFbmHvqJ8TJecqkjwfxrJY9cRX3+PHFfY52+1lWllFgfR8Jkm5tuW/0gEyKA0NPk8roTPk5wDPXEx8utNl54zqo9PE3m7g/0oxBrE2y4rs57VaY3A+iV8dXqRHoltrah1qAzUchYVJ9IqTxemTsrinaCUGHP+I/NdicKW7jqOn4TS9wd/B1yfnsyHl/m7b2b5W70PBGvFZ9uImsSrmwhjQG5IbERDvFvEKA4KFwoALu+zxE4LFKQOV/944Su60mj2Bss0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(66946007)(66476007)(8676002)(66556008)(4326008)(86362001)(921005)(38350700002)(36756003)(38100700002)(1076003)(186003)(8936002)(6512007)(26005)(52116002)(9686003)(6666004)(41300700001)(6486002)(478600001)(966005)(6506007)(7416002)(316002)(4001150100001)(2906002)(83380400001)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSV4y0RIv0UAmyRuUphfqBqJ5K8cUoFX59SEnheS4DNuI3mBeFd0LIJEP05G?=
 =?us-ascii?Q?S+JsH+5/sTIyzw+c+zyUcZLSViE4zq2BmW9EhzIKdVnObT5F0su7Hdmi3ToA?=
 =?us-ascii?Q?z/p4DAc90Et/NSpGbhED8ZTT7TzgqmBiFi4r5+mTrEF/eJ5fUW7grXLqQJrQ?=
 =?us-ascii?Q?kiF6hqBVFaT/T0GUZNjbZKLHAuVYO6upP8sIf6ibqv42clCgbO6WPyTjKpug?=
 =?us-ascii?Q?AjFn2b0mteyo1tploLNUcgRmx+A8K1Kqc1DOkDYA+1dYyQvBcI9wU0n60pAq?=
 =?us-ascii?Q?OwoHWj4SxaiVtwv2phZfgGGMIn55QcV+bD5VtPhHg9F5kmTjYBUradB+2Fu1?=
 =?us-ascii?Q?brWSAwpMt3FhdLZkcnknzCUD5S6FCihQN+cP9cZ5YmxA01HcP4H8Rmw5ZavB?=
 =?us-ascii?Q?llWPfrdWDIDeYneYeC3X1vqQvKey+iVNcRpbkaHhihj9COAoFlNlPhwfwwHU?=
 =?us-ascii?Q?8bR7mqjuU+nEBKwB3GxAz4z7DMVZh7zAQd0ja0ZIgFldYODXmB39dsbZuPpe?=
 =?us-ascii?Q?pMfGx3NQs1EZvLqfVsRCV4ucYhZUXqpEAekDybipaq7Pifyw9KwegMaUZC25?=
 =?us-ascii?Q?b5kn6FMHl1MQsvqExgBrG07UhQsCU84kxLjXIxe8xEt4MaRKj8Ov+1qVjpWq?=
 =?us-ascii?Q?YhlOloAE1Sk4n3DGRpuEefmnKnLMRZir0Vxf2wnJUIIohG6KX3h0qw8bmA++?=
 =?us-ascii?Q?4yLGDLPlSeevpg00ZK7OJ6/lmEfU3kXZML8EWsRyk8N+xeI8zy2e9Zx+Ujeq?=
 =?us-ascii?Q?gI/QDxFWkSVC7ldK68Z6FNYp7DA5PlOkDDYdhAyVpC2Iwqtz7mzLSRrIgFYN?=
 =?us-ascii?Q?BsY4JZwinCCcMbW4FR/BvGiPpM+XBadvX47JW1yLoVQ0Axu15ulS7xoult+T?=
 =?us-ascii?Q?Ovyl3ua65fPFzYNZJIjAtYCy8gnRGlBB27VYV4/+qYhMcV2c22gIIiFdYrYY?=
 =?us-ascii?Q?zuIhrXRp3Ev5jcwEfn3m9I2XAOVFRv2kX8k8cSAacEZ69BuA28vkK0QWbbEA?=
 =?us-ascii?Q?BoioD14QjVvg496DhfRke40ya0cy0z+chlTM+2MCpJk8Rb/35OwzfUapq3iF?=
 =?us-ascii?Q?4u6L2VgLuoVpUKAuT2ss46ptmWIQamWG2kg93wHLDHkoqE0/HHSwiDZyXvoz?=
 =?us-ascii?Q?GyIAEXc8lt6QQc4EDIEPkp9S4nDJh3kK+z/D0pPalm/2ZImQYcRpWOaPgEJl?=
 =?us-ascii?Q?tjJZqcal8jeI4nLvbfiH4AEAkJFIoOMf3nmrlhVf8n69iLQSIHPf3slTWL16?=
 =?us-ascii?Q?jzimFas6NP8uq3EmpUbjbCuIPCI/NiqOpRisfwFN1fYxo3jxHFgZ+IQCEfHt?=
 =?us-ascii?Q?LI9cVCcyq1L2C7zQej03N0EZeICBqqOPzgDzMLq7A1QUMsyBBPLMbNF7GoSd?=
 =?us-ascii?Q?MA53ifhZx2Vmx6tfclzb3+449Lyh3n9ZLz843Ln92Uw84PoyVV6Vw71dHhuy?=
 =?us-ascii?Q?4SvyVvDBon26aTtfW32xy0fHYQUxVuneUh+dzWVf7eQwQ7ICJLSDDeBZZjCJ?=
 =?us-ascii?Q?i2VG8DFo6ozNO5RplTzyVARRIQIlLBjla7HiHk6tI9KIBq4Mao9m4p6ywlg+?=
 =?us-ascii?Q?Y5lAHS8o8p33rwcwIWpyReHY5DWEARokX2ko5FOQGKkeIHXaCyZ56gjUs3JP?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a61d95-1f09-451e-d41a-08da84111c1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:37:04.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcoMjFi2ha/qBh6+z9A16zNRX292yCkS1HislEAEDmYUvMpMaZ/Dp1/bveoHYM+yRc5eNatrOJeFwngG28pBVLMRxy2Min6TU0T7am4exqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220032
X-Proofpoint-ORIG-GUID: LnniLAlzZOCvljIHsQh-fdaz53MbXGF-
X-Proofpoint-GUID: LnniLAlzZOCvljIHsQh-fdaz53MbXGF-
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gireesh-Hiremath-in-bosch-com/driver-input-matric-keypad-switch-to-gpiod/20220819-151155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220819/202208192340.m1XMlTj5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/input/keyboard/matrix_keypad.c:432 matrix_keypad_parse_dt() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/input/keyboard/matrix_keypad.c:439 matrix_keypad_parse_dt() error: uninitialized symbol 'ret'.

vim +/ret +432 drivers/input/keyboard/matrix_keypad.c

5298cc4cc753bb Bill Pemberton   2012-11-23  380  static struct matrix_keypad_platform_data *
4a83eecff65bd3 AnilKumar Ch     2012-11-20  381  matrix_keypad_parse_dt(struct device *dev)
4a83eecff65bd3 AnilKumar Ch     2012-11-20  382  {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  383  	struct matrix_keypad_platform_data *pdata;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  384  	struct device_node *np = dev->of_node;
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  385  	struct gpio_desc **gpios;
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  386  	struct gpio_desc *desc;
d55bda1b3e7c5a Christian Hoff   2018-11-12  387  	int ret, i, nrow, ncol;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  388  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  389  	if (!np) {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  390  		dev_err(dev, "device lacks DT data\n");
4a83eecff65bd3 AnilKumar Ch     2012-11-20  391  		return ERR_PTR(-ENODEV);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  392  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  393  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  394  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  395  	if (!pdata) {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  396  		dev_err(dev, "could not allocate memory for platform data\n");
4a83eecff65bd3 AnilKumar Ch     2012-11-20  397  		return ERR_PTR(-ENOMEM);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  398  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  399  
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  400  	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  401  	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
e80beb27d2f81a Grant Likely     2013-02-12  402  	if (nrow <= 0 || ncol <= 0) {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  403  		dev_err(dev, "number of keypad rows/columns not specified\n");
4a83eecff65bd3 AnilKumar Ch     2012-11-20  404  		return ERR_PTR(-EINVAL);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  405  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  406  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  407  	if (of_get_property(np, "linux,no-autorepeat", NULL))
4a83eecff65bd3 AnilKumar Ch     2012-11-20  408  		pdata->no_autorepeat = true;
aeda5003d0b987 Dmitry Torokhov  2015-07-16  409  
aeda5003d0b987 Dmitry Torokhov  2015-07-16  410  	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
aeda5003d0b987 Dmitry Torokhov  2015-07-16  411  			of_property_read_bool(np, "linux,wakeup"); /* legacy */
aeda5003d0b987 Dmitry Torokhov  2015-07-16  412  
aa0e26bb786b00 David Rivshin    2017-03-29  413  	pdata->drive_inactive_cols =
aa0e26bb786b00 David Rivshin    2017-03-29  414  		of_property_read_bool(np, "drive-inactive-cols");
aa0e26bb786b00 David Rivshin    2017-03-29  415  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  416  	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  417  	of_property_read_u32(np, "col-scan-delay-us",
4a83eecff65bd3 AnilKumar Ch     2012-11-20  418  						&pdata->col_scan_delay_us);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  419  
a86854d0c599b3 Kees Cook        2018-06-12  420  	gpios = devm_kcalloc(dev,
a86854d0c599b3 Kees Cook        2018-06-12  421  			     pdata->num_row_gpios + pdata->num_col_gpios,
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  422  			     sizeof(*gpios),
4a83eecff65bd3 AnilKumar Ch     2012-11-20  423  			     GFP_KERNEL);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  424  	if (!gpios) {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  425  		dev_err(dev, "could not allocate memory for gpios\n");
4a83eecff65bd3 AnilKumar Ch     2012-11-20  426  		return ERR_PTR(-ENOMEM);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  427  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  428  
d55bda1b3e7c5a Christian Hoff   2018-11-12  429  	for (i = 0; i < nrow; i++) {
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  430  		desc = devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  431  		if (IS_ERR(desc))
d55bda1b3e7c5a Christian Hoff   2018-11-12 @432  			return ERR_PTR(ret);

s/ret/desc/

90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  433  		gpios[i] = desc;
d55bda1b3e7c5a Christian Hoff   2018-11-12  434  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  435  
d55bda1b3e7c5a Christian Hoff   2018-11-12  436  	for (i = 0; i < ncol; i++) {
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  437  		desc = devm_gpiod_get_index(dev, "col", i, GPIOD_IN);
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  438  		if (IS_ERR(desc))
d55bda1b3e7c5a Christian Hoff   2018-11-12  439  			return ERR_PTR(ret);
90bb4ee8dc3c27 Gireesh Hiremath 2022-08-19  440  		gpios[nrow + i] = desc;
d55bda1b3e7c5a Christian Hoff   2018-11-12  441  	}
4a83eecff65bd3 AnilKumar Ch     2012-11-20  442  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  443  	pdata->row_gpios = gpios;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  444  	pdata->col_gpios = &gpios[pdata->num_row_gpios];
4a83eecff65bd3 AnilKumar Ch     2012-11-20  445  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  446  	return pdata;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  447  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

