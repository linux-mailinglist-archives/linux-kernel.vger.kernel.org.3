Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3366954CFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbiFOR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiFOR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8FE34BB3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u18so11001080plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=il/KBps6ii6Gd5FHFi9j3ZFy5kAtbrCy1Dgg4+ftDI4=;
        b=nGG3zeC3ujp1Lyr79SQNyz3Yei5eS80xvtngKVpw/5YXlWoG5FFrAxwd8qnLOVoDPS
         SIaZg0HNQMFqJ/TRcM4ZVL9bkTGfLuu9eUAPFm41Xl9FQLgRlRlMO5MR7y10uklFmE+u
         PipgW0PTjhJ1/PPY6CMmEFkVkCl9GbkCXKKPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=il/KBps6ii6Gd5FHFi9j3ZFy5kAtbrCy1Dgg4+ftDI4=;
        b=tgVyyAd3vyWEScRVXaQjbK9ovje6iwAq5vSy6KYHicdTUywvmJ6GqwJNvmn+j1fcEJ
         WuAQO+vSleO3N6/c/4jO4xsTAHUzkIMtNjtlCI2i8R2Segktkhf55lLynpKrZFABbrOI
         BmcS8cEWWd9vi2V3zRxo3a40O9jfCeOea81+qY/6Qemt+CtTCEbNqcAgFIlsmrvurwCU
         OSBIrTc7ohZ5eW8UoizTW4tIvzODnsd3f3eEfga7qut9uJMQKUvsM+72CNQH288dDdzI
         ysHvZpV0jQW9odYB+OfDhe4ek0tHpcYgdKJ/AAsfy80ti3rwSUTJJAUxY1MlMdWWTAgC
         N05Q==
X-Gm-Message-State: AJIora99VJQcqyuuwe+QjdCavQMUSp1SgX/dotKmA8WflTLP44GWwU7h
        e3+TsHV6P8MSKTRwUkIAKy/ouw==
X-Google-Smtp-Source: AGRyM1sYHET89749fDt5TDoEPXQeflY6qeT3IV7HNP/7XVyGqeBNCkZrte/HBbD0kJf4G/g2FjkDMQ==
X-Received: by 2002:a17:90a:6444:b0:1ea:b662:c12e with SMTP id y4-20020a17090a644400b001eab662c12emr506120pjm.199.1655314162312;
        Wed, 15 Jun 2022 10:29:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:342:e7bd:5391:5d5b])
        by smtp.gmail.com with ESMTPSA id g3-20020a636b03000000b003fcfdc9946dsm10402512pgc.51.2022.06.15.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:21 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:29:19 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Message-ID: <YqoW7+6iL/SHGaAY@google.com>
References: <20220615045146.3134420-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615045146.3134420-1-judyhsiao@chromium.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Normally the subject should look like "[PATCH v1] ...", not just "[v1]
...".

On Wed, Jun 15, 2022 at 04:51:46AM +0000, Judy Hsiao wrote:
> We discoverd that the state of BCLK on, LRCLK off and SD_MODE on
> may cause the speaker melting issue. Removing LRCLK while BCLK
> is present can cause unexpected output behavior including a large
> DC output voltage as described in the Max98357a datasheet.
> 
> In order to:
>   1. prevent BCLK from turning on by other component.
>   2. keep BCLK and LRCLK being present at the same time
> 
> This patch adjusts the device tree to allow BCLK to switch
> to GPIO func before LRCLK output, and switch back during
> LRCLK is output.

I get how this "allows" switching, but it seems like this would make
more sense in a patch series that implements the switching.

I'm also not certain, but it might be worth adding this to the DT
binding, so we set the 'pinctrl-names' piece (which presumably you need
to use in a driver) in stone.

> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi

...

> @@ -2225,6 +2226,8 @@ pcfg_input_pull_down: pcfg-input-pull-down {
>  			input-enable;
>  			bias-pull-down;
>  			drive-strength = <2>;
> +		pcfg_pull_none_hiz: pcfg-pull-none-hiz {
> +			bias-disable;
>  		};

This isn't valid syntax. You probably didn't resolve conflicts correctly
when rebasing a patch? You need an extra brace somewhere.

Also, this definition seems like it belongs next to 'pcfg_pull_none'
(around line 2138), or at least somewhere near the other 'pcfg_pull_*'
handles.

Brian

>  
>  		clock {
 
