Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F45539B47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiFAC0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiFAC0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:26:06 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED58723D;
        Tue, 31 May 2022 19:26:05 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id w10so341148vsa.4;
        Tue, 31 May 2022 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpXzXAPejgWgPrC0CnOM+GA27MWRTR2lw+J/3W1An1g=;
        b=I9BZQdCtgWQDSRXmH2jzuW8s1CG3TtW/pYGutaIn6W9tvPPOkT46hdmcqp8IS/ewdy
         OwQ/EB4rQgeSVkeWKX43xO+Xn4BHNUpWlBu9WgWw1OlSFwQgbk5ZpqlF/njkx5mCwj/v
         sqeHpw8wYRne2V1AjCua/TiVpqvTV5I+mOQ8ed5Gw8qVlVUahIqn/ALQgN1/jhbBLUJv
         NyQzIxMzp0Q5KrWGffdNjls1D0ggnyElBeV5J74qPMPU0qDN+yZKwaD5C4TYVFv0MBoJ
         47XYatXLBQ/wo2U9cdmz7t16UMi6m3jOxqTLAw4LME4QczqmIwMhkuHtJ8EWue+i4+NO
         KkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpXzXAPejgWgPrC0CnOM+GA27MWRTR2lw+J/3W1An1g=;
        b=5Yqt3v8FHPhTXOXSzOJ/9BJCc/sd1y+IRPGSIz1i+7XGCtB3MJ5ENA3pM+HKs/d7RU
         ZsZYxncipUa2BPjNhISiQu7hmN/qXiOnCT7rPLkzFdwRUUMq4Im+lmwx3DW6aHvS0P6u
         HtTbXjxuCuoCc8s8x1E30nGbue0bNXZnyP5KDzp7pgww+hND7lRhE4oDH7nYaHBAt3vY
         twIzHWckAzPR/WJ5U3DvsfXskgLeyuMQABnD8dW456KaoIB/cSP/m7uNVRo9S0HwB5v+
         xpu1Dwub3fBXhl/tuzAhjHGMf2sfx04flsW53eN5M80B2kMKeNe+dCFkz54krLswMOX5
         6ScA==
X-Gm-Message-State: AOAM531PA77unKIUTC+bi/s2EVLaBXLRWhmEo14FBM1LbqY0cBkPi7Q5
        tVfPTvCL7TWbvdKokqU4R4o82eisk7gHd+UkJuS9ieg=
X-Google-Smtp-Source: ABdhPJzpkKT6PL/qsAp0D0vVWeqB7UAmy4qxR3oYi/Cz+vdxMyZWo7DiMN+/Lm0o1d50l06bPUt6Sv+Td1cnMp9jJbo=
X-Received: by 2002:a05:6102:50a4:b0:335:bfc3:5cda with SMTP id
 bl36-20020a05610250a400b00335bfc35cdamr25255705vsb.85.1654050364452; Tue, 31
 May 2022 19:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220601082959.2fefa1e7@canb.auug.org.au> <YpaYEtWSEyD7WKCU@pendragon.ideasonboard.com>
In-Reply-To: <YpaYEtWSEyD7WKCU@pendragon.ideasonboard.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Tue, 31 May 2022 21:25:53 -0500
Message-ID: <CAL_Jsq+52mozs2-9kYerNPLQzQ+p0JR1aeDxkdB3fc4RTK2vKA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree-fixes tree
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 5:35 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 01, 2022 at 08:29:59AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   adb97f9f8442 ("dt-bindings: soc: imx8mp-media-blk-ctrl: Fix DT example")
> >
> > Fixes tag
> >
> >   Fixes: 584d6dd668e2 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe you meant
> >
> > Fixes: 8b3dd27bfe47 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")
>
> My bad, that's the correct SHA1.

Now fixed.

Rob
