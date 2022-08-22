Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228C59BA98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiHVHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiHVHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:48:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60063CF;
        Mon, 22 Aug 2022 00:48:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M7lxG8028645;
        Mon, 22 Aug 2022 07:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=036IaCcxUTHfNNGpoEt/UhRQy444HEjstOLo7pwfESc=;
 b=wDrIWBdEVWuF5x1ChxBMkijfj30JcXnlqIUWscA4N0z4TzznuSqh1UJT+bsLMwq9r36t
 gP1taFhvTIFBiThUXKJRdohINfWJPR+VmKN8I//JxawkRogw1YjtO4EXpPRfLeqvWv1u
 FcL8GyBXdVtdIvP0aFHqhpd4VUBP+SWSL1dX2l5BWU4I3tRh9gokBZcHfpajdSGPuXx+
 oGN3zeUHUPN+ylHBWpGyZOgHitukBxxbLaNJPEn18XcwZwJGYA1ub4Ub6R23hd0VfeP9
 7hBUxtGGsCqnu3rABqw373jrLOrpw6I5fsCLgQAEP43h0x/WILkdXhra7xoIC10oMUZ3 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j45qk0013-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:48:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M7egOw013438;
        Mon, 22 Aug 2022 07:40:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjcqdjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHpTGqL1Rl6cuLw0t2YtapaM4o3CblFmIhkwsF1QGwEK5zXlDlI6X4b1KaV9gf3vk7wR4IE4tUO1A0k5a7MoQ20D750bku2bzOXKmnLUlm02A/Fv+I4MPylsOERsVfTSntygpF6kTA065Rsf9c5P1LAiT3oxqBMvO5QieaygIguri+npq4I50mcc0A0UZKZ1CRQPoBtMV5VhMtgx5lv0/nKxD+PbzGYakngselybSAJWgOEaRKENmHD2b9wgjEyfiNVZdEJ2aL9s862/6MUzN88n5xb6cv5vdw63NdA9bHk4QWABv882ynCSJmQERbme7DduClfjrQbd78S/DWgo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=036IaCcxUTHfNNGpoEt/UhRQy444HEjstOLo7pwfESc=;
 b=HqAEPXvZ2WrdVSIGd+PjZYv4uLiVflxk7/CwoOOO1vOXfoqMndGYWEa4dyoPuE4dYcCoCu7F468tVpoRxAUlood0U1p2OJ77H5LL2uplpys8cSoaJw//mceZjpkz/BLsNp7S1nylz3J6VJe8Y01DO6Ne8aMcp5AsgluftfGXD5RQoGEKsXVIpfH2/Dy0BCzubZWYqptV3l0oJGj3ERMVg7rmhpxmWD4t6vm+bE59p70Bh4GyA/hN+xQXp8Js4k3Vr7Yo3TrIzSdYoVY4EwKXO8cz2eUpocRTSbNWdIILaQd+nl0K8iBFHCoZEvGTLcknc+rTVE/UQkq0YcEE9KOQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=036IaCcxUTHfNNGpoEt/UhRQy444HEjstOLo7pwfESc=;
 b=AT+DHDqP/EEntxtswVxLQxCe6yVnusM7ZgpEwAVi+uGo78MbFnsZIjZ1l1z620HXvbPqDHhVMvSyMp9ZbiVlGAgv8gqfMxcO3NglRcpXmWzdr/Y3EDoObhzwEpqgp0rJPQeJG3gMvp77IDY+fRBH8/TYq+9PpD+AC5nVUcP6+/w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB2011.namprd10.prod.outlook.com
 (2603:10b6:3:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 07:40:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:40:43 +0000
Date:   Mon, 22 Aug 2022 10:40:25 +0300
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
Subject: Re: [PATCH v3 2/3] driver: input: matric-keypad: add reduced matrix
 support
Message-ID: <202208200111.6wvFtbES-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0177.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f583c09-3d3d-462e-8ed7-08da84119e0f
X-MS-TrafficTypeDiagnostic: DM5PR10MB2011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhyaGuMmJlKApmuQlKOIA9WObpjDpVZ3UvR15gOgvaKwGzYFUW7Mun6/9p7r2+kpiOKFQlLpuSJbwSZzxxjKyxBTEzfaTWlRnQgSvKWH354io5FYk0k69QzFQOHEDH90dqI+DmFomxAoKde3AlsuQXor5RjyzLhDOjsSS3IqU41HOZf8lsPYPNGxt7oMz7vDhxcDTHNbM+bW1/zMlOASQ9I7qv5M0x5KQcpDVIiF6Mwoz3n9KI1gR6pgT0Q+P8bjrcvItng84LpaTZ0fLIIylcQFKAa6Pk4QfoiEC56lEjhNMFLfVeenm6NSSwkQWW/8yHx9EfQj8Xyd5qqvVKJkbpZGwewiEsDJ5QyXOJjg1PsEx2Oq2yODvT9kz4f2FzyKa7XVuuI1UxFV1D8jqOnR8DeR09JQeMFulGj11JaZYJAJNILi6VVtPA0QzFuS5BSvwVtPJ62xLbNA3BRgyV2HMsMSoGRDLR9mO52v4791KBE4L7BIeCpA2eye3nb1F0qNEsobR1UgQSjDOjy2egMsmHBTQQoSEjKdTfxQ8RPqU3nsMn5uLZWpkNq2WZKT3CMyI91zgchrdun9kLySvZfi/U/6y1f+8V3UsFy4Du07iucKU2PsIrNxWFfU5GFDaMoVA1GJAjuUSsLoUTneMA6SJvMCiwPwhu19Hv3NTcj/S/OZtHE0uydnpFzV7q0pRCPr/oATNqh9KcnmmVi0aUv8YMc4lIxkrcct2jxBhxGwYWGAHnAJn6DSfVp8fdVfgH3EcoJSdit/K/uZN3MIiNdlS0G9tZfVkuDrbdMyRXa0Xd8Twyqz0uW8UYIiZjjq3yMlEUtwzVjSaBuZ7fZkhBY5NHMGEamDedptb1CosiWDjhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(66946007)(66476007)(8676002)(66556008)(4326008)(86362001)(921005)(38350700002)(36756003)(38100700002)(1076003)(186003)(8936002)(6512007)(26005)(52116002)(9686003)(6666004)(41300700001)(6486002)(478600001)(966005)(6506007)(7416002)(316002)(4001150100001)(2906002)(83380400001)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cb8d88iK8Vw6rP/w+KjZMAS0xd0+vaotCP2ewcgCFdwLV5oWJBWQBRtCwrBx?=
 =?us-ascii?Q?OFCTh3wEfu6Bne2f2uhiO9hoPyADA69gOGhVvVB0RSCaDX6H+JeH1t798w2f?=
 =?us-ascii?Q?ZAVGyN4E5WCvnLcipsNJPm6e2TtrP14ZUwkuifPvzSoXof0vIYCcQXI17/ca?=
 =?us-ascii?Q?pbVtQjPayDNnNA1MnCxqiaFcihHqKqOd9TDiVQwhUIIquyRvEVE3bhIcHYSm?=
 =?us-ascii?Q?0T25ehsVbmmYW2NkiVUQatkZDk9+29nG7PLed2vjRhw+He+bsIcPM81VuQ6O?=
 =?us-ascii?Q?DQ8FF2XXym9hMTyaqvQkJDHuUoydPsaymFhtBxat4myxd4CFOR82ilk5KNSm?=
 =?us-ascii?Q?Z3DteCK1Ic+IGoaA+nZSQhlngqmP540t/c3Z/ghQHcZMlu1/POzlUNPhYn2z?=
 =?us-ascii?Q?pgf5GIvhMzBj83vCn6X4Xb49kRwdISIGzsAwpSSHPPlew7gTT2nJTM4PKmP5?=
 =?us-ascii?Q?AeL0NNNnz/lKMY1rC9YAh/tRrOmbcCC4ZkTdv6kEXr83n+a67O7Dox70Zllv?=
 =?us-ascii?Q?3udIWScC7LSctg75Sw3TOXVPMy22kdVnFeySKbCAHtclc6PsaWe7QIwsbg+g?=
 =?us-ascii?Q?pcdB8xhjduhGY0/FEoVqyFzJNMnfvksxRJHSAY3PYxiebhLo+rpxvhSBsT8j?=
 =?us-ascii?Q?BHFRfJvlyzTbZpxH312578qI5fGO3+ubT0f0Mxc2Ybx054hZR+gSopeXi0Gm?=
 =?us-ascii?Q?PF7/w+q8UE+bRhN7mYmSg8EiBJ+XoY2XUATj/xwqZRt/QmjO55g2WN07hlEb?=
 =?us-ascii?Q?+ld42YrPiHciB2Mmg85l30GYHcf4u34BXc8/265NDY+P3tIeRxOn6AJyZPco?=
 =?us-ascii?Q?VCLC+OnW2jhrZH0KeN5WN5c7JYWYxoyMemXMa8JXiyXZa2CMlA302xe8DlK9?=
 =?us-ascii?Q?DKOSKDV51cKRFatJRKVLhQh+dFMIWqRvdvG9O/ixecEjNTOfmFLMGpOLG9xm?=
 =?us-ascii?Q?XWvzcT3SXSul7PJL78MsusMeyjI5Pnhx5T43Peta3OsNtX12qUaR+rWqSaQO?=
 =?us-ascii?Q?c0GRwuiIv6p9KM9SkVjyki5FN9fu3VVfYPpWWmXrdTUom/MPlVR9GRTP5Ebf?=
 =?us-ascii?Q?/K0QtMitPiOF8jPRwTyrqtKijIF2WdmZLGJBLDFPGMgn16O17AMHHwsQ3vaZ?=
 =?us-ascii?Q?gZuS34NBRymwZ10/6WSQpb/NLYiH2vdDySE10nvUCj8ziixYCpYDFNjr6QQX?=
 =?us-ascii?Q?Utj/4kB0sMyS37WjVpWRe5ePl+NUqCHP7632j2R9zpS9BssBGGD90Ah4O4/Z?=
 =?us-ascii?Q?GftKxjkwLMNzqixBtSIX9qb9SZtweqlvSQRX1DQlhLyxz1/k1x6TIhnnC11Q?=
 =?us-ascii?Q?KLOj7+sVCtA7LA0VcUcHr+DrtNiq1vHGtrAbLDXG2s2tGiUpdvXDqZFjGdEW?=
 =?us-ascii?Q?/+ZYDtFY73/miZ0UXWzwHXSxpoSKiYKcqLWHZSmLxNV1WWB7afUVmkeSqJsi?=
 =?us-ascii?Q?pQXpDGBEeenwBQaL+smlHzNzkyr4TrydrHVUTLopOY5BrCxiYocH/D8Pw6oB?=
 =?us-ascii?Q?Dv5MfefL0iO5QIXF+rt8XR6RcBtjLgSUB/o6vC272pZ3dnu23SyYnU0Gigk2?=
 =?us-ascii?Q?9tPGc/LxOGKkcPRtCVNGIz+qwe1ddPOmztktN6x0lx5MY/HA+NAnyxQYWhSt?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f583c09-3d3d-462e-8ed7-08da84119e0f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:40:43.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg5TqVdUIXtRYgjC2DFzYsSMJcQpwxlQNfaUtjjZGOgGimWbOpuIA8ORrYZiMyJ8015bFlu5whOa68bHDrhsSvzFlyMEZb7AYAZGHNqbS1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220032
X-Proofpoint-ORIG-GUID: sIzmsiX-tydalzwcDQJFmmrQwmgsALfb
X-Proofpoint-GUID: sIzmsiX-tydalzwcDQJFmmrQwmgsALfb
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
config: s390-randconfig-m041-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200111.6wvFtbES-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/input/keyboard/matrix_keypad.c:932 matrix_keypad_probe() error: uninitialized symbol 'err'.

vim +/err +932 drivers/input/keyboard/matrix_keypad.c

5298cc4cc753bb Bill Pemberton   2012-11-23  823  static int matrix_keypad_probe(struct platform_device *pdev)
bab7614d6d1b1f Eric Miao        2009-06-29  824  {
bab7614d6d1b1f Eric Miao        2009-06-29  825  	const struct matrix_keypad_platform_data *pdata;
bab7614d6d1b1f Eric Miao        2009-06-29  826  	struct matrix_keypad *keypad;
bab7614d6d1b1f Eric Miao        2009-06-29  827  	struct input_dev *input_dev;
bab7614d6d1b1f Eric Miao        2009-06-29  828  	int err;
bab7614d6d1b1f Eric Miao        2009-06-29  829  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  830  	pdata = dev_get_platdata(&pdev->dev);
bab7614d6d1b1f Eric Miao        2009-06-29  831  	if (!pdata) {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  832  		pdata = matrix_keypad_parse_dt(&pdev->dev);
d55bda1b3e7c5a Christian Hoff   2018-11-12  833  		if (IS_ERR(pdata))
4a83eecff65bd3 AnilKumar Ch     2012-11-20  834  			return PTR_ERR(pdata);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  835  	} else if (!pdata->keymap_data) {
bab7614d6d1b1f Eric Miao        2009-06-29  836  		dev_err(&pdev->dev, "no keymap data defined\n");
bab7614d6d1b1f Eric Miao        2009-06-29  837  		return -EINVAL;
bab7614d6d1b1f Eric Miao        2009-06-29  838  	}
bab7614d6d1b1f Eric Miao        2009-06-29  839  
4a83eecff65bd3 AnilKumar Ch     2012-11-20  840  	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
bab7614d6d1b1f Eric Miao        2009-06-29  841  	input_dev = input_allocate_device();
01111fcd42b050 Dmitry Torokhov  2012-04-20  842  	if (!keypad || !input_dev) {
bab7614d6d1b1f Eric Miao        2009-06-29  843  		err = -ENOMEM;
bab7614d6d1b1f Eric Miao        2009-06-29  844  		goto err_free_mem;
bab7614d6d1b1f Eric Miao        2009-06-29  845  	}
bab7614d6d1b1f Eric Miao        2009-06-29  846  
bab7614d6d1b1f Eric Miao        2009-06-29  847  	keypad->input_dev = input_dev;
bab7614d6d1b1f Eric Miao        2009-06-29  848  	keypad->pdata = pdata;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  849  	keypad->row_shift = get_count_order(pdata->num_col_gpios);
bab7614d6d1b1f Eric Miao        2009-06-29  850  	keypad->stopped = true;
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  851  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  852  	if (pdata->mode == REDUCED) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  853  		keypad->button_array = devm_kzalloc(
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  854  			&pdev->dev,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  855  			sizeof(struct button) * (pdata->num_of_buttons),
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  856  			GFP_KERNEL);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  857  		if (!keypad->button_array) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  858  			dev_err(&pdev->dev,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  859  				"could not allocate memory for button array\n");

err = -ENOMEM;

a0b420e08e3b87 Gireesh Hiremath 2022-08-19  860  			goto err_free_mem;
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  861  			;

Why the extra ;?

a0b420e08e3b87 Gireesh Hiremath 2022-08-19  862  		}
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  863  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  864  		poll_prepare(keypad);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  865  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  866  		err = input_setup_polling(input_dev, matrix_keypad_poll);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  867  		if (err) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  868  			dev_err(&pdev->dev,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  869  				"unable to set up polling, err=%d\n", err);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  870  			return err;

Memory leaks.  Needs to goto err_free_mem;

a0b420e08e3b87 Gireesh Hiremath 2022-08-19  871  		}
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  872  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  873  		input_set_poll_interval(input_dev, pdata->poll_interval_ms);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  874  	} else {
bab7614d6d1b1f Eric Miao        2009-06-29  875  		INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  876  	}
bab7614d6d1b1f Eric Miao        2009-06-29  877  	spin_lock_init(&keypad->lock);
bab7614d6d1b1f Eric Miao        2009-06-29  878  
bab7614d6d1b1f Eric Miao        2009-06-29  879  	input_dev->name = pdev->name;
bab7614d6d1b1f Eric Miao        2009-06-29  880  	input_dev->id.bustype = BUS_HOST;
bab7614d6d1b1f Eric Miao        2009-06-29  881  	input_dev->dev.parent = &pdev->dev;
bab7614d6d1b1f Eric Miao        2009-06-29  882  	input_dev->open = matrix_keypad_start;
bab7614d6d1b1f Eric Miao        2009-06-29  883  	input_dev->close = matrix_keypad_stop;
bab7614d6d1b1f Eric Miao        2009-06-29  884  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  885  	if (pdata->mode == REDUCED) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  886  		err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  887  						 pdata->num_line_gpios,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  888  						 pdata->num_line_gpios, NULL,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  889  						 input_dev);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  890  		if (err) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  891  			dev_err(&pdev->dev, "failed to build keymap for reduced mode\n");
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  892  			goto err_free_mem;
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  893  		}
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  894  	} else {
4a83eecff65bd3 AnilKumar Ch     2012-11-20  895  		err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
1932811f426fee Dmitry Torokhov  2012-05-10  896  						 pdata->num_row_gpios,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  897  						 pdata->num_col_gpios, NULL,
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  898  						 input_dev);
4a83eecff65bd3 AnilKumar Ch     2012-11-20  899  		if (err) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  900  			dev_err(&pdev->dev, "failed to build keymap for generic mode\n");
1932811f426fee Dmitry Torokhov  2012-05-10  901  			goto err_free_mem;
4a83eecff65bd3 AnilKumar Ch     2012-11-20  902  		}
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  903  	}
bab7614d6d1b1f Eric Miao        2009-06-29  904  
1932811f426fee Dmitry Torokhov  2012-05-10  905  	if (!pdata->no_autorepeat)
1932811f426fee Dmitry Torokhov  2012-05-10  906  		__set_bit(EV_REP, input_dev->evbit);
bab7614d6d1b1f Eric Miao        2009-06-29  907  	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
bab7614d6d1b1f Eric Miao        2009-06-29  908  	input_set_drvdata(input_dev, keypad);
bab7614d6d1b1f Eric Miao        2009-06-29  909  
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  910  	if (pdata->mode == REDUCED) {
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  911  		button_hdl_init(keypad);
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  912  	} else {
b83643ebf22423 Dmitry Torokhov  2012-04-20  913  		err = matrix_keypad_init_gpio(pdev, keypad);
bab7614d6d1b1f Eric Miao        2009-06-29  914  		if (err)
bab7614d6d1b1f Eric Miao        2009-06-29  915  			goto err_free_mem;
a0b420e08e3b87 Gireesh Hiremath 2022-08-19  916  	}
bab7614d6d1b1f Eric Miao        2009-06-29  917  
bab7614d6d1b1f Eric Miao        2009-06-29  918  	err = input_register_device(keypad->input_dev);
bab7614d6d1b1f Eric Miao        2009-06-29  919  	if (err)
b83643ebf22423 Dmitry Torokhov  2012-04-20  920  		goto err_free_gpio;
bab7614d6d1b1f Eric Miao        2009-06-29  921  
bab7614d6d1b1f Eric Miao        2009-06-29  922  	device_init_wakeup(&pdev->dev, pdata->wakeup);
bab7614d6d1b1f Eric Miao        2009-06-29  923  	platform_set_drvdata(pdev, keypad);
bab7614d6d1b1f Eric Miao        2009-06-29  924  
bab7614d6d1b1f Eric Miao        2009-06-29  925  	return 0;
bab7614d6d1b1f Eric Miao        2009-06-29  926  
b83643ebf22423 Dmitry Torokhov  2012-04-20  927  err_free_gpio:
b83643ebf22423 Dmitry Torokhov  2012-04-20  928  	matrix_keypad_free_gpio(keypad);
bab7614d6d1b1f Eric Miao        2009-06-29  929  err_free_mem:
bab7614d6d1b1f Eric Miao        2009-06-29  930  	input_free_device(input_dev);
bab7614d6d1b1f Eric Miao        2009-06-29  931  	kfree(keypad);
bab7614d6d1b1f Eric Miao        2009-06-29 @932  	return err;
bab7614d6d1b1f Eric Miao        2009-06-29  933  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

