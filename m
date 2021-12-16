Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306FF476875
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhLPDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLPDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:07:24 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:07:24 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bj13so34528736oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NejVyBoDRKTUQRXdaYR9tb6ltwN/AStdGjjkwn7Uk+s=;
        b=g1TkbmDI6gWDQloHqmRvrNzoPup+e9nPlXTQlcH3FHLl0wYvsDFEb+ZCSaKPIKjfsf
         sJZaqNXFMA4jwNod8u4R0l7ssP/b1T74+HUBguxOb9TVRjoqPx19+YBqrHyblm0NCbvj
         i207pxhYDX+RxDOnX4DQqbeQl+XtyJ0EjOAQP+mXroVqQGRM9wF3HfPCdj/QSsfpIY7r
         4ClrTaYkzcj0cMCOvzH0ZFlXQLKoHFTEnpv93YqDwXnv6stNmgWDxVzz7DrpBaVFxwbA
         hQjiTqsIBcn1CtDw2ra4dnGmKJ3h1HjfFd6E5oufWDyDQslDfgOaS+jyGlAHm21yUv0V
         97LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NejVyBoDRKTUQRXdaYR9tb6ltwN/AStdGjjkwn7Uk+s=;
        b=ur9t/I16CEI1HS+R0miLAK7BPdyvuOpjo+PoCGsuLV6QPoR7HrbRkhh8dFtxj+V6hM
         2UexizjB+yrt5bWP3pOzIfrfN0HPYHE0za7JJnR4fiBF2kNXps7AVvK183QLrgNATntN
         q9oDEiMDthh3omEw8rMyiNo7cqFmlmHyhKvZQIE7YVbswvwXQ5ogBFXmHPxSDSItbgQ7
         9T4lyxiYkZTpRF4HZZoxEQ7dBPPB9AyJIcalCt103JJhxuEb2j98PM1lirnafQFks9rO
         gDj/zVKq1KmYokSxRGAYIyjie5xxRUIZzPFDsYjvG2ntEmxLjDWijI6Qqx0Hy6TPAs2Q
         QbFA==
X-Gm-Message-State: AOAM531suKGqteHPmdRoc6EVOUSs04+Un96uf16PPtsCjlmXmChP+HHg
        iZYE2zDBOESSCK0LGxnvDAtKBxNmZpFN/U3bwuU/Xw==
X-Google-Smtp-Source: ABdhPJyFv/0gs+gd1B7jD6sYmT25ancZcI2AisMb3GlzN5/ccXwB1QAb+QehAyr2L7NYhy8E6V8IB/cXvagiRXpPicY=
X-Received: by 2002:aca:120f:: with SMTP id 15mr2584692ois.132.1639624043631;
 Wed, 15 Dec 2021 19:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20211215174821.21668-1-zajec5@gmail.com>
In-Reply-To: <20211215174821.21668-1-zajec5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Dec 2021 04:07:12 +0100
Message-ID: <CACRpkdarh1N+NwYgDR31T=eESF20AgWJd=PTyv321jTdpH8PsA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add one more "const" for generic function groups
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 6:48 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Generic code doesn't modify those strings and .get_function_groups
> callback has that extra "const" as well. This allows more flexibility in
> GENERIC_PINMUX_FUNCTIONS users.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

I really like const-correctness and I'm a fan of this patch.

It seems some users need to be modified as well though,
the test robot is unhappy.

Yours,
Linus Walleij
