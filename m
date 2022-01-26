Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99D49C90A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiAZLq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiAZLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:46:55 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF1C06161C;
        Wed, 26 Jan 2022 03:46:55 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id u6so42948367uaq.0;
        Wed, 26 Jan 2022 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4CNUTqSVWn9bXn7l88zPRdfRlbtM6HbzeC8ZWljLDY=;
        b=kZlc5lyneJxcG3mgrIIsGcOndeVBblAK0nKqJSIxp5XBRMZDtyWdX5FBwuNfSIkm9a
         KEa3BbUfSUgVIEcWlYs98e72BJkdt70ayYnbXgyYLT2AGf8mBiDWdNBn4GM7fs4t9y7s
         tv9chq0HqYSR4PmevC7Ay1dz4ZgO1zXBQaak7iVtaAqHzINmLVcIHjWHrY4iC9LBEQ1z
         NvtFXX/fQh2btOfQHsd9ie7Hq9Jk9xKK8Yp+oomhROlf1ZbDVzK+Ph9Ciprme7e2np4f
         a0Ioc50iPwG018CiaEhUt+3VNIM+BzYZITkX0FfQdiQ7uu7jlOfQGewH2itZbhggiEL2
         z+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4CNUTqSVWn9bXn7l88zPRdfRlbtM6HbzeC8ZWljLDY=;
        b=G+1nTM3BJ8Ay/6RvEYKzXjeYvPqlV24W3+Xruzcvc8a2kQDYyWPieLE4kHnwp6hrzh
         gRCewYPva2lk94zzrDTjo4/5sTe+7/7ys4qX6IEkDjX0eYNPYD3QYxF/W+V3aPQE6Ffu
         Kv2mR2bBmtLzx1QX6pRz0QKIEwBMhDxEhdzFPiCAN9xpBdaNABTGeuQQKXpR0idatfpU
         zO49aDGp6rwmMDZzEi8iK6SKbRZQIa7+q3Jh6QN2FAupZ0S0kjoStEqM345YiVlS8IrR
         58w9anhBVUSVKiQBm+uzwEfUIfYQFFziigYpzbMwcD/uL5H18WRXrtwyqwNOHiiU+jQL
         nT0Q==
X-Gm-Message-State: AOAM530TaFb7LcMq//RBnEBvwBpXhDA3wyyoON2D6+7D5AP+UE3nTv+c
        K+E1GGlswn3xFF6nyA1AGviGNfdthaPPAdkCcxc=
X-Google-Smtp-Source: ABdhPJwZR3GhqHW6vVDPMdvc5RfjPrPxRISo7AxE0yRaHiKPCLToutmaZ91KccUpC53UUHP3+xvCW8VUf4CPP4L+I4g=
X-Received: by 2002:a67:c98d:: with SMTP id y13mr3479175vsk.43.1643197614279;
 Wed, 26 Jan 2022 03:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <20220110114930.1406665-5-sergio.paracuellos@gmail.com> <d62d838872d26201b04a1014a925738d29ff3e48.camel@pengutronix.de>
In-Reply-To: <d62d838872d26201b04a1014a925738d29ff3e48.camel@pengutronix.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 26 Jan 2022 12:46:43 +0100
Message-ID: <CAMhs-H__SxEZ4OtdN_PFf4g+joWBRgRR0q7hHkZX3d=qZtpxUQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] staging: mt7621-dts: align resets with binding documentation
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 10, 2022 at 12:54 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2022-01-10 at 12:49 +0100, Sergio Paracuellos wrote:
> > Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> > to be used as a reset provider. Align reset related bits and system controller
> > node with binding documentation along the dtsi file.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp

Can I get your Acked-by on this patch to apply this series through the clk tree?

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
