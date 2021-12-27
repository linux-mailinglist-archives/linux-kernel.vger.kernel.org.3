Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB9480334
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhL0SK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhL0SK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:10:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A54C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:10:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z29so64538673edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZfv4l30H99dim1rIkVyLOCmppXl3dBKONr9XpRFCFo=;
        b=g7U9MrCrWSr012g4arHmdhf79XLSEcekZhy8re1OrG7IkWyJOHNreqfQPtWXJp4z3X
         Dp9qu+mrltQabq6X5NtbdjVbrBUEldDfNgGgTmw1fLDuYpq8MP7TE023bj1Y2dazXuna
         BNtuuLCHV2sC8Yp4ZRYEevyWAvQWRezwxWWyIKJ16EH5xyExZCcOBKiHJcP6zkfFhXGi
         evmH1BhCGrK+exdG3UQECj22/KNUqJGbYtZ5llNwWLH4km3qY5h6w2WvKYkWUQALVCCz
         rt6NbdEu5tGgFfuZ0Py5CwLJ7gdaORWAeU8mMupAS81WrVWfd0A532xFXTBs/5axCS2X
         5l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZfv4l30H99dim1rIkVyLOCmppXl3dBKONr9XpRFCFo=;
        b=lGS2jblYodcWyPNPbL0EkzVBdDYxWowllpERYzvKOAWyvZ1OTzsileQUwjkwI9hRy1
         wpJc9R0GmzrT7QgsK94d56hiIHhvXDWtYoq5l1P0iTpFfKzVBw81Qt/u6bN9ggfvlsww
         Hte2ibzEpbSs4K3Yp6BMxuLC7iGZ9jz4/z4uITm95n8GFniGhIQslRLU/QOpSUKY2BMq
         oxeEe2nBOYbs3hd6rkS9WvvokxtHoJID6wSYjACwpy6f0PiDQ5XarXqvDIGzPNW1u4LT
         lcZrJFet/zQVo36PoZoquXcaTDSSQ5Gi2mcG87klQU3fMtAa/QNgl+ZVi0uzTETDYvBk
         ibvQ==
X-Gm-Message-State: AOAM5311xblNUuI6tMJrYrtiEPxQYF/ANJYAmphdGC+sXpGd/k+rW2fx
        V7iLSSSKDtelyPUdL6cgFAsaHr1X89jbyvcH8c4=
X-Google-Smtp-Source: ABdhPJx5xiU6DZrcXlQ71TpUeO1xkZfpvgTcNZ43G3beRQGQeeZ3itkoGEPXg1kLa4rLJNi6P2eDkZq5uCXoZgd8tOA=
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr14863800ejb.302.1640628654866;
 Mon, 27 Dec 2021 10:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20211227090139.2001-1-zelong.dong@amlogic.com>
In-Reply-To: <20211227090139.2001-1-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Dec 2021 19:10:39 +0100
Message-ID: <CAFBinCDDxCuwC-zNurWW44v3tJnmeK5xkJajx4RDe+1uDtecuA@mail.gmail.com>
Subject: Re: [PATCH] reset: reset-meson: add support for the Meson-S4 SoC
 Reset Controller
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     p.zabel@pengutronix.de, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for this patch!

On Mon, Dec 27, 2021 at 10:01 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Most maintainers don't take patches without a proper description.
./scripts/checkpatch.pl this.patch states:
WARNING: Missing commit description - Add an appropriate one

I suggest something like:
"Compared to the A1 SoCs the number of RESET registers is different
and the offset for the level registers is the same. Add a new
compatible string and struct meson_reset_param to add support for the
reset controller on the S4 SoC."

[...]
> +        { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
checkpatch reports here:
WARNING: DT compatible string "amlogic,meson-s4-reset" appears
un-documented -- check ./Documentation/devicetree/bindings/

My suggestion is to take your previous dt-bindings patch for the reset
controller and to extend it with one entry in
Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml just
like it was done for the A1 SoC: [0]
Then take both patches (dt-binding and driver) and send them as one
series, so it's clear to the reset-maintainers and reviewers that
these patches belong together.


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d9730b9eb05a349c278a9f6f058ebefa9063def
