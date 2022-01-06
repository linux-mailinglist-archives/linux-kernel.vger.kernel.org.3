Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5618D48608E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiAFGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:20:00 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:56257
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbiAFGT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:19:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbTVJsSt5Kdnp7l3pGdV5bhUniOi6EYYfsUyGQh5fFs5TbrhZSfB0d3DhCYCEQ+71+ZNH4cDg3PRX1fEozAbxFVr+ZlSHN2SwWx4utxO8SWZtQscuU6WF7YeEjI6SMKum6F8UlyUgWf3uiLoSWbOU0oxiQIqF6UloQLJzZ+EtdYloiSvkPLfFxE6yC0wyqzLBBBRhV2koFCP5XJ+zi6fJeDS/j/BJLAnSs1c/viJlx/oPgVQEeKZf5fMj0JDEgHUogLvDxHtD6Y+FA61zU++Ysp318mmFdRCxQX9uzCUPvY+7K7OltZP3nXYUJ4r1DcXeOXGZQRlWtPTkxCogHzCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMKzi8jH3d1wCgGI4nePnhwICv2jYp6Or0tV/LkjtLs=;
 b=E0hej6hbU0vNvdbXEsEv1gOl68nihX5gWRHnMR1EOkbf2FegWR+6zobYLRWiT5ebzZMmi87OtBWv0VS18jJPEkqZuAr3p0poscGuPD0YvtuP9aRx3kkqVHVHQolRFCJY+SpGPRlzygqbZcOR6OhRb/cfNgY/q9k343zLPNqc7KSeqdyvpjpS/nXR8quRseVI3gFC05uzkfLooRZHIZll3TDzhrvP9YQWI7d5/gSonnaUKFpKhdLKfVNOZjbgVkdEEG17EHKVTGZeX3bzuUhQ9m1BpCnbYIQ3q3cfT1XxveI6DAbPOoTiTPAgjpTWjX6ohyXdUyuaazda66QVuC/INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMKzi8jH3d1wCgGI4nePnhwICv2jYp6Or0tV/LkjtLs=;
 b=VMeacYW2V7vc43C0V8p0vT8W6pyNa2S7tehPouVDs5CzkxdYtCy1nDHtpXCHIR/CkQYO4YBEqBEzQcB1mntFNyicYJWZ1xPAGX3tmUWbruxm3cghfugChom86uV3KOJrlIHDmXYeH04fZ0Qzo49GHnz3hVkJnVUX/b4AgunMmJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Thu, 6 Jan 2022 06:19:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 06:19:57 +0000
Date:   Thu, 6 Jan 2022 14:19:32 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] cpufreq: amd-pstate: Fix struct amd_cpudata
 kernel-doc comment
