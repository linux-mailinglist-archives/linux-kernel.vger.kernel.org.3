Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6114E7FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiCZIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:07:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A4F4E;
        Sat, 26 Mar 2022 01:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36038B8006F;
        Sat, 26 Mar 2022 08:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF05AC340ED;
        Sat, 26 Mar 2022 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648281944;
        bh=HsH9JnvulbBf0WXim3uFrjhndeqnIMfv1wnDQkhH5mo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bpnp/B8Yezt0CyovfGLN4RkAMLBCFzSV+ZXOI7d4hp/JzsCi+wjUqi59gJX9mNSVy
         4cE3le70v/+f+TBLo/2FirYchWh5iTjdoaWZbl3n6iOpeOrtDhLwOofeq9vh83tfiG
         8RTMPufFl1zMQoZwGvD4GQWz793yPIxysdRcQIiNsHVG2zhoSYn7mPF84N/KIV2coK
         N3PLdoIG6z8OUThajYxo36nVw2lokmzLW91zF3xM53UyyQPxs5YjnW84n31zk+Wppj
         EBULYm4DaSKhtx/W6gVO4oqzpuSxoQIKiIn11tJMi8U3oOGxDhb3vdeXs/ucZ5wuWI
         9316OXqxu8Q3w==
Received: by mail-pf1-f174.google.com with SMTP id h19so7404059pfv.1;
        Sat, 26 Mar 2022 01:05:44 -0700 (PDT)
X-Gm-Message-State: AOAM5301FD2unf4lFV1wjEkkQ9wbBSPsJmWDNnfhFcqxqbzh4XcsPl4o
        PqQMhI7SC4kQvMmMJ5TD57V+haDIpnJNmaBAaNM=
X-Google-Smtp-Source: ABdhPJzznmPTvbsWhZ7Dh/8yAaoqMZq4XOuBRCg9BNfg7mWf00GX6DmojizMHLqhRj5wKTk1g4qJIWgQaKVnLlaJu3Y=
X-Received: by 2002:a65:63d9:0:b0:374:6b38:c6b3 with SMTP id
 n25-20020a6563d9000000b003746b38c6b3mr2607672pgv.195.1648281944317; Sat, 26
 Mar 2022 01:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com> <CACRpkdZATQubzrzqq2b4VY+W3Pb9RfzOGRiF+34YhEqpSKyUZg@mail.gmail.com>
In-Reply-To: <CACRpkdZATQubzrzqq2b4VY+W3Pb9RfzOGRiF+34YhEqpSKyUZg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 26 Mar 2022 09:05:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdyDeCozev=AqSnS-E0Cvc6BjXysV70vm0eaSnwN6eB3w@mail.gmail.com>
Message-ID: <CAJKOXPdyDeCozev=AqSnS-E0Cvc6BjXysV70vm0eaSnwN6eB3w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: add common consumer GPIO lines
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022 at 01:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 15, 2022 at 9:37 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>
> > Typical GPIO lines like enable, powerdown, reset or wakeup are not
> > documented as common, which leads to new variations of these (e.g.
> > pwdn-gpios).  Add a common schema which serves also as a documentation
> > for preferred naming.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> I like the idea!
>
> > +  enable-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +  reset-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +  powerdown-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +  pwdn-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: Use powerdown-gpios
> > +    deprecated: true
> > +
> > +  wakeup-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
>
> I would underscore either on each one or in a global description:
> that lines on components that indicate they are active low
> such as RESETN, RESET* etc MUST have the flag in the
> second cell set to GPIO_ACTIVE_LOW.

Sure, I'll add it.

Best regards,
Krzysztof
