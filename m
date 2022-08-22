Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704F859BBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiHVIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiHVIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:40:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CAD26101;
        Mon, 22 Aug 2022 01:40:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8RKva006168;
        Mon, 22 Aug 2022 08:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=VfqHMGFtIPy8qos8yATeUuPVXWc3E5Np/suIq6FvCno=;
 b=dPvJvKsYqg1DPf2iz3/gpsuSf45qy/PksZBYImyBarNUxPvyGI3YvDPAdSrudLUu7UFn
 hFI7XKD2xsFpEWFCb7jr2pXMjb6/taOqc3xGG2SV3Ggj9w9yF+9izNSZBZjTBhenMCi+
 CBXYa/kBGJvOBcY2mHQRes8M2z19R1LaF6bNQ08k4V9g5Py7oRMtJk97oPb64anVFUuz
 qICEi+twYXiTA7qvEmZOdB7zHcTFRvaiunBalP9DonBG7M3FYvLaYGUSylZPRSPak0jt
 s9E5Ct1N0rTnV9yNPwrdo6cmQFCV+XbtvbZNdPxSmTOOxbjjq9zrVXTat+IYJZLh5O0m Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j46a6r169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:40:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8Zwc8038244;
        Mon, 22 Aug 2022 08:40:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfs5a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOwOLfOTrdDH6m20x0+O6urLyoKrt19ahbFaI6jPmfibjCoTeFBHLlb2Vou2pZghJ0TnzrAes8mwpkq8NpPhL+VDL9IWeOuq+jxgnfyGZtxYygIxjAdf+BScxjfoHB7vMhFgQpsqiZL+PxqNCjXf3yJhX2PIo4pdy2HnDN7bGDED0OUoI4GrejDGXwKY6SKizH23/Xa5N/l4P5iGWEqmhGOgzJWVNqf5oXJZY2LP1FIe69Lt6UImGu4RNbNNdECfhnCcrbKgD9HTsrzR2T9fj6AnwDixuA8CosEiP3WR3Lcl/TqhK7Pg1FgiywNEvT/J1/6G7a/UQL01abS2oVhErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfqHMGFtIPy8qos8yATeUuPVXWc3E5Np/suIq6FvCno=;
 b=MpOPsXHD7OmT/TbO6g6NCcqJc+s9EGpjivjekQc8mgE/axNC1H/E21oHyrEFPql1Z0tQp/p6++EOwa1mJCy/r+oxbqEQ07gKINORJG5YLFZWo2DKjN0x9W1A9kBxeKuwBSaNwHlOGBzUhW6FVsfPdgW7XyakgSupBogREaxorZ6oX+C4y/33PZjHAimLkXgTGSyAzrvVqQWDCu1QySVJ2GaG60kXtQyszN5PUxoxTv4Z//QcFqByhrVtjkmqhpO+ocaEKcuNZvMwN5uV0EbpLoN8spyHw57RJ5nHhi6GwrkjMPIVJOcV7gcmlyuPHLeKy6bg6Yn2VHB44hMzxXoM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfqHMGFtIPy8qos8yATeUuPVXWc3E5Np/suIq6FvCno=;
 b=NKaw04Ky373JFZU7fxH2HUuDmZ/VZRhTqWF0/xmIL75COSiFyP6BKB2+5iFW/lzKDfAeTuxmACM4ueXqTNXYQL0l+wqcXQpLCoJLrUz5bD5Q8FVh0lL9qemf9gLWbGPb1MzsvWIc1+QVWatlgMolrclkvZ88oKYyFeuYMmYLB8g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1895.namprd10.prod.outlook.com
 (2603:10b6:903:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 08:40:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:40:27 +0000
Date:   Mon, 22 Aug 2022 11:40:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qin Jian <qinjian@cqplus1.com>,
        sboyd@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH] clk: Add Sunplus SP7021 clock driver
