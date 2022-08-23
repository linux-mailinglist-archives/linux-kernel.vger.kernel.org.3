Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2197959EF75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiHWWvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiHWWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:51:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B07960A;
        Tue, 23 Aug 2022 15:51:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo18623277pjd.3;
        Tue, 23 Aug 2022 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TCZVKueJFWTVqGgf5laKNPR1ALkCEtWWSEFFSVbljXw=;
        b=hqwHSxYf03YiK+vuHypIwp4MFVfA5Q7jjW+erMpt8oLSYp1+TbPZsvf0j9h8qEy78Y
         KBIoQ1a0ZIW45BO40nV9MNeVEFDaGvlMU+wY5qVT3F6qNrdETTNnK1E9mr/fJZa6yMSK
         CLvf3qVpbFwvwQnmpzVf63Hb5yVDd6Y4Gf8aYlTULq4La9Xs/hon9QRZKuvMegxL2ckt
         rlCZ0o5Mm+J9/a/+MuS1QUCS2Okoahh/+vQvSdYm3UwYlh+JTTWR5tvirDRVy4ZiqOi/
         YM9M76/J5O/x03ufSGw1gyhc39HP75SaV2wDmbj599V19oWvpTULoPn3lDg08J1HLgAq
         WaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TCZVKueJFWTVqGgf5laKNPR1ALkCEtWWSEFFSVbljXw=;
        b=F8Ea1I7ddAyV6xGG78TcT2AzRtwHAOjE6dciBtsNwvZNNNuAx+8EgY9uzd8g4Jp7vD
         e/C7YaPYpkRhSN+f2LW0LzlxDm78gpBFfhVb+FpvoBQ/oNp1U3L65bVhJ5ooFQHY2DwM
         DKnQ4X3Yl17EjNFumFs2g+wkvPofoH49StIhW2I8/Vs+wscqPiuSJci0mMUfemOD5pcL
         IL3CH4LKIVUR1rcHcwE1g9FReWQqN26xYKZpG43wZ8M2PinFq1b4EI+xFRXzM7+waCXj
         JKl8ljZMout8NsM8pl83rggkSVNg/c03csR1hriY3QZ87KtQ0xrpsMKg0N8R8KONFLCG
         CiYQ==
X-Gm-Message-State: ACgBeo2pKZpix7cvXM4awsm2Xg6PPw0TtZxyk+zp1gFYFEs/QIYjbUeD
        qYMK0YxmpN2GZoUf5G/5ye8=
X-Google-Smtp-Source: AA6agR4KpCMf0gNEZx0UGgCHVfmv4BXGqJnuUkNBqC7ZkxD2h9RBqGGtSCMEUFdRphpvJWuq6BifDQ==
X-Received: by 2002:a17:902:a608:b0:172:ffa5:2ed8 with SMTP id u8-20020a170902a60800b00172ffa52ed8mr4889767plq.164.1661295092090;
        Tue, 23 Aug 2022 15:51:32 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c8-20020a056a00008800b00536bbe91b83sm4349884pfj.157.2022.08.23.15.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:51:31 -0700 (PDT)
Message-ID: <df8f1406-e586-3e3c-987c-826b52702a3b@gmail.com>
Date:   Wed, 24 Aug 2022 07:51:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PM / devfreq: mtk-cci: Handle sram regulator probe
 deferral
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, myungjoo.ham@samsung.com
Cc:     kyungmin.park@samsung.com, cw00.choi@samsung.com,
        matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        jia-wei.chang@mediatek.com, johnson.wang@mediatek.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220713111511.115007-1-angelogioacchino.delregno@collabora.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220713111511.115007-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 7. 13. 20:15, AngeloGioacchino Del Regno wrote:
> If the regulator_get_optional()	call for the SRAM regulator returns
> a probe deferral, we must bail out and retry probing later: failing
> to do this will	produce	unstabilities on platforms requiring the
> handling for this regulator.
> 
> Fixes: b615b00c42da ("PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/devfreq/mtk-cci-devfreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> index 71abb3fbd042..e5458ada5197 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -291,9 +291,13 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
>  	}
>  
>  	drv->sram_reg = devm_regulator_get_optional(dev, "sram");
> -	if (IS_ERR(drv->sram_reg))
> +	if (IS_ERR(drv->sram_reg)) {
> +		ret = PTR_ERR(drv->sram_reg);
> +		if (ret == -EPROBE_DEFER)
> +			goto out_free_resources;
> +
>  		drv->sram_reg = NULL;
> -	else {
> +	} else {
>  		ret = regulator_enable(drv->sram_reg);
>  		if (ret) {
>  			dev_err(dev, "failed to enable sram regulator\n");

Applied it. Thanks

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
