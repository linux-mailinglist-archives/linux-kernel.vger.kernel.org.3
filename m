Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F764892A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbiAJHpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:45:52 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:40683 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiAJHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:38:48 -0500
Received: by mail-vk1-f170.google.com with SMTP id 78so7560155vkz.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 23:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjI5/tOCXa4LhOlobTI7CWiqFNOTrhMglYVnreX/oyA=;
        b=x2jQb0x8AvqVYF34XQw56olsnO+SUW9s/+Kf4ADLS2uSu+X48M1TQwTb6q6VhYuhE2
         /NRdRog0XpsshrPW2GahxaxZrWYZ1PkIM2Y6EBI3AXIFyWlCt3eEKbxTbaB+VhCSxrSc
         bn5uaAaNvz3/Nysna9D0AUsmASjotHQg4MF5ZtkUojH+PiguMc10uwLTNPNZIW2C0Wmj
         6ijM1I87PWD9CnQpQbvly+dDc/kX8XOj41pKxVslR5yMgC399CecbGUFr2G7zauT34fz
         Bqx8BsZ2Xgr2zPb+Rt6GzSwYX2hdVFuvSJLRjs7kpcFvkcJcRf1k4MShC89WG0iQ5q4S
         Ir6A==
X-Gm-Message-State: AOAM531ZF5jK9zQUOKaus5IS3b3XpNeNWuqN+qPGkWPF4tlYVHjJ1RTV
        QRYcf2ywkTDtMCnoJ/HImxL9rCRsCED0VA==
X-Google-Smtp-Source: ABdhPJxH77QJ/g46cz5SoRKZbIE4zfvoYgiegVhNB4VhhkN5YW6mr6zBxgMg6lXaQBqbWxn5hFOhbg==
X-Received: by 2002:a05:6122:1348:: with SMTP id f8mr21846618vkp.32.1641800327574;
        Sun, 09 Jan 2022 23:38:47 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id u33sm3607774uau.7.2022.01.09.23.38.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 23:38:47 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p37so21825322uae.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 23:38:47 -0800 (PST)
X-Received: by 2002:a67:c81c:: with SMTP id u28mr24272101vsk.38.1641800326823;
 Sun, 09 Jan 2022 23:38:46 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
 <163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org>
In-Reply-To: <163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 08:38:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEKbc9ovGPqtO8v-xRCoSKF=KZ-53g+7vRKnDZMCmeGA@mail.gmail.com>
Message-ID: <CAMuHMdXEKbc9ovGPqtO8v-xRCoSKF=KZ-53g+7vRKnDZMCmeGA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.16-rc3
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 8:29 PM <pr-tracker-bot@kernel.org> wrote:
> The pull request you sent on Fri, 26 Nov 2021 10:52:04 +1000:
>
> > git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-26
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/a4849f6000e29235a2707f22e39da6b897bb9543

The commit that merged this branch made a seemingly innocent change to
the top Makefile:

--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,7 @@ VERSION = 5
 PATCHLEVEL = 16
 SUBLEVEL = 0
 EXTRAVERSION = -rc2
-NAME = Trick or Treat
+NAME = Gobble Gobble

 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
