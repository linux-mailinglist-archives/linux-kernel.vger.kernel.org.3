Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99D56D30B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGKCrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:47:38 -0400
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644213DD4;
        Sun, 10 Jul 2022 19:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1657507628; x=1689043628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=v12qdOoNBgSKK1OOxqsA79EWSPpi7JefJH3nHtUIn+I=;
  b=ekuZh4T8I5SBHIYum7uXwjkq88FQGjvv0LOxl6ZcArQj+IYTKYaeG4Kp
   HXylMdwpZs/rwnF/ykFczKcnSsgSqq5Ss3sAGytEUbqtTOiHHGuRXhRbG
   q7xaQ/2qVkYK13uNzm1x9jZzPASL0O0p3oG8qFwN7609AVvR8svCd3DYt
   c=;
X-IPAS-Result: =?us-ascii?q?A2ElAAB9jsti/zMvFqxaHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBgiOCWYxwhWqDAgOCI5kmgSwUgWgLAQEBAQEBAQEBBwEBQgQBAYUEA?=
 =?us-ascii?q?oUNJjQJDgECBAEBAQEDAgMBAQEBAQEDAQEBBQEBAQEBAQYDAQEBAoEYhS9Gg?=
 =?us-ascii?q?jUig3UCAQMnUhAgMTIlBgENBYJ9gxmufDKBAYIUBIdnCQGBMwGJW4Qle4JQJ?=
 =?us-ascii?q?m+BPIIshA8BEgFNhg8EjRWEIoZvgkw5AwkEBwUuLxKBH2wBCAQGBwoFMAYCD?=
 =?us-ascii?q?BgUBAITElMKDAISDAoZDg5DFwwPAxIDDwEHAgkQCBIlCAMCAwgDAgMbCwIDF?=
 =?us-ascii?q?gkOAx0IChgSEBICBBEaCwgDFj8JAgQOA0AIDgMRBAMPGAkSCBAEBgMyDCULA?=
 =?us-ascii?q?wUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EIh0DAwUlAwICGwcCAgMCBhUGA?=
 =?us-ascii?q?gI/LTkIBAgEKyMPBQIHLwUELwIeBAUGEQgCFgIGBAUCBAQWAhAIAggnFwcTM?=
 =?us-ascii?q?xkBBQ5LEAkhHCcQBQYVAyFtBQc+Dyg0NjwsHxsKgRUsKxYDBAQDAgYaAwMiA?=
 =?us-ascii?q?hApBjEDFQYpFRQaEwkqgQAGIh2cHhNpUBAbFIEDK2URBECSMR6DEAGLFYISn?=
 =?us-ascii?q?kUNo0kaMYN1jEOYLZZ3IKJYhCYCBAIEBQIOCIE+I4EmcHCBCg5WgUpRGQ+OL?=
 =?us-ascii?q?BaBKo0RaDsCBgsBAQMJjD0FgWZdAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bSeWNK4hP3qBtwFEO7yH1QxRtN/GchMFZxGqfqrLsTDasY5as4F+v
 mVOWzqObqqOMWbzKI10OY2/phtU7cDdnNdkSwc5rH03Eysa+MHILOrCIxarNUt+DOWaFxs/s
 J92hvosjiwQZiWBzvt4GuW5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZS9LwobVvKY52bBVPCvQ4
 bsek+WHULNy82UsWo68w/vrRCJH5JweihtB1rANTakjUGvlqpUgJMl3yZddj5fPatI88uaSH
 44vxVwil4/T109F5tiNyt4XfqCWK1J70MfnZnd+AsCfbhZ+SiMa06MBN8MWdHxuuW+mvOEyx
 /kcqpfrcFJ8VkHMsLx1vxhwLxk7GIFn3oPqGz2B6ZXVxErca33h37NnF1wtVWEa0r8oWycUr
 7pEd3ZQN3hvhMrvqF6/YtFlisgyL9HcDYoYknh70CqfBvEjKXzGa/uUuoABhmtg7ixINdbyJ
 MA1Sjh9Vj77UzlQIw4uOK9gsuj90xETdBUd8jp5v5Ef6m7f3Upq0LXzO9rYfN+NbcpQl0ec4
 GnB+gzRAh0XO9uSxTet6H+ghubT2yj8Xeo6Hbag96Jjm0CIg3EIBQc+UVqgveL/kUmjQdlSJ
 UsO9Sdoq6UunGSgScPwWQG5pjiPvhcGSvJfFuQ77EeGza+8yweCHmEIQi9pZ9kvtctwTjsvv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJSMB/truiIUxiRTCVZBvHbDdptj6Azbr2
 BiOrS4jl/MSi9IG0+Ow+lWvqyqor4THSRQwownNX3yo9EZpNNCNeYOl8x7Y4OxGIYLfSUOO1
 EXogOCC9KULAZCLiCGXBftVRfei4OydNjDAx1d0AoJJGymRxkNPtLt4uFlWTHqF+O5fEdM1S
 Cc/YT9s2aI=
