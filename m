Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F14D9F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349782AbiCOPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349776AbiCOPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:51:49 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C854687
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:50:35 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso24840616ooc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=I4c51xsdjxSyFom4STgtqxq6o6AKdTW8OLe7O5/jVnI=;
        b=RdbsXMNlP8wYdG7quqOUWkNI912I8J8v2dI1CpPrFRzvPMlqWvYUjRZcc3CPAOO29S
         Yge/Doop6f6uEsSFKCqhOIsjsvZ/KqP+eWOLjwNC9rSDGozrfKDRjbcvxa5z0pCPEIve
         c5NtXIfspKzVJ4hupGwMTdkiQ23FjnfxTBn9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=I4c51xsdjxSyFom4STgtqxq6o6AKdTW8OLe7O5/jVnI=;
        b=5oAJevrWWnqSb0ajXxj+qdoDtqYnpNz2/DzrbqVeB0i7nmA5X4qxVkeNv8XfpFjH90
         AOlqgBrBBX1FGvC0Ea012hU/J31CZqzrBfxkvaYakNbojynN9CnXkp3oGSacCgfDmxSK
         Pn8kSTSVnWEi29262ha0PpjyNftwdWdGbil7mxYfAGnzPxjlu+HbpDLYxJwHpUjdwD69
         j1+VboWHCc0Q/mt9lGHVQ3wSstFYmgEinKnj/u0tpPnXBP1JndtimMOcv61wim/RJkjK
         6QWH7zfTGPYEtU+ZI70+qFFucEkHrUBjXNMB3mPZXe0okC/6K6/GlHIObK/RzXV31bi0
         oCNQ==
X-Gm-Message-State: AOAM53392r5+5KJcJompVR0l2uXBYkdDuh5SS1HaCSmpYZ8yphUgQNs3
        8V/S+vXR4AAjJxk7wsDSIHFRYOGbVDqLin7Ee1oOtw==
X-Google-Smtp-Source: ABdhPJyHK2Q+ikMVle/mFHZsw86q2VaSnh4TIjabq9UlQBoV+QZTX64BB1/3Nt6dBd6/Mt4xS0Vdwi/ekXUmIzZbJxQ=
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id
 e11-20020a056870c0cb00b000da2bccaa09mr1821164oad.63.1647359435184; Tue, 15
 Mar 2022 08:50:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 10:50:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAHNYxRwFYBbgxUqz79jYXbDxSd-r+NdHWQPucEyuNK83U577xw@mail.gmail.com>
References: <20220314232214.4183078-1-swboyd@chromium.org> <20220314232214.4183078-2-swboyd@chromium.org>
 <CAHNYxRwFYBbgxUqz79jYXbDxSd-r+NdHWQPucEyuNK83U577xw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 10:50:34 -0500
Message-ID: <CAE-0n50A2yrSbQJA8EMum3AoLf+w263ddFh6sA5d+tfMMMkarA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
To:     Alexandru M Stan <amstan@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru M Stan (2022-03-14 17:23:38)
> On Mon, Mar 14, 2022 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > +        compatible = "google,cros-ec-fp";
> > +        reg = <0>;
> > +        interrupt-parent = <&gpio_controller>;
> > +        interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> > +        spi-max-frequency = <3000000>;
> > +        google,cros-ec-spi-msg-delay = <37>;
> > +        google,cros-ec-spi-pre-delay = <5>;
> > +        reset-gpios = <&gpio_controller 5 GPIO_ACTIVE_LOW>;
> > +        boot0-gpios = <&gpio_controller 10 GPIO_ACTIVE_LOW>;
> This should say GPIO_ACTIVE_HIGH, since there's no inverting going on
> either with a real inverter, or the convention (of 'N' being in the
> pin name).
>
> It might be easier to reason about if there's no invesion going for this signal.
>
> Consider it like an enum instead of a verb (unlike active_low
> reset-gpios which can be considered: in reset if it's set):
>
> enum boot0 {
>         normal = 0,
>         bootloader = 1,
> };

Ok got it! I have in my notes that physically high line means normal
boot mode and physically low is bootloader mode. I confused myself. I'll
fix this.
