Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA57E4E545E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiCWOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiCWOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:39:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810327A;
        Wed, 23 Mar 2022 07:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03D3AB81F52;
        Wed, 23 Mar 2022 14:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7040C340F2;
        Wed, 23 Mar 2022 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648046276;
        bh=y7kPB+6dz+NTgOxXvHEPt4jVFLvTfCy8QOblukuN19k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLaezqStUH26yDjyzPofJ8wgZLSXXnrZU8AVSixiSAmQ8ZPvHTO0eWSNP+5+ypecA
         yY/Dw4v84+t6Wqfi769TVna5IugBGOH7uVbOOsejDS5GmhZjFQ6geh2J43uUt6xSlM
         Yvny2Zi4mZgEVnqcEVwTpp7oVEaoyizKuxcawWC01viMl0Nny6i+kyk9kdtc+M0YLX
         K0XVQzZSOdQwFLYdNFHtbpMv/8AuJBqZ2x/C9UFVcRwB2x7xX7dYzHn33i2DRGdjwT
         T30Q3b6kYF0j/7I0GLzBi7s/5jERngdZXDGGaLE55jKsKsLyDvnR6HSb7w5C3F6XNZ
         P+pcpwJqUY/TA==
Received: by mail-ed1-f45.google.com with SMTP id h1so2110839edj.1;
        Wed, 23 Mar 2022 07:37:56 -0700 (PDT)
X-Gm-Message-State: AOAM532FCoHsfejmbA8gKKGdsiYN79OiTWKJnsYkLWKvKc6IqT9Paa09
        oYnkJ2mkN/NyBJxSDepR3k3wCgT+y5AaSjwfUQ==
X-Google-Smtp-Source: ABdhPJxkYhGJZroqp0K4TQl4kYe/4WvgzJrBtElcSt4uMwnWhsfX/Dqo/ZAYg+WYAz1tvKUP7RuzhTrRC7d46flZT0s=
X-Received: by 2002:a05:6402:42c6:b0:419:276a:dded with SMTP id
 i6-20020a05640242c600b00419276addedmr488840edc.2.1648046274998; Wed, 23 Mar
 2022 07:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220303232350.2591143-1-robh@kernel.org> <Yjl6fP2Bylv6ud8W@google.com>
In-Reply-To: <Yjl6fP2Bylv6ud8W@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 09:37:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5GkEaE9sf5HJMaNQLkZUB_q2Qyv2rzADVD7if1MNvqg@mail.gmail.com>
Message-ID: <CAL_Jsq+5GkEaE9sf5HJMaNQLkZUB_q2Qyv2rzADVD7if1MNvqg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mfd: Fix pinctrl node name warnings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 2:28 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 03 Mar 2022, Rob Herring wrote:
>
> > The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
> > pinctrl: use pinctrl.yaml") resulted in some node name warnings:
> >
> > Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml:=
 \
> >  lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(=
pinctrl|pinmux)(@[0-9a-f]+)?$'
> > Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
> >  codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[=
0-9a-f]+)?$'
> > Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
> >  pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '=
^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> >
> > Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
> > nothing from pinctrl.yaml schema is used, so just drop the reference.
> >
> > Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
> > Cc: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Fix lochnagar-pinctrl nodename in example
> > v3:
> >  - And fix lochnagar-pinctrl nodename in 'required'. Sigh...
> > ---
> >  Documentation/devicetree/bindings/mfd/brcm,cru.yaml         | 4 ++--
> >  Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
> >  .../devicetree/bindings/pinctrl/cirrus,madera.yaml          | 3 ---
> >  3 files changed, 5 insertions(+), 8 deletions(-)
>
> Requires rebase.  Doesn't presently apply.

It's already in 5.17.

Rob
