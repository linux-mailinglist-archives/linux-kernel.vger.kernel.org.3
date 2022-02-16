Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE604B7FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiBPFCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:02:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiBPFCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:02:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638B19C11;
        Tue, 15 Feb 2022 21:02:10 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id o25so803195qkj.7;
        Tue, 15 Feb 2022 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYPtY5u6D3N2oAx07Twnx1Q6uW+oBqsNGkla18NTHW4=;
        b=MpCID14hiuBXc/bNPMaQ0Rcp+ls6qDgqKWHh97Z5zMzFMGaXiMikULLv20rqLswR2W
         biN4XnMARqzymx9yW/pV7hUvW7Mm22bgA5LEiqhjSc28hsqbz+Hh0GN5tL7t/LHkc4OW
         CH5jES8tubBrPzc4J3FskyOVee+0iryJjd3Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYPtY5u6D3N2oAx07Twnx1Q6uW+oBqsNGkla18NTHW4=;
        b=6sm7pMYEk6fCDsFPifRmOQepWSIRY7FQi8RGlOkM5rQoCyA5AYHL9s81+CMsDIiFJd
         Oh2EluCd1OjlVrEArlW6vo4pJ1eO8qqo9lJv/7XM0hzZugpujnQaSXUwUSQLbUKPcxdy
         XQvHug3998HgROfjPxp98HteuqKl0ODO84gPKwNU5hEUJztOnOL98eIYjgaL0qpPP4Ne
         eTrPh4oGKUqvZa0gSNA702veyEIAG3NGn7ojX4adkRTRDiXalQtuHHlKjU52ZTHE6zR4
         G+HK6oICljTv8V82ehwTc5r2yfJrwgC9hgl8T34km+g00Ep9k3lkpRcP0EUZfAPJ4Lb/
         JWfQ==
X-Gm-Message-State: AOAM5305lue5E4u4qTYlT2B8EPuWVwWbDMB1+V4pGFnCoOpanTaApcGu
        7sWedXXy6uUjZMLXNzXopREz/ywu0FNNUdwJErg=
X-Google-Smtp-Source: ABdhPJy/jdRpLYMO8gCka38ySD07dqPGr2tdWJbVBEk+9TLSpek5WfeeQ28NmoNTnGFNXYbGVV8BDtT84dSYF8JIUBE=
X-Received: by 2002:a05:620a:1414:b0:47d:87ec:72b6 with SMTP id
 d20-20020a05620a141400b0047d87ec72b6mr517115qkj.666.1644987729766; Tue, 15
 Feb 2022 21:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20220215163151.32252-1-potin.lai@quantatw.com>
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 05:01:56 +0000
Message-ID: <CACPK8Xfs34gw2_XGeduJ6D=-khN7RtMj3LY8hQ8B96fFxMuE8A@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] update Facebook Bletchley BMC
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, 15 Feb 2022 at 16:32, Potin Lai <potin.lai@quantatw.com> wrote:
>
> This patch series update Facebook Bletchley BMC devicetree base on EVT HW
> schematioc design, and rebase SLED numbering to 1-based for OpenBMC
> multi-host.
>
> - GPIO:
>   - adding more gpio line names
>   - include interrupt line in io expander for gpio interrupt monitoring
>
> - SPI flash:
>   - adding dual flash BSM module support
>   - switch to spi2-gpio on spi2 due to unstable signal issue
>
> - Hwmon Sensors:
>   - adding INA230 sensors for monitoring
>   - fix ADM1278 shunt-resistor
>
> - MDIO Bus: enable mido3 bus
>
> - RTC: switch to external battery-backed rtc
>
> - OpenBMC: 1-based SLED numbering
>
>
> LINK: [v2] https://lore.kernel.org/all/20220214042538.12132-1-potin.lai@quantatw.com/
> LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai@quantatw.com/
>
>
> Changes v2 --> v3:
> - update patch name prefix
> - Disable spi2, and create a new node call spi2_gpio

Thanks, the patches look good.

Reviewed-by: Joel Stanley <joel@jms.id.au>

and given the minor differences from v2, lets add Patrick's review:

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

I've applied these for submission in the v5.18 merge window, and to
the openbmc tree.


>
> Changes v1 --> v2:
> - update the details of new added gpio line names in commit message
> - add battery-backed rtc information in comment and commit message
>
>
> Potin Lai (10):
>   ARM: dts: aspeed: bletchley: switch sled numbering to 1-based
>   ARM: dts: aspeed: bletchley: separate leds into multiple groups
>   ARM: dts: aspeed: bletchley: update gpio-line-names
>   ARM: dts: aspeed: bletchley: update fmc configurations
>   ARM: dts: aspeed: bletchley: switch to spi-gpio for spi2
>   ARM: dts: aspeed: bletchley: add interrupt support for sled io
>     expander
>   ARM: dts: aspeed: bletchley: add shunt-resistor for ADM1278
>   ARM: dts: aspeed: bletchley: add INA230 sensor on each sled
>   ARM: dts: aspeed: bletchley: enable mdio3 bus
>   ARM: dts: aspeed: bletchley: cleanup redundant nodes
>
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 320 +++++++++++-------
>  1 file changed, 202 insertions(+), 118 deletions(-)
>
> --
> 2.17.1
>
