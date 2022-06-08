Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D417543E75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiFHVUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFHVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:20:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055D18FA74;
        Wed,  8 Jun 2022 14:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BABAB82B45;
        Wed,  8 Jun 2022 21:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAA4C341C0;
        Wed,  8 Jun 2022 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654723242;
        bh=Jsxs9fcO7DTGXDp/Xmt0ApBO6k+WCxLLqeQHoawXuQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eTlWZj+zbHmYk73D6tGciRoN2u80G+3q5qH2HOw+GBxcHd7IIs88qx0wynWdhe+GU
         G9H7+NcD2ai2RpifLfyA+ifHUM71K06CGqaEBMeyk5HQqNrVVxy+PPCKh01Jz437qh
         og67Euuq/OjYibaeS1GBVJMuA8j/6fpK/KHLgHf+Fof+PAqGCYCbQ4o9qtJrY+IA6k
         6xQ/mUGArQj2X60x+PXKIDKMyaEEQnHy7gngDmJY54aCnFdxyXz0Qh4y+63ii+mTrA
         Iw01SgVQmgGJIWXYzRqIwKjj+xhHEonZZh+c3zU9sNmEnB9rYCbYZlGYEIxON5bFDy
         00+0axHz078PA==
Received: by mail-vs1-f44.google.com with SMTP id e20so1086590vso.4;
        Wed, 08 Jun 2022 14:20:42 -0700 (PDT)
X-Gm-Message-State: AOAM533crxmp/B60Zd5Om7vx0KeG87Cccxy7Rbn6vhki0RkpTluovxQa
        x1Ehb3Ru02CSZJ24xn6xT3gRTte2ULDaqDmfoA==
X-Google-Smtp-Source: ABdhPJxtfFfzpvo2hF0voes+IcUHQ7LFJjOJsciNeveT/roEHWXTr0atCteMc8uuC1XRD8KW8+EsvDsxvzR0+3cUpk0=
X-Received: by 2002:a67:d38c:0:b0:349:d028:c8ea with SMTP id
 b12-20020a67d38c000000b00349d028c8eamr16162915vsj.6.1654723241803; Wed, 08
 Jun 2022 14:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-3-krzysztof.kozlowski@linaro.org> <Ypo6Q8/SuPGxp/ac@google.com>
 <ca93699e-f905-c0ee-8ddb-1be2491fc8cc@linaro.org>
In-Reply-To: <ca93699e-f905-c0ee-8ddb-1be2491fc8cc@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Jun 2022 15:20:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQSBV9_An2=2euSQcesRjvEqE0kQ7bQh86P+BaEzvN1A@mail.gmail.com>
Message-ID: <CAL_JsqLQSBV9_An2=2euSQcesRjvEqE0kQ7bQh86P+BaEzvN1A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: input: gpio-keys: document label and
 autorepeat properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
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

On Sun, Jun 5, 2022 at 9:15 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/06/2022 18:43, Dmitry Torokhov wrote:
> > On Fri, Jun 03, 2022 at 12:16:01PM +0200, Krzysztof Kozlowski wrote:
> >> The original text bindings documented "autorepeat" and "label"
> >> properties (in the device node, beside the nodes with keys).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >> index 49d388dc8d78..b1c910a5e233 100644
> >> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >> @@ -15,6 +15,14 @@ properties:
> >>        - gpio-keys
> >>        - gpio-keys-polled
> >>
> >> +  autorepeat:
> >> +    type: boolean
> >> +    description:
> >> +      Enable operating system (not hardware) key auto repeat feature.
> >
> > Should we refer to the generic input device property here instead (one
> > on described in input.yaml)?
>
> You mean copy the description from input.yaml or say something like:
> "see input.yaml"?

No, just:

$ref: input.yaml#
properties:
  autorepeat: true

And 'poll-interval' needs its definition removed.

It's a bit strange for input.yaml to be referenced in both the parent
and child nodes, but that's the nature of the input bindings. Maybe
input.yaml could be split? Doesn't really look like it to me. The main
issue with one file is the users need to list out which properties
they use (not a bad thing).

Note that this series (patch 1) is going to conflict with what I just
sent out[1].

Rob

[1] https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
