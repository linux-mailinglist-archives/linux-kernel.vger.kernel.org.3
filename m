Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243148EE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbiANQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbiANQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:23:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA4C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:23:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m3so17852905lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=42zPbb0yroZukcZ5WPJ2D+PdN5fgMopF24EmDtHwsH4=;
        b=E5AwvZ8XcO+MsT9Hq92x30gcmZmZqPYcSC+iuhS9vWpX6JEbk+/JsTyTk/UL8/9wzm
         CBKUeKeamZDJYUaB/sZ9mXo8xCA1OhAfe8ZYXOxhJ1k6oiH3zfCEiYLrLklRNMOCZOO5
         3HreIIzMhmoim1gKEOJzbOQkJSI3wY+CVS9dg94jQfkIsUgboAJ1ThBq1TiP5GkwF3pW
         zS9LuGVuF6dfrlx2mTjRd1M6DkgK924sC8RNJlBTkUKh2lpTtvgOE7/dBVko+s6Mm+6A
         z+EnOACdOWOS0NDOUhuUGaRIlVEoNSosAbPWEShtX1Hyw3qgzxOx84PdodTaR19YUjdR
         TIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=42zPbb0yroZukcZ5WPJ2D+PdN5fgMopF24EmDtHwsH4=;
        b=GBUfNee44EWEAPBtRoXBsHuLT2Ga/2lBiSvYsJRuz72vQ9/PTwtZN9IImQBjKaE3Yn
         YSuFLWQM7rU89pJUIcCsIWFVmOtjuJzh2Bosw6L2ikRLPjM/0aaC5HdarCq6Fk+0HO+j
         WW2lwk35n6XiyNgEx3XxlSBzfn5VNRvHAknTVzL2cGMG+uQSv+Dw2Gsgua710yxM1xM4
         ccBIG6CdQetJkj5P1RQtz5ouzlgLR8qxI6Y22m2o0nbsGkc44BroJOP10kQJokSTXdpg
         ZPCeLIPgpmNvoXTA0+UxgipxLZ4VXAiEYTY/eiRuNXamYwPmU/X06SJyDG1L31rwGHza
         MzLA==
X-Gm-Message-State: AOAM532GN+xqju5uJvB0MGonXVAhmu+Kk1/Vx0QgjjBknvioHekcu40W
        Rlqicrdc0WywDlGDlEyZy/g=
X-Google-Smtp-Source: ABdhPJwxqYTPEnm/szEKg/tWZvhyJXTB2ySl61arfJl0qseHH8097Qm/FF0M8jMMM7V/tSGRMpHWcA==
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr974222lji.11.1642177403033;
        Fri, 14 Jan 2022 08:23:23 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id k19sm624295lfu.176.2022.01.14.08.23.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Jan 2022 08:23:22 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:29:03 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix speakers and micmute on HP 855 G8
Message-ID: <20220114162903.fbdejorf5ibia4sw@localhost.localdomain>
User-Agent: mtt
References: <20220113210930.dtryx4ifjsmb33lz@localhost.localdomain>
 <s5hh7a647vw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5hh7a647vw.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 05:08:51PM +0100, Takashi Iwai wrote:
>The change looks OK, but it doesn't apply to the latest tree.
>Could you rebase it with either sound.git tree for-linus branch or
>the latest Linus tree, and resubmit?

Sure, I'll rebase on the sound.git branch.
