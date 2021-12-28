Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B133480777
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhL1ImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:42:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:53689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhL1ImX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640680943; x=1672216943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSqxKZ+1S+aKG3rT8pMpa2DJ/Zsa+fcstG1zVVNVaNQ=;
  b=GVPMVmv+UHMSrHuJf8Q/ob70vE9+dNQOTqJJ8mNJpBqaAjinGTk4a5XY
   9REBLDdUzLJXEGzs2TItc3C4sHk7RqQce0011wBZ/WlCJYXBdJjIHmyqK
   E8g5cb6hIIP+DP8sPAtpL4LS4JktlNcIvnT301eOAncxRqRxEocoaRTnn
   UowYnmRi2b6dLg+rabu5PqFLMFvyE8roQ05ELAbtRkXCw+CIP804rRDM+
   QkF161qebg2afv8mkrnJ3h5FkxsJY2zvbzsy9geztmkDM51L/EOhguTSw
   dz0oWqDpBa5yrZM20JIopC2hwc1U+DcPQafXj4mUJ0Pm2wQnVRtaa0FAz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241287091"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="241287091"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 00:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="524493746"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2021 00:42:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 00:42:21 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 00:42:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 00:42:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 00:42:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7O93CAlFjZrdvyy3ye6UIBnFlC7zQrvujvwY7VXYs9skLCkMVjsFWBXcKsPsR80JQ2FM0QGSpKEYfBVtAvwMWCbbzjtaFsxXRvazr2h1mTaIrME1DOWCJ2iYQEAmA27hulaPBCSlYyb0q7RqSPE3AwCoYPJ22EytX2jF1XKKpDejZOnEGt4+PltDaO91Z7tG8h+WYxs6N4mw9nsrMezA46mbcRKUZTn4lwQ/YKcsFUr/U8HsL+h+oN0ehoy7TbaQVSkCb197Oh1OguqqRHYS4YbpNZRh7BptIvpU2d4oJNrf1pBbv1tlZ2AJk02ETQiP4N8+y7Z+xeI0PJHmkG3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s59yDK0Ev4BgbJvz4VNd9rOqVscBmFJXoBDVZLLZYrU=;
 b=HwV1gdbpAQKMFcDvaXIHtqNWqBdUXtd2MqyL6LuWqMQawhyTDg9UN2d2ePdi9lDRVpNV/nSvGIkmV24StTZ9RNZbn9orMNMGpAwPtqfS1Rpgu/1C1/ua6XZ3cUVvFd5eWmSsF7HzixLLLlTaT9+mm1iCpshg2QKHasNdtn5rtXpkeJfOcTJApexxom3I4WpCelQ9/mM8rnUkytiyvHe6FC51aajraLpCxz6I7Jbi43sQdQ+EqpGocDHH3DcP/yr9wWGU8T9AeCgAr9lyGF7g9OOmZOOhk6rYnjfKYaOgRjjZTvMuY0jmqVS4WOggxniBrLbC3XOVXr0r2B/hZdC8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 DM6PR11MB3177.namprd11.prod.outlook.com (2603:10b6:5:c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.22; Tue, 28 Dec 2021 08:42:16 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d%3]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 08:42:16 +0000
