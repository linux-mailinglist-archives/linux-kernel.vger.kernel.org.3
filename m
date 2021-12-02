Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6936A465BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbhLBCAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbhLBCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:00:49 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBCC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:57:28 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso38028001otf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lCMYrhm5t5lva25mCfOVtAtdQc5BhH6E74NoPZjUbA=;
        b=kbN5VAd3EWzVITSWCiuAVlnCBYntE1oSbkRiiStHk1SRl2vjP37dW0UwV64k66adwJ
         24qzE5a2BByZfzxyqgIhnICyaWuBh3cNZ5C2z6mXlOayvRTACgLiuXA2g1/BUZ4WjJjP
         ojly8x07Q/pDR4d7mbyPlm0peu5bCtQRY1yo7pNSbQOgeTiMjPX3e609cubVq0Yy5XRs
         /EaM+/1qFkCc26ZrmY3ZLJlq41thk/SL4G6sL10fSD9B3Lg/opEU9nQ1gbDZ0cOIObaI
         eOQVGa52Q1VpEo7UqP0Qn6gBg/OrwMUeNvDtUUUNxlEGcjlLoy4/zF1yznZldgc1Su1Y
         2C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lCMYrhm5t5lva25mCfOVtAtdQc5BhH6E74NoPZjUbA=;
        b=umCyHABfd/AUWws4nvRzLmqeQjv5sRLtuzyGyoZlC4dz0k45LZc/uDdgJaCuo2K7dH
         eWGH/5jbmLoKfRSwDH3JpnbQSo2PHYuedDxDiA7Kl9LA3SfJNiYwgM4bJyfAvnDu6SS4
         BuSV5cx2Zl7Kl3f1cLm56UgOTrEyFX6swbBh9qRk4mSPziR2Gpr1ZxbtRX7bMyrcg7TM
         4TO5vFBrarsJbuR8TVCTCazbcb9HycgBeiIXNKfrn5dLCBHvJn5D1zIz6LptNWuoyxi9
         DjJ/z77+Bf3HgUOv5qt4J7PSZB8efVWGy5o4dop6zxSjIOkF78m73H37mPSCXZcmrBz+
         STfA==
X-Gm-Message-State: AOAM530QlVRSblAGpjJucI0gduCsXdHZvbjZS+j2SrLPDd4pssOiAmDF
        1T59s4eewqv9DdEourskQH4zLumlmn2nJcbKhj/6rcAbyI4=
X-Google-Smtp-Source: ABdhPJyuIlyp15f6FFJnwyRvnSdZY2wzuaWptSL7NkR9cG64eNxcHaqNqhS0ll24px3A6oDmh6YoPPsJyo6JDsiPOz0=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr8829373otl.237.1638410247820;
 Wed, 01 Dec 2021 17:57:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com> <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
 <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com>
 <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com> <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
 <d14580b3-1647-5105-4770-2cd8751d9fe5@fi.rohmeurope.com>
In-Reply-To: <d14580b3-1647-5105-4770-2cd8751d9fe5@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 02:57:16 +0100
Message-ID: <CACRpkdYvi7__DJNWRRHgL=4QcA0XV2uXXbW+boVU8dy10rEuVw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        =?UTF-8?B?c2hpbWkgPj4g5riF5rC0IOW0h+W8mA==?= 
        <shimizu394@lapis-tech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:33 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> Hmm. Fair enough. Maybe instead of providing 'temperature range where
> degradation is constant' we should simply support providing the
> data-points. Eg, an array of known
> temperature-[degradation/change]-from-[designed/full]-capacity pairs and
> leave selecting the best fitting model to the software. Linear
> interpolation is simple, and may suffice for cases where we have enough
> of data-points - but you are correct that there probably are better
> alternatives. Nice thing is software is that it can be changed over time
> - so even implementing it with linear approach means opening a room for
> further improvements ;)

Yeah someone will implement spline interpolation in the kernel one
day I bet...

> Well, I don't know how constant such degradation is over time. I just
> guess it is not constant but might be proportional to age-compensated
> capacity rather than the designed capacity. It'd be nice to use correct
> approximation of reality in device-tree...

IIUC the degradation of a battery is related to number of full charge cycles,
i.e. the times that the battery has been emptied and recharged fully.
This is of course never happening in practice, so e.g. two recharge cycles
from 50% to 100% is one full charge cycle. So you integrate this
over time (needs to be saved in a file system or flash if the battery does
not say it itself).

This measures how much the lithium ions have moved around in the
electrolyte and thus how much chemical interaction the battery has
seen.

Then the relationship between complete charge cycles and capacity
degradation is certainly also going to be something nonlinear so it
needs manufacturer data for the battery.

> By the way, I was reading the ab8500 fuel-gauge driver as you suggested.
> So, if I am correct, you used the battery internal resistance + current
> to compute the voltage-drop caused by battery internal resistance. This
> for sure improves the accuracy when we assume VBAT can be used as OCV.

Yes this is how it is done. With a few measurements averaged to
iron out the noise.

> Epilogue:
> In general, I see bunch of power-supply drivers scheduling work for
> running some battery-measurements. Some do this periodically (I think
> the ab8500 did this although I lost the track when I tried to see in
> which case the periodic work was not scheduled - and maybe for
> fuel-gauging) or after an IRQ is triggered (for example to see if change
> indication should be sent).

Yes there is some tight community of electronic engineers who read the
right articles and design these things. We don't know them :(

> I think we could simplify a few drivers if the core provided some helper
> thread (like the simple-gauge) which could be woken by drivers (to do
> fuel-gauge operations, or to just conditionally send the change
> notification).

I think so too, I don't think they are very rocket science once the
right abstractions fall out.

Yours,
Linus Walleij