Message-ID: <YdaJ9GFoz4AlIgQv@amd.com>
References: <20220106021605.93341-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106021605.93341-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d9dfc6-7326-4bee-4ffa-08d9d0dc8f3e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1644:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16446EB1E2A01AC4A9F04D1CEC4C9@DM5PR12MB1644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxhuP802XsCV5BVXpl4OKkqy3rHcz+koRuS72Bk5PI+YqbAsDZY7uFN1T3XZ7WtUXeMorZp26ua/NGqZDSMKq4Gok6EYwqhQ3Gtz67EyKWBBOfl8/Bz0jcCiVPyTWuaYKEZ9G65SrCIG1w4lw54wLeHQDtMLF6XAh3RgIe7Iivl0KswyuXb6aMM6930JET3A3fP9OlnkdIzeFO5bFuhI20WvlHSKt7WJ2roQl22lwxN+ax35Tbc9lceUQI4DwTqiQmMufvvCbNeS557BNOQJzlKH0E5dA6LvXn1MARahhYxPHWtI4ItMUoD/J1vVSlVnPfjjgnubr7eGcjvfJGrhWV4O2e/NFFTP1gXMSAoVOLwwynbNxbRWqY53k7Q0B7PU9cfu++UKb1CpohJw3oRc60UfC7uRabhdC0TvgCg9M/ug4siFq3Dyu+bg6tdhstTUnTKVvCUJqhkBKV1GQBfYv+u6NUc4yS8H9Ss3qaCmDn2OjxMFS7aAzbbRs+Pl5Frp8g2xJfrAB/hxq/cNGC2z6GKOWE3VA1MO5yBHY5brtk++nm1KiJCVOkghlAHUofx2SgCOflbEj3wp7YU/hxH3mrPwHZHq3uaXwlk0VBsleLZHmLlvgoCzXllZVr6kgEmsR+FeQ1KTiq1EFgxIY3uwxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(36756003)(4326008)(6666004)(83380400001)(6512007)(6506007)(54906003)(86362001)(26005)(66476007)(66556008)(66946007)(38100700002)(5660300002)(2906002)(8676002)(316002)(2616005)(6486002)(6916009)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HEETacEEAG0W3kYHBWheXLrMGfCy9LzgHlpk+pICokHZg/5H8+JbDHR3jWT0?=
 =?us-ascii?Q?l15EeEzvu4hDKU7gRoRtFNlq7VcI7Lm1CP/xHKe5+pGQZaLV6fnlNRlwMs+h?=
 =?us-ascii?Q?IY6rcYmMlmBkMLIqkpF1TeiVycPrgDeH4yFim+gK7DR1hv5O+atj6HbNRVxl?=
 =?us-ascii?Q?jHbEBqEvWndQowZMUSYRnr28iEU9GZq3sKHfgg5Pl4iLZIxoKZm5PbutFdFy?=
 =?us-ascii?Q?rpohBZm+H0Cjcye8Fy4tDrXkzHn0vxEvKjD3QZHgOEEugxZJQ8v57UiHLbcA?=
 =?us-ascii?Q?go6iDHGLUiVizQfSsc1YHC698woLICO3DZxANPlXPeRxmY767XM933XYzFDf?=
 =?us-ascii?Q?Hlp+k6jXKHolpq9REVZCmVD0cRCK2f0DBgjRlAgBSH6k05HJCi701uu3+lZL?=
 =?us-ascii?Q?onmYF3cnzI3iqfY8VNeoIlU9HgtDhZ1dpk9IcULeW/zuPJY62gdmTnbq5Fo4?=
 =?us-ascii?Q?b8Fhf+yksYrksBiJTdhved/wHB6mokCt0LmnJrsRJeYcB9FsdxgdZQckn0eC?=
 =?us-ascii?Q?vD/oh9wP4FeF5DSh7+jF/+LQXM8uR/XT0VbflJTIIF9qyZViLyQu+ZWPBIha?=
 =?us-ascii?Q?epgQXSm2GEf4H7d0Ht98I80RO8TwB5igDE0fRreN2TAdoRwK3xNTdj9Ybaoy?=
 =?us-ascii?Q?KSGODcX0DAlB9LTnz7fULe9LVCyD094OrKsQRqFx9DAqb+tDdXtz8Gz6UfOg?=
 =?us-ascii?Q?/oIIK52Dmd2Rj+BIZoh0BA3ZIh2rEIwP8GOU3E50n1zhobLx4bcgwn7imtJm?=
 =?us-ascii?Q?PPYXqXj2vER3du8+5V5rj2mCruMF1+HDwatHrFyV8jfbpzmkEDP3VfUhdiZs?=
 =?us-ascii?Q?CfwgOdLoV1Tuf127QruJ8UPYdZdJQr8N1k7TwyCIT6AoT3+mg51UQZcYQZFy?=
 =?us-ascii?Q?xsPN8ksSYTecne5xLqZt2q3puDxr/8S+mvdbSbNSp5mKfAPamqWxMVJJiwsI?=
 =?us-ascii?Q?ua2CCWDNzsRvwbK2AuwDoACPeWSoJoaxWzQ5XKFp7/GnGjUqQHMHrA+V+wRZ?=
 =?us-ascii?Q?nFFnZGzigFEtJ8I5CwXlrYiFvoxw6Q8CucZORRNTA1Y4Xi51oPdfE/WVFZIA?=
 =?us-ascii?Q?Ly7sQMvXeIl0DXrZQcS9qBVzo6miDMXB/a47kFjRaCuazGKy24dVENmh2t7V?=
 =?us-ascii?Q?ndz1dKAlVsCpsSmZsdY5TILCIl1VhTDqmYgDAEWZ2eWUQ442ggEF72/T1Ase?=
 =?us-ascii?Q?3R5W/V8kqo+Ji47sIii5LmoAMvRgNncOsrfHqc8aUCw4f7OlqfhxciiM1Ig5?=
 =?us-ascii?Q?QjHtrG8KsHe2HE1OKKljoWsHJ5hFv1mtk6PG3sQTGce6eOcoO79rVg691Ptb?=
 =?us-ascii?Q?zrUYO10fsKaNo4eH0Dys+OzUEmi95qr4YD4oHpcpEyYSNCGcfCZSne4L651z?=
 =?us-ascii?Q?n+Eb4fY5hrQNteVEl50dAWU6ryFIvmIZOCnDgAea5gvUyE0qLA+Js8HPPLJV?=
 =?us-ascii?Q?rRH0TC92zF3uDDXQMvpeknEsE5gr6EtCq+rEMzivUshSQmxm0QrLt1uCKQSa?=
 =?us-ascii?Q?obLCVA6OzSYJreSn5wgct61/nhpxRKq7KdfnZ+Nj2rTbobIliHGOgQBn3WKL?=
 =?us-ascii?Q?4MBiJANZwWcmlegw3L3UC1rXoyAzCs6MhIGg2rRQrSFPxOFbJbXGWckVxleX?=
 =?us-ascii?Q?SIcDPWReL55bbqKLq6AxEUo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d9dfc6-7326-4bee-4ffa-08d9d0dc8f3e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 06:19:57.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki/vP4uo3BKhnJin3AayfTpsrr4NmilgRs3PWZVdJk7ETtRMgnFVhGqsaJciGS+A4SwwDUe6fw0tAPktj/9vAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:16:05AM +0800, Yang Li wrote:
> Add the description of @req and @boost_supported in struct amd_cpudata
> kernel-doc comment to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
> 'req' not described in 'amd_cpudata'
> drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
> 'boost_supported' not described in 'amd_cpudata'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 40ceb031abf5..9ce75ed11f8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -68,6 +68,7 @@ static struct cpufreq_driver amd_pstate_driver;
>  /**
>   * struct amd_cpudata - private CPU data for AMD P-State
>   * @cpu: CPU number
> + * @req: constraint request to apply
>   * @cppc_req_cached: cached performance request hints
>   * @highest_perf: the maximum performance an individual processor may reach,
>   *		  assuming ideal conditions
> @@ -80,6 +81,7 @@ static struct cpufreq_driver amd_pstate_driver;
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> + * @boost_supported: check whether the Processor or SBIOS supports boost mode
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> -- 
> 2.20.1.7.g153144c
> 