IronPort-HdrOrdr: A9a23:6xHPzqmZpkEbDj/UV0UULPJRoe7pDfORimdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcLC7VpVpQRvnhPtICO4qTM2ftWjdyRaVxe5ZnOzfKlHbak7DH6tmpN
 9dmstFeaPN5DpB/KDHCWCDer5KqrjmzEnrv5ak854Ed3AUV0gK1XYcNu/0KDwVeOEQbqBJaK
 Z0q/A30QaISDAyVICWF3MFV+/Mq5nik4/nWwcPA1oC5BOVhT2lxbbmG1zAty1uGw9n8PMHyy
 zoggb57qKsv7WSzQLd7Xba69BzlMH6wtVOKcSQgow+KynqiCyveIN9Mofy9QwdkaWK0hIHgd
 PMqxAvM4Ba7G7QRHi8pV/X1wzpwF8Vmgrf4G7dpUGmjd3yRTo8BcYEr5leaAHl500pu8w5+L
 5X3kqC3qAnQC/orWDY3ZzlRhtqnk27rT4JiugIlUFSVoMYdft4sZEfxkVIC50NdRiKorzPKN
 MeQ/002cwmP29zNxvizyhSKZ2XLz8O9y69MwQ/Upf/6UkXoJh7p3FotvD30E1wt67VcKM0l9
 gsAp4Y5Y2mcfVmHp6VfN1xOPdfKla9NS4kY1jiVmgPUpt3eU4kYfbMkfAIDCLDQu1N8HNJ8q
 6xFm+x7gQJChvT4Ynk5uwQzvgJKF/NGggEDqlllsBEUnqVfsuxDRG+
X-IronPort-Anti-Spam-Filtered: true
Received: from tp-mdinter-v01.corpnet.asus ([172.22.47.51])
  by ms.asus.com with ESMTP; 11 Jul 2022 10:47:05 +0800
