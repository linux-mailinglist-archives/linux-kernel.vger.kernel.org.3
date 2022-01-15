Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95848F767
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiAOPQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 10:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiAOPQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 10:16:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD464C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:16:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p27so28771507lfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aw0wDC5RObM03gYq5UCQkUBkn1tAzlt+aPibmT+t4NQ=;
        b=R2zEYBVOKAKMJBxJZoPMqB1tWVWQGQ1DydqYumbS27TCDpxe/e8iAimPcKALSp9xLB
         XISiGgZzpO3bDzYvqXrcx1Jnj2i4jprX6wtnKzIO2ZpNxst/h1XCIBQJgEzc6bO2KDpR
         u6Pvc6l26Eg7WAF7sGCSbzo34/egDUFrHXw1+NmI8zFlwK9ElfNtbQNwx9UEQyEvDX/3
         dRQK7DQ9HgW/XKFlBF1boJqkGSWbvbSXEXErybZuoEoehgzBApKZ9rsujb7AgF+AK1rj
         uvwyUtSZ2u7H+wxqo0j3ngcIKaIx1YDvzQnoDJCoYwfvzFr1s6AN9n/87KLuEAfGBPb0
         i3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=Aw0wDC5RObM03gYq5UCQkUBkn1tAzlt+aPibmT+t4NQ=;
        b=MzCcAJ4Q3ZC1fDzZO9c3J9wNvQEe1uPfhfTIuGubnoBvz6lXUlGFR45z87QO27vd92
         uwlwv7lslQK+yhBtcw34c+2LHr2fWJTCRgxk1q8+Dq6otUFiMdpX4S6bnDPSIVSlvvMI
         vsf5UEvkVs7bSuTafEJSLqo9vTfx1tI76M4CFTiY1QH0Xy0rF3l4hG2wd8r7sEvLlV8b
         ulJJAXhEWDoxX4PCtx3325FpG9d+kX6GvRDA2GaDW1n4T8LiR3u1l16YFQLJ2ext5Ycm
         Qby1qxLox7OnAISJQqzHEjEnszuXX4KZcO9ofMacSiKes1FVmPEzHAVvLXGv4JsUdsI4
         muPw==
X-Gm-Message-State: AOAM5336SQDIJnhUfKfqBfjNSnfCNWrbW9zCNuDOEiDDYY66kIxiQxdv
        b+SUzqPb+LjzkRfUvnjFuiQ=
X-Google-Smtp-Source: ABdhPJz5GbSUsaaqOY3bcMZYLsgUqGx0Dfr1w8xyUU8t8Iu2mCLGqpJCeui6A9iUR9IDR+KB+M4qEA==
X-Received: by 2002:a2e:86c8:: with SMTP id n8mr3885610ljj.386.1642259794158;
        Sat, 15 Jan 2022 07:16:34 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id j1sm845483ljg.45.2022.01.15.07.16.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 15 Jan 2022 07:16:33 -0800 (PST)
Date:   Sat, 15 Jan 2022 18:22:15 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220115152215.kprws5nja2i43qax@localhost.localdomain>
User-Agent: mtt
References: <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsftp3027.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 08:55:28AM +0100, Takashi Iwai wrote:
> > This patch solved the BUG problem. But after unbind/bind micmute LED
> > stopped working. Speakers and mute LED are fine though.
> Does the corresponding sysfs entry exist in /sys/class/leds/*?

Yes.

> And can you control LED over there?

After "out of range cmd" messages the sysfs entry remains present, but writing 
ones to the brightness file stops to produce any effect.

Actually, the timing issues are present here as well. Sometimes unbind & bind 
works fine. But fails on the second round.

> This seems to be a bogus COEF.  But I have no idea from where this
> comes.  The values look completely wrong.
> I guess you'd need to put some debug prints to trace down how those
> are triggered...

Okay, I'll try. It's going to take some time though.
