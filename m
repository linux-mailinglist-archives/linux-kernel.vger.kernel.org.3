Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467454F1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380414AbiFQHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFQHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:31:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1344F38DAF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:31:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gl15so7140277ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dCV6qGUI7Cqg9TdhqvU2+ai6zKfvgQ0lGjyyVFexPIU=;
        b=HE7KhYE/xjUlakk27H3lZOjL19q7HyTLJa+vdphCgSnuB+czh4rVByLN78Sj1p+5RQ
         4V8QTQUKTVuiHbxXI2U9QY6RCMYc0SE9qc/8DjOd/RNJh2EeSlQIZvmH4UDYmfpClkrl
         zxOLypIgJzz2CVNok1B3vytvYEoiM+c6yd8QgJaLgL1RGKl6H42d3EGhsIT3QQxedVBT
         /pDJN8p2MXO2g+YjtQasXNEcF/50BTHOazd2Wsicgek5gQPmLhMx5YXmrqLEyhjT3D/o
         4Ws/cOypVK2Z5sotjuPIYRetuiLUSlLrH1Bu6fBSYPxTzUKdoVRUC2jHVFl2RKH8szvS
         Zn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dCV6qGUI7Cqg9TdhqvU2+ai6zKfvgQ0lGjyyVFexPIU=;
        b=nMJbgg07S/VhU4wuAlJTC9sOxHwprkCdIexng+WuWbVEYOk4GlV+A6l6o6XVIFR0cF
         uUpM/kEDiv/B+ExEZJ7Ez8FfAE7EE6Pu8qsAbFBhda699/oUa+2KWiDagN6zWmukBFEY
         pyBTa7DF0wV4VqkHGl9M7o9wxf6q2666CwuLsDYlGrmJrMt9ZmkMfrIFLTbeBICTd4s+
         Jk2HtVLsxh4H1Nuva/Fci58g7XSce90BbhWskVyblQMpsjrt9675NULtd82rp71IKqQK
         oDcAYYiHOR7rnL2cd9/2/Imo7F/6seXUvghd8K1UxgYM7FADNKlUfMKuL4GvZtZjLYmc
         eURw==
X-Gm-Message-State: AJIora/EVDWvHznRW+ObF60Q6K8R/aSNdybrbuorqNQJauSl9z468lP4
        gjvuZSyC3f6WmKyLxAoY0jNkaA==
X-Google-Smtp-Source: AGRyM1tZZKYyQmjR0eXxMRCwbJxX3hwGRDzNXhGufI0x/0CPupOmdiMHa8oj4351VL2iQ1h3Z8vNQg==
X-Received: by 2002:a17:906:74cc:b0:712:381:9c5a with SMTP id z12-20020a17090674cc00b0071203819c5amr7885326ejl.466.1655451076601;
        Fri, 17 Jun 2022 00:31:16 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d227:8f3c:286a:d9d8? ([2001:861:44c0:66c0:d227:8f3c:286a:d9d8])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906300700b00702d8b37a03sm1852519ejz.17.2022.06.17.00.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:31:16 -0700 (PDT)
Message-ID: <54e1434d-e517-9283-3078-7f042c04385b@baylibre.com>
Date:   Fri, 17 Jun 2022 09:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
Content-Language: en-US
To:     Liang He <windhl@126.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616144915.3988071-1-windhl@126.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220616144915.3988071-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 16:49, Liang He wrote:
> In meson_secure_pwrc_probe(), there is a refcount leak in one fail
> path.
> 
> Signed-off-by: Liang He <windhl@126.com>
Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains controller")
> ---
>   drivers/soc/amlogic/meson-secure-pwrc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index a10a417a87db..e93518763526 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -152,8 +152,10 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   	}
>   
>   	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> -	if (!pwrc)
> +	if (!pwrc) {
> +		of_node_put(sm_np);
>   		return -ENOMEM;
> +	}
>   
>   	pwrc->fw = meson_sm_get(sm_np);
>   	of_node_put(sm_np);


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
