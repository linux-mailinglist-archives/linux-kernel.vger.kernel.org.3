Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C67459BBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiHVInl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiHVIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:43:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0013DF3;
        Mon, 22 Aug 2022 01:43:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8AbHF004949;
        Mon, 22 Aug 2022 08:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=3uhdjkOeNbB7UhfLALKaVnRKWUeiz36tguYXpBXGkUA=;
 b=VUGJwhaFeTuKXiEtx+Xn/sUBSGJ6XhR01doE3V9kanVuslJb/fu0zBNSFGMq5lUnB+09
 fU26+Ql0ndM9iVSYWmiBttwH8k1XmyMpFv+PnH0xA6SMRWFDCocPMaGwr5JJ7E5ex8Ti
 vIwk5w/I2rjR7DjMcMeT8VracrPw2lLIZvFDrbjbSxc/i2T4sZ/yhTmsOSPuI3CE3zS9
 vQwy7RJu4LRWypD2BskysdnLBP+IGcr+yaSspShHCRwON3iK49Ip2Fq+5bK0iqrDY6AX
 X+3qUISlefJ8xW9QjmpX9vMmNaeJv17gYZWsJSM9IvuK9MwiFo1ocDVvtHktVdR2F7gk 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j462882ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:43:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5U2Cw038092;
        Mon, 22 Aug 2022 08:43:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfs7ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwOJFuosohCfp6zLet1X58+3ji56DmRUmSVvtibJRiEnFyxrSKn+n6HJFFGBZtVsINxKm+++sq+GWfuuAiZH4QI4hpGuL7sKbHX5gfdan9Jhp5gr66dEP4cTqPC5QpFp1DmGWejxWbOnEEhqKZqXXYqkhBRV5uhYUNhu8uYXKbJ5wcZEGil71H5Daod7/Ar4uO3Fom1wx9uHDBPY0rFBQYxv57g6Gb7nhUM5fNwb2GBKNNgoOKJ2YxrTu0W88GZYXQ4qRHll2HFT1MdmY3Y0s1WfdO4oU4jPwQU4TexnFt4mHbWEHFOLKhxY28nCf044L7M9tlkQ8MHC0Ds1hibbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uhdjkOeNbB7UhfLALKaVnRKWUeiz36tguYXpBXGkUA=;
 b=m4R0T2/iq66HvljzMhzcPgxsYT+PTHDZEaHU75eNtEFgJUaFSqcfmOv1G7ZvIpApocbEkJOs22wVCGkXNK/wzPNVUub0eM9n+2OZSNEVHtLESjRS3+l1rXK8GojrM4YNkIEsJuD8y81Qrto7yYRT50GyLShsonh91zqrjjvQqqmxjZf5wvMxCrtkbCcgBwSlz/XPHgZnjERS/g98lO0rXbW59iz5xH+7GwUKmAurmqDBKEd0mViPPrpA5ON2EDRnpctDQ7potuOKsl5rDajCieyPjqzTymkqTweGAXbW7ZOyLKamcqPjEat12WIHKjg4AZupJ45jm1rcOuTsswPhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uhdjkOeNbB7UhfLALKaVnRKWUeiz36tguYXpBXGkUA=;
 b=bud9Zlw+aeJ4tpOlajOW8BiEpyuvTQoaGnt60bVUTdFRoxpRBS5jNAteZH89T9sTPeY//E3FvWjV3DptYYmWJao9rZtIxiH3EZauzArKFb3dt7JSIj/rwHGiihbN1siJPTeXTZ+/3ODN397m51YY6rgn9KpZpwQK2sTDy8XYdyE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2561.namprd10.prod.outlook.com
 (2603:10b6:406:c9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 08:43:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:43:12 +0000
Date:   Mon, 22 Aug 2022 11:42:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <202208212329.XETz1mt0-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819085703.4161266-4-conor.dooley@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96bae38f-2715-4d06-dcc9-08da841a58ad
X-MS-TrafficTypeDiagnostic: BN7PR10MB2561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daV9pf5UVmbPaunSTCYqiSsUL0vg3tMpR+7vt718RYj+blqmFkRShjomR2npiIvq0r1J0i5QxJP627BM3iXEIJn7y6F4ms2ntPvxC+54fes4qh5deHpfZrCC9m2T8TRHkq7euSo0D2/wWew+efVBx7jB8oER+0h8ydPxxVbWn/gSEAnb7xyofjX8rdYhBtmb0fy7qtU/IYAIszRTWPmSfEQ6DrzUkJMe/T5OZOU+rghRaIkSFcNdiqMn1bo3BAAXeanFhcMtzFn5ijeBIhbynmcZExelWN0t81czOwHSbruqE3cieMSxlEX/AL4itYl/vb62ZsntRI3j7Khlhh66515KPvRz8iuUe2WeW8eKpvGK+FS9aUQ6om79KN7TWX2oVd8E8cRDlQG7PWHoReyw/N5+lO9gbLHlqmmF4ZwCpw3ZK9n7o6+knq7B4e/D7Icw7o8gEoZeFBjkAnJ5kcQVBElEmd0jbpL2okJOYK8Q3JYprv7f3me1J6udZkCNn6KYluBnDSqIo1SYg32FyGLi9AIFu7rarK6Wd+JvZi1X4aWzJ+mgoVYB/FyXPlRtVfiGZwVs1HO4CBZx+KkFw0X+iXs2xgTXAgquplxyibBa7NmgR9A6Yx/mQoXUhQQRwnQDUP8ZoKV8S7CNhSYO0PdDYMrL8uKQSsYwHrOdEKr7xXk1Z/eQ7Lu9bkZc6BOtKzp3JPt5713mvcDLIWq4mf35DfEUP/xJ9/rXLSyWkIklBr+6wDDsDZSg3Nu6yEGx8QvCttHVpKRqfFeWUprUW2lZn7u5DtzR6y+/AOZNQGvJLaOAy+IoS6LQ+wupZpULWiKFzQ4nlXbPZEkVMM6is3Ucqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(39860400002)(346002)(6666004)(52116002)(6506007)(26005)(6512007)(9686003)(478600001)(966005)(6486002)(41300700001)(83380400001)(2906002)(186003)(1076003)(4326008)(7416002)(8676002)(66946007)(66476007)(66556008)(5660300002)(8936002)(44832011)(110136005)(316002)(54906003)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4NtxvYdeWAlURfeA8ifEC5dfym9jmp+5T6o3Bec6aYfkhyNpTEn6m5amwK8I?=
 =?us-ascii?Q?ceG8PwDu5cXO7NneiDLhj+Om8IXZma6FJP4NC/6pcSLolyxOrkBGbVGaP0qE?=
 =?us-ascii?Q?rvN3tPT7ArDKt7yx/TI8nFKweM1ojb1u+hqplvAecX2qPSIkbDw/OnLlqcep?=
 =?us-ascii?Q?hDcNZpAJERfdXFyHTO3QZtul1Tu0bHrJel4fJpLg7rEXGdTr1It6mQ9ihTex?=
 =?us-ascii?Q?/SUhQWzQJARZ5hnD0U6QyfbFv9dkffTACpEcDr1qiUM7vsoEDNiZS2IuJUov?=
 =?us-ascii?Q?TECrci2awOp2uG9j/rAcfP3ECma28LVaYbNGfMnrqz+VE00yg1zmVqE6q6ns?=
 =?us-ascii?Q?hBDUqw/1CRV2z6/4skdrjI5jm+JL0mdFvVFrGwHoog0k1tnzqWLaoHdy9pD0?=
 =?us-ascii?Q?Mm4rnHlLQKLsesxB+IgXkbAor5V6lxIeLCHjajtj0XlbGn9I+aNtzaCYEHZG?=
 =?us-ascii?Q?W9FntfH5Py1V0JwJYTep4jSwh5yum8V5vLJSIzxUkShozunpOEY1JtJH92rt?=
 =?us-ascii?Q?AUqv2szUI57yZAHKztdmt2VR4MCg7cUi+tkqIgCAhAE3jZk1R5gYYvYdPTS1?=
 =?us-ascii?Q?bIYnGZk4ovSuILdZ3jEAZoij4b+yb5TNQHBMaPRQjwqaC2ZJrnO5IGuiulEO?=
 =?us-ascii?Q?cNmeer5Kr2LPr2hwJ7nw7BsrrFvCNjnYE9VDJWrLrBIrxnHN/ebBdEZxTr9r?=
 =?us-ascii?Q?WLiIbLhDFKxhmRPO/jPEVDXT0HxoEYq6UojyeYF6Ua9Jk19F03w5/QgA4ZVk?=
 =?us-ascii?Q?d1fhdzPz2odw7u4+2giKh6aqbXpDN+8a7rci4SbkEGbVipFMaTx2y1xYszGk?=
 =?us-ascii?Q?yEoNU0qIfa6cV4/NWwuWLBC514TJDbdjp3wYbUF0x5rEtPyCxV1Tm+39Aa/t?=
 =?us-ascii?Q?NpEGmjxpgMAza7f32ymqu2ySXGOCm1Iv2IwCn0zH2U82+XUCwbuYUic5yePC?=
 =?us-ascii?Q?q0d4NipiTS+mAPLH1sZixS1JtSmfn2g/LzHnkifxyqBcY81O7LylLBUfDK/e?=
 =?us-ascii?Q?1SQZh9ip8xr5Y50sMEibrNZuNZNESWtzU5AqaSDO1oXYReWvqcABpi2WzdkX?=
 =?us-ascii?Q?AUad/XnPpMACQYcRE1Rb4OKL+G3u0wWVuFCsCDsUsV4EV7/xkJw+XZ3yGovc?=
 =?us-ascii?Q?AphKUmB0+CVoJ3WPl6KkibtvVdXqjvVLkRyJCKWPM+SJHDzxj39ubWGM27i4?=
 =?us-ascii?Q?nuMTjKSYti+dkhrbmfpaLkK8FF908uqahOpDUaxTTX4wF4WOQOesMMTj6N4o?=
 =?us-ascii?Q?B/GvvTfBHhwipi8ElEFuVhg+eYU8dlbeQHlX0bicHksRnvlwsGlEtZ3HZXmV?=
 =?us-ascii?Q?PG/CPmj7BcpPG70Z4aXCrbQTUiouG8CBTveVL6oRfNwhHhae2wcZ+3z4/y8g?=
 =?us-ascii?Q?3t4CeJgJtc3xWoLolgjQ3nbSg5f4liosbxH7Gt7xo7mHJTmPE/rRfHJTXkYq?=
 =?us-ascii?Q?0Yg4LO+sfpJu9h2n8nCOF9vCb/eXUlK6hoSQuX3kw1QH92WkPaOIKEaBXC4c?=
 =?us-ascii?Q?dLoxs4BdNvavCp0LgvceskXzTxPvLTRS0B0RIyBIsfc4lObLxrcOASavMjsd?=
 =?us-ascii?Q?p7kgpZIL57x09KMc1zKK2cn43cOPnqpTRMyYD0NsMKvgWJ3p5MjXE2fw+xrp?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bae38f-2715-4d06-dcc9-08da841a58ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:43:12.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e627TWhi9IFfDNtahN1EqBDHE5ygFWUzo4LwTDzKmXDWtrwSxmzWPLoMjP5d0X5iuRRpFzrEMEvZl3TRwVY9YSONfhPfof/r4ZRKtXbsgmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220036
X-Proofpoint-ORIG-GUID: inUmolzi8k3Sul71ygiqLkin7Q-oUFtk
X-Proofpoint-GUID: inUmolzi8k3Sul71ygiqLkin7Q-oUFtk
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

url:    https://github.com/intel-lab-lkp/linux/commits/Conor-Dooley/Microchip-soft-ip-corePWM-driver/20220819-170106
base:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: arm64-randconfig-m031-20220821 (https://download.01.org/0day-ci/archive/20220821/202208212329.XETz1mt0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pwm/pwm-microchip-core.c:295 mchp_core_pwm_apply() warn: inconsistent returns '&mchp_core_pwm->lock'.

vim +295 drivers/pwm/pwm-microchip-core.c

ae39414af22131 Conor Dooley 2022-08-19  200  static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
ae39414af22131 Conor Dooley 2022-08-19  201  			       const struct pwm_state *state)
ae39414af22131 Conor Dooley 2022-08-19  202  {
ae39414af22131 Conor Dooley 2022-08-19  203  	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
ae39414af22131 Conor Dooley 2022-08-19  204  	struct pwm_state current_state = pwm->state;
ae39414af22131 Conor Dooley 2022-08-19  205  	bool period_locked;
ae39414af22131 Conor Dooley 2022-08-19  206  	u64 duty_steps;
ae39414af22131 Conor Dooley 2022-08-19  207  	u16 prescale;
ae39414af22131 Conor Dooley 2022-08-19  208  	u8 period_steps;
ae39414af22131 Conor Dooley 2022-08-19  209  	int ret;
ae39414af22131 Conor Dooley 2022-08-19  210  
ae39414af22131 Conor Dooley 2022-08-19  211  	mutex_lock(&mchp_core_pwm->lock);
ae39414af22131 Conor Dooley 2022-08-19  212  
ae39414af22131 Conor Dooley 2022-08-19  213  	if (!state->enabled) {
ae39414af22131 Conor Dooley 2022-08-19  214  		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
ae39414af22131 Conor Dooley 2022-08-19  215  		mutex_unlock(&mchp_core_pwm->lock);
ae39414af22131 Conor Dooley 2022-08-19  216  		return 0;
ae39414af22131 Conor Dooley 2022-08-19  217  	}
ae39414af22131 Conor Dooley 2022-08-19  218  
ae39414af22131 Conor Dooley 2022-08-19  219  	/*
ae39414af22131 Conor Dooley 2022-08-19  220  	 * If the only thing that has changed is the duty cycle or the polarity,
ae39414af22131 Conor Dooley 2022-08-19  221  	 * we can shortcut the calculations and just compute/apply the new duty
ae39414af22131 Conor Dooley 2022-08-19  222  	 * cycle pos & neg edges
ae39414af22131 Conor Dooley 2022-08-19  223  	 * As all the channels share the same period, do not allow it to be
ae39414af22131 Conor Dooley 2022-08-19  224  	 * changed if any other channels are enabled.
ae39414af22131 Conor Dooley 2022-08-19  225  	 * If the period is locked, it may not be possible to use a period
ae39414af22131 Conor Dooley 2022-08-19  226  	 * less than that requested. In that case, we just abort.
ae39414af22131 Conor Dooley 2022-08-19  227  	 */
ae39414af22131 Conor Dooley 2022-08-19  228  	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
ae39414af22131 Conor Dooley 2022-08-19  229  
ae39414af22131 Conor Dooley 2022-08-19  230  	if (period_locked) {
ae39414af22131 Conor Dooley 2022-08-19  231  		u16 hw_prescale;
ae39414af22131 Conor Dooley 2022-08-19  232  		u8 hw_period_steps;
ae39414af22131 Conor Dooley 2022-08-19  233  
ae39414af22131 Conor Dooley 2022-08-19  234  		mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
ae39414af22131 Conor Dooley 2022-08-19  235  		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
ae39414af22131 Conor Dooley 2022-08-19  236  		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
ae39414af22131 Conor Dooley 2022-08-19  237  
ae39414af22131 Conor Dooley 2022-08-19  238  		if ((period_steps + 1) * (prescale + 1) <
ae39414af22131 Conor Dooley 2022-08-19  239  		    (hw_period_steps + 1) * (hw_prescale + 1)) {
ae39414af22131 Conor Dooley 2022-08-19  240  			mutex_unlock(&mchp_core_pwm->lock);
ae39414af22131 Conor Dooley 2022-08-19  241  			return -EINVAL;
ae39414af22131 Conor Dooley 2022-08-19  242  		}
ae39414af22131 Conor Dooley 2022-08-19  243  
ae39414af22131 Conor Dooley 2022-08-19  244  		/*
ae39414af22131 Conor Dooley 2022-08-19  245  		 * It is possible that something could have set the period_steps
ae39414af22131 Conor Dooley 2022-08-19  246  		 * register to 0xff, which would prevent us from setting a 100%
ae39414af22131 Conor Dooley 2022-08-19  247  		 * duty cycle, as explained in the mchp_core_pwm_calc_period()
ae39414af22131 Conor Dooley 2022-08-19  248  		 * above.
ae39414af22131 Conor Dooley 2022-08-19  249  		 * The period is locked and we cannot change this, so we abort.
ae39414af22131 Conor Dooley 2022-08-19  250  		 */
ae39414af22131 Conor Dooley 2022-08-19  251  		if (period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
ae39414af22131 Conor Dooley 2022-08-19  252  			return -EINVAL;

mutex_unlock(&mchp_core_pwm->lock); before the retun?

ae39414af22131 Conor Dooley 2022-08-19  253  
ae39414af22131 Conor Dooley 2022-08-19  254  		prescale = hw_prescale;
ae39414af22131 Conor Dooley 2022-08-19  255  		period_steps = hw_period_steps;
ae39414af22131 Conor Dooley 2022-08-19  256  	} else if (!current_state.enabled || current_state.period != state->period) {
ae39414af22131 Conor Dooley 2022-08-19  257  		ret = mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
ae39414af22131 Conor Dooley 2022-08-19  258  		if (ret) {
ae39414af22131 Conor Dooley 2022-08-19  259  			mutex_unlock(&mchp_core_pwm->lock);
ae39414af22131 Conor Dooley 2022-08-19  260  			return ret;
ae39414af22131 Conor Dooley 2022-08-19  261  		}
ae39414af22131 Conor Dooley 2022-08-19  262  		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
ae39414af22131 Conor Dooley 2022-08-19  263  	} else {
ae39414af22131 Conor Dooley 2022-08-19  264  		prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
ae39414af22131 Conor Dooley 2022-08-19  265  		period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
ae39414af22131 Conor Dooley 2022-08-19  266  
ae39414af22131 Conor Dooley 2022-08-19  267  		/*
ae39414af22131 Conor Dooley 2022-08-19  268  		 * As above, it is possible that something could have set the
ae39414af22131 Conor Dooley 2022-08-19  269  		 * period_steps register to 0xff, which would prevent us from
ae39414af22131 Conor Dooley 2022-08-19  270  		 * setting a 100% duty cycle, as explained above.
ae39414af22131 Conor Dooley 2022-08-19  271  		 * As the period is not locked, we are free to fix this.
ae39414af22131 Conor Dooley 2022-08-19  272  		 */
ae39414af22131 Conor Dooley 2022-08-19  273  		if (period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX) {
ae39414af22131 Conor Dooley 2022-08-19  274  			period_steps -= 1;
ae39414af22131 Conor Dooley 2022-08-19  275  			mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
ae39414af22131 Conor Dooley 2022-08-19  276  		}
ae39414af22131 Conor Dooley 2022-08-19  277  	}
ae39414af22131 Conor Dooley 2022-08-19  278  
ae39414af22131 Conor Dooley 2022-08-19  279  	duty_steps = mchp_core_pwm_calc_duty(chip, pwm, state, prescale, period_steps);
ae39414af22131 Conor Dooley 2022-08-19  280  
ae39414af22131 Conor Dooley 2022-08-19  281  	/*
ae39414af22131 Conor Dooley 2022-08-19  282  	 * Because the period is per channel, it is possible that the requested
ae39414af22131 Conor Dooley 2022-08-19  283  	 * duty cycle is longer than the period, in which case cap it to the
ae39414af22131 Conor Dooley 2022-08-19  284  	 * period, IOW a 100% duty cycle.
ae39414af22131 Conor Dooley 2022-08-19  285  	 */
ae39414af22131 Conor Dooley 2022-08-19  286  	if (duty_steps > period_steps)
ae39414af22131 Conor Dooley 2022-08-19  287  		duty_steps = period_steps + 1;
ae39414af22131 Conor Dooley 2022-08-19  288  
ae39414af22131 Conor Dooley 2022-08-19  289  	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
ae39414af22131 Conor Dooley 2022-08-19  290  
ae39414af22131 Conor Dooley 2022-08-19  291  	mchp_core_pwm_enable(chip, pwm, true, state->period);
ae39414af22131 Conor Dooley 2022-08-19  292  
ae39414af22131 Conor Dooley 2022-08-19  293  	mutex_unlock(&mchp_core_pwm->lock);
ae39414af22131 Conor Dooley 2022-08-19  294  
ae39414af22131 Conor Dooley 2022-08-19 @295  	return 0;
ae39414af22131 Conor Dooley 2022-08-19  296  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

