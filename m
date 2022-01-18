Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FB491F43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiARGHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:07:06 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:30337
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240422AbiARGHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1vY9cY1YPaofK4HpLNEWLGlekGHkg1QQEWfuO3Zaj+6bgQUW+SYF3Ez6CvettK1CwrueGMhHyRKV+u9gE/iFkASTzpfNuY9GAnb8cqKz/TV0lTDQlkJyc/PA3axbAE7gFEAaBI4rptfQpvxlm4D/oiDtAw1CDNzIRIAqnbEIbDTzgL7RRgvxNWSKyFim2bpVxwTvITWedi8jSkNtnOw1Jm0un75/MGrOW6RDuu5j5jw4POUlLKtWA6l/upaFrXQ2iuHbeTfBZoWOPPXVGNLw5zb9cTne1HB/CEXHW2OBgXraoSyxi6Adb/3JwgVfrGHmgK+UtXfKaXUC1KKgN2Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOJuIv/30qzyGJHc3IgJmEZvRUp6eICNsPzSM+A7xrs=;
 b=QfCTKDGV9zrsW1ZSJt1uvVY/ghougk5wQ1w4nCtwUmU/ZZ5D1vimc5O8s3OdymqapRQCzVF84z8hirvyHPl+qn0H5icelwmV9hFX4GyhXv/aMotKBPj+rmER2j2/X9/xgrKEIgkUZVHCylxK4PGqAWOraMTQSHHMIbiW7b+areaP3HWW0MDOEjuCwWAyac2ZXCXwDsluNj+OX4IQCsMoxWsN6a7nh2tFEYsNpfxkFaXWYlxCMyL5+LkervSlloaaP0C7kheVDeIKOA5OKUlJZyWCr4Q5eFu1Kk6dMRW0D0Ee5vVRMfKlDPCJvMJUZJ/a4K+2E8dPcHJQStN/DndxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOJuIv/30qzyGJHc3IgJmEZvRUp6eICNsPzSM+A7xrs=;
 b=l83Nt4mCCl/amm1P4Q9OOqu4DBHF4D490QoDuqeYJTiGwca+57ozgbUQ5MQTea0+PDjYX/Tp0Y7lspPlnVJBIAfd3/3Gj4unEkMmnbIzzMEAj7lTp6BRfACfCRGlgB04c2Br6lBGUcCjtYq+6N2DJwz6tg3xTUNQPetGWXQRVXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 06:07:03 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 06:07:03 +0000