Message-ID: <4197bba7-9827-7490-6ebd-f3c8da74b5ad@intel.com>
Date:   Tue, 28 Dec 2021 09:42:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH 04/13] media: s5p-mfc: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-media@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20211223173015.22251-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::14) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891a8d9d-194c-422b-8772-08d9c9ddf381
X-MS-TrafficTypeDiagnostic: DM6PR11MB3177:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB3177F9E09D11389AFF4D79CBEB439@DM6PR11MB3177.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbXmgpTY3GlfGu+MSQf31f3i8ppE/N7pYapl77/7xa0g8gKYQdlsVJoRXLlx0ywA4T1hMlBRRXA9KEsummG4jHVJsMq8ww1IVGY07ZF9FcGlSAfqF4dJSs3G4TOEPqFSE7L48qyVulzrkAqjU782sYDe3ewJK8gcfnVobqRzLYsxvuAMfgpF1pO4xj/pEcm9Uv3InG7bQ1/Xr3VqAynWmz9bM143zJ9o5c4cchbV+cvpm9TSqTP6rq7IR1KZSPnhixl158P5DSdclBN5RlKPNWi2RCHN9vRhplF4CGuOEySNKaJiiTaW+svIqngZXxpixvNQVdE5+umYFZ3VJLvvEO9KPisv0spAjR+T1rVfUH+rA+GsVjcL1Sq3cPkVH3oOGnkW4k+oINcMraNOFyJTb69v4sWxnWxywx0OHiKh9QHGDdbxc3qTyq4X+yQXXyonZ0II390yy0aUHwShbvVmClWMonsk8TjLQixWkICVbq/a6m/6+W0RUjidbRlq1OPuRsMScRUWDWSbpO3bNL1dXmOhBS4tD/7igJrLWz+wZ+ceYbJkXyeUFnHQtktt6uCEZH9zLn1xDvD5XIe1IiPSGRQ0x0hj/DqxQdE7rNZ20kcw4YJOf2e357AHWnzXMakWcytkbrFZ48fnaqj31G4PtHnMdN/mFY8485Us9nK9WqcPLLQkM+mqIexqijhL84Rgz9jWVreSqhxdcxQSZlIpskRgG+hALJQi+T+WNmnN+oUs5QsI7B7wqq8UQTHTwq0p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6486002)(83380400001)(66946007)(5660300002)(2616005)(110136005)(8936002)(508600001)(44832011)(66556008)(7416002)(66476007)(6512007)(38100700002)(53546011)(6506007)(26005)(186003)(36916002)(86362001)(31686004)(8676002)(2906002)(54906003)(36756003)(4326008)(6666004)(82960400001)(31696002)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NngzRGVBVkVESlQ1WlJDSk14RDZZS3YvWHd6YXZtM0NGeGJzVWlBQTRuU255?=
 =?utf-8?B?MXQxdWw0anNodVZ5MDlQTnhkNVY1TXFhTjFWMlErbURoamtwTEZqU213RlFs?=
 =?utf-8?B?eC9QZEtjYzJTSUhOejRqSGwvVWVaM21PV1R1bHI4Y21xdDNIQWV2RGRMbFI4?=
 =?utf-8?B?aXJLY00rWXFuQ2pkZTI1elhJOGYrRW1zbDJVVDRNUzh0VExkREoxN2pGaWRw?=
 =?utf-8?B?bTNCTmMxdVcvK09QdktmY1VxZHFPNzFDOWpURXlXa1RNT282S0EwZFVuTlNk?=
 =?utf-8?B?U3pBQnFxemRMNVZIOG9xTUF6SlhqemhzTzh0bkhPZzh4dVU3NTJsMkFHWkZz?=
 =?utf-8?B?Y1NSWFdlM3cyeG9wcDlXV2Nsb2huTk93aWpzMWtOUy9rTWc2eHJpSnlpVWZj?=
 =?utf-8?B?YzR3UHdRNEY3L0VabnhwY2RhUlJ0Vy83T2ZGVlBERHVoMGdFTElDM0pQMjFK?=
 =?utf-8?B?ZzNsbXhwK1FPTDhGdnFGNjErZnRrTWVXd3pNSHY3dWRrNlM0dTNET3JWNDhr?=
 =?utf-8?B?SC83TTU3ZG9oVUdqcitETDdpTE5rMUxqRG9qNFVNRkFNUnNmNFFtU0FQblkr?=
 =?utf-8?B?VjlwRnljUEpKODR3a3RtWWgrWEpZT1pDR3UwRzZEcm5MeDVqRHJxdld4T1BE?=
 =?utf-8?B?THBPQ2g1eFhhSGNOZ0liZS96WTZ4bVcwd3dVaHJyT1hOR3c0VHFDY0I2b2tO?=
 =?utf-8?B?NU95VHJXK3MrNml4MGs2UkQ5NjhYRjFmVUZFTEVDWWorbTlXNjEzemJtdG4z?=
 =?utf-8?B?MHczc2JQbjRJMG9LTEVST3FBSTN6T0Q5UXhZeW04WVNZS201STlXNndZdjg1?=
 =?utf-8?B?QUk1WGxzUTUyemRUaXoyQ0RrcEYzVHBvNEdEK1RxUENjdjdCRHhrVEoxb09T?=
 =?utf-8?B?RVdNSkNTVXQ4Ynd4Vm5FeHMrQzhKT1k5bm1OQTg0bVdmYi84YUFDbVpFOVZB?=
 =?utf-8?B?c052MkdTUmx2d3RUYkxScDJlQUZEQ1lyR2RwRE5oREhtVlY5L0RTTTZOWVla?=
 =?utf-8?B?VTF1ZHZ6eHhPRjNrTExKZ1pNTmFJVXBFc2pKQ3ZJZDNmY0hzaHd5bjQ4cmpr?=
 =?utf-8?B?QitaTUFaaVNCaUk4TU9iZkZLbmo4eDBPeHJzSmMvZm1TRE4yQlpzQ3NlNHZS?=
 =?utf-8?B?eVYzMUdqcjF4VHo0ZDhLdjJld2QxWDlTcC9XWThidTJwQVFQRk5aYW45Y1Y0?=
 =?utf-8?B?dFFHbExYTGZ3QXF1cDFabU5YZmNqQWFLTlhJM1VZTndOYmZrU0VuR0tQeEVz?=
 =?utf-8?B?T3hVRGhPNlRyYjFKRmxKUmQyb0tPNnhpcFMrb3BGK0Z2dmZhbkJJQ3NVK3hQ?=
 =?utf-8?B?em14U3pMM2FxRitkVmdDeGRha3NqamFyOGNoTDYySlQzc3V3Qmg4a3lyd1c5?=
 =?utf-8?B?TXFDdSthRk1sMGtXWU1TZXQrZVlocGdJYWl6dnJKb1BQV2ZiUW9UT1ZDRzZP?=
 =?utf-8?B?YTM2Mkw2VmpKRVprN3F3UFliSlY3WVB1WGtEbnlzN292WVlJV1dVc2RnMUhk?=
 =?utf-8?B?ZlJjUkZHMmlyc21GZUFwcFc5OHFFMzVMUHNnMTFzcFhwRU11bzJxcndKSWxK?=
 =?utf-8?B?R0Nsc0s3dG5NS2JPU1pPMVBKSkFsUXI4UmtyTDVtb3FWUU9FZ0t6ZjFpdzdG?=
 =?utf-8?B?N0VNQWRBRFpVWXBqOXRrTGg0UjZ5ckVXeTg5Nk5MdFlncS9JYmJYRWFsVVBG?=
 =?utf-8?B?MXdpU3NhOXNRbkNzdGF6OWt0Zm05N3huQnZTZjFzVTE3Q1NpTjJKVENVNkhi?=
 =?utf-8?B?WXFEMGlXdzBUNTlNMENyQWdMUytkRDJJNFBGdE5HMmtMclByMkk2U3FyZ2k1?=
 =?utf-8?B?R0V3cURHRkYyanBpNFd3NkVJTjJhaDFsclpIMUZGTjJBZHBHdGlpMmk0TXlU?=
 =?utf-8?B?ZU8wVG5pck80Rzd3VDZTc1FEZkRmL2ZpaWlmSWNmOVhXWnJjYWgyTExVbDVk?=
 =?utf-8?B?cDByZE9Xcjg1RHVoK3R5cWZQbEZ0eFhHcG5Rd0Jpa3BrUGJGeVZiYmhIS0Y2?=
 =?utf-8?B?R2hlT1BhanE1S1BvSllFY3JkM2ZBdzltYXE4eTlEOG9pbVU3ekh6NXFtakF2?=
 =?utf-8?B?SmZId1NaQW5wYTYvalpaZEY0T3p3ZGxUdHFaVFgxRkRwd1ZiUUlNK0xURDht?=
 =?utf-8?B?dER3anI5RUJMUW1WL0tTbzl3UkZML0FrMHdBcncwckhvTkRhUUhOMDNvOFl1?=
 =?utf-8?Q?6ehsVstEzKOjwFnoROLjK9w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 891a8d9d-194c-422b-8772-08d9c9ddf381
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 08:42:16.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wreYAyrUGWxBjhfzaqXIb1fI+YZSHC02ZU3i/y87lhAVji8P4wfEhqo772A99L7FzSl7x9OHP/GQJPHp+fHdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3177
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.12.2021 18:30, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards

Andrzej

> ---
>   drivers/media/platform/s5p-mfc/s5p_mfc.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index f6732f031e96..761341934925 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -1268,7 +1268,6 @@ static int s5p_mfc_probe(struct platform_device *pdev)
>   {
>   	struct s5p_mfc_dev *dev;
>   	struct video_device *vfd;
> -	struct resource *res;
>   	int ret;
>   
>   	pr_debug("%s++\n", __func__);
> @@ -1294,12 +1293,10 @@ static int s5p_mfc_probe(struct platform_device *pdev)
>   	if (IS_ERR(dev->regs_base))
>   		return PTR_ERR(dev->regs_base);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to get irq resource\n");
> -		return -ENOENT;
> -	}
> -	dev->irq = res->start;
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	dev->irq = ret;
>   	ret = devm_request_irq(&pdev->dev, dev->irq, s5p_mfc_irq,
>   					0, pdev->name, dev);
>   	if (ret) {
