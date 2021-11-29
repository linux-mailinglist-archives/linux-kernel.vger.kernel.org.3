Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43176461CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbhK2RlH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 12:41:07 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45843 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbhK2RjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:39:06 -0500
Received: by mail-ua1-f51.google.com with SMTP id ay21so35674924uab.12;
        Mon, 29 Nov 2021 09:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LNSjwgPBAW69tYr5ppeJRmtuxxe2teojG1+3mTlzbk8=;
        b=MFRBRw8AuP50KywGjykujHpvaMtsLVXRCE+LHoGflCkNTZYF6FF0LSnDd31cW8ApMk
         9DI51qQ35d23dLcu01htvqoHdhfG2wlXQDKXboU+M51KnAujXbo+6Q4XRhmtBbZ5U/wd
         yW9Of3oNLQywdrRuj6XWkwFHG/w5tF6YK60rj1jqTQYZRwm56z0XNG+qZUy+C28ktyZ2
         ZlretbzwZyojrSxVHvyLtYYL73T2YhguaU1Mdts2WStfOOzi3Vl6SlDcJPMG9vIn2g66
         Br3VK3GaSidMfVYzRDH2yMyV6PoWFTU5RsXbQCo0B3b7xuDOhhRjDjr7iv0AIgu5gJ2k
         6lCg==
X-Gm-Message-State: AOAM5331GnRAgtxlUIVgZSCiuRt3XiMGWh4MwROtDyTnQZ+YpT0SZ7bi
        O3GwPN7XeMD7Kvyvy9mgvjIJi8L/1AlOEQ==
X-Google-Smtp-Source: ABdhPJytZa6+epuVqQi94Eg9aJIdN07pdl7EU7jg5r44weqWA5zpTtoqAcKqECdyYp2clA4p7e5m9w==
X-Received: by 2002:ab0:3349:: with SMTP id h9mr52239155uap.111.1638207348213;
        Mon, 29 Nov 2021 09:35:48 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id j145sm8527641vke.47.2021.11.29.09.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:35:48 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id r15so35727535uao.3;
        Mon, 29 Nov 2021 09:35:47 -0800 (PST)
X-Received: by 2002:a67:c90a:: with SMTP id w10mr34928412vsk.22.1638207347791;
 Mon, 29 Nov 2021 09:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
 <CAGb2v67M2Qi5tUq0BNbgahTsY4bbYGQeqzjoH8RZ6fYWzrWsYA@mail.gmail.com> <5516984.DvuYhMxLoT@kista>
In-Reply-To: <5516984.DvuYhMxLoT@kista>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 30 Nov 2021 01:35:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ZGMxqgU7sGrSrnog3yHZ+Ny_xJdvBFVYZWH2Q5XbiCQ@mail.gmail.com>
Message-ID: <CAGb2v66ZGMxqgU7sGrSrnog3yHZ+Ny_xJdvBFVYZWH2Q5XbiCQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Klein <michael@fossekall.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:29 AM Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>
> Dne ponedeljek, 29. november 2021 ob 18:16:31 CET je Chen-Yu Tsai napisal(a):
> > On Tue, Nov 30, 2021 at 12:55 AM Jernej Skrabec
> > <jernej.skrabec@gmail.com> wrote:
> > >
> > > Several H3 and one H2+ board have power key nodes, which are slightly
> > > off. Some are missing wakeup-source property and some have BTN_0 code
> > > assigned instead of KEY_POWER.
> >
> > It might have been that after shutdown there was really no way to
> > "power on" the board with these GPIO power keys, so we didn't use
> > KEY_POWER for them?
>
> KEY_POWER is actually processed by userspace, so it would still make sense to
> power down board if power key is pressed. Correct me if I'm wrong, but in
> combination with wfi it could work before SCP FW was available?

I guess it could? But where would it do wfi, and what would execute
after wfi?

IIRC the kernel's halt sequence doesn't really clean up interrupts,
so wfi isn't going to get very far.

> >
> > > Adjust them, so they can function as intended by designer.
> > >
> > > Co-developed-by: Michael Klein <michael@fossekall.de>
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> >
>
> Thanks!
>
> Best regards,
> Jernej
>
>
