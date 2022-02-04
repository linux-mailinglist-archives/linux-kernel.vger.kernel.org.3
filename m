Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7D4A974F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358056AbiBDKAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:00:21 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:37658 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiBDKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:00:20 -0500
Received: by mail-vk1-f179.google.com with SMTP id v192so3375334vkv.4;
        Fri, 04 Feb 2022 02:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qfMcnOHtfS1bLvkZ8irbT3G/RJ7P/0NHu2x4nFmRtw=;
        b=2xw2UMpfKiO3WzxCXCh7+reYDrUgvZu9ZTKGMnYTnioClFuf5YnMXuk19YEyiKBWfW
         nRtTm3q5eBWfnzExPlf8zpYoUjSo4s9cWPvizK4IS7u0IqDauHMtROeVjRuCO/5fDN32
         9Ky25GWHd7DY/50yN7F7/1oVPvPpewVCNWNRvUmQ01Bc7l/dts5b3lBESmoVIucuuSA7
         ZFI6j/2LPP9kFTU+gWQSaR/lBnkntbUHR2Qm1DJZdGQj2bxIettJUphjThTpm0aBnYZx
         r99WeNSOtoBxNKD6gC/v00MX5yda2UVNarRHpC/R1t/Juv4yobKEP1ybpJrbLei6ri+g
         xJkQ==
X-Gm-Message-State: AOAM5305xsAT+A6/SlKtjQosR4vVuSpEyW2jGCN6k+kkEMJkA1Z8IrZc
        O8ukMidOjduMBJRf3pqVVrGplNUh1QF4UA==
X-Google-Smtp-Source: ABdhPJxs+SX/pZZIfPB2cn5+6xbGmW+ui8LTaVrvuvAtcu06ygFX8AHnIJoUA8DYe23OL9pKVNhoLA==
X-Received: by 2002:a05:6122:d06:: with SMTP id az6mr742309vkb.22.1643968819243;
        Fri, 04 Feb 2022 02:00:19 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id e1sm296324vsh.19.2022.02.04.02.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 02:00:18 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id p7so9922985uao.6;
        Fri, 04 Feb 2022 02:00:18 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr528892vsb.68.1643968818566;
 Fri, 04 Feb 2022 02:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-5-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-5-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Feb 2022 11:00:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUL=8xay27vvBvbv0iQ0T0oSwMgxMNrLdDmj03ozAM4Gw@mail.gmail.com>
Message-ID: <CAMuHMdUL=8xay27vvBvbv0iQ0T0oSwMgxMNrLdDmj03ozAM4Gw@mail.gmail.com>
Subject: Re: [PATCH 04/21] fbcon: delete a few unneeded forward decl
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:50 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> I didn't bother with any code movement to fix the others, these just
> got a bit in the way.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
