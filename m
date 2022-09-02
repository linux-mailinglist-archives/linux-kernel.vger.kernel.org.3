Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583665AB9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIBVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:05:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127A4D14C;
        Fri,  2 Sep 2022 14:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B79DBB82D99;
        Fri,  2 Sep 2022 21:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767AAC43470;
        Fri,  2 Sep 2022 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662152722;
        bh=qsStvP91ihR00dZ3kRmIXS3gp2oRIvI8e0UNRUUK9iU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vAJhH9VGjiTcp8aOmKgoX2qbddBxsvkgr2d6lCX/VRYDIE/oguVxxJOd/jijB7cQF
         oR1O8LNuncj7abV5/XBJTKfieox1lMWGsI4VgTwLCk61T6RyTHGKFSAdlyRe+NmM5Q
         8y/plzRcnodjc6wckvFYL7q7uVdcxp8a6rgoK1CkjIcc28UYmtWjhstYbQV0ITlAEJ
         cCZgrPPU+uhjhtmmVTBSr9inXHgSEuyjT1LGrWcQbsHgKrK9GHqUcKmvPYbyT1M2CX
         0FYRj4AdT3XVfPT28xY31lCgROOpPV+b135QkLsI7nvUmrqeMJyR9kQzdyeoEtytFy
         SXLZzXUUZOPNw==
Received: by mail-vk1-f175.google.com with SMTP id w129so1530060vkg.10;
        Fri, 02 Sep 2022 14:05:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo2BotIQAl79rXzuSu+ZcKAyVCd8qVaP66kPtQX6err0JlbJ2gH2
        prJnySBekYggTuOS+tgwzNDnctPNWi2ce89DYQ==
X-Google-Smtp-Source: AA6agR79pK/SefjTsDIGybHBwpAL12OW8gkE42VozV7uuODUesaBGzPfzSjt1j5VQri5uu5iiMGzNCMQcvSX6NfVS3U=
X-Received: by 2002:a1f:d241:0:b0:398:3e25:d2dd with SMTP id
 j62-20020a1fd241000000b003983e25d2ddmr359225vkg.15.1662152721285; Fri, 02 Sep
 2022 14:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220902060426.2980951-1-jay.xu@rock-chips.com> <20220902060426.2980951-2-jay.xu@rock-chips.com>
In-Reply-To: <20220902060426.2980951-2-jay.xu@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Sep 2022 16:05:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4vXG5b5m5631Jb0ESbjn5z0u2sgKOrXf1BR-qOgeV_w@mail.gmail.com>
Message-ID: <CAL_JsqJ4vXG5b5m5631Jb0ESbjn5z0u2sgKOrXf1BR-qOgeV_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: rockchip: add clock-names
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

On Fri, Sep 2, 2022 at 1:04 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> Add 'clock-names' to the gpio dt node. so the driver could get clocks by
> a const char id, this patch names the clock-names as
>   - 'bus': the apb clock for cpu to access the gpio controller
>   - 'db': the debounce clock for cpu to set debounce clock rate
>
> Since the old dt nodes may have no clock-names, this patch not make them
> as part of 'required properties'.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  .../devicetree/bindings/gpio/rockchip,gpio-bank.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)

Can Rockchip please address DT binding header licensing:

https://lore.kernel.org/all/20220630220409.GA3396626-robh@kernel.org/
https://lore.kernel.org/all/20220902210141.GA403234-robh@kernel.org/
