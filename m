Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F17493668
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352551AbiASIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:35:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:58252 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352549AbiASIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642581331; x=1674117331;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DokxPtNl15TI+uMq1LXO792XDZO9eWNkwvuwYNlfBtI=;
  b=QpgcVYADXAail/0eW3io5gsbOJGSDG3aJT2NSaXGwatUkni15ZYTk8I8
   dW7lf7XdCzVqZ6zrX4h+Q6JbvFTPx2KkpaakV5E3psqse9+w64KGFXt2f
   fg03XJ6b/KiEqEDqPn0Dg1lAcldB1HdY8bWqjnxcXsgRF1uRU1kn6BFMg
   9Dy797mstmCIJlwfr0rbZjWfPh562dxU+op9N/nNZdUHLh59KcbRLF/lH
   LqHg5BrJmDSnbBc5+fWepjUq3eG7MkCKDnVead7iJtSUapcZkGEPlyQUy
   0JEVR3oJUZIOKLtCv7/5y9Ma8rGpmgND0o5MCidKoY6SVbRbNmBkKdhPs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308358458"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="308358458"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:35:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="477293751"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2022 00:35:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 00:35:29 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 00:35:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 00:35:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 00:35:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByNexmUtXVWeGOG0WKpEREFdfj5oa50QnlSOqgU3gvA3ALaj3WQglyk0xoHG96eQC7DnIv1uEviysrLB3KmnaHgDCMEfnJtbtFKX8SXIZc4AWsNcKn0P3P3b4ShR8y0iRKYMoBbhP1y3CQXFtfocD7qG7Hv7otcgabRicy2liEvDtqk6GijcPvnaEsqwLoQsh+XODQ3/qiUK7t75tEHjXxPBN8moUpL1KXOgY5zThcx3RaUBFjcvxSN0/Iaoa4YjiFDqtjQNMDn/Y+/HV9pGSMT9SKwiffHkLjOgTw2rdRi0bLSw1cJENLXd0SPw9S1WZuRNPXxvuvaV+n82OXFcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2ufj62hyjdi1S2RRJ5sP746QZSTEUIvAyKXncM6nG8=;
 b=kssS+uMfDCrZ/8TgQUxWHpcQufcEFadbGNK4u+ozTmTVhzmS/NInGviIyrDWcwKnd4+7kb5MXeDWXPyHBmFI4yiBC+ExV+2WwemgB06TKxy0sHAGuNRQqoUBzAVKxcbaKB5U5LY9KpgPvxBS7VZ7ItsdkvNEtm6MPxwR8NE5HtJsnkjux0bErXRkMdm4cyxmZKXo4hd4OP46Oj9d/9fty8gtdPBMeZ0stWx04ok3dFHqlAW+2qG/cnWw+Wld0q8y+NRDFLiprahSvBmyW5OAeCWpMcSpPf5DzixhpHHv+oTlDFW8z8VcAcOmEt8otAqp9QKJPs+eeMNf/ALq04FmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 BYAPR11MB2920.namprd11.prod.outlook.com (2603:10b6:a03:82::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Wed, 19 Jan 2022 08:35:26 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 08:35:26 +0000
Message-ID: <7a8852b8-c108-f48d-172e-fa2e7605db9f@intel.com>
Date:   Wed, 19 Jan 2022 09:35:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [v10,3/3] drm/bridge: anx7625: config hs packets end aligned to
 avoid screen shift
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
 <20220119022543.26093-4-rex-bc.chen@mediatek.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220119022543.26093-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::13) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145f1864-99aa-41d7-0f96-08d9db26a475
X-MS-TrafficTypeDiagnostic: BYAPR11MB2920:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB2920B13249A5FE9B703A42F0EB599@BYAPR11MB2920.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWiXYk0BhIGTmsoO9xdc9jGnb5pwiFVvrUFd4kmv3xWZpJw/BtYDiaAniazjP18m+QLlZZPNX62yjn9JoUzAgO9ZJX4ba9AkvyGXghAUWq9Kq7nVSgtEpW7Tl9OBHUqjj64MjIneiVialGflTrbgObFA1Vq8kVWHLTAyiLQL2QzD9VoUmiKZ76/NYkAvwNK6okQLpx6Is3B7M18+6tx72Zp2iRAFJ6AjPhPY9YGEBQVY4bW89si+Krr8z6Hx7RIgaxtLzuuigxkjIo/KA6GRb/iKhdq/njbvngieDx44dkI946dOAJjOUZ9xZNN0hY2x5h8++ZM5M4p+JKH9ahLGZgINaFaBRI8izsyAgCKkfxqPbvUMLv++Xxp6QxchCqLn/MBo3NbGlaYt0ABv90n2YOg3UbF5toxFD3iw7OUgaWxvdXIgI1Guy3FkjslhrkVwfLC31fz1SAjHqniSk66k+lYzLhoBkoJSK3lpLsieW8OBfyTcF7ifYwfHUFYa5WF8sx6VLj20P9D+gl/y4/aOERleMavDuFAhPummzQMbnA+6TrtfMT3rHF+GJYV269PFB4AovTsKsrxv1Vq3UMLs+dpZ229GdffotUe8daurvDeTwGhJgYG8M0YuTSB1PvtJgXuy1Yq6m48OUlsfhsmBzQFdu1z2ayVkh+OqnXTbNBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8676002)(6512007)(36756003)(66946007)(66476007)(31686004)(86362001)(83380400001)(8936002)(31696002)(66556008)(316002)(38100700002)(82960400001)(6486002)(7416002)(6666004)(44832011)(508600001)(36916002)(2906002)(186003)(6506007)(5660300002)(53546011)(26005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UXMG0gCwoQZNUXmZ44xyJgJVlOJSDV/RlFJyXbth/DDpURhio0Na6h0HPMSvTgLEdunCMovlpyXThlVk2NA3k3mfzYiRDv05wFusuxN0zacmE0ijSLn3nOSyxoWVRB6A/ta0dxyCCSl1ZrOhYWCOfySiLMYb9V+qBOORPVrT1dLY44FG1B+IfD+FFX+V4Blb2yAeEla284Vkxcfz4vjvZrh2uB5kbEfbpDSIr5oYnJanLSdP+IJWeNaZGYk4whKJi8YOiSD0WaRajmBWiJe2SFL48khOjm7uYDWeqBjuLvX1S358CuKVG/KWSpJgann0yHJV/P3DXpw3iYeOrKav/glT38I1+EiQIDp8Jo4IKDT82CMsqqidCM884TyQ+RmOvSjYU6ktQ4+buceGzQsA2xdXwjooZIwjEGkt4gbhfzcIJ2zJQ7IDzT+H8s24dKRo
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f1864-99aa-41d7-0f96-08d9db26a475
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:35:26.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPrfQewbpwWs2lDS66+WlvEW9m1dAJe8AYnsvUd62CwKnwOQzttiqbMuArCB+0slTG7yBFHo9fjOP7vJ5VKr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2920
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.01.2022 03:25, Rex-BC Chen wrote:
> This device requires the packets on lanes aligned at the end to fix
> screen shift or scroll.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards

Andrzej

> ---
>   drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 2346dbcc505f..fe32ab0878ae 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1673,7 +1673,8 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO	|
>   		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
> -		MIPI_DSI_MODE_VIDEO_HSE;
> +		MIPI_DSI_MODE_VIDEO_HSE	|
> +		MIPI_DSI_HS_PKT_END_ALIGNED;
>   
>   	ret = devm_mipi_dsi_attach(dev, dsi);
>   	if (ret) {