Date:   Tue, 18 Jan 2022 14:06:39 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: {standard input}:1381: Error: Insn slot not set in unwind record.
Message-ID: <YeZY7/KC7a03rCQB@amd.com>
References: <202201151944.siKQX7w9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201151944.siKQX7w9-lkp@intel.com>
X-ClientProxiedBy: SG2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:3:2::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fab9734-1da5-4745-461f-08d9da48bf5c
X-MS-TrafficTypeDiagnostic: PH0PR12MB5434:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5434F84CF504C798F1E21317EC589@PH0PR12MB5434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YvQdZ3egNjYXquDXYeqiopjc1fnJIa+lGqNR3C/1BmMV/TGIUj/PHhbVy4UnW/dm1oysejbwu9+uLAinj9Werq8DrAR1EF50d7eVHoJStbUAGT1b0YDO8x2aTGZQqdORsraVLgCxessTMbBmHFJSGXSl/0Q97hQSzn19yBhdpX5uTCu3PINzE3aBiJpAcFXqLmVT6zx3Kmkw1pzmcBrpOHVuYRnVXamDjf0qCIzYdBqT+XECvDktUHkQ9dN9rs+LkH+LZeSqtgqOqndr7RzboQCFYKDOV0kNEep9iX/K2rVerTDM1AM8A9GBpgXm83A03ODu766E/yVxQb40wIAk5SvMmwqUaOj+N3CeTn2umDXhx6xdG3RgAQXjCzUWuz6n0BnXYMLFuROEBIWYrgixPraMlkfjWneOpf2nwNSUOQAG7nJKujMdOVhyywLHliWf5B+pqig8Q7wlWI4zeziSbo5YwEsrmWDQODoWZp/ov43bSdA/xWzz/tLjiQiXsOez2dXKyVSOfl+1ThFJ5nxH7C+nEHswZv0rZGWI8jjdYV/tGhgxVUJZZ333+9Nd3jLZX02x60cvwmbLbEO2nONMHYnrWHB3nlKmOiKa1GaYjxnIkoHT/CzdHaVEjJ344rS+/ZqKfqFt3wV8lLQCJUhv59O9V99HHZRWT1m7KluzmoV9ITn3cILFv2kyCwDJl9QrksX5FP9NLere0uZsaiOP6ntkd2e2VxaUIH6t7k7oM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6506007)(8936002)(6666004)(8676002)(36756003)(6512007)(966005)(186003)(5660300002)(26005)(508600001)(2906002)(45080400002)(86362001)(6486002)(38100700002)(83380400001)(2616005)(66476007)(4326008)(316002)(54906003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3u1ZlsHHzYdZLFbt6RwjZJA2MT36tw2I2v0ge7q661w2yviusqve1NO1Rjo?=
 =?us-ascii?Q?QTKdwyRIEBtwvWOuMlI+/1+MnTHh20siTy086M0SzNa+S9wU7zjWicPX98hs?=
 =?us-ascii?Q?L3gY0XjMlTWBGmrDHap0mzciQmcRYq0l8X1RF1ditx60iHOs9uDN/BNuOVPh?=
 =?us-ascii?Q?zdP8NB536xIhhlkSD+K+SMp0P3dGcIM4ETaecHCy3kvNy58/GVS23rvlI5jT?=
 =?us-ascii?Q?890cgbCSszhRHRRhjfcVnWgCBEYQWOh/5gM8RHQxE/vKvRvWwO3ngh1sT2pL?=
 =?us-ascii?Q?pi0phLOQJGYjw4CmBF9Gdg+jkfX/JsjROCVgVZTM1IPKs6YTmYltAiBapfhv?=
 =?us-ascii?Q?2/3X1QUv98tojGkb998agxlZn9thL+zVh+I8fcQBvxo1EyESCnRwlk2n8ZFR?=
 =?us-ascii?Q?dp31NOKuRtQpGFAVMS4UPvBDLEddYKgfWTzx+jG5lDY39uJktBf5i+zihIdq?=
 =?us-ascii?Q?yYgur42fxxsLvjJpwjVBf0S9y2vkxD80S/A/DpA7Tql5PCujRuEJYha1WZ8x?=
 =?us-ascii?Q?KkqYK8BMwhk+qvnCfXnJE5QAk2+SowMmBTMlbEgoBVhpilAFoWQltn6dSa7p?=
 =?us-ascii?Q?EIYy5rgQAckQstw4c+3ppO+sJ5BZHbRpMUOhnbdF8OMuYPLfrBt35etrH4zb?=
 =?us-ascii?Q?dnO00qPzTlz9jln0wdkRY20vpjOlzjeJM45b8abz9T/ly/bAT/cvPONfjLow?=
 =?us-ascii?Q?IHXhd5b/ol9uMEX+R6AjRwdlMUNowsAwB1ohlFVUbgrVofTOXrbxO5g9Evkg?=
 =?us-ascii?Q?+30sfOhiOfTMqD95vccv42xp0RwbrOIaEZY/F574gVq9tg0hEfzYZlgiRCKS?=
 =?us-ascii?Q?207FwF5fa5L1RLqXffHn2hu4jr4uDAgPw67Dujsj986xqJodFsILUu/yGzLE?=
 =?us-ascii?Q?VfsAsWC+4dkfwMUXUOVwSvxMC2uwRqcWkZWmLXTb98DXPAf/dUjFO7SMWmOM?=
 =?us-ascii?Q?7e9fajbBq+hSImr3ArHr2LJc+z7djYT9j+SIqouRGOkXJXzkCFsG/fiiDjQu?=
 =?us-ascii?Q?aCGQPgIzFsiEp+22GM45RURJEuw5RfDi8YjGlI8FMF/Nnn51rsE3M9uq1pra?=
 =?us-ascii?Q?6PFLVRAsYzIQc6XnaXmLqnImAdC05vzMWchoccbldGuzkcdqkrtIwg3l/BxC?=
 =?us-ascii?Q?2+ONHMk1VjuWuWzF1XKDFY7sKHxmS9FRJEuzMY6T9dX9fy8rICOxYdTAxq3Y?=
 =?us-ascii?Q?C8ZTI5UXNccFoCvgDNJOtJACqND9lZ5a9nVBc2gKhIyBD2sKTfjwsamK8shx?=
 =?us-ascii?Q?754a0B1AtcPmmBwWQlY86hmdZRFN0qmfnh0ke+cq+FttyBw5IVp3P2lEiNIA?=
 =?us-ascii?Q?E2pCJSF+o97Im2d3SDnjTDdC0qEKtcumkNRWhJebxGUhoOdyUO1km5+EZEUK?=
 =?us-ascii?Q?Mg+a3ppZLssK3ThzIv9aeFZxv1nOGuSsBJEGohCH25LWGMRVM6c8S+pIaO5x?=
 =?us-ascii?Q?miQq4x5Gi36IUBB6eUWMJ25fe+8W8M2LhLnEFvJY4s5l0RayRzGHyQ2wDUvF?=
 =?us-ascii?Q?DYMe7goer2DHjCFGKzqDIj8JLTTGKpUlZqlrwGeUwI04BkwsqFoWYEQRct7H?=
 =?us-ascii?Q?ruUTFMtLWz2+L/rrl5wnQo92xvCZm66s8eLpOEDl1usMHaQ37tTuIFUe6KxZ?=
 =?us-ascii?Q?7bHosDqphmor7yYjGIsgMVs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fab9734-1da5-4745-461f-08d9da48bf5c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 06:07:03.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16CSxj7WlG+lu564U/kfK+ySYWzp149oH9K70NUW9v32+HbGX02RMnEGoB1tYjK+3ucHDAZtr0iQnwytFpxj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 07:49:12PM +0800, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5x0UsKxXHUM8eaXf%2FfEJg5A7m4lq3IIJB5yVoH8wyWQ%3D&amp;reserved=0 master
> head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
> commit: bf67014d6bda16a72deea11dbbff2a97c705ca92 drm/amdgpu: introduce new amdgpu_fence object to indicate the job embedded fence
> date:   4 weeks ago
> config: ia64-randconfig-r033-20220114 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220115%2F202201151944.siKQX7w9-lkp%40intel.com%2Fconfig&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=wvSyECxjF2Bq0hIolStzs%2FST9%2Bi9w8O4zNDQAxolvZI%3D&amp;reserved=0)
> compiler: ia64-linux-gcc (GCC) 11.2.0

May I know where can I get the GCC for IA64?

Thanks,
Ray
