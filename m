Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2A54501E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiFIPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiFIPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:05:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21341DF139
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:05:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so47987204ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lPZqyysbfO+3buaJKul7mEmadI+ROjg8n1gq6FC8MZk=;
        b=GUuTlPoRfZMUwhoNlPqshTBdDwigWGKdXr6k1ybuLUMRk2PTHVOD3lsSAoLIulEL6C
         oe92M3x9VO4xZ2QTeXagALdpleC5i3UaH0EGMg+hUItb/yl5a/qhN0SZ78mE4C5N2//2
         r97Sa/VVq2NbaU9VlkkW2e+vHsw97ZoXL0UovybFrboNLb9FSj5sD96Kp4dj+9eF1vJD
         wnrEe/U2wRXuJ0XISAg0QTdXxbGl4SRWXhEn5qu/D4FDBJ7RQDvT4PCju9fo0a0NOyLk
         YKz0nPjUA32KKVwKU4lAYVyVzSCLj/X3PrmqGOVVwHVN3j7gAGhbod8t86XY6CKh8Ob3
         D8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lPZqyysbfO+3buaJKul7mEmadI+ROjg8n1gq6FC8MZk=;
        b=oCLKnLmOjSXxdAUMKTE8dj82JjiK1PBPzGfBRWmG83Gm3TKyAhGdEh3GS1ywXAxAWc
         gcaE75C3SLbKK5fUctZp4Wg0wz6PKodyrHhtlCOWKJZ1IAc3GJ9K8z6zIXLDdVrqB2kX
         6bF/8Zz9zsnTr7iwPYPDjnyOcju7F6m8smeqPsmqnfniJCA6Sw6C81+BlJJlP+6+4Ot7
         ZL2WkJjOMg3/R9udi9pkSLeYRRSQJm2oh/c/20XvlyI1x1w8zt7HPxxILoVLo0xuNwCL
         moa7qubZ/4wEuZ1otcdUVpb78g9JE1ZOG8Zs9z/bZdQYoKglRJrSesbgiqDCLWAOL7ub
         +DCA==
X-Gm-Message-State: AOAM532ZvvbfqkuOdC0Lf12W+VNFlFBxV/SI2TaaTYlUPRjCiXcLu2pR
        aVQvgvIbeTutWEHlp676NxCm+g==
X-Google-Smtp-Source: ABdhPJwkyyWsIEB6RI1cOVWGgt6CQYMSQhhBa+63/Q1yQVUN9GDh93/YoJ+vTNkZewfJ+r2RpRKqAA==
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id cr16-20020a170906d55000b007047ba69854mr35879652ejc.579.1654787151224;
        Thu, 09 Jun 2022 08:05:51 -0700 (PDT)
Received: from [192.168.0.198] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060e0100b006fec4ee28d0sm9305486eji.189.2022.06.09.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 08:05:50 -0700 (PDT)
Message-ID: <e6406956-07b7-d217-f8f4-ef6168647cc2@linaro.org>
Date:   Thu, 9 Jun 2022 17:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 32/48] arm64: dts: rockchip: align gpio-key node names
 with dtschema
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <CAO_MupKxvaXRQvMyEUZMThBZ9033OeJec+BtBndjs5oZ3etTEQ@mail.gmail.com>
 <e0f7146d-3ccc-a194-bb1e-c3475ca8c29e@linaro.org> <2126178.C4sosBPzcN@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2126178.C4sosBPzcN@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 16:56, Heiko Stübner wrote:
> Am Donnerstag, 9. Juni 2022, 16:15:25 CEST schrieb Krzysztof Kozlowski:
>> On 09/06/2022 15:57, Maya Matuszczyk wrote:
>>> czw., 9 cze 2022 o 13:56 Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> napisał(a):
>>>>
>>>> The node names should be generic and DT schema expects certain pattern
>>>> (e.g. with key/button/switch).
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  2 +-
>>>>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 32 +++++++++----------
>>>>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  2 +-
>>>>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  2 +-
>>>>  .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
>>>>  .../dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
>>>>  .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
>>>>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
>>>>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  4 +--
>>>>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-orangepi.dts     |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts |  4 +--
>>>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
>>>>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  2 +-
>>>>  .../boot/dts/rockchip/rk3566-pinenote.dtsi    |  2 +-
>>>>  21 files changed, 38 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>>>> index 9b4f855ea5d4..4b5413b12bfa 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>>>> @@ -75,7 +75,7 @@ gpio-keys {
>>>>                 pinctrl-names = "default";
>>>>                 pinctrl-0 = <&pwr_key>;
>>>>
>>>> -               power {
>>>> +               power-key {
> 
> hmm, it looks like all the others below are named key-power, while
> only this uses power-key ?
> 

Because a bit earlier in DTS, there are two adc-keys nodes with "key"
suffix, so I kept that approach to be consistent within one DTS. If you
prefer, I can change it to key-power.

> 
>>>>                         gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
>>>>                         linux,code = <KEY_POWER>;
>>>>                         label = "GPIO Key Power";
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> index ea0695b51ecd..72328dd993ee 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> @@ -71,82 +71,82 @@ gpio-keys {
>>>>                  * |------------------------------------------------|
>>>>                  */
>>>>
>>>> -               sw1 {
>>>> +               switch-1 {
>>> Wouldn't it make more sense to rename this and all other
>>> renamed nodes in this dts into "button-dpad-up" or "button-1",
>>> as on the physical device those are buttons and the naming
>>> scheme of "sw" + number seems to be a carryover from
>>> downstream sources.
> 
> The naming actually carries over from the device itself.
> In the schematics the relevant keys are also named sw1, sw2, etc.
> 
> And I do believe it is way nicer when devicetree names correspond to the
> things you find in device schematics and not be named "arbitarily" to
> only conform to some schema ;-)

Then you are entirely depending on hardware engineers which might start
calling their buttons "cute-pony-xxx" :)

> 
> So personally I'd actually prefer going with switch-sw1 (or button-sw1 if
> you prefer) as being able to just use the search function in schematic pdfs
> is a helpful tool.

Both are fine with me, let's just pick one - switch-sw1 or button-sw1.
Since these are physically buttons, I propose the latter.


Best regards,
Krzysztof
