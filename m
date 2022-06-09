Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43149544E42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiFIN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiFIN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:58:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3629DC19;
        Thu,  9 Jun 2022 06:58:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g186so13028620pgc.1;
        Thu, 09 Jun 2022 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=96RW/mbL/2DXM4l3I73TuzvCiuTWdOKUYU3PG/oUzAI=;
        b=SlFMlYBtIJ/K5g5OCznvRlvul8d4SV8HRB+pG+lzVNyUqxOFclbbfZLuxq27CIKtyu
         4N3BPrpxDld8pG00PIuA20mHxX0oz9kBlygD0ZmiXuBxS6erJ7D4pRMjsPDqogyuvNzV
         bGSm2yOWc4m1fJZnW0KJcbqwV8wqK4A7bwKydp8hisrUK7uUX5p4Y1+6e3RxDcTwDQLs
         kwt0/PgrFHTlaDUr0PMxb44X2P2I0USvSdyyM4CGSTEXg7BSxAiWkASIx1V7KtW9yVv5
         6qKG9qEAD5AUWQih6Gez6cBRLwO2XjvHivcBP3g6/YbREDinrcn0csMsXHoRPc148rzu
         zlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=96RW/mbL/2DXM4l3I73TuzvCiuTWdOKUYU3PG/oUzAI=;
        b=1mv5eD0aipGGB6FPVKQJdca+B3ra5FRXZ4xbh9driIYNYE26RFf3naVKsntJn6GxMt
         Xrf/SpAIY/+T4Mrgr3zxtkJLyJv+tpRqU7Rg8gb/R8HG//U6O7AbutSZ1mTm3v7MdvJS
         S8Y9pW6m05sqL+Tz3S8ukxXS/Ngh3gIqGBzMIMWN4zzPseBvDHhE07vemPZK0nKgWNZZ
         DrMMnwcHDN04g5UZ6DlDoSe2tqvUnCw9+ChMOhikgrjoIAgSNmd3KivZRQ/4rkjaohIn
         50eGkc2MVdMFk/vPiEuIsXORQzN0NihdutUAy8jwx7rI7MjIM5ohdj/Ojv8iRoJCB0EH
         oIsA==
X-Gm-Message-State: AOAM531/THL/NLQ2tFupxPmME0z7taBYkHOJOr4yTK9K74+fzUZCK7Eb
        JDCCI5JftDP0oe6miyr08hF9fayLsVYTt2+YhYJXGzFTv5xUYw==
X-Google-Smtp-Source: ABdhPJxdQOsF/jy/W9Sm3gtlVbx9Q0MLLzsW63TqmMEat5HrSAEw2Wm/rDyrqDhSBuYXXOi9qMB0pvCET46e5qc4pC4=
X-Received: by 2002:a63:2:0:b0:3f6:5b37:e94c with SMTP id 2-20020a630002000000b003f65b37e94cmr34982956pga.356.1654783083815;
 Thu, 09 Jun 2022 06:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609114026.380682-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609114026.380682-3-krzysztof.kozlowski@linaro.org>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Thu, 9 Jun 2022 15:57:27 +0200
