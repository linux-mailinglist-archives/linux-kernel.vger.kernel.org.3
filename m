Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AB4E9824
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiC1NaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiC1NaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:30:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D25BC4;
        Mon, 28 Mar 2022 06:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6AAFB81126;
        Mon, 28 Mar 2022 13:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1872C34110;
        Mon, 28 Mar 2022 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648474101;
        bh=tIR5y1hpm4AjO9RJ6v9GsRGC9Ca0AqosOs+7fpsV3Ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uiP/2hcfgJ3zmSkfN+z42KczzDVrtCHK1ONpnC3cRb1wim0y2ms+Lxcb3FKqgeelg
         zkOwT46z506BqRE+39zk4Eswmahgg3XIRbmT1Ys+B8DbUOrQuHP8z1uEqlFuS0kKQ5
         ofTH73Gor19i5qG7597AQ/gzqQZ4wm7IF4o5afyT8MwRXCdzimNWawAtf5ILEuB4ew
         gdzM7LdGlIfiF9kLFbipw7kuzEsguACL4WN3+HJ/CpFGXzN/sHlUakkW4g1X0nf/7n
         rPNmuMmDZ04PBS1MKyRDCtsUYHAJgAtCTMgzv8D9bqdaRTpZBZqDiJtgo2Q8A9VK3F
         I66kv69HlqD1Q==
Received: by mail-ej1-f43.google.com with SMTP id qa43so28643126ejc.12;
        Mon, 28 Mar 2022 06:28:21 -0700 (PDT)
X-Gm-Message-State: AOAM532L0gU87c2ykn/B1bfhdcOay7mMABSgSqttQVSLxYuqXKDEz7UK
        R3dgu/w9T0PzJyBjQ29B+V1aHqn0HE3CxGdEow==
X-Google-Smtp-Source: ABdhPJw9vOvGYrmizEfXrzpQNqE0Cos/IyfXm4WzYVaV3l2V+fNfbJKz/yJlVk2RcFDMbVCV2HDXqIp3k8hJWlRTwAI=
X-Received: by 2002:a17:907:2d0a:b0:6df:87bd:4cd5 with SMTP id
 gs10-20020a1709072d0a00b006df87bd4cd5mr27665304ejc.423.1648474099888; Mon, 28
 Mar 2022 06:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220324124402.3631379-1-daniel@0x0f.com> <20220324124402.3631379-5-daniel@0x0f.com>
In-Reply-To: <20220324124402.3631379-5-daniel@0x0f.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Mar 2022 08:28:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8A78Czx_3GZ6Tsg3_4xGUiL3u14R176gZTe+54CbGHw@mail.gmail.com>
Message-ID: <CAL_JsqL8A78Czx_3GZ6Tsg3_4xGUiL3u14R176gZTe+54CbGHw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: mstar: Add second UART to base dtsi.
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 7:44 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Add the second UART to the base dtsi.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/arm/boot/dts/mstar-v7.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
> index 8464a8f1b136..baf2422b9854 100644
> --- a/arch/arm/boot/dts/mstar-v7.dtsi
> +++ b/arch/arm/boot/dts/mstar-v7.dtsi
> @@ -182,6 +182,14 @@ pm_uart: uart@221000 {
>                                 clock-frequency = <172000000>;
>                                 status = "disabled";
>                         };
> +
> +                       uart1: uart@221200 {

serial@...

Please run schema checks on your DT as that should be a warning that I
don't have to tell you about.

Rob
