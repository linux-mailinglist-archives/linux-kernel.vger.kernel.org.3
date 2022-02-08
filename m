Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0394AD64F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349718AbiBHLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349748AbiBHJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:55:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12106C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:55:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so36265504edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqLy4wbT30gKNHEEk8JX8phB5jik7Edkg+UhlJoA5rs=;
        b=GmStCOfR1LjR64d3+n6xiUfvnpjdXMYf6CGOzrW6RIz8xDIP0n8/jYPfRmgeH4wvSA
         OHrBANagwetRO1ctOhpjjqD7hq3IRov+o5g/6r0ohsUWmjxkkAJDMOq5G7RuPuznKZbW
         Lzs8UqpznjHrlZnMzaYxyFRSPYAnFnvEXsiKUDiZvjkpTJFrJJ7Ls7UIM2rbS4+dOVrw
         ZTl80lTnm3SQW3C0NMVVs1AuA2J1zOFaOQeqPQydNl0ZsDO068k9z5YB2blovsV4bGfr
         gty2VNbQEfzPRpAvMj9ngw21yaINuwxLkGx4nbkMcjKNYVKDht8HkTJcUAvqS8XqsgVi
         dwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqLy4wbT30gKNHEEk8JX8phB5jik7Edkg+UhlJoA5rs=;
        b=FNPHfgf9J+vKzuVDR1lMuS5YPCOMO/NTSwjCs9LTNI2Iuikk5Ms8P9ztwplnXWNqvj
         ndKtonRW4WsffmJFBbf4kwcURmaqOIVy+0P6/t3plAZeLk1HmaNuULQfiNM/1svBFl78
         f0WwER0dLbv9Ow3MP9dYjjDabKWb6E6jocmCIxdSTCcAZih139DuKNNY8yJYjw5eB5uC
         tHMwNdJMK2nGpdU/3+c9fnNmdwxed/ubkajavu8d72Xt/c2Bt4LgcxmkJiD/mUAGdMjU
         2T7kCB16U3H2Z+GnzFt8AKrKZfCtebC6rkgJgygwIPZncpLfmhtiFA5jDe4AQAOmBCUF
         n2Sw==
X-Gm-Message-State: AOAM530WqPXPGY/HG1Mh5k2uX7MPm5Q540zQFvGq/Y1T5erAkB0AY/l8
        XcUkMQJYe2Tvel0f8VTUWBUXIoSmEFk5uIRIx1xQBA==
X-Google-Smtp-Source: ABdhPJyuckf4+FV8dJpo2WtDgSZtUTZx/r7KCc+6Q0sBzWGx76zj30iQdTOjUHRAsDoMGMpJF9mslMLO5Se5xA+4mcg=
X-Received: by 2002:aa7:de91:: with SMTP id j17mr3715196edv.396.1644314105618;
 Tue, 08 Feb 2022 01:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
 <20220120150024.646714-4-paul.kocialkowski@bootlin.com> <CACRpkdZnw-Tf2eQwO+LZRW4UacR09qWRWct00=XLb4pfa-N3=g@mail.gmail.com>
In-Reply-To: <CACRpkdZnw-Tf2eQwO+LZRW4UacR09qWRWct00=XLb4pfa-N3=g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 10:54:55 +0100
Message-ID: <CAMRc=MewxfQqM+QvzqjP05Qe5TeiEx+iiOFZLmieqCCVOL9UGQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] gpio: logicvc: Support compatible with major
 version only
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 1:43 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
>
> > Support the newly-introduced common compatible for version 3.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Are there dependencies between the GPIO patches and the rest?
> Doesn't look like that.
> Can Bartosz just merge the GPIO stuff to the GPIO tree?
>
> Yours,
> Linus Walleij

Except I'm seeing there's no agreement on the actual compatible yet in
the previous patch.

Bart
