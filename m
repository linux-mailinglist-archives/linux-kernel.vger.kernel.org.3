Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8D4E65B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351037AbiCXO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbiCXO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:56:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BFF7486C;
        Thu, 24 Mar 2022 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1648133676; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4RqB7TRAYJBu7Wm3B9VZjS3Tw7CidJf6vGxQitVk5U=;
        b=JZkuKyp52NeLVnkK54mHEffdaxGZogn6w7EExst0FnYnOjuPeY02hv0eN/B3k7788lYv8O
        TD1U7aFUKGOnTvCF+8COJRlHOzZDJ25L0JD0yHEfjl3W8KRbReteN5anggoyJQwNAQvYIO
        a/oYoJyMwMp16R4dCiGVwY/2qGnoACk=
Date:   Thu, 24 Mar 2022 14:54:17 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] pinctrl: Ingenic: Add missing UART2 group C for
 X1000/E
To:     Yunian Yang <reimu@sudomaker.com>
Cc:     linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <H2899R.18AGJJTC83P61@crapouillou.net>
In-Reply-To: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
References: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu., mars 24 2022 at 21:33:56 +0800, Yunian Yang=20
<reimu@sudomaker.com> a =E9crit :
> v2: Define PC31 pin only once, noted by Paul Cercueil=20
> <paul@crapouillou.net>
>     Confirmed to work on hardware. Although the Ingenic folks did=20
> this twice
>     in their 4.4 kernel fork; not sure why.
>=20
> X1000/E has a third UART2 pin group selection, which uses the TDI(G2)=20
> as RX
> and TDO(G1) as TX. This configuration is becoming increasingly=20
> popular in
> newer core boards, such as the Halley2 v4.1. This is done by enabling
> function 1 of a "virtual pin" PC31. See section 19.3.3 of the X1000
> Programming Manual for details.
>=20
> Signed-off-by: Yunian Yang <reimu@sudomaker.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 2712f51eb238..29709059d62b 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -1982,6 +1982,7 @@ static int x1000_uart1_data_a_pins[] =3D { 0x04,=20
> 0x05, };
>  static int x1000_uart1_data_d_pins[] =3D { 0x62, 0x63, };
>  static int x1000_uart1_hwflow_pins[] =3D { 0x64, 0x65, };
>  static int x1000_uart2_data_a_pins[] =3D { 0x02, 0x03, };
> +static int x1000_uart2_data_c_pins[] =3D { 0x5f, };
>  static int x1000_uart2_data_d_pins[] =3D { 0x65, 0x64, };
>  static int x1000_sfc_data_pins[] =3D { 0x1d, 0x1c, 0x1e, 0x1f, };
>  static int x1000_sfc_clk_pins[] =3D { 0x1a, };
> @@ -2058,6 +2059,7 @@ static const struct group_desc x1000_groups[] =3D=20
> {
>         INGENIC_PIN_GROUP("uart1-data-d", x1000_uart1_data_d, 1),
>         INGENIC_PIN_GROUP("uart1-hwflow", x1000_uart1_hwflow, 1),
>         INGENIC_PIN_GROUP("uart2-data-a", x1000_uart2_data_a, 2),
> +       INGENIC_PIN_GROUP("uart2-data-c", x1000_uart2_data_c, 1),
>         INGENIC_PIN_GROUP("uart2-data-d", x1000_uart2_data_d, 0),
>         INGENIC_PIN_GROUP("sfc-data", x1000_sfc_data, 1),
>         INGENIC_PIN_GROUP("sfc-clk", x1000_sfc_clk, 1),
> @@ -2115,7 +2117,7 @@ static const char *x1000_uart0_groups[] =3D {=20
> "uart0-data", "uart0-hwflow", };
>  static const char *x1000_uart1_groups[] =3D {
>         "uart1-data-a", "uart1-data-d", "uart1-hwflow",
>  };
> -static const char *x1000_uart2_groups[] =3D { "uart2-data-a",=20
> "uart2-data-d", };
> +static const char *x1000_uart2_groups[] =3D { "uart2-data-a",=20
> "uart2-data-c", "uart2-data-d", };
>  static const char *x1000_sfc_groups[] =3D { "sfc-data", "sfc-clk",=20
> "sfc-ce", };
>  static const char *x1000_ssi_groups[] =3D {
>         "ssi-dt-a-22", "ssi-dt-a-29", "ssi-dt-d",
> --
> 2.30.2


