Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A27464E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbhLAMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:45:35 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:45651 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhLAMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:45:34 -0500
Received: by mail-ua1-f44.google.com with SMTP id ay21so48600243uab.12;
        Wed, 01 Dec 2021 04:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=La75mYyicBSHo3/PwvSDeXoIi9UyxaqT15CWxLOFL3w=;
        b=F1cebL+Ga93tvzsHPxEqCVJDd8+7YM6LpmkrnuZ3T5K8DuyvLzhqsJ2QIcJKwH93p9
         KUulN6ZoYbp8uw5zVRlEc2cSg+N5VeOf6UHvmNKrWhW1UXQcsALu4txfwrIzC0Dn3aza
         H9Uhn6EpAtP5tl+8ZOEKUgDiUax1plsUAYTvZzGFbIyWICXIWDk0t27ORTD1nD+tdAIY
         WsapAExRJYUhNrw9yG7AnHUpgr61yjXZY+IkK/7NG+NaiLB0o25JoWJ5CCgQmn6MD/fx
         cMhmJgTyh17aKmYTauHX2Hb3TMxK0gm1Qz7O+uScNoFEyKqlfqHW7aPPa9SsKZxdYqij
         8xyQ==
X-Gm-Message-State: AOAM533lrkClo+q2wjVFJCv1x9AThToUfnOIOUS9FXowo9l4XjEc1YJN
        5GNztRowwx9zgiVnXG5Rts9MjcsG0gkv+Q==
X-Google-Smtp-Source: ABdhPJzw6iO7kSgcumAKwYFFxTR8dSed+ewB5kLOHIHB3MZCtL1t1Fk0EAa/IvAep9yYvYFT0Ezo1w==
X-Received: by 2002:ab0:224e:: with SMTP id z14mr6970453uan.97.1638362533253;
        Wed, 01 Dec 2021 04:42:13 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id r20sm11690923vkq.15.2021.12.01.04.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 04:42:13 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id y5so48607072ual.7;
        Wed, 01 Dec 2021 04:42:13 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr6580166vsj.77.1638362532976;
 Wed, 01 Dec 2021 04:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
In-Reply-To: <20211130164558.85584-1-tsbogend@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 13:42:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqKcnpDeKFaKs4sx_9UpeQYyfVrSDyqYf6MxFbdr64Gg@mail.gmail.com>
Message-ID: <CAMuHMdUqKcnpDeKFaKs4sx_9UpeQYyfVrSDyqYf6MxFbdr64Gg@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: TXX9: Remove rbtx4938 board support
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Nov 30, 2021 at 5:46 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> No active MIPS user own this board, so let's remove it.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

My rbtx4927 still works fine afterwards, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
