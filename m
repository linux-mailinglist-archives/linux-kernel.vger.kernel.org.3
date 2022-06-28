Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9755E600
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347260AbiF1PXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347840AbiF1PXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:23:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439427FD7;
        Tue, 28 Jun 2022 08:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4561B81EB0;
        Tue, 28 Jun 2022 15:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9736EC3411D;
        Tue, 28 Jun 2022 15:23:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iEiH28Go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656429825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7kqdjIR171pSbvH2lGZ2vQhHvcvnOwMVzW1AX6PeZ0=;
        b=iEiH28GosiLiJnxavcGnyk5NieqsY7gvnZPBI0szZq5U9CMyoJ/2Y4rM7qnyOQGr99TMBX
        L/f0Z/ndT7cY8lH03tAa4Xbg+9Utf9TovHh0lVQFf++q2+u3N3EEsQJHRtIx0l66cxH/vt
        2iqJgyznkhYCwmhtJcFL7CI54Bh6d1Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 20f3a433 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 15:23:45 +0000 (UTC)
Date:   Tue, 28 Jun 2022 17:23:39 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] dt-bindings: chosen: document rng-seed property
Message-ID: <Yrsc+50Y2UX1wlYH@zx2c4.com>
References: <20220627152107.645860-1-Jason@zx2c4.com>
 <CAJMQK-jGsobw7i4NjQ4oezA0rU03ECs_nY=Txr6TgsHFu2jXhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJMQK-jGsobw7i4NjQ4oezA0rU03ECs_nY=Txr6TgsHFu2jXhg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Tue, Jun 28, 2022 at 11:39:38AM +0800, Hsin-Yi Wang wrote:
> On Mon, Jun 27, 2022 at 11:21 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Document the /chosen/rng-seed property, which has existed for quite some
> > time but without an entry in this file.
> >
> > Fixes: 428826f5358c ("fdt: add support for rng-seed")
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> It's currently documented in
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml
> 
> https://lore.kernel.org/lkml/CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com/

Well, let's see. That email says:

> Already documented here[1]. I've been meaning to delete chosen.txt so
> that's a bit more obvious.
> 
> I realize it's a bit harder to find what's documented where. Long term
> we'd like to generate documentation from the schema and integrate as
> part of the spec. Short term, it would be quite trivial to make a 'am
> I documented' utility.

That sounds reasonable. But when was that email written? April 2, 2020.
That's 817 days ago.

So I call BS on this being a continued justification for rejecting this
patch (which apparently was submitted by Florian over two years ago
too). Rob clearly hasn't followed through. So please apply this patch so
that chosen.txt remains maintained.

Later if he moves forward with his plan, then no harm done, since the
file will be deleted anyway.

Sometimes it's best to reassess things based on the reality of the
situation, you know?

Jason
