Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C895A6EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiH3U53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiH3U51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234037C755;
        Tue, 30 Aug 2022 13:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE145B81D9E;
        Tue, 30 Aug 2022 20:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C7C43142;
        Tue, 30 Aug 2022 20:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661893043;
        bh=iftuHYqQXTY9T/Jpg0WAmZaO4NFtXezaRWCYZ6TK3ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sN4VuKXwsfijKIrdwPjxw4NxzoBbgK7Lox0+jXU7CWFZd7NuNAH8YfB9YRrON1H2e
         Ign2ztR7Z18cKcRwpntRAKciL/Im4Y1zybhsvCWZ2eCg0Nsl4C7ZuTyheh3jt01mLy
         Mlau/BTkjCJzMXT/wYvTnibXh8G+67o0svHApuryc4XyV1dPxGs50jScXBItoxOOBs
         MZ3rej3kOXPmbMBikQg5kcyZpUZ7c9tW9FB1aO85szVVn0bI9Vc0RQjMBKL1J6k0Zo
         CDsU4caak9l+0z4fo9Fsp3f92DXvvQbqUIAS0ApPTxfEiimAH2N0Tt4q/WvbaETQCl
         f/zRNkDfPTVlA==
Received: by mail-ua1-f53.google.com with SMTP id a18so4535916uat.11;
        Tue, 30 Aug 2022 13:57:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo0T+Qozbw5WsKtB7xUwv4dW24FltCftOLV6I1tXc4UQQyft7Yff
        JeOHJdiAEbWbHy1l50DzOAL20U9kp3G+bg44tQ==
X-Google-Smtp-Source: AA6agR6f85XnSpzHwZBKN0RRZyto5EZpAAgQSxtyliRBWdAaWrt2oixrLAfJCE0oQ44ghreW7ST5f7W6/kpWI4HA5iI=
X-Received: by 2002:a9f:23ec:0:b0:39e:c54f:ffc7 with SMTP id
 99-20020a9f23ec000000b0039ec54fffc7mr5975565uao.17.1661893042185; Tue, 30 Aug
 2022 13:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220825180417.1259360-1-mail@conchuod.ie> <20220825180417.1259360-2-mail@conchuod.ie>
 <5f00ab85-d5ac-728d-2157-e70f2a46cc90@canonical.com>
In-Reply-To: <5f00ab85-d5ac-728d-2157-e70f2a46cc90@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Aug 2022 15:57:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdYT5Bqn1aCd+vDxgOQAH_B2nMwsP9siATdK6DRte0QA@mail.gmail.com>
Message-ID: <CAL_JsqLdYT5Bqn1aCd+vDxgOQAH_B2nMwsP9siATdK6DRte0QA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <mail@conchuod.ie>
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

On Thu, Aug 25, 2022 at 1:36 PM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/25/22 20:04, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > The l2 cache on PolarFire SoC is cross between that of the fu540 and
> > the fu740. It has the extra interrupt from the fu740 but the lower
> > number of cache-sets. Add a specific compatible to avoid the likes
> > of:
> >
> > mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
>
> Where is such a message written? I couldn't find the string in
> next-20220825 (git grep -n 'is too long"').
>
> Why should a different number of cache sets require an extra compatible
> string. cache-size is simply a parameter going with the existing
> compatible strings.
>
> I would assume that you only need an extra compatible string if there is
> a functional difference that can not be expressed with the existing
> parameters.

Correct, but you have to account for unknown functional differences
aka errata as well. Otherwise, we need firmware updates to enable the
OS to handle errata.

> > Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >   .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
> >   1 file changed, 49 insertions(+), 30 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > index 69cdab18d629..ca3b9be58058 100644
> > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > @@ -17,9 +17,6 @@ description:
> >     acts as directory-based coherency manager.
> >     All the properties in ePAPR/DeviceTree specification applies for this platform.
> >
> > -allOf:
> > -  - $ref: /schemas/cache-controller.yaml#
> > -
> >   select:
> >     properties:
> >       compatible:
> > @@ -33,11 +30,16 @@ select:
> >
> >   properties:
> >     compatible:
> > -    items:
> > -      - enum:
> > -          - sifive,fu540-c000-ccache
> > -          - sifive,fu740-c000-ccache
>
> Why can't you simply add microchip,mpfs-ccache here?
>
> > -      - const: cache
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - sifive,fu540-c000-ccache
> > +              - sifive,fu740-c000-ccache
> > +          - const: cache
> > +      - items:
> > +          - const: microchip,mpfs-ccache
> > +          - const: sifive,fu540-c000-ccache
>
> Why do we need 'sifive,fu540-c000-ccache' twice?

Because it is in 2 different positions. While we can express that the
last N entries in a list are optional, there is no way in json-schema
to express entries at the beginning or in the middle are optional.

Rob
