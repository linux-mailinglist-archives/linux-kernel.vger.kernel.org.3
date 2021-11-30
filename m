Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49B74629D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhK3BiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbhK3BiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:38:00 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3515C061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:34:41 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bf8so38173293oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlAlW8lzEiwMilapgFJ9XcVfAOd8fce3a/oZQ90BQPU=;
        b=fncGRT3xZrQM0eMsLHETx9uok4uUmgxob4q2WDOg/zAZGZTgK9XgbV6AhGDTtAZV1M
         dnJ42UowfZnxY0PNQvFaPxDmttQX4zfddVCqyRkzYHtEyh3J6HfhU3ogVh6PX8vt0iCY
         jkfAb7LlRrvpI/Sn0v27MyDpQhG1MoZiAN9p0jv6rVKBlbppOhYccyXV+lMOleoV0riX
         nXX6B4ndA0AJaQlyDAdUWG74TMUbXRYVBDLaN846lYl8Wd2jfM+aOb0V/kBel7ZZdR1i
         GLPIQ23Bmcg7+PdePjV00uwqnw3IRFTiP1o+EEQvcwoHA5eIKu3da2kI8XPSmEeo/goT
         a95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlAlW8lzEiwMilapgFJ9XcVfAOd8fce3a/oZQ90BQPU=;
        b=oQ8V+Cpf2eTuQ6yfYBfGxUjrG8eo79eho/6yOcEiYU54ASo86+aswwEyZQRs+/4b76
         3MqEXfEEdhtn2RpnWxX854g3nGd9m+2VRUoQg91o2ZcvP0mzlzSDkCF4xt1xPwVKs/Gr
         /WR3naG91hzza7UAKi4MqqlxO8gVKvGc5w8sLfb7ZkO/4bZQD9uBxFxYbWUMv3Qskis0
         MNPjr3JGoJL0ktJA/qczY90qTw25MELHCMZb4FZtocs3thcNjVEbMlbEtaDDoVB+kQST
         6KrxmDdPq6j7yILKnFFHqUJah41KFaq9VpWKvQpHgDBVWHJ8mnMQTNEfLrLTRvjxGAVQ
         A1lg==
X-Gm-Message-State: AOAM530qnMDdl0e5OQ5slEiZmfUUvJx7UEMaGsK0Awc7Ei36T7mS7qoz
        aQ7E+sK17RhGSGCz0J3WTRdCJOMHfp313Ddl+bRcGw==
X-Google-Smtp-Source: ABdhPJyAuUEjDcA9GzFX3njqloe8SERPQYlO82Dy2P7l1F4bCJEdMiSuXAzx7o2eFssirsvu4ANhvlkzXemDlIxSVwQ=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1605375oic.114.1638236079803;
 Mon, 29 Nov 2021 17:34:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com> <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
 <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com> <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com>
In-Reply-To: <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Nov 2021 02:34:27 +0100
Message-ID: <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
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
        linux-power <linux-power@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

not so much time so trying to answer the central question here!

On Sun, Nov 28, 2021 at 9:51 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I am pretty
> sure the current power-supply framework allows us to expose the current
> full_cap to userlans - so building your Tesla example with the star
> should be doable - if the drivers can somehow get the information about
> the absolute capacity drop.

To do this we would need to export a capacity at current temperature
and capacity at nominal temperature (which is usually 25 deg C)
so you can scale to something. This isn't in sysfs today but we could
probably add it (and then the world of UI:s battery icons need to change
in response).

> > Then the question is: is the method used by Rohm universal and
> > well-known and something many chargers will do exactly this
> > way, so it should be in the core, or is it a particularity that should
> > be in your driver?
>
> I am not sure this is the correct question. I'd rephrase it to: Would it
> be beneficial for drivers to come if the core did support this
> functionality - or is the feature unnecessary, or are there better
> alternatives. If core does not provide the support - then it is a high
> mountain for one to climb if he wants to use such improvement.

I think we need this.

> I think that the agreement we can do is that the OCV+temperature => SOC
> tables do not provide quite same information as the suggested
> temperature => capacity-drop tables would. Whether there are better
> alternatives - or if this is generally useful remains to be discussed -
> and this is something where I _do_ appreciate your (and everyone else's)
> input!

temperature + OCV => SOC isn't enough I think.

We probably need something to tell us what the total usable
capacity will be under different temperatures. I suspect an
interpolated table is best though, this is going to be quite
nonlinear in practice.

Yours,
Linus Walleij
