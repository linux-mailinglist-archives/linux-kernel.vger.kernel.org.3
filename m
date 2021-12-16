Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E9477469
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhLPOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLPOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:24:54 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D97C061574;
        Thu, 16 Dec 2021 06:24:53 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u22so38732254lju.7;
        Thu, 16 Dec 2021 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3te9pe7rOJHos3EuPgW4pF2bDr58GHICUC52sb6TTQw=;
        b=igVil4d7hecRf/ZlSHkjGruHgf+4OOe4/KwyAc3HNyI/F2/EASnbWlmBW1xTb9kyIf
         LCsjrURmGl04f3eT9XO2PC7S7qc7QHJF7vXVdsW221Oir2aAxMMhWcEDjv3yX9WDczqV
         ZDS/IvjvPnck+FzEw10c7WJJf3Hs1whJzcS4oMZEwL83kIugA95UTue+8vljF7orSw/F
         W1pN26OniH5nNBEyrLvvldgEsL7ZcXLfrgZgfW/+EJCzdM179Fnek2baPlSqDFWaJuu5
         R2hxrJEuFfzP88gWkIzimlDjZBs6i7mip18yIbHvCl3zFmfzJdLvHKsnANZ9IEim+FqC
         +aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3te9pe7rOJHos3EuPgW4pF2bDr58GHICUC52sb6TTQw=;
        b=3u6oU+SIT2NvO14nNK86ndpl5Uz+kufgoj8KnNh33RabfG5b8AJl6/9RE6oUYPcB6f
         NCTXf28/9dRU1BJ9baxj17uhhX4mN4Mn+ElrniqeUj4xAJvbjcpGCfxpx6voQzFFefJN
         8g/k2ehbO7fZgx8UUyF9bB6dm6VyZKRJFhSWEnp9qrOiKEtoCmUVdxG7kbnWRepObcB1
         ndphNIeDlgeHgCvk6Ur4r0gJ/ZmB/DLOpVcjXH9/l+9DMEVJRlVSLLgtsVP3T9LvsEsH
         GSUP8sIND1YVxeNKlehH2W8dwEahvQG+kfblCYKjqGT+OEWAxWUYxWuGjQ6CEocrgXm+
         R6rQ==
X-Gm-Message-State: AOAM532b9toFQPV126tPw7RK6d7IMgS1jUBjA97rWsgH5PFSHj7kqN+O
        8yN1+aAzKCuD0X0SdpneZfk=
X-Google-Smtp-Source: ABdhPJyZgc6J3PJapwYvBcgEEKZ/Jerd++aLCQoky0Jcr64DLrgfwsKC+jhHtu9KLPZdgvdP4/NUvA==
X-Received: by 2002:a2e:948:: with SMTP id 69mr15645160ljj.82.1639664692137;
        Thu, 16 Dec 2021 06:24:52 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id a12sm896315lfk.227.2021.12.16.06.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:24:51 -0800 (PST)
Subject: Re: [PATCH v4 20/22] ARM: tegra: Add HDMI audio graph to Tegra20
 device-tree
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-21-digetx@gmail.com> <YbtDNbdJqCGTaMNs@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7cc2693f-df2d-b3ca-5336-4815d98a67cb@gmail.com>
Date:   Thu, 16 Dec 2021 17:24:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbtDNbdJqCGTaMNs@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2021 16:46, Thierry Reding пишет:
> On Sat, Dec 04, 2021 at 05:37:23PM +0300, Dmitry Osipenko wrote:
>> Add HDMI audio graph to Tegra20 device-tree to enable HDMI audio on
>> Tegra20 devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/boot/dts/tegra20.dtsi | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> index 72cbe32d0c1d..dde228bcbbff 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -186,7 +186,7 @@ rgb {
>>  			};
>>  		};
>>  
>> -		hdmi@54280000 {
>> +		tegra_hdmi: hdmi@54280000 {
>>  			compatible = "nvidia,tegra20-hdmi";
>>  			reg = <0x54280000 0x00040000>;
>>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -1063,4 +1063,24 @@ pmu {
>>  		interrupt-affinity = <&{/cpus/cpu@0}>,
>>  				     <&{/cpus/cpu@1}>;
>>  	};
>> +
>> +	sound-hdmi {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "NVIDIA Tegra20 HDMI";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		simple-audio-card,dai-link@0 {
>> +			reg = <0>;
>> +
>> +			cpu {
>> +				sound-dai = <&tegra_spdif>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&tegra_hdmi>;
>> +			};
>> +		};
>> +	};
> 
> Should this be status = "disabled" and then only enabled for platforms
> that actually enable HDMI?

Assuming that HDMI node is disabled, we assume that the card won't be
initialized. It won't be a problem to restructure this card in DT later
on if we will have any other use-cases than we currently have, but this
is unlikely to happen in practice.