Message-ID: <202208212144.aUofUlUt-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817070113.415971-1-qinjian@cqplus1.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92cf6e26-2203-4716-35a7-08da8419f659
X-MS-TrafficTypeDiagnostic: CY4PR10MB1895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3BFcxZCfxWd/9RmBQS3LOLpIDylyCrAkissrCMnv11TXtxhx/nR5ySODFyBMkF7E+8bxpJzfOWokTkvpBfwbv3XRreAezoKOVZ+G84NlvQ7oLg2ro9fQZX/NHONClceQK3U0nOlY5oX+sV5wVGO22FCI3b+VqMmUU3E+s2FbpXVJ2I2OsSI0V8YI1ewPaG7YNDrYZcePtZw43/G807LIQBUk+ZIf1ENku8oRyT1hEGtYSR+wVCk5MlU/skVY+OYVgGL9gKLJ+aUTWWOhFpC7BF9YSb+TSumxxt8m0o1c4P/0gC+4b4QRtURv5jNqmjfgdeS8CuHbuYQ2eIb8vzDgf1dflI7UQKey6wslaOVxkKkNPWbcHMsYsQ7iz+/DyiYx97h6KNqYpcDHT0GrYGrF3onpBfYELQS+7vmZN8BgGi6zX5FUiVUNndcUvFv73PoxtHrBe+K5SbyrKLkTWtEFeBsCMkmHYC0GN8HNeFnrf4PhjCFyc3luPbETuI5XBMuqxxBV7HsNnn5P9VYECyIra1+JK1F1pI90rk70qXg/exCC4mecDG9ysXSzTeIJEcti8xhCxUM/OZuq+8ebwffjToP50bhFPPzCBQjdeGwso3dh0bo9bx9dsPtU9e971c5lZEbqjE3HFuQqTfwMfu2uqX8iD51kQ7bcl7kGeYCAR7i3sgSngyTMQElmJWbigjX12+yScOKmRKHMWY/Dy9etLD0/3sw+uPFAKBPWAGYMkULBg8hbXcalz03EIEGFmLiS/SAIcklSR/y3q+GrgT+I8vgjVlaWh61+WLu84ejkp9H2Az0lnQ2ziM4ZnB07/6czIpfLbEWRJ9AIq9DO9ZbtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(366004)(136003)(86362001)(316002)(83380400001)(26005)(52116002)(6506007)(6666004)(9686003)(6512007)(1076003)(966005)(186003)(38350700002)(66946007)(6486002)(44832011)(38100700002)(478600001)(41300700001)(8936002)(66556008)(8676002)(2906002)(4326008)(36756003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0TnpwQGkiwJjBPqsvB8DPdan1ZuK7wJtw3lGHd7KRgE0Ri3v8hwEQpPNzXK?=
 =?us-ascii?Q?SnHCkAe0qEcZJNWXNhTeLqRfsn4waVwUu/V1OAritfsr6U/OBqKTv/TSlOR4?=
 =?us-ascii?Q?RAMXjyzXrGx5PvIxN3N/677yscbwJiQYy1gNgHgyPyXpMTyePVp9lCII5Kyt?=
 =?us-ascii?Q?KqJm468hFXa1ASAvjpJo7bAS9Mc1Hljf8WZ7jRZypqgFTtkDAY4xsIM/TnjV?=
 =?us-ascii?Q?ft1j7JR6WMy/rrNGt51J3PiMblWILwc4zS5GvKWWhSsn+IW/8xHJWLhpmCY9?=
 =?us-ascii?Q?BEKANo3TVdxQNxQake3XFvaXOCTFMGpLV48HWdQDZZOHxssHMCCr2XhbY0hi?=
 =?us-ascii?Q?6ufH7RO2wi35Mq1pyGiB2QqD/MXQdNt07st9Q8DXJd7YeLVIdy2mTJaCSxdG?=
 =?us-ascii?Q?T9+ctBhanSo6OsDY3Xb5tkPebA3b+f9Brm4jgV42MgKPK/XnforzVhXkLOE4?=
 =?us-ascii?Q?qG5F0XtOrhv0gJSLhrC1LT+QMDxIRxH9+gXBGZhDTTngl5Hh9oVeN+svfH14?=
 =?us-ascii?Q?FoVyCIEwtvGbubm6PTL99aFLRaR/PzUJ4bGaJ76agCI8K3OpHjH2KrOHndzj?=
 =?us-ascii?Q?+r+pAwemK2fkaDToRaj7OQQRCfeqMuhRA0cGYqbGSp1u+wpEVbiYaPw7fG8O?=
 =?us-ascii?Q?jG4z3Z+YzWGiYC0fJaqKqtB0B1ryqmhdac0t/zVs4oU/dkME5QkTVT+uKQB2?=
 =?us-ascii?Q?Q+a26vhsMt/+FDujdpERAY+ATOK6KPwfXKFQ7VrHY+TdvkkE6Yq6C3cwvWUv?=
 =?us-ascii?Q?/GI68xR+C+SILAlq+3kLUdDl0nDhKy4qKwA38DJFW65ebYlcHuuC2TBGqZh/?=
 =?us-ascii?Q?J9Uc1FdkZVBV/44v0uROOBqgYWKAi5OfcsJ2R9o7ZjZEjB6IO9SiWKB5Hvp/?=
 =?us-ascii?Q?f/YiAyvTG3D1NAh3vhMzXLTGr3WZItoHjghlgAAtBxNjgnk++Cm4hpH9M1/C?=
 =?us-ascii?Q?6JeVNLdKoaejErB2k1PAKYOdRs6X0ZzXqnqm0lJqfPnKhjAUAqCschm+Fw72?=
 =?us-ascii?Q?LXG8eow5CG4zjf5wUYxQp8ixVhvwyOPKGRywLMvTC+KSCdMgRjBkk5Z+IdvI?=
 =?us-ascii?Q?CXcWZeENbshpdOZXmrIdepCRJKekED0Ff1S6NN4JqsZyGjEuD9bgd68fyc8v?=
 =?us-ascii?Q?kZblvt/RGPjxLCQFCpDNSZVTDkF7hw5+6pudPmUoZO5X2QEISCR2tEDfRbRv?=
 =?us-ascii?Q?p6GcePkeBbPwgTnWp0plmBzuhn7zohksgrP/iiIVqGIzEuD45JVcr1cwzZna?=
 =?us-ascii?Q?z/hUwfITRp5js5Ni35b2MfadR2BAFCcKh948NPIGd4tI15IB8KfmBR6WDYfc?=
 =?us-ascii?Q?MEUk690nc814L5HfULPtfh/obSne8uHeGLTQ6Yfajx35PT07rPmexU4OZh11?=
 =?us-ascii?Q?DLb02bNgANLmuCQvRZzQxcPrU8mjbZzSkXKND/Ur1CTn+k/sXw34B1YniH5z?=
 =?us-ascii?Q?ZQJ+s82fLWbXdRhepOxzILeNR7qoqPyyImBxaFlu/xLCiYrjeBu6SSzfQ4Z2?=
 =?us-ascii?Q?52oFfgZemVmKevcfXsm6vttHES291MdWdaAPC/NBlr8ORpoCDOj1GsNCyzbp?=
 =?us-ascii?Q?Yw/z5y/830MZzrRVJ2SiXmTjrU9NoM51T+hEpNTyqoiTZvLBuVF9Go1UJ5G9?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf6e26-2203-4716-35a7-08da8419f659
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:40:27.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZFW8ka2bSwhubQgWBFLmByIWwoaXfM+kNXQjTxgiWc0reDUiEQgTY5fyQQca6CNUXiUcvGloFQKgNpeW8ZJPDwu3hZTbXSl0EoAMTeWjaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220036
X-Proofpoint-ORIG-GUID: eoMgX1hhtfRsFilP8qG96OUFymAtIAMK
X-Proofpoint-GUID: eoMgX1hhtfRsFilP8qG96OUFymAtIAMK
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/clk-Add-Sunplus-SP7021-clock-driver/20220817-151010
base:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: arm64-randconfig-m031-20220821 (https://download.01.org/0day-ci/archive/20220821/202208212144.aUofUlUt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/clk/clk-sp7021.c:171 plltv_integer_div() error: buffer overflow 'm_table' 19 <= 19 (assuming for loop doesn't break)

vim +171 drivers/clk/clk-sp7021.c

5673230d6a56d6 Qin Jian 2022-08-17  145  static long plltv_integer_div(struct sp_pll *clk, unsigned long freq)
5673230d6a56d6 Qin Jian 2022-08-17  146  {
5673230d6a56d6 Qin Jian 2022-08-17  147  	/* valid m values: 27M must be divisible by m */
5673230d6a56d6 Qin Jian 2022-08-17  148  	static const u32 m_table[] = {
5673230d6a56d6 Qin Jian 2022-08-17  149  		1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32
5673230d6a56d6 Qin Jian 2022-08-17  150  	};
5673230d6a56d6 Qin Jian 2022-08-17  151  	u32 m, n, r;
5673230d6a56d6 Qin Jian 2022-08-17  152  	unsigned long fvco, nf;
5673230d6a56d6 Qin Jian 2022-08-17  153  	long ret;
5673230d6a56d6 Qin Jian 2022-08-17  154  
5673230d6a56d6 Qin Jian 2022-08-17  155  	freq = clamp(freq, F_MIN, F_MAX);
5673230d6a56d6 Qin Jian 2022-08-17  156  
5673230d6a56d6 Qin Jian 2022-08-17  157  	/* DIVR 0~3 */
5673230d6a56d6 Qin Jian 2022-08-17  158  	for (r = 0; r <= 3; r++) {
5673230d6a56d6 Qin Jian 2022-08-17  159  		fvco = freq << r;
5673230d6a56d6 Qin Jian 2022-08-17  160  		if (fvco <= FVCO_MAX)
5673230d6a56d6 Qin Jian 2022-08-17  161  			break;
5673230d6a56d6 Qin Jian 2022-08-17  162  	}
5673230d6a56d6 Qin Jian 2022-08-17  163  
5673230d6a56d6 Qin Jian 2022-08-17  164  	/* DIVM */
5673230d6a56d6 Qin Jian 2022-08-17  165  	for (m = 0; m < ARRAY_SIZE(m_table); m++) {
5673230d6a56d6 Qin Jian 2022-08-17  166  		nf = fvco * m_table[m];
5673230d6a56d6 Qin Jian 2022-08-17  167  		n = nf / F_27M;
5673230d6a56d6 Qin Jian 2022-08-17  168  		if ((n * F_27M) == nf)
5673230d6a56d6 Qin Jian 2022-08-17  169  			break;
5673230d6a56d6 Qin Jian 2022-08-17  170  	}
5673230d6a56d6 Qin Jian 2022-08-17 @171  	m = m_table[m];
                                                ^^^^^^^^^^^^^^^
If we know the for loop is going to break then why bother with a limit?

5673230d6a56d6 Qin Jian 2022-08-17  172  
5673230d6a56d6 Qin Jian 2022-08-17  173  	if (!m) {
5673230d6a56d6 Qin Jian 2022-08-17  174  		ret = -EINVAL;
5673230d6a56d6 Qin Jian 2022-08-17  175  		goto err_not_found;
5673230d6a56d6 Qin Jian 2022-08-17  176  	}
5673230d6a56d6 Qin Jian 2022-08-17  177  
5673230d6a56d6 Qin Jian 2022-08-17  178  	/* save parameters */
5673230d6a56d6 Qin Jian 2022-08-17  179  	clk->p[SEL_FRA] = 0;
5673230d6a56d6 Qin Jian 2022-08-17  180  	clk->p[DIVR]    = r;
5673230d6a56d6 Qin Jian 2022-08-17  181  	clk->p[DIVN]    = n;
5673230d6a56d6 Qin Jian 2022-08-17  182  	clk->p[DIVM]    = m;
5673230d6a56d6 Qin Jian 2022-08-17  183  
5673230d6a56d6 Qin Jian 2022-08-17  184  	return freq;
5673230d6a56d6 Qin Jian 2022-08-17  185  
5673230d6a56d6 Qin Jian 2022-08-17  186  err_not_found:
5673230d6a56d6 Qin Jian 2022-08-17  187  	pr_err("%s: %s freq:%lu not found a valid setting\n",
5673230d6a56d6 Qin Jian 2022-08-17  188  	       __func__, clk_hw_get_name(&clk->hw), freq);
5673230d6a56d6 Qin Jian 2022-08-17  189  
5673230d6a56d6 Qin Jian 2022-08-17  190  	return ret;
5673230d6a56d6 Qin Jian 2022-08-17  191  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

