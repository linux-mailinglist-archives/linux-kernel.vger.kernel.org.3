Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733805A1926
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiHYSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiHYSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:53:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C681BEB4;
        Thu, 25 Aug 2022 11:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3E6DCE2927;
        Thu, 25 Aug 2022 18:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DCC433C1;
        Thu, 25 Aug 2022 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661453595;
        bh=LmeJarWwGbA31XsapvzdsmOfLEaI/WHd16dH+kYlUgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mK0rA1/Fpj4z7cUKXvr+gs5bfbeTs7B84V6WBeOC/rCjA163EX3EbOBA/v+oiR+Dl
         bzVUqdUVXsO02VRu57j3mHWAH51BNMNbG4g5+64dIeZVIjgM/EHzgYX+Pyq0LMZrJS
         5XMlGF1OrY11pIRB/iDA4PXdD2vQXOPngxN7GPplOnsOlEzSU5cof+puzVj5gCFfw9
         dEueUl0IoydWn01aWILjUa7h90k6wfBJyEUj/xIzUJG9kp9B2A197CrlJ3ok+xZb+t
         EK0XhnM6IqeFEg1S+grjC/2GYj2N7iWIOeK4DTrOcC9sleIq47KbjyUmQ1thJFiRGt
         aJjv+WA95fxag==
Received: by mail-vk1-f171.google.com with SMTP id o198so6848459vko.4;
        Thu, 25 Aug 2022 11:53:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo0IzSP8wEJJlZLUY8GxBW41/TR7m9gYerALTzFaoSkKLJoexlwv
        ABYyUC7oxGb/6KC0dzUiAKms72hxNVEw+ri4VQ==
X-Google-Smtp-Source: AA6agR4hwsP75jg+CsTIlCg3A84JKrEmTy9ONKitDk5+DIRXfKGuq5albaAzntxsF/nFXpgcxNBg6vQKFIZiTLOk7ik=
X-Received: by 2002:a05:6122:d86:b0:37d:3fe:df43 with SMTP id
 bc6-20020a0561220d8600b0037d03fedf43mr2080142vkb.15.1661453593841; Thu, 25
 Aug 2022 11:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220816183911.2517173-1-robh@kernel.org> <CAOiHx=k1=GG7JNBJ-mqySSqv3d2OeLzWP+Vf1fXKtf0t-O+Kpg@mail.gmail.com>
In-Reply-To: <CAOiHx=k1=GG7JNBJ-mqySSqv3d2OeLzWP+Vf1fXKtf0t-O+Kpg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 13:53:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHoOU3M7ZUrpi8OH+0_5u0LOoYZeXEk08tFjf6fByncA@mail.gmail.com>
Message-ID: <CAL_JsqJHoOU3M7ZUrpi8OH+0_5u0LOoYZeXEk08tFjf6fByncA@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: pinctrl: brcm: Ensure all child node
 properties are documented
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 10:23 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> On Tue, 16 Aug 2022 at 20:39, Rob Herring <robh@kernel.org> wrote:
> >
> > The Broadcom pinctrl bindings are incomplete for child nodes as they are
> > missing 'unevaluatedProperties: false' to prevent unknown properties.
> > Fixing this reveals many warnings including having grandchild nodes in some
> > cases.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > This recursive schema requires a fix not yet committed in dtschema.
> >
> > I'm looking for feedback on whether group->pins or group->groups is the
> > right fix here. There's more warnings with this change in the gpio-sysctl
> > bindings.
>
> The answer is "yes", though pins is probably the closest for most.
>
> bcm6318 has multiple field-per-pin registers, where each pin is
> controlled separately, with more fields than available GPIOs, and the
> pins outside the GPIO range controlling other functions, like
> switching the second USB port between host and client mode.
>
> bcm6328/6362/6368/63268 have two registers. The first one enables an
> alternative function for the first 32 GPIOs, with a 1:1 mapping of
> bits to GPIO. The second one enables a function for whole, arbitrary
> groups. These groups can overlap, and may also target pins outside the
> first 32 GPIOs. The actual pins in use are not documented, and can
> sometimes be guessed/inferred by the function names (e.g. "GPIO35"),
> sometimes not ("NAND", "UTOPIA").
>
> bcm6358 has only the groups register, which also includes non GPIO
> related functions, like inversing the MII clocks for the integrated
> macs.
>
> Not supported is bcm6348, which would be the only one where groups
> would definitely make more sense: there are 5 groups of 8 GPIOs, where
> each group can be set to a certain function (but not all functions are
> valid for all groups). E.g. for PCI support, you would need to set the
> fields to PCI for groups 0, 1 and 3 (and 2 and 5 could be set to a
> different function). You can ignore this though, as bcm6348 is ancient
> (doesn't even support ADSL2+).
>
> Hope that helps a bit.

Only in determining that someone else needs to fix this. Please send me patches.

Rob
