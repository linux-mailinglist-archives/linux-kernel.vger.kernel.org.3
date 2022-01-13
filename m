Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6E48D4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiAMJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:01:19 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:41685 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAMJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:01:17 -0500
Received: by mail-ua1-f51.google.com with SMTP id p37so9740965uae.8;
        Thu, 13 Jan 2022 01:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPUkI5LvvxCzghzBeHMxuJ5P/rCrBrsO0aS+FYZgtrE=;
        b=2l55pHQPbbCrdl+JxOCbLeCyJBJjMfOi5ni3Iddf6CFswzXL2ZVrBLH+BiU20iVWV/
         9YDovQfhIh8lA8bY/0CdZ+Nfs8rKWkV2uluXKlsWBZjtsns0oiMeaIVC/zXVLqYr0Sbm
         aR5dCrpmUDSqHMEHp1NqRtYZMvw0kmVNDA7CdryhTWduBWfxSTljLykSgTEmQFGPlzt9
         cz/JFeC9EVCjIdxNuQN+zjemkjkvr3+smyBIo8MfDIa6K8y/RnjFQjsHuuVjJ9r5qO/A
         6Lst3jUhwav6prbo7hO6/pWxtIxqI8pqm303kCp7HrNbgI0w3b2sO/aD08xjCYaAaWga
         J40Q==
X-Gm-Message-State: AOAM532mEn+mVKC0sP6mzOub1vUv8iWnM4+IPQcKbEFVCbxzRj4F3hkq
        uDIJqWDaA+mzRxmT8dX+tdu9Vi2SNJRr52jj
X-Google-Smtp-Source: ABdhPJyz/SikRbdFufc5nbzL8LFgpjuKBxIpBrIVAeLzjWOKSkk/tzbxCrac9zAA2NIWmBMXdyHFow==
X-Received: by 2002:a05:6102:354e:: with SMTP id e14mr817154vss.41.1642064476911;
        Thu, 13 Jan 2022 01:01:16 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id k135sm1085656vke.53.2022.01.13.01.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 01:01:16 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id h11so9776783uar.5;
        Thu, 13 Jan 2022 01:01:16 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr1810579uai.89.1642064476050;
 Thu, 13 Jan 2022 01:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com> <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
 <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com> <17b8de50-426a-2543-a79a-aab44c9d52cf@cogentembedded.com>
In-Reply-To: <17b8de50-426a-2543-a79a-aab44c9d52cf@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jan 2022 10:01:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVj9k8W_FHtW5G+aYug-VvonMnyWyXteqhLONBBSKLZw@mail.gmail.com>
Message-ID: <CAMuHMdVVj9k8W_FHtW5G+aYug-VvonMnyWyXteqhLONBBSKLZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Jan 12, 2022 at 10:10 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> > I'm writing a patch to drop those right now :-) I'll CC you.
>
> This is not the only place where rcag-gen3 dtsi files are using empty-endpoint pattern.
>
> du rgb port is defined in the same way.
>
> And, I've submitted a patch some weeks ago [1] that hooked into that.
>
> [1] https://lore.kernel.org/lkml/20211225115308.2152364-1-nikita.yoush@cogentembedded.com/
>
> Since there was no reply, I am about to resubmit it.
> But, perhaps need to do something with empty-endpoint pattern first?

No need to resend for now, it is still in my review backlog
(Hi Xmas/NY ;-).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
