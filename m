Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A6544E80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiFIOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiFIOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:15:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FF71DAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:15:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so47788925ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xMZyHB+w1HZyBtjYMs8VhyGH58NpWoIROf4SCsJgVWE=;
        b=IHfLfPqINk7QaemV+fnV7fo1ZYEA9/I2MgUtE2RiNbc6CjqAc2dVvhHP6lyYYroDa9
         Btg7oV8h6m2pfWzlCHGvCcDTcw7pxjsTyjpbIYw6dPKrpXJHHisL2zCA2yuGtrk7QCIp
         px21nXKdE0RpOq3V6GbPTBVyPpt4hkWmU9JLFuVFSGu4IK7SLMQpP248PfFxY+wx6KLE
         ZR0cMC6Lic7+BaBSEH6kXcnedohAd5llgl5UciHgNnTKDqeOZZTEPFbg6qmJDqxPguLg
         VzROxqS2E9P1v+lvmA5yA8oQTUewsPFedXXNZ15QsBxmGxQmreKxQs5MjO7ij0JiBfTg
         8ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xMZyHB+w1HZyBtjYMs8VhyGH58NpWoIROf4SCsJgVWE=;
        b=No5ZBk0aj/ed+AvQYHMdGq5o4MBLuDkDo8VwXz6kvcu2fKPW5QhEoFFWm5/D9shQqM
         MckBLXfuGibMs16w4ewOQ7yF3ZPEHWE6IbQEvUyqlFh5ICII2WWT+73mih8a7kL97Mjc
         lT/27EU9aDCSzj05wyie6yI2fGUGH6g5gN9gkgJcMYsvYj4zUfwP0RL+/HHOw/QEWdUy
         hSZRJxZSf23vcgCm1vt7Mvhhc810EHiVoj1zj4TIEvXkxvyCtfxHMmiRUpt12pVzqU7R
         tchCItURKCRhYXZtkupTMbAUQrL/73SaTTuzS6nyAvdRN1HMnhOX6HBPy76xl9vSVDAs
         YMQg==
X-Gm-Message-State: AOAM533qbziHxAO6OJb1MMy2m4BRvW+lmExV7GKMGLE5+VYEM6Egclq2
        rFTdc6eMVVlLlthV8rEpVZKtVQ==
X-Google-Smtp-Source: ABdhPJwsQpdC8zY3pVgw5zuU9Lvz3PaHrGxutuHe3kM9BTzGZe/6dDFTxGXvB8QTefO1W0gh7jjJeA==
X-Received: by 2002:a17:907:d24:b0:712:1142:88c7 with SMTP id gn36-20020a1709070d2400b00712114288c7mr1505148ejc.435.1654784126853;
        Thu, 09 Jun 2022 07:15:26 -0700 (PDT)
Received: from [192.168.0.198] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rn13-20020a170906d92d00b006f3ef214df2sm10603243ejb.88.2022.06.09.07.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 07:15:26 -0700 (PDT)
Message-ID: <e0f7146d-3ccc-a194-bb1e-c3475ca8c29e@linaro.org>
Date:   Thu, 9 Jun 2022 16:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 32/48] arm64: dts: rockchip: align gpio-key node names
 with dtschema
Content-Language: en-US
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609114026.380682-3-krzysztof.kozlowski@linaro.org>
 <CAO_MupKxvaXRQvMyEUZMThBZ9033OeJec+BtBndjs5oZ3etTEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAO_MupKxvaXRQvMyEUZMThBZ9033OeJec+BtBndjs5oZ3etTEQ@mail.gmail.com>
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

On 09/06/2022 15:57, Maya Matuszczyk wrote:
> czw., 9 cze 2022 o 13:56 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> napisał(a):
>>
>> The node names should be generic and DT schema expects certain pattern
>> (e.g. with key/button/switch).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  2 +-
>>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 32 +++++++++----------
>>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  2 +-
>>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  2 +-
>>  .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
>>  .../dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
>>  .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
>>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  2 +-
>>  .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
>>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
>>  .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 +-
>>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  2 +-
>>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
>>  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  4 +--
>>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  2 +-
>>  .../boot/dts/rockchip/rk3399-orangepi.dts     |  2 +-
>>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts |  4 +--
>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
>>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
>>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  2 +-
>>  .../boot/dts/rockchip/rk3566-pinenote.dtsi    |  2 +-
>>  21 files changed, 38 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>> index 9b4f855ea5d4..4b5413b12bfa 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
>> @@ -75,7 +75,7 @@ gpio-keys {
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pwr_key>;
>>
>> -               power {
>> +               power-key {
>>                         gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
>>                         linux,code = <KEY_POWER>;
>>                         label = "GPIO Key Power";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>> index ea0695b51ecd..72328dd993ee 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>> @@ -71,82 +71,82 @@ gpio-keys {
>>                  * |------------------------------------------------|
>>                  */
>>
>> -               sw1 {
>> +               switch-1 {
> Wouldn't it make more sense to rename this and all other
> renamed nodes in this dts into "button-dpad-up" or "button-1",
> as on the physical device those are buttons and the naming
> scheme of "sw" + number seems to be a carryover from
> downstream sources.

Can be buttons. I assumed SW comes from some kind of switch.
I assume you mean only this Odroid Go2 DTS, because some other DTSes
(like EVB above) explicitly call it "Key Power".


Best regards,
Krzysztof
