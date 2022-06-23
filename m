Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4555767C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiFWJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiFWJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:19:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FD4665D;
        Thu, 23 Jun 2022 02:19:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FF226601752;
        Thu, 23 Jun 2022 10:19:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655975969;
        bh=jvTSpUApFuNR+zry7deDGr045Bs+SsvwvHOVl8kQWBE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HtlXJ6FpjazjmbTMa4K2OgCwmcUvIgnEBsNkestc/XFp/KcB1WYvMxf57uDyTjU79
         +UmT84cZ5l7aebBlizcY3SvC9cSANEU7MooekayQBaJAEImjOp+g7A8BYnJgcNLPtM
         HKogcZk+1CnKeTDKJYkek4EsPkyAtW+kBdvfFMnolf26yDoAHWwi+DbDHc2S9OGX3B
         9JpOCV8Q9ApJstpZHhUJRjKjRG9H3rJdInA/HmgqlkLwwUpCd+L6QlezzR6rLy7otL
         aKC3KUaagtPTXQDtZkzncR+c/SlrbTVmiLf5z396DxfIBcDp7IExBd4oSehUKKvTDC
         hcOy74FkPmOpg==
Message-ID: <0b065a56-5ab1-9be4-d92c-f7bfec629a3e@collabora.com>
Date:   Thu, 23 Jun 2022 11:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/4] Add MT8186 ADSP dt-binding
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220622062245.21021-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220622062245.21021-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> v3 -> v4:
> 1. Update commit message of patch 1/4
> 2. Add review tag to path 3/4
> 
> v2 -> v3:
> 1. Change mbox-names to rx/tx for both mt8186 and mt8195.
> 2. Update description of mbox-names
> 3. Use static string array instead of kasprintf
> 4. Align clock names in dsp driver with dt-bindings
> 
> v1 -> v2:
> 1. Change mbox-names from mbox0/mbox1 to rep/req for both mt8186 and mt8195.
> 2. rename clock-names and remove unused headers
> 
> Tinghan Shen (4):
>    dt-bindings: dsp: mediatek: Use meaningful names for mbox
>    firmware: mediatek: Use meaningful names for mbox
>    dt-bindings: dsp: mediatek: Add mt8186 dsp document
>    ASoC: SOF: mediatek: Align mt8186 clock names with dt-bindings
> 
>   .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 91 +++++++++++++++++++
>   .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 10 +-
>   drivers/firmware/mtk-adsp-ipc.c               | 36 +++-----
>   sound/soc/sof/mediatek/mt8186/mt8186-clk.c    |  4 +-
>   4 files changed, 110 insertions(+), 31 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> 

