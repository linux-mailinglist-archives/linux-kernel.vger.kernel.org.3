Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969765499CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiFMRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiFMRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:22:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FD33352;
        Mon, 13 Jun 2022 05:37:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D92866015D8;
        Mon, 13 Jun 2022 13:37:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655123843;
        bh=SN+r3+C8txifAec4wsuKPre5ESL3Qr6tJo6VOZZTPok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QcnCpgdKPGIs5XF/cGQZGajDsXPaLCx4/cUDwJ3hkKxnxba7UOwoo+ZESoepdSREa
         DHNY065sHf4gj09AlGRWZW/yAW3NiAGGX1zoTAypT7WkGxBgDuF3ubaZgD+uRACUMe
         u9jun8TWs8F+CEZmmdemRxwibE+NPeNn+OuaseKeGHtCPkW4ws5ExS7+WQqSCgUTas
         XTnxGHCjEqE9DmbzUWjbOotVtFo+A553TYfNifOMqUiJoHs5OlaYNL5LX/s1siMSwQ
         T0wqYCXfc8jkOKFFuCBHOHRUxRvCuXwW2nb0WCiXs4wQ1uNHiFzVslzFJwcQzu10Np
         LhoBxki8cfVkQ==
Message-ID: <d3f718fa-c773-4bc7-506b-d109bf72aa3b@collabora.com>
Date:   Mon, 13 Jun 2022 14:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] firmware: mediatek: Use meaningful names for mbox
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
 <20220609083101.24195-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609083101.24195-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/22 10:31, Tinghan Shen ha scritto:
> Rename mbox according to action instead of 'mbox0' and 'mbox1'
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/firmware/mtk-adsp-ipc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
> index cb255a99170c..3de94765d659 100644
> --- a/drivers/firmware/mtk-adsp-ipc.c
> +++ b/drivers/firmware/mtk-adsp-ipc.c
> @@ -83,7 +83,11 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> -		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> +		if (i < MTK_ADSP_MBOX_NUM / 2)
> +			chan_name = kasprintf(GFP_KERNEL, "rep");
> +		else
> +			chan_name = kasprintf(GFP_KERNEL, "req");
> +
>   		if (!chan_name) {
>   			ret = -ENOMEM;
>   			goto out;

At this point, just call them "reply" and "request", as that simply provides a
perfectly clear explanation.

Besides, I'm sorry but I really don't like this code, it's really too much
fragile and will have to be changed entirely if a third mbox is introduced.

I can suggest a cooler way:

static const char * const adsp_mbox_ch_names[MTK_ADSP_MBOX_NUM] = { "rep", "req" };

for (i = 0; i < ARRAY_SIZE(adsp_mbox_ch_names); i++) {
	/* we can delete chan_name and also avoid a kfree if we do... */

	.... code ....

	adsp_chan->ch = mbox_request_channel_byname(cl, adsp_mbox_ch_names[i]);

	... etc etc ...
}

Cheers,
Angelo
