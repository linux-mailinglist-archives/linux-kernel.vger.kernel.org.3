Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CDC4D3FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiCJDiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbiCJDiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:38:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612112B749
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:37:18 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c0so44937817b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 19:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yQTKhKZiy0dUPmGqJVBdGvAVphmdM4bBbUG0dfDJxA=;
        b=l8ZoaPWHxwzbVpBhjmxinUTGj1j+Ig58rGZSi3+BJqEfohJetEebkCtGVXGmOi88as
         RgOeKfLY2ZX5wH72NwrACWu7i3CfsGj5AHezzZzN6Xn3IYWVfFZwtjSwCFCfnCmZCqBg
         2URYSWoyX1aaT67mpJbQp4uHKr91W+6dsxTzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yQTKhKZiy0dUPmGqJVBdGvAVphmdM4bBbUG0dfDJxA=;
        b=Kcy+u/QOxtwVwiY8D6Fzuw1E+0IoI3uOYvl2FXTFCl8kEC2RxqUC9WbTrfhz64vf6i
         QLABOtn28l6y+DvCK5YY9M07z1mGC+OJOPfUT2w1jfjTJ90lMYXRns3JXorF+odirjoe
         37MTeF1Vy/5QDlf9e6aGT2C8naetqxp3kT869QXGFIJWzEVBAhV5sea76sUgQJ5+Is8Y
         TyN8oSSp5MvZUd/OpxTZlQLr+Ql0my/tA5CWwJPmB1IokKkzyvlNNxqcJ3/O3RFvPTvf
         YJvKzL1OAFb5nEzE7tJtwWygPyIOpVRcSCooxf9EOq4OJqTIB48wiSL37JCXUg1Qhy9T
         PZ6g==
X-Gm-Message-State: AOAM5308++0ncsHtYT9cJVLhkZ6LMkvun07PL2hpPo8Bqkxvqz+tYBjy
        3VgwYL2Nt8XAOhW1PBH80kyFXl77H4tzrt46zBNFsA==
X-Google-Smtp-Source: ABdhPJzD4At+0kNDeSdaPownG05HBBbm9XR+dPHBAUs2dzK5t7RTrvr+pZUyJbh1iI5EfuV1fzcc2FvG6pci0IJKTDk=
X-Received: by 2002:a81:5791:0:b0:2dc:4a64:56f4 with SMTP id
 l139-20020a815791000000b002dc4a6456f4mr2475820ywb.286.1646883437469; Wed, 09
 Mar 2022 19:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20220308100956.2750295-1-wenst@chromium.org> <20220308100956.2750295-6-wenst@chromium.org>
 <400cf2fc8cbc3887a90f50709f40adc0662ec0f4.camel@perches.com>
In-Reply-To: <400cf2fc8cbc3887a90f50709f40adc0662ec0f4.camel@perches.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 10 Mar 2022 11:37:06 +0800
Message-ID: <CAGXv+5F7pQt28m7wjS22io-MF=ms-HAWOSGC2iMz8cX=zhd1wg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] pinctrl: mediatek: paris: Drop extra newline in mtk_pctrl_show_one_pin()
To:     Joe Perches <joe@perches.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 4:01 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2022-03-08 at 18:09 +0800, Chen-Yu Tsai wrote:
> > The caller of mtk_pctrl_show_one_pin() is responsible for printing the
> > full line. mtk_pctrl_show_one_pin(), called through mtk_pctrl_dbg_show(),
> > should only produce a string containing the extra information the driver
> > wants included.
>
> Does this function have another caller?
>
> It looks as if this function doesn't need to be EXPORT_SYMBOL_GPL
> and could just be declared static in the file instead.

Judging from the commit history, I suspect there might have been plans
for using this in another module?

I can do a patch to make it static until that ever happens.

> btw: using %1d is mostly senseless as a control, but has some
>      documentary use as a value < 0 or >= 10 will be always be
>      fully emitted anyway.

Ack. But we could just leave it be.


Regards
ChenYu

> > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> []
> > @@ -634,14 +634,10 @@ ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
> >                       pullen,
> >                       pullup);
> >
> > -     if (r1 != -1) {
> > -             len += scnprintf(buf + len, buf_len - len, " (%1d %1d)\n",
> > -                     r1, r0);
> > -     } else if (rsel != -1) {
> > -             len += scnprintf(buf + len, buf_len - len, " (%1d)\n", rsel);
> > -     } else {
> > -             len += scnprintf(buf + len, buf_len - len, "\n");
> > -     }
> > +     if (r1 != -1)
> > +             len += scnprintf(buf + len, buf_len - len, " (%1d %1d)", r1, r0);
> > +     else if (rsel != -1)
> > +             len += scnprintf(buf + len, buf_len - len, " (%1d)", rsel);
> >
> >       return len;
> >  }
>
>
