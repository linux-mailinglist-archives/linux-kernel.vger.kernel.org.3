Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA95493664
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbiASIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:35:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:1593 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352527AbiASIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642581296; x=1674117296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=32Roy5p7DLjCiyZC7pNZ8vRTcoOSUxxDVXvR1bN2CAk=;
  b=kC9Ms+Ukntl0APd8d9PqTCIEQrdOcXa6bu8Z2Q/03Bj3CvmF4HV4jpIP
   Uln/B/1kl+RSRNhwr7h9I5om89dKFGgu8LnaHqyTM0MQomislQNzJcqGX
   YSJb+d+CWgu20Lvj79T1S3DxOl9HBK0DfZbun4Qc9jv0Z5Q9OZTmQQKxn
   FuR5hX5e2q5c+b92zmZsqsG/e/m1lo98U8pHxK3weZOw+0p4V399sYHmV
   yYtFL7qw4CTSxzDDcKR0tY+XviMsJk8/hMO7zCJ336+noM9amVrPGam/r
   WgDHTpDUt5UgPrWTjvp08sL5ULvVw64/+1yUzUtsGZXlwVEQNHvDrUPV5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="242578907"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="242578907"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="492956958"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2022 00:34:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 00:34:52 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 00:34:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 00:34:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 00:34:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfwzFIO5j+w+2pHjo8fu3Q1s4sCebtb/dTcX0sIFvukiqgN3tpOIlqOjOqlIclQQ7C8E1FFfrWnP25EXl7+4OAymAnQ+GTaa5MXHt8i5mH+GMYvQPT6lLilB11zRPnwBoopcI9kczQCLe/elv6GXZFl05JbdDxDG+H7CiLpLHwW88KllK+s21WjxcyoTKIQUYQocyjQ3/0xwhNJxA/KmsxVqZjUQ8k3rIuLX7bLu41nqCm/fGJNcjarEDvmiGE7tGf0+Q1DNvMyOxoeaf/+59QcRVyfGUklBqLqzquUt62mUJ2O2DFaUcUoZ7n4C7J+yRlWa1q/tQ1eVLyBPbOkMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/67U84hT0a25z4NuSM4bWL4JAevgnVNYUBQty1rJgaE=;
 b=j8IeOxjlkE6KXDyXeNTWmDK175Oudz9rCyQZkOelZL+hv69DT165pLQKhy4cvarwAu/MM/+YaueQGmCDJI8EJbNPHw44w/fj/z5G4Jjfq8Zj4LuuyFAlpNI4ZAujKuQTDpsSdv3icSTtf6g5zHNuYqtsPECQjBnE2I50gWXwmob/o3yhis7eh4fMf7wXgWOomsGS/2ZYVboxu+kuvH1VEbjw0epW79eXci7SfPefdabEkFpsj/z+uYXp1jgauRBdY3NqnQ1u8V0KEO11iV2O6h6yZZm3d/ZBitW4fo8WCmJZaKP/DsWgpFDkvnxsLtAraqTAJAssPCRRK+1VlXeLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 DM6PR11MB3995.namprd11.prod.outlook.com (2603:10b6:5:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Wed, 19 Jan 2022 08:34:50 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 08:34:50 +0000
Message-ID: <dd84f8d4-097e-45b9-aa75-812b1fc524ff@intel.com>
Date:   Wed, 19 Jan 2022 09:34:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [v10,1/3] drm/dsi: transfer DSI HS packets ending at the same
 time
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220119022543.26093-1-rex-bc.chen@mediatek.com>
 <20220119022543.26093-2-rex-bc.chen@mediatek.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220119022543.26093-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR02CA0036.eurprd02.prod.outlook.com
 (2603:10a6:10:52::49) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f033f92e-1c52-4646-a9c6-08d9db268ee3
X-MS-TrafficTypeDiagnostic: DM6PR11MB3995:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB399583FCED0BF62661850BFCEB599@DM6PR11MB3995.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXr+0H4vwEPrAqWKMklogUXTRqVhCXssDkYFZmaRMVbsRTHNKccN5Ih9EX6UcuxzzOLtbN0/XcccuetuaTT0VXvaUyYyuWh1wMNgEnRgfAJY5mtHa7DViWe2SV2T+zEpVzXMwq5jr/iyTnwp2SSYEYiZZ6q0XUFREUe+aHoSAWS2T0CiFU8OJzs3igrHK/g8bCUQsd1GQgyTlL6l8s8vzmiRRaxULsZp0ODIjF6/fC5FJPlbdRqgbXBMo3RZPVCHxKpPTn3x3+GXIMpNPm5Orl/LwJ8li4YKZOvVoiZfOxixrfkzJG/+CXioNjc0Za2Z4JvJq75ocdC3zJb8rF/v5KH273n2UDhnUCcHCiBMLLQ8QL4r5jGbdOPVrxmASOp5ItYVfN9bpRpH2iG7ypSeSCePd7BTMjMbCsSne69uUHNuUB/cUbZLgOA+f5go5vBW6eVKa2Bb9gPadisjGM1fEpvQksYaOwrpYb7xl3HW79M0vAARVdazYa2HS82GVISB03M/2gHwqzc7ZjxeO9ZuTSG7Hjkf4piRxKlUzTRNqt2brjwy4GpKe+1cMWMExY+uWo6wngPSOzFRxMj70je6v9AxJCVCSW25qZytKnRoqfWpylNlyMQM7BNQE17hc5MClOaM5gIyHchuS46v810Ywy8LnFEsHSdsps1Fz0hL3EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(4326008)(8936002)(26005)(36756003)(8676002)(31686004)(5660300002)(7416002)(508600001)(6512007)(31696002)(38100700002)(6486002)(44832011)(86362001)(2616005)(66946007)(66476007)(66556008)(316002)(82960400001)(83380400001)(6506007)(53546011)(36916002)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P3T8LzeLzA2rdE3VF5vM5x+TLreKexVZKKwhlJgkmI2QGS8Nd16x6Grmrgxht1lJ+4Pqh+0QBTbTp12LrLDzzbKCyIo6oQpoCBXAyas3FJwMv84+EPaivCFHFPEu/ZdSU6HJouULiIcECUctConvtzgTooVrMbyUFqlCcjuZgkg5HAzjgojnZ1KwepanYh2y6THZU/OJszyjcYOn010SlJSPuQ+ha83EBL5FAxxNvj/d5Oh8km6F90mIA9BN8hiOReVcTf5EJ1zmGwJvBqz1Y6nRl+KHmnDrknxkMFHHP1cORtYgiRGoql0IfUkPbJuasUcg3+jiVe/jnUebmNnhCsUPSqYyQ19vnX1jnFRwJ+4PRlZCwlXmbz5s++/45GUVTJbNDZyEYbgF4qjlOSsJ1sE0taRTaE+Qk70Qtu1laYPuvcJgs/SiuXeiRLQmXNUQ
X-MS-Exchange-CrossTenant-Network-Message-Id: f033f92e-1c52-4646-a9c6-08d9db268ee3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:34:50.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s11K0DT3SDFgGrZoXvFKfTWPdyD9bcNaMMFaMjnIG5DZkwaEntnXaYHDHsytts0ns37+BUDThZOGMmzfTbMt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3995
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.01.2022 03:25, Rex-BC Chen wrote:
> Since a HS transmission is composed of an arbitrary number
> of bytes that may not be an integer multiple of lanes, some
> lanes may run out of data before others.
> (Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)
>
> However, for some DSI RX devices (for example, anx7625),
> there is a limitation that packet number should be the same
> on all DSI lanes. In other words, they need to end a HS at
> the same time.
>
> Because this limitation is for some specific DSI RX devices,
> it is more reasonable to put the enable control in these
> DSI RX drivers. If DSI TX driver knows the information,
> they can adjust the setting for this situation.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards

Andrzej

> ---
>   include/drm/drm_mipi_dsi.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 147e51b6d241..51e09a1a106a 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -137,6 +137,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
>   #define MIPI_DSI_CLOCK_NON_CONTINUOUS	BIT(10)
>   /* transmit data in low power */
>   #define MIPI_DSI_MODE_LPM		BIT(11)
> +/* transmit data ending at the same time for all lanes within one hsync */
> +#define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
>   
>   enum mipi_dsi_pixel_format {
>   	MIPI_DSI_FMT_RGB888,
