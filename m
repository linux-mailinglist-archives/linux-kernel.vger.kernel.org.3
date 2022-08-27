Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127585A361E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiH0I4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiH0I4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:56:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186E81A800
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:56:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x10so3582967ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QJ4HT0he87HIgYoNNPjNZYpebuQrG8KDl61t9yCXsaY=;
        b=BaWqQvP4at07HKbZdqtc0L8oDdEaQYPfd7KBR+mYZ/CisEiBqIcJ8kzbcAY2g2tYpZ
         jHbuE8F56jVyhmXF3ZjAmh5frvuiJEj9ruNZ+R7Re30akwJLgkyZaaFhNCReoJ0zQnqE
         c6QURcK7vm1ofxsR4SZTKRJfxQPJchPhBaikT8MV9E7QdtmjnVowN/tH3cspjNnyH3zT
         n+rECFpc95h6++tIo/KGObvUOBkXmwlEh7Z9ya8k0ZfrYOImfWvcH6QL4ODDidNyS+vg
         alkBLFySZiDrf151hSSbeO8v/KExGY1SZBxdhNDnlPYHb3H1RjXG1/bl+hhAg3vaRLac
         RFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QJ4HT0he87HIgYoNNPjNZYpebuQrG8KDl61t9yCXsaY=;
        b=35w0kVU9zJNunE4HIoPD91jx470mjSWtj36V+RyUmn1A+YaflaUljFCfhtd0gyUTQX
         XrZt2m+S12NIw0yMlOxphB4dtz4M5ewfW4uwXOiilDNNvn3ArzOTinh+3zIgYNuLT1ta
         t0yz84Qh2zeSQ0xBcOgXaKZG1YoCxVKLaDTURYoaLTcu0SmHuMf9VxEsHKt1D1/3kgYe
         1VPVnvdkwnbkLpvVgsQ4IkUCvRw+cTFtCkLqzYLEPx/fo0m32gICi2vITKizsEnWqImN
         LBfVwvYreVF0dZUJedUkUn5SPBeZO1CZHGp+WjhaO9oPjeGw+uOKw/S+n3Or961aLIdQ
         VhFw==
X-Gm-Message-State: ACgBeo1gnvId1gP2z3Dc15/FBVAi295neseueDhlS6uFQf28za2yke/i
        SLzITBqJ6zZiWYorEAy91rythw==
X-Google-Smtp-Source: AA6agR5Gf2HiB0PYqIOyopTJHVHjtmH8tqD3JHxMYot9zAwjH2AhyPPMzu27/HBBbMawPBnpWAwh0Q==
X-Received: by 2002:a2e:a78e:0:b0:261:d661:14b8 with SMTP id c14-20020a2ea78e000000b00261d66114b8mr3384038ljf.452.1661590572347;
        Sat, 27 Aug 2022 01:56:12 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id u16-20020a056512129000b00492c2394ea5sm41760lfs.165.2022.08.27.01.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 01:56:11 -0700 (PDT)
Message-ID: <ee6dc940-8b90-1f57-28b7-6de8e3483027@linaro.org>
Date:   Sat, 27 Aug 2022 11:56:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Aw: Re: [PATCH v5 5/5] arm64: dts: rockchip: Add PCIe v3 nodes to
 BPI-R2-Pro
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-6-linux@fw-web.de>
 <cae915f6-c951-ba97-346d-00922c85067d@linaro.org>
 <trinity-88fbbdbe-de76-4479-9580-70edc34a4181-1661590200169@3c-app-gmx-bs16>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-88fbbdbe-de76-4479-9580-70edc34a4181-1661590200169@3c-app-gmx-bs16>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2022 11:50, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Freitag, 26. August 2022 um 08:50 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> On 25/08/2022 22:38, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
> 
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>> index 93d383b8be87..40b90c052634 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>> @@ -86,6 +86,66 @@ vcc5v0_sys: vcc5v0-sys {
>>>  		vin-supply = <&dc_12v>;
>>>  	};
>>>
>>> +	pcie30_avdd0v9: pcie30-avdd0v9 {
>>
>> Use consistent naming, so if other nodes have "regulator" suffix, use it
>> here as well.
> 
> only these 3 new have the suffix:
> 
> vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator
> vcc3v3_minipcie: vcc3v3-minipcie-regulator
> vcc3v3_ngff: vcc3v3-ngff-regulator
> 
> so i would drop it there...
> 
> so i end up with (including existing ones to compare):
> 
> vcc3v3_sys: vcc3v3-sys
> vcc5v0_sys: vcc5v0-sys
> pcie30_avdd0v9: pcie30-avdd0v9
> pcie30_avdd1v8: pcie30-avdd1v8
> vcc3v3_pi6c_05: vcc3v3-pi6c-05
> vcc3v3_minipcie: vcc3v3-minipcie
> vcc3v3_ngff: vcc3v3-ngff
> vcc5v0_usb: vcc5v0_usb
> vcc5v0_usb_host: vcc5v0-usb-host
> vcc5v0_usb_otg: vcc5v0-usb-otg
> 
> is this ok?
> 
> maybe swap avdd* and pcie30 part to have voltage in front of function.
> 

I prefer all of them have regulator suffix. I think reasonable is also
to rename the old ones and then add new ones with suffix.


Best regards,
Krzysztof
