Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8045A1212
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiHYN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiHYN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:28:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC4B2CCB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k17so10274620wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gso4zEc2tsd2SpRRIptou/A9NpRMhUK2WNA/cgD69YM=;
        b=I0Dc00L0QNQCzKZs5Wqc8xhvt7ABLf+OoML0udhyLTnVnGgTlBD4xF0aF1YonLmEcB
         Ns1Ppwk2zEwfNHBeloXB2JQ3qmOFr96hqxa5BfsGK+8XbHgRBA+dSJ7w64v6gKaEwa50
         ncMWyic8lASJMC7TlUmwrDd1c6XqgKFz6W7mKHsOssQD4Pg8A0lvujaHKJX+LQ2hDgeO
         0pjIcps6kC1S5Z95+JZFpu9955IQBAhGkOzR9x17aRuc683742a88CZqOokBdE1vJfo2
         YzFXv42fegAbceGXqmEPDP4U2Nazoo0n88c8tuqZ0l1hs+8lBXev9uEyVaK2uZ9EOu/A
         rK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gso4zEc2tsd2SpRRIptou/A9NpRMhUK2WNA/cgD69YM=;
        b=JPxoW+D8I7Cy8wKCO7gGNqhxl6nRlCdDnWpTPbsR4Iup6DQF164m7c6Fzp8A3YUw7z
         svByLq4yBWlr70ElaO6a9ejopyTQmUCuxGhhLLrXZGRgJj/dxjLBnQK+0DlMIf9ra9vW
         aI5XusE230jATtoQYWfwFIDJQBa8P/8tcJsUSZEKHYYQZPGHpS06b+BgnkNO45JjkoVn
         E+TtMts5sGgr2qij96uSoyQRNAFc9yZxHy/Km3s7Asr7prs4v6LCLyIet5g59Fjm0gZQ
         Bg/Ter5AjjXLK3eSpgtiCJ0Z8tai64/eZ6PB1ra1sX69HXcmuR6jNFbx1QPRx/1qhQ0g
         xO1g==
X-Gm-Message-State: ACgBeo04l34aDh3Ol0PH+BXHmk1cbui/Xng7i5xhO5DUsAPBLpaiFmqB
        fg3IsE0UqS8b1VTRqOeUiQk=
X-Google-Smtp-Source: AA6agR4h2e363WvW8msby77B6QYfrw2i6rg9NyHdyGpzWeUDTFjTROTo9qm/vZ8e/AWz6cTQnrgV5A==
X-Received: by 2002:a05:600c:1c8d:b0:3a6:9d60:faf0 with SMTP id k13-20020a05600c1c8d00b003a69d60faf0mr1464075wms.82.1661434112422;
        Thu, 25 Aug 2022 06:28:32 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b003a604a29a34sm6372686wms.35.2022.08.25.06.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:28:31 -0700 (PDT)
Message-ID: <c83413a8-2871-ecae-8954-25baddc7f04f@gmail.com>
Date:   Thu, 25 Aug 2022 15:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/6] soc: mediatek: mtk-svs: Drop of_match_ptr() for
 of_match_table
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-5-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726141653.177948-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> If CONFIG_OF is not set, we get a -Wunused-const-variable: dropping
> of_match_ptr() solves that issue.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-svs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index fcf246a6bb07..80d0bab1a045 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2840,7 +2840,7 @@ static struct platform_driver svs_driver = {
>   	.driver	= {
>   		.name		= "mtk-svs",
>   		.pm		= &svs_pm_ops,
> -		.of_match_table	= of_match_ptr(svs_of_match),
> +		.of_match_table	= svs_of_match,
>   	},
>   };
>   
