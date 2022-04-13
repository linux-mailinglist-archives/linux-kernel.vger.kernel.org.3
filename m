Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8962C500154
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiDMVqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiDMVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:46:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33958C30;
        Wed, 13 Apr 2022 14:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3555B82793;
        Wed, 13 Apr 2022 21:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDFC385A8;
        Wed, 13 Apr 2022 21:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649886255;
        bh=REiyYi+mAYXjrShDQXfJol6vF7Esfj2JO/hO4v7g+W0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EkvpSCsm95a5C0y+uRSD+EzG/PTSs/+RWmwGAbXcsuraTlgp5LKBQ0w2zVRH4JnNu
         s0urlqeS+1AgvyOzbARE29DvfMEPnnUdOxfiHz6npuDhnx0uO+I0kHoIHSnLlqj3aV
         RFYf98RymVZamj3KNvwjJ1DdkDr0FOKj1smDDDYmDQxYay2/2oWN5/MzNfZWAPmYm4
         h2exISzIil0hKsR+ZshZCtGrxW8d1JpSa2mFfUL+tknIfyqSiQIbCTJASSVmSTX5uD
         ycPF/rgVgSYGeOE6rjqQ1KlKyr8/NXAwztiWMx8bJi32zFJXxyMzsPABxawgh0nnBj
         +spT08jahXJgA==
Received: by mail-io1-f51.google.com with SMTP id x4so3411714iop.7;
        Wed, 13 Apr 2022 14:44:15 -0700 (PDT)
X-Gm-Message-State: AOAM531gvGk6AK2HArWihcyWLxu4RyUmvBfNlrdfYaaxa6/V6pIOSav4
        3XOijKM+c0lCD2Ru4hXGDhBR9KdobaA7zEPUVw==
X-Google-Smtp-Source: ABdhPJy4uYEv5eq5qGfZfRlrdz3pvFGWusEa99bVYRYSjIEyLUJ+2rxHj/odHZIg8lnVBKbLdVtR5AqTxuzbun3IYB4=
X-Received: by 2002:a6b:e60a:0:b0:646:3e9e:172f with SMTP id
 g10-20020a6be60a000000b006463e9e172fmr19128552ioh.1.1649886254463; Wed, 13
 Apr 2022 14:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220324133229.24035-1-jbx6244@gmail.com> <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org>
 <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com> <20220325005130.C45A3C340EC@smtp.kernel.org>
 <bf438af8-5969-73e4-009d-cb7d93095a5e@kernel.org> <20220331223759.B8B12C340ED@smtp.kernel.org>
In-Reply-To: <20220331223759.B8B12C340ED@smtp.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Apr 2022 16:44:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsE9kGzpHr6bkLmU9xmdxXiq-dWBFFO-W+4Z33iqK8_g@mail.gmail.com>
Message-ID: <CAL_JsqLsE9kGzpHr6bkLmU9xmdxXiq-dWBFFO-W+4Z33iqK8_g@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Thu, Mar 31, 2022 at 5:38 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Krzysztof Kozlowski (2022-03-25 00:31:25)
> > On 25/03/2022 01:51, Stephen Boyd wrote:
> > > Quoting Johan Jonker (2022-03-24 12:51:36)
> > >> Hi Heiko, Krzysztof,
> > >>
> > >> Question for the Rockchip clock maintainer:
> > >> What clock should be used here and other SoCs with several clock parents
> > >> in the tree?
> > >>
> > >> The clock.yaml produces a lot off notifications like:
> > >>
> > >> /arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
> > >> is a dependency of 'assigned-clocks'
> > >
> > > 'clocks' is not a dependency of 'assigned-clocks'. The dt-schema should
> > > be fixed to remove that requirement.
> >
> > If the driver does not have any clock inputs ("clocks" property), why
> > does it care about some clock frequencies and parents?
>
> Because it's a clock provider itself. In this case I suspect because
> this is a clock-controller node it was skipping describing some crystal
> input though. Maybe it wants to configure the various PLLs in the
> clock-controller for a particular board. I can imagine some node with
> #clock-cells may want to configure the frequency of the clock outputs or
> configure the clk parents for a certain board/SoC. In that case there
> may not be any clocks property, but we still want to configure things.
>
> >
> > The clocks is the logical dependency of assigned-clocks, because
> > otherwise hardware description is not complete.
>
> Sure, but also #clock-cells indicating that this is a clock-controller
> itself means something. The existing bindings are what they are so
> forcing bindings to be updated to comply with having a 'clocks' property
> doesn't seem very nice.
>
> >
> > What should be here for Rockhip? We had similar cases like this for many
> > drivers, I was fixing some of Exynos as well. In my case usually the
> > root/external clock was missing, so I supplied is as input clock to the
> > clock controller.
> >
>
> Can the schema consider either #clock-cells or clocks? I think that will
> work for most cases. It would also be good to have a comment in the
> schema or more detail around the definition of assigned-clocks in
> bindings/clock/clock-bindings.txt that clocks or #clock-cells are
> required. It would be super cool if assigned-clocks only applied if
> #clock-cells was present, otherwise clocks property applies, but I doubt
> we can do that anymore given how long the binding has been around.

I've just made a schema change to allow this. This will still require
'assigned-clocks' to be explicitly listed in the clock controller
schemas if 'clocks' is not present.

Please don't add to clock-bindings.txt, but improve the schema
instead. I need Samsung's permission to relicense all the
assigned-clocks text though.

Rob
