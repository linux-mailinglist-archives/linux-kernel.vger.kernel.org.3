Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815E519C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347884AbiEDKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiEDKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:12:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EA25E80
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:08:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2449a9IW026114;
        Wed, 4 May 2022 10:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r3R+jhIIJJdNTeYTiw6CkHGhf6GD26WfqhGO/4lHNMU=;
 b=H05jE5ewiO+5WBw+aOpxqM5D+R8iPnKC8lijrQaES9URWw0QRgOC9tl0Zs2WVtdsYXci
 sf2eu65hhGKNGc1IuvIxcwGoK42o32jButRcaV1Zacsi+/s/N9IIWGfkY26zxxdYvKha
 Rf75M/Y4DVsHJ1ssMEhUskgOTVh6VXxGVW+2rMpFOqUIoWKbzSBglvUS1CqJuWut+N3I
 qkd3FwtNg7pO57MuK9skY/fW2si0uKmuytapm93lIIAeB0sdH5BLKbSnz98pwuE89mQn
 9D+/+9/7LYxkYlLZifZZ4/RXhgs3Bl7Y+annh/TvbGyZHclkONsQ0zF0vtAI3vV/tsZT NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7vww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 10:08:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244A6o7e033707;
        Wed, 4 May 2022 10:08:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj385ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 10:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElArkFEPND2FL4ymAHJY1MbovIopjYE0FpUV5eQg10gXXLDQlILS5vTYd/2CgMecGyASBEQrIn7VnIsFn/EiEgA5rqzYfnCbeSGRsBvgdWVQipw9LZXtBdVimHXLivwhAiBLU98XfcsglrTVzi5KWSkYBwL/b6j1ena8Cghrm0RZq9trp6RoKjO/7ioJ5nbciQlndQjyWsxWHlHDi27FCyj3q9/t7xxJKFvtMnqxwhuVk5LeDljIDGR5lVTTcRcEFDZMZh0HSm1IMt8jgHngNsFM6yM/7I5LYY6NK5WhUvtYRBMFshACIZbq8j5XkGY/FlZ9jG51WamAe/+6uGWs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3R+jhIIJJdNTeYTiw6CkHGhf6GD26WfqhGO/4lHNMU=;
 b=c+d3oKIrBqZIov+KJk9jCaNXHEazj3CZaZ6xVMG8sHwoXir0w9xoszpGGB7wpLx1vCfKhjp9QIr9EiRutBFIfKi1OS7qkD0CeP7nJ3CO3VWEOtrPIaVGeT0K+gN8HIBD5CocL3GGIkK1u2B2MBi5H9ufrLdnGKTkTd+s34qb0l0TNvfClCTS2Mup8ayTCeDQ30fyvgbMYla5eqRMQqjcetflXgZd59UlqiBSrRiMAXHObCDZhfcx7vPI+TJATTk69D8o9dWABm98h48Y/i2l8lN7sIRYqOi0/fBWsni++nOG2B8jKh0B8YS5jfvqdVe+RLeqB00jFB7OoV5Lr0CL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3R+jhIIJJdNTeYTiw6CkHGhf6GD26WfqhGO/4lHNMU=;
 b=CjgVysvFOVhpd6mc4rieg3s69S5J9pVCqOmq3feFDXAiuTWNpV+FZhTjMcJHcncHnr0qkQuE6sAtm5YO+qGUk24AKn0+ufYczsb3xPakZgkFxruezIVYlnMny7HNEH/FUQjazcuaBmB1gVdgLn3NPbi5rFMfMBwHdWKT7JgzWcI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB6133.namprd10.prod.outlook.com
 (2603:10b6:8:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 10:08:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 10:08:17 +0000
Date:   Wed, 4 May 2022 13:07:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [drm-misc:for-linux-next 1/7] drivers/gpu/drm/ast/ast_mode.c:1019
 ast_crtc_dpms() warn: ignoring unreachable code.
Message-ID: <202205041752.s96JbPPp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2bb9d24-b2a4-45a5-7f43-08da2db60272
X-MS-TrafficTypeDiagnostic: DM4PR10MB6133:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB6133E44F96469DB7F0F65B018EC39@DM4PR10MB6133.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpbpVrgYI5WgVZEcQRkenbsAAZ7ievqrzJaYKIMj6x6ecbKHKsIf/MrHjlfnD4l4Y9sPz8pYq1IXFBHsFGUA2oDKt+EUhP5z7Yk64v2yA3HMJFrXq3RkbLgizcN1+9n6vUkxGrjfeLLB9SlsJwvBdwWjW24Caxxdpf6bVoTH2Li9U1ln9fEzOP+LJ4o2ELyIGwGDTiSqz8fmQZ4vQKzndphWTq8wXwRDNOniclBt0OVyIVI1AOPrmKEAh+ls06Hqp7CBNYT10rHSD9o7/16Ld0ekAplUNlBZgwf8zMoT9ypNYkevsnQ4lQNM7vXPomPHybDOGuaXTDD+T+ySY5T8LlJ6CVXR6XxN8V8nz7lVBxIEtQjG3olsZpyAZvO6+UJgGJ4Y6i2M3ure5Q1vrZvShPtJObGQHej9JTbWbKNBhc+hyte9q9rQsBAHVpSV83hmz6j/1YiF5O9UkHRf+UUvtXEXO5bQqKehBAsc4RZlk1Uw5sy1mSuc9ydLaM9UUyohGvbzIgK7HiLhSrWn0FuwflwpHm9x9d3BV/eRBv3uBEkG+cqakZQMNpnWFIDmxW91DUVN3RC5ktiL/IvlwwSn4cEC8g35e50DDFA08R42ehQrd+1BKtjF9LPhjfTRDNUnQPVA8xE4wn3Td4twTdTHM26HNGTgVidw7LGLFRlrkpyFQmdl23WLwvka0btdGBV7y154epSejXN2v2wMC30yrHwAzNpy/ZBYHIGfCSww/14whsARtShkcsFBcc+iLIEjwkBHMJLP++Dd3aEL249Rm+iIXq888c/sN0J1VKseDKTEx+L8YhRd6QDrlD2Fr4in8iw9z6h+y7Ewd5QdCzMe9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(44832011)(966005)(9686003)(186003)(38350700002)(1076003)(6512007)(8936002)(26005)(38100700002)(508600001)(5660300002)(36756003)(2906002)(6666004)(316002)(52116002)(6916009)(4326008)(66946007)(66476007)(8676002)(83380400001)(66556008)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3weeaR+dlFIIx7GAoUTkvNrc6ZPERP480c7ttgqeia8ORTQE4sxYkqpTKTc1?=
 =?us-ascii?Q?fWYUd6K3ksKJ7mpDcGQdFhobOJRoWrmBKo2OdzJFzXEhqeTXRKqzccKIAjwV?=
 =?us-ascii?Q?Cu4mR9xxsjyBw9ptBNXUiifuqCn9Z49LRyaS4el97U58/nHJxkTM6jM2eegY?=
 =?us-ascii?Q?P43xB+ls4nYqm8xpAg+VfzHH9yN/vuqA4QGS5/D4icQmif/R29gBvR5IJO3C?=
 =?us-ascii?Q?QmeFucJFyfC/UtLWn0xuQdhH8hNjmIurly4bvtjIjSDRdGa451uP3kqFM8lI?=
 =?us-ascii?Q?ZaBKSHx4CbP0m8gj7EiW7mH/t+kkvn5+nahRBj6R3NqdnvIXEA14ZeTrAV/X?=
 =?us-ascii?Q?lBDegyE5Ai2blbg0G6Yg4J0A7a8QTJAB/E7EnEHX9wgXKpfVY+IEip2LJ5C8?=
 =?us-ascii?Q?8sQThoRcKGJLoVya1Stsdq5d5+TuSnv4WBQhelKAeV1jMCn3n4iIueib2bWE?=
 =?us-ascii?Q?53KhsIxZ25CreQ22reQp/CDqIQlg2gVzscB5ArPgoO2qK+MPv78tHWEN7mG6?=
 =?us-ascii?Q?gVtcy4zDfxKiWNafRNGTfdlZTcoUDf5ILxtZlIwmcpggADfMK1cXVYwbyp1l?=
 =?us-ascii?Q?W6MP0YEeYjlS28PDlsTk3v9qxCWB1x6yJqAmbLXUPh7kUk8K6boomEsmVsE2?=
 =?us-ascii?Q?8uOIP1FPF0RtzXi41s0OjC0jh9YO0tkFKrX2JXAXlM+P8r6nKGyUYr9liSmN?=
 =?us-ascii?Q?U24TaDB70wOCY37B64CloV9Y+jSGRmqv6wXL8jLShgovJAdF9hAeeBZVbD6x?=
 =?us-ascii?Q?i62rvDxLJWquA6rEV6lzOaC1wkgyRnhLhLsR/BkIy5ow+Kj6jduXWyf6hHb1?=
 =?us-ascii?Q?G5CcRdn1gjst7kpNrkqJPxqVh+RIGhC+wYtPDPxo/0i7Uj6Ahr3CxnsGlYm8?=
 =?us-ascii?Q?7LTWJNgCDiqmCtjPvyt7kY3zAKfUPC9RwZdX4Dj57eRH+RkGO6HXx2WSOFAF?=
 =?us-ascii?Q?xN4PPltJtWZ2kqT55OXw64FlZB/XbDT9P30ZNq5vbxU4/HM3r1+OJfqqsuRP?=
 =?us-ascii?Q?Wj6Ry7jSgaEgtgvt+snhbgLUTwU11XRbXvafa6CYoTVJtNR8mqUhCzZsaZ5i?=
 =?us-ascii?Q?yr4tlqGv6i5wevvEVy+g1eiMcW7bvIGaad0WtqnJzZPRGdUoj6WnWDAufbfW?=
 =?us-ascii?Q?ALl+uBW8Vf4/RzVXeMai+P5z/ll+7XBMr+n7QzrrarmYfKsghuUb/zCCRZAL?=
 =?us-ascii?Q?CxoiDpVaH12uWFrke8C5qz0riA6zLcHz9d7IdPM9ceeZoW2jyo2xn/7rbkAE?=
 =?us-ascii?Q?PUH4F9kprAkQiE6jkfjgAZZPN01LU/ZrOJp+PR5V8r5n7LQ66fVu0cBjPF6D?=
 =?us-ascii?Q?th29Q5IOchxlRMZNRygTh6gMSUoY+mfy+VXPKjoZih2M77q0FlK/XR6yMm4S?=
 =?us-ascii?Q?MDN7O0WtV7yScyXA2TS6NvS8iIBQAiLCSRwfP7LMzjIKMCLcwaaNdj39y6Vn?=
 =?us-ascii?Q?VhrgDft2rCwGac2bKX9hb81OG7QZphOMGQz8FRb+csObHsFFnRyPLBBEkmv8?=
 =?us-ascii?Q?lbgPJ3ANmokN0tpcWadxf9J01lKJ61UeeQKCumnO8gI2ORIQUqwwWx8xnrqT?=
 =?us-ascii?Q?vJaXFHxJTEp832OCEMVOOVPESuC2PTwi3ZauedUmRBacDJsH1vvfvvT+9jU/?=
 =?us-ascii?Q?BZCEZmzn92pAL2NNzxXemZt3B43jIRpf3YmHHmud8reYMZqwW1+uVa1CUF5x?=
 =?us-ascii?Q?4dYUVBHYU05fNA3TEbq/ewICUmot+yG3wJFK4uUnbjAs+ZgE0SqrzxgUgSt2?=
 =?us-ascii?Q?ExncVbwXCYndft4z8JqEr2dw61eGDj0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bb9d24-b2a4-45a5-7f43-08da2db60272
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 10:08:17.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjgkgFkqsHmmwL+5AzijOQq6DEIymkU/xS7E7EqLPvlEIFP9WRoP7A0sMheI32PLPjVciS7eDY1PpxdUApH2JfR3NCVosEwp3N8KRGDCBm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6133
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040067
X-Proofpoint-GUID: D3rFQpCmKYR9cUyudHsApWCEI54oWN-C
X-Proofpoint-ORIG-GUID: D3rFQpCmKYR9cUyudHsApWCEI54oWN-C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d7442505de9259f8b975232470378d399c25b2fa
commit: 594e9c04b5864b4b8b151ef4ba9521c59e0f5c54 [1/7] drm/ast: Create the driver for ASPEED proprietory Display-Port
config: ia64-randconfig-m031-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041752.s96JbPPp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/ast/ast_mode.c:1019 ast_crtc_dpms() warn: ignoring unreachable code.

vim +1019 drivers/gpu/drm/ast/ast_mode.c

312fec1405dd54 Dave Airlie       2012-02-29   988  static void ast_crtc_dpms(struct drm_crtc *crtc, int mode)
312fec1405dd54 Dave Airlie       2012-02-29   989  {
fa7dbd7688849d Thomas Zimmermann 2020-06-17   990  	struct ast_private *ast = to_ast_private(crtc->dev);
594e9c04b5864b KuoHsiang Chou    2022-04-28   991  	u8 ch = AST_DPMS_VSYNC_OFF | AST_DPMS_HSYNC_OFF;
312fec1405dd54 Dave Airlie       2012-02-29   992  
2fbeec03e17165 Thomas Zimmermann 2019-12-02   993  	/* TODO: Maybe control display signal generation with
2fbeec03e17165 Thomas Zimmermann 2019-12-02   994  	 *       Sync Enable (bit CR17.7).
2fbeec03e17165 Thomas Zimmermann 2019-12-02   995  	 */
312fec1405dd54 Dave Airlie       2012-02-29   996  	switch (mode) {
312fec1405dd54 Dave Airlie       2012-02-29   997  	case DRM_MODE_DPMS_ON:
594e9c04b5864b KuoHsiang Chou    2022-04-28   998  		ast_set_index_reg_mask(ast, AST_IO_SEQ_PORT,  0x01, 0xdf, 0);
594e9c04b5864b KuoHsiang Chou    2022-04-28   999  		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb6, 0xfc, 0);
83c6620bae3f14 Dave Airlie       2014-03-28  1000  		if (ast->tx_chip_type == AST_TX_DP501)
83c6620bae3f14 Dave Airlie       2014-03-28  1001  			ast_set_dp501_video_output(crtc->dev, 1);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1002  
594e9c04b5864b KuoHsiang Chou    2022-04-28  1003  		if (ast->tx_chip_type == AST_TX_ASTDP) {
594e9c04b5864b KuoHsiang Chou    2022-04-28  1004  			ast_dp_power_on_off(crtc->dev, AST_DP_POWER_ON);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1005  			ast_wait_for_vretrace(ast);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1006  			ast_dp_set_on_off(crtc->dev, 1);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1007  		}
594e9c04b5864b KuoHsiang Chou    2022-04-28  1008  
594e9c04b5864b KuoHsiang Chou    2022-04-28  1009  		ast_crtc_load_lut(ast, crtc);
312fec1405dd54 Dave Airlie       2012-02-29  1010  		break;
594e9c04b5864b KuoHsiang Chou    2022-04-28  1011  	case DRM_MODE_DPMS_STANDBY:
594e9c04b5864b KuoHsiang Chou    2022-04-28  1012  	case DRM_MODE_DPMS_SUSPEND:
312fec1405dd54 Dave Airlie       2012-02-29  1013  	case DRM_MODE_DPMS_OFF:
594e9c04b5864b KuoHsiang Chou    2022-04-28  1014  		ch = mode;
83c6620bae3f14 Dave Airlie       2014-03-28  1015  		if (ast->tx_chip_type == AST_TX_DP501)
83c6620bae3f14 Dave Airlie       2014-03-28  1016  			ast_set_dp501_video_output(crtc->dev, 0);
312fec1405dd54 Dave Airlie       2012-02-29  1017  		break;
                                                                ^^^^^^
break

594e9c04b5864b KuoHsiang Chou    2022-04-28  1018  
594e9c04b5864b KuoHsiang Chou    2022-04-28 @1019  		if (ast->tx_chip_type == AST_TX_ASTDP) {

Unreachable code.


594e9c04b5864b KuoHsiang Chou    2022-04-28  1020  			ast_dp_set_on_off(crtc->dev, 0);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1021  			ast_dp_power_on_off(crtc->dev, AST_DP_POWER_OFF);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1022  		}
594e9c04b5864b KuoHsiang Chou    2022-04-28  1023  
594e9c04b5864b KuoHsiang Chou    2022-04-28  1024  		ast_set_index_reg_mask(ast, AST_IO_SEQ_PORT,  0x01, 0xdf, 0x20);
594e9c04b5864b KuoHsiang Chou    2022-04-28  1025  		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb6, 0xfc, ch);
312fec1405dd54 Dave Airlie       2012-02-29  1026  	}
312fec1405dd54 Dave Airlie       2012-02-29  1027  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

