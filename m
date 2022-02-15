Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE474B66F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiBOJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:06:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBOJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:06:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93C10610A;
        Tue, 15 Feb 2022 01:06:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 618881F43CBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644915980;
        bh=KT3ZzPL5bMaQsMc6VIAvOaWmPqUEHPijK80eTrRqlyU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jVL9UMVhkEC02XIfCXepsseP84rrZ37lMw+YnM3XbD0hVbwPUVUkDd+dXEgai7UbE
         y2fBhkPw+u/DpNe3Ym0VMOMiL5NmM9GL/pit0vOPwk4N1xBsCHhFpWwCjZyaIXnzMy
         +uhN+4CooMPCBzQlnpyXYsoPEUop6EhPnK2uca6jcbdEhzjlgxceMi2T270017ub2x
         485O6jZHlxN14XmDqI/JcaATm8E5zFOAaSj27/n7F+OnqZmS3aB8+d9TtGzsMDXWlx
         Vc5F3ssQqtT6M9CnULDLKxgU4vkDQhLB4+qBYyXTD9f1tlmzJooxiAzDhq8cO038bz
         raylOxkRSmoRw==
Message-ID: <319d7236-292c-787f-4578-bffe75e33ba1@collabora.com>
Date:   Tue, 15 Feb 2022 10:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v7 0/5] Mediatek MT8195 power domain support
Content-Language: en-US
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/01/22 02:20, Chun-Jie Chen ha scritto:
> This patch series adds power domain support for MT8195
> and is based on 5.17-rc1.

Hello Matthias,

this series has been tested for a while on multiple MediaTek platforms, hence
new versions will not be necessary.

Can you please pick it for v5.18?

Thank you,
Angelo

> 
> change since v6:
> - rebase to 5.17-rc1
> 
> change since v5:
> - rebase to 5.16-rc1
> - add domain capacity in mfg power domain
> 
> change since v4:
> - rebase to 5.15-rc1 (fix conflict at patch 4 in this series)
> - change license
> 
> change since v3:
> - remove redundant bus protection steps
> - remove unused power domain
> 
> change since v2:
> - move modification of wakeup capacity to single patch
> 
> reason for resend v2:
> - miss patch version in series
> 
> changes since v1:
> - fix signed-off name
> - describe more detail in patch 3
> - move modification of removing redundant macro to single patch
> 
> Chun-Jie Chen (5):
>    dt-bindings: power: Add MT8195 power domains
>    soc: mediatek: pm-domains: Add wakeup capacity support in power domain
>    soc: mediatek: pm-domains: Remove unused macro
>    soc: mediatek: pm-domains: Move power status offset to power domain
>      data
>    soc: mediatek: pm-domains: Add support for mt8195
> 
>   .../power/mediatek,power-controller.yaml      |   2 +
>   drivers/soc/mediatek/mt8167-pm-domains.h      |  16 +-
>   drivers/soc/mediatek/mt8173-pm-domains.h      |  22 +-
>   drivers/soc/mediatek/mt8183-pm-domains.h      |  32 +-
>   drivers/soc/mediatek/mt8192-pm-domains.h      |  44 +-
>   drivers/soc/mediatek/mt8195-pm-domains.h      | 613 ++++++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.c         |  12 +-
>   drivers/soc/mediatek/mtk-pm-domains.h         |   8 +-
>   include/dt-bindings/power/mt8195-power.h      |  46 ++
>   include/linux/soc/mediatek/infracfg.h         |  82 +++
>   10 files changed, 862 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mt8195-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mt8195-power.h
> 

