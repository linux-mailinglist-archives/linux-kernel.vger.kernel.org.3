Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23514EB2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiC2Rpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbiC2Rpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:45:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65068DEB8;
        Tue, 29 Mar 2022 10:43:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so36613636ejc.7;
        Tue, 29 Mar 2022 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MehIMCOHPm3o42xMjUspyRsRaGCPZO4k+2JRMM8VP60=;
        b=Ioy9Hj2QZz5p8Z/D5ukHs4lzEtpu1CXcwGQ+UNVfJhDtlG00LRfk412S3en59kv4Re
         WkhEr82+A9Icp/37rVNFTZ7xqXaINY6BxwA91tMo50N60XyJWjcmh55PR8288Fs59taM
         Ct4ZVD65f/yBY5vEHMJ0AoYGhcJvutWLB07q/8vyXX7c4AYWRAMD94kVYhvDYNvvFPMK
         kB0ZIjQ1/orxaNdAssqD0k0b+wVwSB6yb22fGPdAmvc1RZXT3TXsEn7mjas36G665mMX
         WzwZ4kUYAOOSZoKnxObBCbvgnIwbV4H+FKnaFF92XFton5X3ClKjR8D/dpepI3WoEh3T
         ij2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MehIMCOHPm3o42xMjUspyRsRaGCPZO4k+2JRMM8VP60=;
        b=UOxgVmv1kePUmDlqXSSbPuwhcVJuhmqNNpB0t0UKEtx7sP+u9zVxvaYSnLZdECxq9C
         UbRXW0+KLM8Xu+fQ4QOAhYC1SyKdPDFlN876N7/nNuKnl9jH55HbmscRmsu2nasyZ8Jg
         NIsmW991opZR7SlzJVky3OWt7TRiUgxJ7NUoaAgtpHYgDsB2fPIZbmxizNyTmy+8Q0/7
         6hrhh7L3FMNE6GgTwjXy9CbNqw2Zgs6n6W9d1ozBLVflxr/TBErF5QSNx9NSOiWKsBVz
         KM4hnmpxW3WtbnWKvFZI0qYT0N3gaTt8+NWFfGtFQfvXmoTn123P2402cGYH3SwGxrAK
         A4cA==
X-Gm-Message-State: AOAM531IR7g5bzrIqzxgzkIYtN/ss0yJfPe94z4dG+unHhIAcN1U80HL
        xn4YVHIw5hU+opssc+mJBmk=
X-Google-Smtp-Source: ABdhPJyzfti3CS/e24Ly5WM74Dz/LkpZUBjNoeNIQqIY56i7iaj94vcNqx1CjI1XHgEUr+qwuY0XUg==
X-Received: by 2002:a17:906:99c3:b0:6df:a289:ed3a with SMTP id s3-20020a17090699c300b006dfa289ed3amr35708735ejn.660.1648575830776;
        Tue, 29 Mar 2022 10:43:50 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e28-20020a170906649c00b006df6dfeb557sm7265737ejm.49.2022.03.29.10.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:43:50 -0700 (PDT)
Message-ID: <686f4aab-e41f-ad3d-249c-09fb8da8ef8c@gmail.com>
Date:   Tue, 29 Mar 2022 19:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 2/3] arm64: dts: rockchip: fix compatible string rk3328
 cru node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329163016.27458-1-jbx6244@gmail.com>
 <20220329163016.27458-2-jbx6244@gmail.com>
 <09fa521e-dcf9-b744-da30-86542fd8855e@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <09fa521e-dcf9-b744-da30-86542fd8855e@linaro.org>
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



On 3/29/22 19:23, Krzysztof Kozlowski wrote:
> On 29/03/2022 18:30, Johan Jonker wrote:
>> The rockchip,rk3328-cru.txt file was converted to YAML.
>> A DT test of the rk3328 cru node gives notifications regarding
>> the compatible string. Bring it in line with the binding by
>> removing some unused fall back strings.
> 

> Are you sure these are unused? rockchip,cru maybe, but what about DTS
> used out of tree? It's useful to mention that the compatible is not
> documented (so if there are any out of tree users, it's their fault).
> 
> Removal of syscon is different case - why do you think it is unused? Did
> you check it? It's not a fallback compatible.

Hi,

If someone knows why that was added to the Rockchip tree? Let us
know.(Elaine ??)
Other well know locations don't seem to use it.

Please advise.

Johan
===

https://github.com/torvalds/linux/search?q=rockchip%2Ccru&type=code

https://source.denx.de/search?search=rockchip%2Ccru&group_id=325&project_id=540&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar

https://github.com/rockchip-linux/kernel/search?q=rockchip%2Ccru&type=code

> 
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index b822533dc..73418fd2f 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -756,7 +756,7 @@
>>  	};
>>  
>>  	cru: clock-controller@ff440000 {
>> -		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
>> +		compatible = "rockchip,rk3328-cru";
>>  		reg = <0x0 0xff440000 0x0 0x1000>;
>>  		rockchip,grf = <&grf>;
>>  		#clock-cells = <1>;
> 
> 
> Best regards,
> Krzysztof
