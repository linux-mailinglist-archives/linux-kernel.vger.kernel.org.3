Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E1522F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiEKJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiEKJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:31:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6613568A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:31:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8ovea003190;
        Wed, 11 May 2022 09:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=qPfER60eSNcDIvMVP3UbqKHt5Uc3VipXZCi7GmSsxPs=;
 b=Hid/LE012erzBcBg1gblM4HvLeHvTdKuKpAK3aB95gezBwlLbsWU+CV+YaVS0cQ9BGG0
 iXewAGaOpncRHd63637RhkgfvWGhdxJT02tJ9V1HePYZQW89amnE7HBn3dLGoBO75h5M
 rgCs1sOUegOpfEnYVgcuXVPG8BiB8X4fIvivhiKQr1JqmXobmwnCNP1RrzqjDg/5Y08+
 CT5+4wZJp6peJcaarvE6WndQ2Oa30Gs5wpf0E21saRML4E+7iXmZOCYZapQcxGiTMNq6
 xerArrv9u0kLbKfF0D8wRRDPn+loMvV+NBc7f4YDZTIomKdCgKzdoo0DGDYCCrDWYsrE KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04g3te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:31:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9HJnm005015;
        Wed, 11 May 2022 09:31:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6ejrh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC1ZdUan/1V8ei0fN4ucxMM++ghfvZd2IWvAnAiKa7cWU53QPPf3/eJ9KgIyCoMUNjgr2AlFckiAGCcSrL+AfcVWgUXaXZkGBSjyjHYU+PHK01vT8XsF2mdgNm1R+YarDywApPmt5Q/U6WvGuM6LvyzL4Ud7oNmbEwMY70bZwrN32oUasOhEJEV6xzHpm7LtCm1yHIUh8YyKlTl4iXEE5I178uPjZtRBGyYqNkYnrhFxr8K/1ExXO9OQfqKr25w3K0VfM5MOZEGAIB2pY3ukuakhY1ZE5WvgwkU+7ECNseW5hzlvYYOleXkVaxxuowxY34C9T59AOGn2iMk+UR9YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPfER60eSNcDIvMVP3UbqKHt5Uc3VipXZCi7GmSsxPs=;
 b=RziUTfeuwnJBYaM+QVArbxlAXSYRjFiO/7jKPbpOS7dMky3YexH+lGVZ/FBTkqca0DHW+OXzEzMAFYrduxq/o7IKwWJdK7D1FkI25NnqaolaPGShou89YKfBDq44D8+UM+bHxNz65e6cQ8Mcgtgtf4V713hEVTlXIZsfSDC6f1/PExMvIOmBrSWv+rfuszPNrnDFHgOGZVnTKiRyTRtGcbWxkpDWbsopmW+x9OXB7fvtTTNUkTVesGUUjuYTimruQ/q4WlhwUsQ2prAb6K0jBYeDUTvhey4uGHFuplUCP8AiC3MblYYdh+vnf47pHlO+/l5t7uEppQXTbR1KYs8ZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPfER60eSNcDIvMVP3UbqKHt5Uc3VipXZCi7GmSsxPs=;
 b=AVWmMaOvEWrtx9P/IjKz65nd6Na8hJtx/dIAEFss/k460OJNH4rC+V0KI6z8NlSWgVWItZRyRXIyJjqPHVnYlA0b8mlht2jUODKBMfOdrbv7CMg9IBnQlfsLrqJTV7tH0/OhHPAEikzh2k4bwJGeYB4ZYQltB4bD0ZeD8ehZJaU=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BY5PR10MB4210.namprd10.prod.outlook.com
 (2603:10b6:a03:201::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 09:31:33 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:31:33 +0000
Date:   Wed, 11 May 2022 12:31:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@foss.st.com>
Subject: drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn:
 variable dereferenced before check 'crtc' (see line 1119)
Message-ID: <202205090654.2i2tXZVZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7651c361-8822-40b7-37b7-08da33310971
X-MS-TrafficTypeDiagnostic: BY5PR10MB4210:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4210191302F323215F4239588EC89@BY5PR10MB4210.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cllUwZNtjtp65JOUA/+F3hCUlQruwdkokzLoOdFoMuRckJgGvAjfYy5fH7xUdPohInDfQZJv+jhS0htROiMm8Sh+5oTp2Y1iiZN3xRQqAsBERynBOUT2KiA6G64g5J2EEvhIeUi9Cnibe6pM67d4jipiDwMtI6k+Uqr/g6D3I48ECSu3csra/8hZjhAkUevQtNnyTR46D1+LRoN3x2huBxTcC4r8G0DsDVV0lnily4zK6k6WzyheVAOd91/Oi7Wj+3ZrVl4BbFkTu7cY+P7EtvvYbRj+SsBgYdbjJ+lYoCweYnCpWB8XwbUuEXc7+9vTZrNN6mNqdTyCdMKeNCfvCqUC13LN6gfoSSFlzSw9+vxhjbVnDK8Fep30JKUPzjhQ86wTr4HnIZTyEcTJPu+Ts+jB1Aa+wUanl34n4jWVbWLV3oRwte6VmmZRhyXKs/Jx2dBgh36QkPFqTwCDtSD4GemNtG5lt04t5h9lBKtdqW/EDFlXoqCpqq7Oz5kgVJ8FHOVlklYmj7KI+UTahrQk070A/kT5RFRJmGEoHmLSbm0r181sbRGyVmrgS2Vf7Wuos8JiIFX5Ri46nO7PNZZ0emsRBoB5cWk1OxvPHsr7GoMF9YLVq+uQ4JP+2gz8ZygW9RPCr5JUX4jYyPKT5fxJgW51b3egdtU7xaJqX4UW6HYHG3WXpFgjtpaAZhCs7iDIzdzF2VQlDSmC60FMnFLKKlbhvJbOYFcRUqSAPbsVz81LGcXkPRMs366Rrk34VDmPAdox8HXgZmtBiYbjuMuqMbThysIg+a4AY/FF0BC/ox+vjhwIHznwX9CBtjTqA6rd0D/NY2SghKk5kvydErlv5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(38350700002)(316002)(66476007)(66946007)(8676002)(66556008)(4326008)(508600001)(86362001)(966005)(52116002)(36756003)(83380400001)(6486002)(5660300002)(1076003)(8936002)(2906002)(6666004)(44832011)(6512007)(6506007)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwgesZiubKXpbKX/DQrUOIQyIRXfdSwmQG2cKE20YvamH9GCJlZAUZ1d14rB?=
 =?us-ascii?Q?zhpP4n/gHpuymrYNmvdGUaSoaMOCPtxCNvzfpR8+Y/9hfUKFKFzMMegoygWJ?=
 =?us-ascii?Q?f0biVRklpw06ptBH6ky2IivYHYGjv4/au9vS1ZRck7i886fmEtc5dh8Plgeb?=
 =?us-ascii?Q?ti/+RE9XnGU683Psx3Jei+wmzx9dXQxIwU1qV9xCDTa4bounbzsWVxGWhreK?=
 =?us-ascii?Q?J82+LpAlK4uOGKpV3o/R1e+ONUvoWX+tZkEvhOxpN+fQVJFLWNVRVPGOikb8?=
 =?us-ascii?Q?cx4U1PYlnCNPZESXq+dZJss7R5FL0oBqZd0oAxX7+BwRGN5gtdHOW4SuNInW?=
 =?us-ascii?Q?HLCJu8cPok2kQg4te+B1OUMZyh+sD/wNPmeTY7i2IQynjAY4/R7DgSxQB7Ly?=
 =?us-ascii?Q?LjyG+XAvAi//StOrjwi93tlseW+pWxxK2erMSrPaVsxHvjnjovRpa1MrC8Br?=
 =?us-ascii?Q?d2SeMstNjDkj0iNVBvLCwVBFEydi3pfVrZuGBBmSd2Mj9E7+QaV9QhgcDwwb?=
 =?us-ascii?Q?KY5BNtsJbBfJMEzUHp2DcnEh4ePfoHylEC4SYn9Z0Xyga+WTXTvzxOyhVsxx?=
 =?us-ascii?Q?4TpmugI+IwQFdw+Zk+z6gf7VyoN5RKR9A+uOpSzR/Fn8bjQGa9JSifQiIg8H?=
 =?us-ascii?Q?xJt+HZMuMkEPfIASZQE5GiMBn7Xb0oESI+fJO4LV/Le3r9vZGajB5LHvKSOL?=
 =?us-ascii?Q?Qa9TZcnh7sgJ6ZdHsOBESvfm+awUKnqgQ5euO7/wv1Ia6IeADg9xwBELLvTD?=
 =?us-ascii?Q?/GqqEdYrTI7zhtrx2B4YnoxcbPa1i/Cwdp5jSnXVG3SK7dScPhC1F9gxk7Ux?=
 =?us-ascii?Q?DQzUMxUTH85M3+u1djy9u5LBYF2yGr+WW90mrIgZqcVdbvRjipKWN7BtGMzj?=
 =?us-ascii?Q?MiDO63JC5GsEhalVPOGYnA4nX0I5kB+WHriZmhYDs5i64//LW4Ms0G26b2dk?=
 =?us-ascii?Q?Sub9jdPGT5FmHfFlUCW/F7VRuc5zZ1pr33tToNUYvvD9RcA+53Xho0tvNfSL?=
 =?us-ascii?Q?NAosx8WSsgHkr2E93LbULfKe191e99KuhJXPWcv9UzTPlNrDv7fy6DStOObF?=
 =?us-ascii?Q?01pyXoh7j1YW3dTreasG36TuPN7IfESYcAK5yTOlqQnl2x/RtA29odPAV2n7?=
 =?us-ascii?Q?AqFnucJfKAni40f5TdkJ03krDLa+H/CwGVpzdRaMWbpZWTey+VJL0D3LVz2Q?=
 =?us-ascii?Q?WMVMYZsh+CfKFTfME9gTRbXVgyjcB9tAKXm1b1Okq6ElXTkjXCMNq4BWt9r7?=
 =?us-ascii?Q?RoyCnhC1oO4pvRIlyR10LQChaGpfRyENHExu9Xt2wV4aR9mEGWCUiVBcp/8+?=
 =?us-ascii?Q?2OhYGKexJM66C4fYQr4dK1zhZxtsVucif8cNZTxz37CemkGcTbYBz4B9gA+j?=
 =?us-ascii?Q?HNRenq5EIsVQTtWQ2FVaxVor/IP/CUWmF9qE9Zh/JQQK6tXheUrTL+/0crkA?=
 =?us-ascii?Q?6TpdbGoob75z5T7qr7RMY8nhFQWUA4G80Kbuemf/NHDU1rMKFTYMCiE4zwjl?=
 =?us-ascii?Q?rx6WYDnEyujPPKJztXSra26PspIDnwWnBm4K4+uL4GSJfOXJRH3pgi4IaRTw?=
 =?us-ascii?Q?CzIHb5+GvyhZmzSOep2r33zgbE7QRyTx6Wv3910RzcaRhPBxkm9QyySso1tP?=
 =?us-ascii?Q?fTZjd4jdqZVCaeX/h6yX/bqrSTXLXTJx/IRs8yzUlhYfm+MLI6Tq8mXMmuwI?=
 =?us-ascii?Q?pRPzbMsWrRAA77XCBOyK8/6r4gaimV1VmSdeDJLVDP3oRkKOj37zehAtu1jm?=
 =?us-ascii?Q?HFBQpuzG0Ws9fuvotO8OoYTWi42Lzkk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7651c361-8822-40b7-37b7-08da33310971
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:31:33.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liiwGVYJkzmBGdh2zMr7bvmr3nVAm6CVGUCiSAzkG05LRRadu/sqdTOerYqt4iw55GPz9KrixXGy0GYUr+aXi38GMhY4lYpD0epfO5+okBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110042
X-Proofpoint-GUID: N7NKeOCRmEAw-1ciBVe4MIQoMSmI6qkw
X-Proofpoint-ORIG-GUID: N7NKeOCRmEAw-1ciBVe4MIQoMSmI6qkw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f002488d80b557c7dc540457b176011449895fcb
commit: 79b44684a14e363d24c299b772f037344ad8c8dc drm/stm: ltdc: add support for CRC hashing feature
config: arm-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220509/202205090654.2i2tXZVZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn: variable dereferenced before check 'crtc' (see line 1119)

Old smatch warnings:
drivers/gpu/drm/stm/ltdc.c:901 ltdc_crtc_mode_set_nofb() warn: iterator used outside loop: 'bridge'
drivers/gpu/drm/stm/ltdc.c:911 ltdc_crtc_mode_set_nofb() warn: pm_runtime_get_sync() also returns 1 on success

vim +/crtc +1124 drivers/gpu/drm/stm/ltdc.c

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1117  static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1118  {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1119  	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
                                                                                                ^^^^
Dereferenced inside call

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1120  	int ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1121  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1122  	DRM_DEBUG_DRIVER("\n");
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1123  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1124  	if (!crtc)
                                                            ^^^^^
Too late

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1125  		return -ENODEV;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1126  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1127  	if (source && strcmp(source, "auto") == 0) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1128  		ldev->crc_active = true;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1129  		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1130  	} else if (!source) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1131  		ldev->crc_active = false;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1132  		ret = regmap_clear_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1133  	} else {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1134  		ret = -EINVAL;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1135  	}
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1136  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1137  	ldev->crc_skip_count = 0;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1138  	return ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1139  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