Received: from TP-EXHB-V01.corpnet.asus (172.22.6.13) by
 TP-MDINTER-V01.corpnet.asus (172.22.47.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 11 Jul 2022 10:47:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.49)
 by TP-EXHB-V01.corpnet.asus (172.22.6.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Mon, 11 Jul 2022 10:47:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQkzeEPz5rvoXBxk+e1SGDwUButDozMYIUTy4nGJlgMazd8KDc7p80cYY8H5e5Ty0e5NSN2ZfmmFuDg3D91XmIEsn+ELZIDALyD5oHCsSsRXQBJndmcPa0Nic5dzH7Z3PezyPi7ttSlv5aRdl3AJQoFOCTt6ETs0/CfuLgt65Lgviu9IG3lrgaNpGyLk5BMvuQYUU0OjxxZ7zTRxaMBG4cJM9KRrfjxnwo07rjNIYtTgO+vuxF5tEMEQzhY0/rrHHuPiOHJuhfN0ISdCkLcBqgqos2b56SfAnH4mV5FdqwPo/8AJrdVH+I40JQmQaoS3OYyQvlXU6jeX2hOXUa1qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFZPJEdbo501c3XbJ7wSPj94gg76+/BoRPTi3Bt7x38=;
 b=LUvZ+1SxKQ80p/eJeq7+rbwrQQQWcgj3U4tl11KikgyeEIv46GiU7vdEZLxVSyxSxrTKvz+ZLg5RglFKzrMp5/j4RKafSlIwPvEeBUp/UgIW6M5ld/2AIhTRLgWmbUdirheHXoGpn8mA6y+3QpONeWKvqU1rErudHzkcoxaVPbWe7BVzquyONN774+nmGXAFTemGDwsQhUk5gVh/52S8iLVYf4U7kINO8/avZDpe65uCafu2nlDDBFJcEfnZilqv6NbbIuiJqd6rPXeA0FcojK3zShxYWb13xkL0G4+DEE4dZrF7V7YkFNlAkREIqzUluUxUmoHtI+22686Qp+/9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
Received: from HK0PR04MB3363.apcprd04.prod.outlook.com (2603:1096:203:8b::14)
 by KL1PR0401MB4274.apcprd04.prod.outlook.com (2603:1096:820:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Mon, 11 Jul
 2022 02:47:24 +0000
Received: from HK0PR04MB3363.apcprd04.prod.outlook.com
 ([fe80::5032:7603:6171:2fc1]) by HK0PR04MB3363.apcprd04.prod.outlook.com
 ([fe80::5032:7603:6171:2fc1%6]) with mapi id 15.20.5417.025; Mon, 11 Jul 2022
 02:47:23 +0000
From:   <PaddyKP_Yao@asus.com>
To:     <andy.shevchenko@gmail.com>, <hdegoede@redhat.com>
CC:     <paddykp_yao@asus.com>, <acpi4asus-user@lists.sourceforge.net>,
        <corentin.chary@gmail.com>, <ispaddy@gmail.com>,
        <linux-kernel@vger.kernel.org>, <luke@ljones.dev>,
        <mgross@linux.intel.com>, <platform-driver-x86@vger.kernel.org>,
        PaddyKP_Yao <PaddyKP_Yao@asus.com>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
Date:   Mon, 11 Jul 2022 10:47:18 +0800
Message-ID: <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To HK0PR04MB3363.apcprd04.prod.outlook.com (2603:1096:203:8b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e977fa8-157f-474e-2a18-08da62e7ae8e
X-MS-TrafficTypeDiagnostic: KL1PR0401MB4274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kIAi0mSg9JXLAtOJ46a2LteFyK4rhrttQvolBgSsTFfWpUq4KkNzGPlMM/W/RLTfWD+NIjg4WAaccDN9Npu5+g1J1R2jGeS8gwiuSg3XHsqEFB1fbHNH+lSiuS24pRoTLY0LV/wwcmr6Iv2FBVKM7HLSyRsbs9XLEnK/BgTy9WwzVkI2GkV7loBM12iBYN+UcKP2l4+Arss9Bk8RQ0y3cv9e84G50XlkvrBIgds/0Wt8dX3K/gYhWFh1m/0Ho348O6BuO1IY6Q5KyPP5z9kM5VzU33VzsERe0xLl/K/mz2mripHYfsMZZgoIg61RGkExnmBzlGQDV86/THuVFi3oa+9NAOtOYshwkHWGvUd3PbXXkb7MGn3okoE41+cV0utMsf8PUv+Yt/ZGijNUZpiQNXXzTPRxwG8OjSqeqaEMm9QsGPPDp+ofaD76pJC5G6a7lgEActqRWd4NSN2tCR9+QNRQRPmo6W7LcZy/ishe192bTVHmNwFOXh/v35dOGyE63qYe7iui9P66Xn/eXSQnH7fmnMQTqoWfYvckXErRGy3ifN2Y2mwqJJikdRk+MosiARhQ4vc4dOjgLIic/twBWTMJKhY5+Ug8F2Uqr3MBIKS8TbZwqR2tjU3JbffYblRXhJN1ZMWyp4m/1Vn0DWplGyiX5Fnk6yH34b9llJ0jZ+7jWCmnoMYesdeGcoPpM5UTiIhnGaPw1m2WVDq0GWv0/UnGULS124ct3aAgjaGEqbfQ4+wFSFuepcf+fJx+MJdlh9ZrzaW0waM9RtSxyvCUdxSeP5gNQHNBYVc8+9Xh1Yn0GJD0x3yAyz2Rtuud1cT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3363.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(366004)(396003)(478600001)(6486002)(86362001)(38100700002)(38350700002)(36756003)(52116002)(41300700001)(6666004)(6506007)(316002)(4326008)(8676002)(66556008)(1076003)(66946007)(66476007)(186003)(2616005)(107886003)(26005)(6512007)(9686003)(8936002)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Yg1zVpZePxT0WbL4XsOrvXmRlXg+MECr7DTPAQPCfyOFDqohIK8zIoWvGgR?=
 =?us-ascii?Q?ELYI+jgLb/DIHDZdwpGv7QMtDKDMRpHJ/aX3ZvKoH/dvp5G04fOA3sP9jZhN?=
 =?us-ascii?Q?bOLSb27eeuknUnhxBfYxAcF32zIVvQ+TlZpxVfIYpgJgUUdlWQSBPDp1av36?=
 =?us-ascii?Q?wajT2EgHDWIAg3/j8YGIBWUc9QpXbh4dnChbeyD27Xll5q9rDCM8PjhMLRK5?=
 =?us-ascii?Q?BEnq0/Tk2sZDGct2m82pro34bsV42BYGF+oszbyukkKc3mRTvmO3hSm1Edqr?=
 =?us-ascii?Q?aQrb80yP3b2bKyNvPACBatw3cCzeMyE9Bj33wFNSznECfYZJJKOS1vC5A5MS?=
 =?us-ascii?Q?G9cE0tMadTsjssjJHjvbod4NfndgQjNPqDwh4JFxMpyZODwSmZtFvHYOS16O?=
 =?us-ascii?Q?XP5DqkT2D/NE1m0FdhsK84pAZjs64kwvoizjfUWE1IhPs/3N+ORUgJkdTzD9?=
 =?us-ascii?Q?IJDwpD8SBzBixC7S7NmhZK9yLtXAq+n1OurtzCOZ1vSAAtmyvjpwmJt+VAaq?=
 =?us-ascii?Q?IzvLaVQj6e65p4J70ModOsz6tAz+bAOndhXkUxBDRDfl3c87PhJmaPqJufxl?=
 =?us-ascii?Q?T1CHXDpfeOm9NxjcThhj/NCcKHlxxNnPXCpY7BV8l8SXqSvYfOb1cj5+ZLGv?=
 =?us-ascii?Q?DSCGQi+C74FclYPegAM+nYxxBcx5QEtc4nSDR7fpDZVKKXdq+g4+YVDytBid?=
 =?us-ascii?Q?jFI/R9kr7asfKZUoEXQ2RM0+wnMs7eSNowlx8Tne+S9ydY0cQ8itlXxAGfo+?=
 =?us-ascii?Q?idnMQihWB1SAFvJ24OIDD9O3PRU/da/y9thIlv5zJnRIQ31wZ7j+me44OMNr?=
 =?us-ascii?Q?ssbfPLkRUZEVqAYhLqrReUkF4oBY0obljG2SOExFRcu4YXnUKi5rMDY+ooQB?=
 =?us-ascii?Q?+zxRxbx9ylldv9N4wnBNMRcBi3NMQPZUnZs1TbJjP76ysvGjqIPQFYB9kZjy?=
 =?us-ascii?Q?lPHg1YbX8H/iC2pZyAHkTn228b7I+tnpFTJ8FqyDrGlwyGL2ST8J147ZpR1J?=
 =?us-ascii?Q?fnPdZ3iw2rRD4fFMujH13QG3CxdCpDN0OLUmNmv5xCJiwem/cgIX7OTowNSc?=
 =?us-ascii?Q?1mOUfSBy31FimYysmHr0RwoIdsUcwumKfVtdMfXNC2vwTdy+1j6TxuEdqD/8?=
 =?us-ascii?Q?xUjv0Cr6414cZToREqCaf10NdyrphxAjmDvd8C2gjnzc+RQHuieWUHA8NLa+?=
 =?us-ascii?Q?RRpL/UmiVXjI+cJ6/Fs1tywAFzXu9YBDLTCproYxLiCldT9PJJyrwxWGsNlI?=
 =?us-ascii?Q?KdyCHCyku7zZ8efwQDmaES36ImxAk3c1E/luXu855msbFHUWYbR+8wD1ucFd?=
 =?us-ascii?Q?0bUmKt/7KaYI0LdW59JZz772YOO+AZeIn77mkqaJ6fdU5RI4JvtPrCZn98rP?=
 =?us-ascii?Q?u0BCwcMYBxkfqwuIxRvnaxW6//FEKILdJpROgHsY6kzDeOU4409eZq0lqBEv?=
 =?us-ascii?Q?LkiaV5hBUUbYtqz7Dk9zHGEaqpSlJ2TP16jsBN0Oz+BDlYU294IBv3vPaQBQ?=
 =?us-ascii?Q?ljIFhtXwlPh91ux8Mz4ZC7O0qoTrmPGgwfp9A8SwySFfcOlW2tBg05OGd9NW?=
 =?us-ascii?Q?reXNRiVPBPtQCfea0DSSTHpOg3ph0z5xY/vDhPwo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e977fa8-157f-474e-2a18-08da62e7ae8e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3363.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 02:47:23.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alboumIZS3iLGVK7uy2PH6uIuidrucTvqNpjVl6Ln/tB6QYR0eXayIngNbxtPITpcN+WW4S1QZ46Wkk68aadLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4274
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3092-9.0.1002-27008.003
X-TM-AS-Result: No-10--0.460400-8.000000
X-TMASE-MatchedRID: cSoPLjBYd52aX3HcZnS3oxqkhv3OdF4DRealVAhocE8kt9BigJAcVnsA
        kVNIIeDNmC+wH+KoDcoUH8PmWo2hhU1QH6PUk2DDWFHKJ2wSViSHqfCKxjr5zToUdFbHYUawvwU
        evDt+uW5/XjpbSJS7a0sBtygzCPHvc33gkrfTLYhYXl/bcXwbaJgYcfOfx5hmL31P64kiV5EDX/
        yNv61n9Fx7oGogKAw03A+tqr+Jdv4hlf8RDoxNxbi7edL7cQQOqpDGltbclm+XBXaJoB9JZxRFJ
        Jyf5BJe3QfwsVk0Ubt2gyyw2xTBhQfyBxIYiPiHLb/TnAA5T/j2KEMsqThyxWglOgQVZjpsovWR
        HzgG4oYcU9I/IyxDZ6Qb5DSZmGFThuubwEHkXAZqJhpJfFffAlO4Oz5PE/4VljL0yikcb06cNiH
        8pmBc7ub/tUPjMeNRVOmr9EvEY/s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.460400-8.000000
X-TMASE-Version: SMEX-14.0.0.3092-9.0.1002-27008.003
X-TM-SNTS-SMTP: D7D699F25793026FC161EB824B2464A7BB9ABAEC678A8E0F775E3D23B14E50C32000:9
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PaddyKP_Yao <PaddyKP_Yao@asus.com>

In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
it. The binding of mic-mute LED controls will be swithched with LED
trigger.

Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
---
V1 -> V2: fix typo for 'present' and remove unnecessary pr_info() log

 drivers/platform/x86/Kconfig               |  2 ++
 drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f915cf67aa26..74769050b770 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -274,6 +274,8 @@ config ASUS_WMI
        select INPUT_SPARSEKMAP
        select LEDS_CLASS
        select NEW_LEDS
+       select LEDS_TRIGGERS
+       select LEDS_TRIGGER_AUDIO
        select ACPI_PLATFORM_PROFILE
        help
          Say Y here if you have a WMI aware Asus laptop (like Eee PCs or n=
ew
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wm=
i.c
index e14fb5fa7324..40c0e00a4b71 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -191,6 +191,7 @@ struct asus_wmi {
        int kbd_led_wk;
        struct led_classdev lightbar_led;
        int lightbar_led_wk;
+       struct led_classdev micmute_led;
        struct workqueue_struct *led_workqueue;
        struct work_struct tpd_led_work;
        struct work_struct wlan_led_work;
@@ -906,12 +907,23 @@ static enum led_brightness lightbar_led_get(struct le=
d_classdev *led_cdev)
        return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }

+static int micmute_led_set(struct led_classdev *led_cdev,
+                          enum led_brightness brightness)
+{
+       int state =3D brightness !=3D LED_OFF;
+       int err;
+
+       err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_MICMUTE_LED, state, NU=
LL);
+       return err < 0 ? err : 0;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
        led_classdev_unregister(&asus->kbd_led);
        led_classdev_unregister(&asus->tpd_led);
        led_classdev_unregister(&asus->wlan_led);
        led_classdev_unregister(&asus->lightbar_led);
+       led_classdev_unregister(&asus->micmute_led);

        if (asus->led_workqueue)
                destroy_workqueue(asus->led_workqueue);
@@ -983,6 +995,19 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
                                           &asus->lightbar_led);
        }

+       if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
+               asus->micmute_led.name =3D "asus::micmute";
+               asus->micmute_led.max_brightness =3D 1;
+               asus->micmute_led.brightness =3D ledtrig_audio_get(LED_AUDI=
O_MICMUTE);
+               asus->micmute_led.brightness_set_blocking =3D micmute_led_s=
et;
+               asus->micmute_led.default_trigger =3D "audio-micmute";
+
+               rv =3D led_classdev_register(&asus->platform_device->dev,
+                                               &asus->micmute_led);
+               if (rv)
+                       goto error;
+       }
+
 error:
        if (rv)
                asus_wmi_led_exit(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/pla=
tform_data/x86/asus-wmi.h
index 17dc5cb6f3f2..38ee75874d11 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -49,6 +49,7 @@
 #define ASUS_WMI_DEVID_LED4            0x00020014
 #define ASUS_WMI_DEVID_LED5            0x00020015
 #define ASUS_WMI_DEVID_LED6            0x00020016
+#define ASUS_WMI_DEVID_MICMUTE_LED             0x00040017

 /* Backlight and Brightness */
 #define ASUS_WMI_DEVID_ALS_ENABLE      0x00050001 /* Ambient Light Sensor =
*/
--
2.34.1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
This email and any attachments to it contain confidential information and a=
re intended solely for the use of the individual to whom it is addressed.If=
 you are not the intended recipient or receive it accidentally, please imme=
diately notify the sender by e-mail and delete the message and any attachme=
nts from your computer system, and destroy all hard copies. If any, please =
be advised that any unauthorized disclosure, copying, distribution or any a=
ction taken or omitted in reliance on this, is illegal and prohibited. Furt=
hermore, any views or opinions expressed are solely those of the author and=
 do not represent those of ASUSTeK. Thank you for your cooperation.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
