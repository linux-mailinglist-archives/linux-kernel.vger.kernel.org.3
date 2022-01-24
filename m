Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375D949A55E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409664AbiAYA1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573402AbiAXVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:44:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF7C08B4C2;
        Mon, 24 Jan 2022 12:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A6C61581;
        Mon, 24 Jan 2022 20:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F28C340ED;
        Mon, 24 Jan 2022 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643056329;
        bh=EcSc5NGWQWYVTuB7MnoRf3rQ2LAOnZ2MYQlWCYRDxV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mi6gIXyr/tKOn8rTTMqwC2IFZMFu3q7Jf2dhA+dYuOZmtpv9SY4EsrPVBiimrJ2ml
         QtUY6gVvWqrsPU6CyiX27p9eK7YhbmPtlFJyCxYOIsN5cobstj32OJhBjeA42lmTX4
         EeW5FqUXvc/sK1GWdiJiD/hgwxto2EPNLyhXUD1kMJRvCrOeXSK2m9IDxlQ/IIJFtK
         XqmnpliOD3ZCsoHNywC2pEqyY2TioUwNlG4w0zlFTu0LrT5Jr6A8f/LyQ1AMGQSba9
         /AdrRN1RrsWfDEVGITTMcJiFH6Kk0cSBzyg/2u8Pbvlofo6kt+B5qph/vNx/cQ3yv7
         WVuYV9qk85D+A==
Received: by mail-qt1-f170.google.com with SMTP id y17so21094304qtx.9;
        Mon, 24 Jan 2022 12:32:09 -0800 (PST)
X-Gm-Message-State: AOAM531RCuT+heygqZ5zXroH0QeRR+H0H/ySqRCn1LIZkbHoofbEAT4u
        T9E7cbGTwtf75MAcOebgI+8wBqcvhB1cweqIng==
X-Google-Smtp-Source: ABdhPJxhfE3hNbKeQnW9wjko8Ek4KGnAVOUwl4hpmRLOwvce8D+R+2d0iKBHLgo1PXB3c+kB2arYv9PAoJ1m15VdEl8=
X-Received: by 2002:ac8:580b:: with SMTP id g11mr14053696qtg.478.1643056328171;
 Mon, 24 Jan 2022 12:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20220119015038.2433585-1-robh@kernel.org> <CA+Eumj4HjM8SPoOUo7_eLBOHFYXTPPPgmx_YDYdEXDyaT67Rrg@mail.gmail.com>
In-Reply-To: <CA+Eumj4HjM8SPoOUo7_eLBOHFYXTPPPgmx_YDYdEXDyaT67Rrg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jan 2022 14:31:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jg=2svsVsNY_kd8vQ+b9mM77t8ua8omCRT5rHRFcrUw@mail.gmail.com>
Message-ID: <CAL_Jsq+jg=2svsVsNY_kd8vQ+b9mM77t8ua8omCRT5rHRFcrUw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve phandle-array schemas
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:55 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Wed, 19 Jan 2022 at 02:50, Rob Herring <robh@kernel.org> wrote:
> >
> > The 'phandle-array' type is a bit ambiguous. It can be either just an
> > array of phandles or an array of phandles plus args. Many schemas for
> > phandle-array properties aren't clear in the schema which case applies
> > though the description usually describes it.
> >
>
> Hi Rob,
>
> I have few questions below.
>
> (...)
>
> > diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> > index 095775c598fa..3a4df2ce1728 100644
> > --- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> > +++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> > @@ -21,8 +21,7 @@ properties:
> >      type: object
> >      properties:
> >        sound-dai:
> > -        $ref: /schemas/types.yaml#/definitions/phandle-array
> > -        maxItems: 1
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> >          description: phandle to the I2S controller
> >      required:
> >        - sound-dai
>
> This passes the example only because the example was simplified to
> hide dtschema errors.
>
> The cpu dai node is like:
> cpu {
>     sound-dai = <&i2s0 0>;
> };
>
> and this fails with errors missing phandle tag in 0.
>
> I am converting rest of Samsung audio bindings to dtschema and have
> trouble expressing this. How schema should express such cpu node?

The above hunk should be reverted. I'll drop that hunk.


Rob
