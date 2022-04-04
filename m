Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF34F104F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiDDHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377843AbiDDHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:52:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E93B29A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:50:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k23so544796wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=CVOw/LnzR+FU3Wl5ZYv0rtjB0R73JkKUrPjFPYHJa+k=;
        b=C3LFox7eE6dCp7eKT1/ySVqfeBAwlHmOr0wnCj4BjQtUusIomrrRsNuWhRlewdgW6g
         T7i0eyLqpTwupDf295JlqdxJqkVPEW/uixETapJQwfHB6ocEXYbA9CY6noSPlJihQfQV
         9WL1K+IGfG2/hc4IhNdLzqf7DLtz8r7Qfq5Gi0P+iaUcpmq/kHX4BwaDrIte4p3iQ3I3
         pdV2QqdEqmwrNR1bnJxN4et1gWG29konh4QssyGchU+l3/PXaDeAZ4SRsSsdk0wtWxuX
         au3dEGTNaTXQfoqNI6czKs6ZNwvhTE98j2NhLgHAPuD3BbFx7bhR1MLqC/o4VUa9PfYp
         /DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CVOw/LnzR+FU3Wl5ZYv0rtjB0R73JkKUrPjFPYHJa+k=;
        b=ghWI7KU1THUfueE1/l3N68c2Q51u+j6w/LKBQW7DlHTLjod2uWlOglmUVxZV0lP3H0
         RBMh3XyrHuTmv+f6+T1H5trNXAJs2lSy/EZ/JqP5FJ7SNc8n3BIX7AvDn4nFII/U8/pd
         z4v9D0oTN20SImWZGwP9FqmvNlp5HYAb/9qsGRYEud8l9ewQAwpsccl4VIa0vZ5tETYo
         mbzLSkKS2hcwAtqbWrsVEg5zGGvHLnUot0XlMeBM85MsbqpFuUc/X3jKpTrgka3CDvoO
         RNDUKNmHt3BRvlOb6aEoiR1cw6Q6QfVE7xc4u9sapBmUFswRIsNz+PnQx4pSVifpO+IG
         EOmg==
X-Gm-Message-State: AOAM532MdIIIqhp1u2tTj+g+ndKeeTYR6IRIDPoBV8dnL/uyYNhDsAgE
        5U2T5If1FTNcCuuyddTl1AjlRQ==
X-Google-Smtp-Source: ABdhPJw6n7rlU6gSwNroZmpobyR6C2fXEEog4wsvWJs4pRqrcPYltbz1802lWVLzbcF/oLhax9QTow==
X-Received: by 2002:adf:e2cb:0:b0:203:7564:1076 with SMTP id d11-20020adfe2cb000000b0020375641076mr16279951wrj.199.1649058638174;
        Mon, 04 Apr 2022 00:50:38 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:1add:1b28:2457:eb46? ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm9526826wrs.73.2022.04.04.00.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 00:50:37 -0700 (PDT)
Message-ID: <ccc45d36-0c87-742c-4105-56820b058040@baylibre.com>
Date:   Mon, 4 Apr 2022 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: remove CPU opps below 1GHz for
 SM1 boards
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220210100638.19130-1-christianshewitt@gmail.com>
 <20220210100638.19130-3-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220210100638.19130-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 11:06, Christian Hewitt wrote:
> Amlogic SM1 devices experience CPU stalls and random board wedges when
> the system idles and CPU cores clock down to lower opp points. Recent
> vendor kernels include a change to remove 100-250MHz and other distro
> sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
> are removed or the CPU governor forced to performance stalls are still
> observed, so let's remove them to improve stability and uptime.
> 
> Fixes: 3d9e76483049 ("arm64: dts: meson-sm1-sei610: enable DVFS")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3c07a89bfd27..80737731af3f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -95,26 +95,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <666666666>;
> -			opp-microvolt = <750000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <770000>;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
