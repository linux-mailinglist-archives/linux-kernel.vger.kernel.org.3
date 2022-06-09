Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB454515B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbiFIPzd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jun 2022 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbiFIPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:55:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221A434B3;
        Thu,  9 Jun 2022 08:55:24 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nzKVB-0007Jz-Ts; Thu, 09 Jun 2022 17:55:17 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 32/48] arm64: dts: rockchip: align gpio-key node names with dtschema
Date:   Thu, 09 Jun 2022 17:55:17 +0200
Message-ID: <6317926.K2JlShyGXD@diego>
In-Reply-To: <e6406956-07b7-d217-f8f4-ef6168647cc2@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <2126178.C4sosBPzcN@diego> <e6406956-07b7-d217-f8f4-ef6168647cc2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Juni 2022, 17:05:49 CEST schrieb Krzysztof Kozlowski:
> On 09/06/2022 16:56, Heiko Stübner wrote:
> > Am Donnerstag, 9. Juni 2022, 16:15:25 CEST schrieb Krzysztof Kozlowski:
> >> On 09/06/2022 15:57, Maya Matuszczyk wrote:
> >>> czw., 9 cze 2022 o 13:56 Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> napisał(a):
> >>>>
> >>>> The node names should be generic and DT schema expects certain pattern
> >>>> (e.g. with key/button/switch).
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  2 +-
> >>>>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 32 +++++++++----------
> >>>>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  2 +-
> >>>>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  2 +-
> >>>>  .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
> >>>>  .../dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
> >>>>  .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
> >>>>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
> >>>>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  4 +--
> >>>>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-orangepi.dts     |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts |  4 +--
> >>>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
> >>>>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  2 +-
> >>>>  .../boot/dts/rockchip/rk3566-pinenote.dtsi    |  2 +-
> >>>>  21 files changed, 38 insertions(+), 38 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
> >>>> index 9b4f855ea5d4..4b5413b12bfa 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
> >>>> @@ -75,7 +75,7 @@ gpio-keys {
> >>>>                 pinctrl-names = "default";
> >>>>                 pinctrl-0 = <&pwr_key>;
> >>>>
> >>>> -               power {
> >>>> +               power-key {
> > 
> > hmm, it looks like all the others below are named key-power, while
> > only this uses power-key ?
> > 
> 
> Because a bit earlier in DTS, there are two adc-keys nodes with "key"
> suffix, so I kept that approach to be consistent within one DTS. If you
> prefer, I can change it to key-power.

I just saw that discrepancy and was not sure if that was intentional.
Although with the below, I guess it makes sense to go with
$type-$name, aka key-power, same as button-sw1 etc.


> >>>>                         gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> >>>>                         linux,code = <KEY_POWER>;
> >>>>                         label = "GPIO Key Power";
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> >>>> index ea0695b51ecd..72328dd993ee 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> >>>> @@ -71,82 +71,82 @@ gpio-keys {
> >>>>                  * |------------------------------------------------|
> >>>>                  */
> >>>>
> >>>> -               sw1 {
> >>>> +               switch-1 {
> >>> Wouldn't it make more sense to rename this and all other
> >>> renamed nodes in this dts into "button-dpad-up" or "button-1",
> >>> as on the physical device those are buttons and the naming
> >>> scheme of "sw" + number seems to be a carryover from
> >>> downstream sources.
> > 
> > The naming actually carries over from the device itself.
> > In the schematics the relevant keys are also named sw1, sw2, etc.
> > 
> > And I do believe it is way nicer when devicetree names correspond to the
> > things you find in device schematics and not be named "arbitarily" to
> > only conform to some schema ;-)
> 
> Then you are entirely depending on hardware engineers which might start
> calling their buttons "cute-pony-xxx" :)

What's wrong with cute-ponies?
Though it should be button-cute-pony-xxx then ;-)


> > So personally I'd actually prefer going with switch-sw1 (or button-sw1 if
> > you prefer) as being able to just use the search function in schematic pdfs
> > is a helpful tool.
> 
> Both are fine with me, let's just pick one - switch-sw1 or button-sw1.
> Since these are physically buttons, I propose the latter.

fine by me, button-sw1, etc it is then :-)

Heiko


