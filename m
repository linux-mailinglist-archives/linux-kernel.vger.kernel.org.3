Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3946B514A16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359630AbiD2NBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359623AbiD2NBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:01:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440DA94C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:58:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so6378400wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mk6QBfK1Qs6MGWhspJvjaQsz3Ch5Q47MYj9GDufUOYc=;
        b=S6dY++xHXjw2/8EguPozN/Se9x38PJjiTyNnwzxquzIhz8Gx4h+yC6lRF612vYZFLr
         zG7z+pjIVhBO7fSgqdELefDFac+3CmRF9BERPLi4EWO0iw91I2Qs1X6hQJueuDbjN0n0
         w+C8uHRbawUwsRspgmWu76ZNc/OmVJOZeXiUL4UjHVllXgh7PPkJgj4mTKDsq47muT9G
         rZTuyYdJau3Qub8fTbS5UE4EkcxIDdFIIiFWRsQ4uvDURf7adooquFGvFWOti5++vBmK
         H+0zcl4ZQmJoAANULUX0PXB+Mb4xOne4VYjzq54AMfXjZiw/3Huut7zFFwCgkvEKZZ0V
         24fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mk6QBfK1Qs6MGWhspJvjaQsz3Ch5Q47MYj9GDufUOYc=;
        b=v2Ho/YINFIuwTZSIbpAUcK13KMBbtDE09QFiOLVFpvP3nwg8yeSJ9mAWUsZDmfprQD
         zPVznwo+xakX7uJ5F6+JbhiFVHKQgy4QzW81myDOa9Fg8D4jYefoVEcHL8UyxuQm5DPR
         R6fDmzbTeT43X0wHAj3nbEpAGYA8Rn9zfYhLNSkee3JC8Eqq0i2bdbrz03i2J8Q1rojg
         0QcWDA779S9ZdLh9DvKiMPAvFT49ZuI5TB7IkeVYQBxG7IqQt0JJjJqyIMCzCwgkPT3U
         OKhrTjYJjzC6rcKLboNuIoG1NsYAI/I/d4z62yZg6k8zKK3XHCp4+cO3B8PGFzUSBo+W
         GLEw==
X-Gm-Message-State: AOAM531qRgds9VWhupmYB74Xihm2tr1d8G5X7qqmNcj9dWm0C8Z+npPd
        6lXx0AF8zaDVNc+pyXcVvN8=
X-Google-Smtp-Source: ABdhPJzSZc8J/7hX7g28rcH3m7+CBMc8qNeyNM1KSrCrZaeBaZnnR3MnMgNB8ZruHSLCdWRQueVl6g==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr3110658wmh.59.1651237106322;
        Fri, 29 Apr 2022 05:58:26 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id c9-20020adfa309000000b0020ad4eae9b6sm2445896wrb.100.2022.04.29.05.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:58:25 -0700 (PDT)
Message-ID: <a9300186-07f8-30c4-b5d8-e88f6f0ee629@gmail.com>
Date:   Fri, 29 Apr 2022 14:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt7622: specify the L2 cache topology
Content-Language: en-US
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ryder.lee@mediatek.com, daniel@makrotopia.org
References: <20220428225755.785153-1-rsalvaterra@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220428225755.785153-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/2022 00:57, Rui Salvaterra wrote:
> On an MT7622 system, the kernel complains of not being able to detect the cache
> hierarchy of CPU 0. Specify the shared L2 cache node in the device tree, in
> order to fix this.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 6f8cb3ad1e84..3d6eaf6dd078 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -80,6 +80,7 @@ cpu0: cpu@0 {
>   			enable-method = "psci";
>   			clock-frequency = <1300000000>;
>   			cci-control-port = <&cci_control2>;
> +			next-level-cache = <&L2>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -94,6 +95,12 @@ cpu1: cpu@1 {
>   			enable-method = "psci";
>   			clock-frequency = <1300000000>;
>   			cci-control-port = <&cci_control2>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		L2: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