Message-ID: <CAO_MupKxvaXRQvMyEUZMThBZ9033OeJec+BtBndjs5oZ3etTEQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/48] arm64: dts: rockchip: align gpio-key node names
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 cze 2022 o 13:56 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisa=C5=82(a):
>
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  2 +-
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 32 +++++++++----------
>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  2 +-
>  .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
>  .../dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
>  .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  2 +-
>  .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
>  .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 +-
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  2 +-
>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
>  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  4 +--
>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  2 +-
>  .../boot/dts/rockchip/rk3399-orangepi.dts     |  2 +-
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts |  4 +--
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  2 +-
>  .../boot/dts/rockchip/rk3566-pinenote.dtsi    |  2 +-
>  21 files changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boo=
t/dts/rockchip/rk3308-evb.dts
> index 9b4f855ea5d4..4b5413b12bfa 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
> @@ -75,7 +75,7 @@ gpio-keys {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pwr_key>;
>
> -               power {
> +               power-key {
>                         gpios =3D <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
>                         linux,code =3D <KEY_POWER>;
>                         label =3D "GPIO Key Power";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/ar=
m64/boot/dts/rockchip/rk3326-odroid-go2.dts
> index ea0695b51ecd..72328dd993ee 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> @@ -71,82 +71,82 @@ gpio-keys {
>                  * |------------------------------------------------|
>                  */
>
> -               sw1 {
> +               switch-1 {
Wouldn't it make more sense to rename this and all other
renamed nodes in this dts into "button-dpad-up" or "button-1",
as on the physical device those are buttons and the naming
scheme of "sw" + number seems to be a carryover from
downstream sources.

>                         gpios =3D <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
>                         label =3D "DPAD-UP";
>                         linux,code =3D <BTN_DPAD_UP>;
>                 };
> -               sw2 {
> +               switch-2 {
>                         gpios =3D <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
>                         label =3D "DPAD-DOWN";
>                         linux,code =3D <BTN_DPAD_DOWN>;
>                 };
> -               sw3 {
> +               switch-3 {
>                         gpios =3D <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
>                         label =3D "DPAD-LEFT";
>                         linux,code =3D <BTN_DPAD_LEFT>;
>                 };
> -               sw4 {
> +               switch-4 {
>                         gpios =3D <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
>                         label =3D "DPAD-RIGHT";
>                         linux,code =3D <BTN_DPAD_RIGHT>;
>                 };
> -               sw5 {
> +               switch-5 {
>                         gpios =3D <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
>                         label =3D "BTN-A";
>                         linux,code =3D <BTN_EAST>;
>                 };
> -               sw6 {
> +               switch-6 {
>                         gpios =3D <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
>                         label =3D "BTN-B";
>                         linux,code =3D <BTN_SOUTH>;
>                 };
> -               sw7 {
> +               switch-7 {
>                         gpios =3D <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
>                         label =3D "BTN-Y";
>                         linux,code =3D <BTN_WEST>;
>                 };
> -               sw8 {
> +               switch-8 {
>                         gpios =3D <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
>                         label =3D "BTN-X";
>                         linux,code =3D <BTN_NORTH>;
>                 };
> -               sw9 {
> +               switch-9 {
>                         gpios =3D <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
>                         label =3D "F1";
>                         linux,code =3D <BTN_TRIGGER_HAPPY1>;
>                 };
> -               sw10 {
> +               switch-10 {
>                         gpios =3D <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
>                         label =3D "F2";
>                         linux,code =3D <BTN_TRIGGER_HAPPY2>;
>                 };
> -               sw11 {
> +               switch-11 {
>                         gpios =3D <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
>                         label =3D "F3";
>                         linux,code =3D <BTN_TRIGGER_HAPPY3>;
>                 };
> -               sw12 {
> +               switch-12 {
>                         gpios =3D <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
>                         label =3D "F4";
>                         linux,code =3D <BTN_TRIGGER_HAPPY4>;
>                 };
> -               sw13 {
> +               switch-13 {
>                         gpios =3D <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
>                         label =3D "F5";
>                         linux,code =3D <BTN_TRIGGER_HAPPY5>;
>                 };
> -               sw14 {
> +               switch-14 {
>                         gpios =3D <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
>                         label =3D "F6";
>                         linux,code =3D <BTN_TRIGGER_HAPPY6>;
>                 };
> -               sw15 {
> +               switch-15 {
>                         gpios =3D <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
>                         label =3D "TOP-LEFT";
>                         linux,code =3D <BTN_TL>;
>                 };
> -               sw16 {
> +               switch-16 {
>                         gpios =3D <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
>                         label =3D "TOP-RIGHT";
>                         linux,code =3D <BTN_TR>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/ar=
m64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> index 3857d487ab84..1445b879ac7a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> @@ -34,7 +34,7 @@ keys {
>                 pinctrl-0 =3D <&reset_button_pin>;
>                 pinctrl-names =3D "default";
>
> -               reset {
> +               key-reset {
>                         label =3D "reset";
>                         gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
>                         linux,code =3D <KEY_RESTART>;

[snip]
