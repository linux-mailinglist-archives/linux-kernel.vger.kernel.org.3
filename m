Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09C5A1581
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiHYPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiHYPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:23:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77FB69E7;
        Thu, 25 Aug 2022 08:23:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so18161956pgi.10;
        Thu, 25 Aug 2022 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sERSCfKpMmgiaBBPRfCq70Yp+FzXmqp9Gg4aLfwlsec=;
        b=hnBMUgTu1qgmDE+P4BqRtyUQlZTWTsKiHQYBl5qdKHkmcjvh5s7xse+dXLZXJanm0H
         1/1ojUZwYlj8afQjz4dGYIev/ip9MaoFQAK/fOLUVMzLCLqb/8NLmNrigoreFcTIxZwW
         ChyfGHBfeh9MUIrBaXADmBjOVNhWoSaqZPlaScNQk+T+UKVy78kQKiAEMYcYui/oyfC7
         K9sDDpB8AQDlqemEKTmikiWX2icYayhkSQwnT0zDBBKTv9SAfVig/MQIBFNkk44Bqp/4
         Kh++PTp2XbVVTvgpYcxgg4NCjwsNvlehEUnC4tUopXwuTy5IwZ4QYDLUcILs35uHaega
         +tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sERSCfKpMmgiaBBPRfCq70Yp+FzXmqp9Gg4aLfwlsec=;
        b=VihGWCxT0H57xIz9YYiX+a2lchUL1S4prUrNzkXYdDvg4ToUdLOP67uiZ/mkZPZTiy
         +jb6Sphzh8Rwnfm4E1YlOFfSAH5pym9qW3wL3Pnwl5XeUk2G9P/Nlp19n6RJthkoqDsv
         ifkBRVPd5afCvOFmY/J5qSWpniCfwELa8s5XzGcxA00Ya8/0h2cCSAoZabm0MYuP6BXs
         tGTJyKq+M+Y+/oiGsHMFvfdwQBoQ9u4qJQETbJukMUIV1gROySvHfWJ4UF3Yd19L8Qng
         ioTMpNBMstQUTVYn9m3OYzUX8qODoQ7AqjB0FfmAjxglxluRPPaOekhdLm9BxD8IKGPg
         Ntdg==
X-Gm-Message-State: ACgBeo3s5MOr2FhqNaDhSBQSy5sq439/hmOwKqSIhInEpCsv+hT9tDcO
        Q8mSTw4WXBzPoBZ4DlyuFW50/WVtuBuezL1dO6ethE+w
X-Google-Smtp-Source: AA6agR6U9SLlrt3DTF4rqwvHO9B2zZAcSk8TEg+ykZLSaeShpevNYMyikrace7g1C+FJQdG/+F1NL7tROG7YPqf+E0Y=
X-Received: by 2002:a63:d84e:0:b0:42b:5834:fd73 with SMTP id
 k14-20020a63d84e000000b0042b5834fd73mr2170721pgj.506.1661440987087; Thu, 25
 Aug 2022 08:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220816183911.2517173-1-robh@kernel.org>
In-Reply-To: <20220816183911.2517173-1-robh@kernel.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 25 Aug 2022 17:22:55 +0200
Message-ID: <CAOiHx=k1=GG7JNBJ-mqySSqv3d2OeLzWP+Vf1fXKtf0t-O+Kpg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: pinctrl: brcm: Ensure all child node
 properties are documented
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 at 20:39, Rob Herring <robh@kernel.org> wrote:
>
> The Broadcom pinctrl bindings are incomplete for child nodes as they are
> missing 'unevaluatedProperties: false' to prevent unknown properties.
> Fixing this reveals many warnings including having grandchild nodes in some
> cases.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This recursive schema requires a fix not yet committed in dtschema.
>
> I'm looking for feedback on whether group->pins or group->groups is the
> right fix here. There's more warnings with this change in the gpio-sysctl
> bindings.

The answer is "yes", though pins is probably the closest for most.

bcm6318 has multiple field-per-pin registers, where each pin is
controlled separately, with more fields than available GPIOs, and the
pins outside the GPIO range controlling other functions, like
switching the second USB port between host and client mode.

bcm6328/6362/6368/63268 have two registers. The first one enables an
alternative function for the first 32 GPIOs, with a 1:1 mapping of
bits to GPIO. The second one enables a function for whole, arbitrary
groups. These groups can overlap, and may also target pins outside the
first 32 GPIOs. The actual pins in use are not documented, and can
sometimes be guessed/inferred by the function names (e.g. "GPIO35"),
sometimes not ("NAND", "UTOPIA").

bcm6358 has only the groups register, which also includes non GPIO
related functions, like inversing the MII clocks for the integrated
macs.

Not supported is bcm6348, which would be the only one where groups
would definitely make more sense: there are 5 groups of 8 GPIOs, where
each group can be set to a certain function (but not all functions are
valid for all groups). E.g. for PCI support, you would need to set the
fields to PCI for groups 0, 1 and 3 (and 2 and 5 could be set to a
different function). You can ignore this though, as bcm6348 is ancient
(doesn't even support ADSL2+).

Hope that helps a bit.

Best regards,
Jonas
