Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06502498905
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiAXSwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:52:25 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:46770 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbiAXSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:51:12 -0500
Received: by mail-vk1-f176.google.com with SMTP id z15so7553837vkp.13;
        Mon, 24 Jan 2022 10:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n04RRQ8nE0niJsTycmRfUY892P4sQ+KhPXgYoCzt8o=;
        b=7MLIGWq94Ge3rxjwb2jdRs5bhcDTpVVVyXWDRPmoKU1cu/J193IVv5t1ofIN4hTIbG
         xgATFTnMfNFYKUimOuXbvU7XHHC8JVileTih0Xt0o1sef2p4nuUrOktaZw110rQMMZ80
         46o1G9n6njd95o6/Bv5hS4kPSYVpr7F4cS1YT/mWQN/d9mtSQDjdbHWy4RpV4DIsnGG1
         60zsTzZp3cC1T+56IbWUnTMDsPwORqDdDAqjpZh0xNjU8rGY7TKxufEynEwQUze8Y5iD
         mzSSsuJkpk54XJFqwu8JK5Kv7eYlN/zi/Lq/0WNc5qvbwaWptjVig/ENW8FRBabrZ9JJ
         KxqQ==
X-Gm-Message-State: AOAM5325bPXUNxtiSiBUmouae62+Ma4I8iTT+yiTo7YIgjTSDDb7gabu
        ymtDsot3fBI+oZGGX0IeeWNj9Wjl/H351A==
X-Google-Smtp-Source: ABdhPJwVhHjTNewS5EYqEjs8Eoxsq/6qMT6hcOYHUMuC+1I6MzQhZHdxsVc5P2D85vzYmRegJ3TAqw==
X-Received: by 2002:a1f:56c2:: with SMTP id k185mr6760810vkb.19.1643050271469;
        Mon, 24 Jan 2022 10:51:11 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id h189sm3049636vka.52.2022.01.24.10.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 10:51:10 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id c36so32780051uae.13;
        Mon, 24 Jan 2022 10:51:10 -0800 (PST)
X-Received: by 2002:a9f:3d89:: with SMTP id c9mr6321567uai.78.1643050270149;
 Mon, 24 Jan 2022 10:51:10 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org> <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
 <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
 <CAMuHMdVjv1+UNeXkCBE+80tdtLuNg=5d6N12hNLgJdaS-jxERg@mail.gmail.com> <CAKMK7uEwDdaR7kDVi9Oah0w8qFEoAywp_wj2eH7DtttVD2L00A@mail.gmail.com>
In-Reply-To: <CAKMK7uEwDdaR7kDVi9Oah0w8qFEoAywp_wj2eH7DtttVD2L00A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 19:50:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUyHEExOCtH-hKh0HmZzadmfZaR=vAVYJkTvphfzs3Xiw@mail.gmail.com>
Message-ID: <CAMuHMdUyHEExOCtH-hKh0HmZzadmfZaR=vAVYJkTvphfzs3Xiw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Jan 20, 2022 at 1:33 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> But reading code&docs is too hard I guess, safer to assume it's just
> broken and not supported.

I confirm there's lots of documentation (and even more code ;-),
which is always great!
But both are intimidating to me, and most of the documentation covers
features I'm not interested in, as they're only applicable to fancy
modern truecolor 3D-capable multi-buffer and multi-head hardware, while
what I am looking for is usually not documented.  E.g. I had a hard
time to discover how color look-up tables work (gamma_{store,size}!),
as this is not covered in https://docs.kernel.org/gpu/index.html,
and none of the tinydrm drivers support CLUT modes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
