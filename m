Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B94C585C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiBZVod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiBZVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:44:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670E3B282;
        Sat, 26 Feb 2022 13:43:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s14so12224365edw.0;
        Sat, 26 Feb 2022 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gwvZa2dcVddk9XhPqnnw7BdDWgMrIWi0l2xYTw7uVq4=;
        b=ieuNHUrgJeWwVhmGIAi92YZErZliThzoNqRKo14Vh+sq3q1K9eTV+DiAdkpOoRTYaG
         WXNuRbXkazy+XO0BJK7MKSAt6Em7dNuT2QdgJpNTqlHnHm/v95O0pfprvooUCt/NvsNP
         GsGeRZcVt6bsmPb/OVepmmCzhLbFdfigKKPGdNKglInJGsvP4kYjYGakxo0TYHKiLOeR
         Hb0B/WodBnzk5LwENVkEwgLMfptAZ2nIh3ed/smowJh+s/V5xsy5YA0d78SnAaHhEZ1c
         +0eV1wxXGGCaV8f22P5RzZZMaDyTH5meSyMsfyoAqbg0Qhf1U2asE7lyjTKtcPwZkp0R
         ISqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gwvZa2dcVddk9XhPqnnw7BdDWgMrIWi0l2xYTw7uVq4=;
        b=5u+WHDBhgs7pud2Faglwv7PBJOhbjzyUmhDB68eEL1EMdqhMjEJWkMZoDDLANgj9fr
         udSHZuMBT0Fe7TBxroAiyXshj3+Ry6f3i+0aFQiAauifXLtG23NSgrnu4DPu2VklVIGS
         O1rDDdQGAFRBiewUABzuvIChhIsdcew0fO2cXS7dww6jlTpbA1XW+IHIQrlj7FYrE717
         ITeRpfZ6f1MPo9VDRq6PeU4P/1mrffmosPQt4p5AkwaMfmYNoJiKFq+6ZTsC7qUe9Ahs
         wx4dzOlyjvgngUls1t97aomwRvDv9edu2qjozIoGM1BnOS09Ia+x2tFxrP0skh2pThpO
         F05g==
X-Gm-Message-State: AOAM533yDRTElakJnta0ubryWWI6jlm9pioR7mdKpZ1bZe9kNgzGlcIe
        +RN7mbeWZx8L+4eIqBUdK59nebLrMdkKxw==
X-Google-Smtp-Source: ABdhPJyNzE3rhYea/K5v861WD31Sr8quT5QSWT3FQqUAGpv/O3PpnjVEp3OTedF/I9qaslLnxSh6uQ==
X-Received: by 2002:a05:6402:518b:b0:412:80a3:fb6e with SMTP id q11-20020a056402518b00b0041280a3fb6emr13399264edd.84.1645911834812;
        Sat, 26 Feb 2022 13:43:54 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm2658615ejf.36.2022.02.26.13.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 13:43:54 -0800 (PST)
Message-ID: <cdbf28ae-b54f-dfaf-887b-c5705319ac06@gmail.com>
Date:   Sat, 26 Feb 2022 22:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 08/11] usb: dwc3: add rk3568 dwc3 support
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220226184147.769964-1-pgwipeout@gmail.com>
 <20220226184147.769964-9-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220226184147.769964-9-pgwipeout@gmail.com>
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

Hi Peter,

See comments by rob+dt:

https://lore.kernel.org/linux-rockchip/CAL_JsqJwNdUfoYM8SZmOgMG9iAyZkJ4-kzjjiDDm_mdmghTEOA@mail.gmail.com/

> Presumably you are getting lucky here (with link order). The kernel
> has no logic to decide which driver to bind to if there are 2 matching
> drivers.

Due to the fall back string you make a mess with two drivers.
Don't use dwc3-of-simple.c
(only for rk3399 and legacy support. Not for new SoCs),
because core.c has now reset support.
You are creating a race which driver get probed first.
Handle your quirks in core.

Johan

On 2/26/22 19:41, Peter Geis wrote:
> The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
> controller.
> Add support for it to the dwc3-of-simple driver.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 57ba9427ad74..d9d1c5bfac3f 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -195,6 +195,10 @@ static const struct of_device_id of_dwc3_simple_match[] = {
>  		.compatible = "rockchip,rk3399-dwc3",
>  		.data = &dwc3_of_simple_data_rk3399,
>  	},
> +	{
> +		.compatible = "rockchip,rk3568-dwc3",
> +		.data = &dwc3_of_simple_data_rk3399,
> +	},
>  	{
>  		.compatible = "sprd,sc9860-dwc3",
>  	},
