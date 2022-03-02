Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853714C9BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiCBDJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239242AbiCBDJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:09:21 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E54AF1C8;
        Tue,  1 Mar 2022 19:08:36 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id jr3so522064qvb.11;
        Tue, 01 Mar 2022 19:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQqrwFMPY5plGbddCnC14E9lxWyrfbG5ICWPNwpm/RM=;
        b=LmkJ4nzw/MELoRSNtv7sEIw35ccww6Tr7FyTGDd77VlakAkiEf6KMriBzFgjV3Dh9Q
         ut5EUs7nLlaXU+ZX7vCFbfbG67wFgGQivXloO/LKKkeV+6+Gx/XzBcFDm/J8GRFK6Sgj
         0DXOgdx/5jCtBgbbAvUzH5vOYvFSe71JlODdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQqrwFMPY5plGbddCnC14E9lxWyrfbG5ICWPNwpm/RM=;
        b=Qe29JwMNQbMEvvZSp9mQW4/OaifwY6VRDskHPQ336wDQnIqkT/pRiouXlmqOSvICDX
         p57/SZ2KUKIRUKPyismM/h3NJoul72uHX32n4E+9xdApPQaJTxTCjyAfmgR/jfkBnQ0U
         aiZc1CClUFsnBZE1M7PMUxm2vS8kerOrWI+UFBR5fPZqzPV3a5HReOKeoWZrFbwH1sz1
         FEZ9bpF914jOyzoqYz+G0DcUfyT1d6zO2CU2qhYVFT3HN/eacf5H/mAlu/NC8pQXJPa/
         YZyYNK2WYxdqWnISKpvyH6cSjp6CPjkxjhpLFNQDmKrYcKSRBhHBLF80xlhdoUiQc4z6
         Krmw==
X-Gm-Message-State: AOAM532qyJ/UHl+IGxKde1t2Fx/SRFwFeez6dgaTY3XorOKNTn81JOSO
        atScgPJpGVa9UCk3gtEEfAAcKY014zG9oiqZTc8=
X-Google-Smtp-Source: ABdhPJztD0vIx1Wl0A9xT1RwV7lGsUr0ZEEv3QSKFr9EnK8lyK9xuR0wpsW6Xg66ZqVBWQ9OL8JSmp1eGkx1vZcag5k=
X-Received: by 2002:a05:6214:19c4:b0:432:8bd1:d8d7 with SMTP id
 j4-20020a05621419c400b004328bd1d8d7mr19678222qvc.65.1646190515132; Tue, 01
 Mar 2022 19:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com> <20220302024930.18758-6-tommy_huang@aspeedtech.com>
In-Reply-To: <20220302024930.18758-6-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 03:08:22 +0000
Message-ID: <CACPK8XcsLBrJo7W5y3sE_jGy9j4e6MPNcB26bJ4SB1ZhVuka+A@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] ARM: dtsi: aspeed: Modified gfx reset control
To:     Tommy Haung <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 02:50, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
>
> Remove the ast2500-gfx from aspeed-g6.dtsi.
> In the AST2600, the ASPEED_RESET_CRT1 is replaced by
> ASPEED_RESET_GRAPHICS. This is no differnce between these two reset
> behavior but reigster location is changed. The HW controller states
> and FW programming resgiter will be reset by CRT reset controller bit
> (SCU040[13]). And another part HW controller will be reset by
> Graphics controller bit (SCU040[26]). These two reset bit need be
> de-assert then the SOC display will be active.
>
> Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>

You don't need this patch; the change should be part of the patch that
introduces the node. I'll fix that up when applying.

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index e38c3742761b..7cc99bc68558 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -352,7 +352,7 @@
>                         };
>
>                         gfx: display@1e6e6000 {
> -                               compatible = "aspeed,ast2600-gfx", "aspeed,ast2500-gfx", "syscon";
> +                               compatible = "aspeed,ast2600-gfx", "syscon";
>                                 reg = <0x1e6e6000 0x1000>;
>                                 reg-io-width = <4>;
>                                 clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
> --
> 2.17.1
>
