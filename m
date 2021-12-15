Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB2476186
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbhLOTTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhLOTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:19:11 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398C061574;
        Wed, 15 Dec 2021 11:19:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so34873452lja.2;
        Wed, 15 Dec 2021 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mcoM9Ax1uVbLecr06Jv1GjfyazYcAb1+Wc5JbxKbgLk=;
        b=SVHqay68VUOAOHu9uBZo4mdJWTihaz5p+A6gLbEoE3abtu4VilIEkQaAoxGgkqIxCJ
         ebBrahy80p+gKC5PUp8cy/iok91hF8uU90zVfcYCEQZ3SHyk2iV/M7yBuM5xXx1q+dbU
         5HYPfT/e1p1lkh8wzWatch4fvJdJLNPZ+kGX2LpuRhZxZYaKjhQyHOeZu6pgOAkfqBrl
         j46GWZWa2ldkdxunzLARSSBw53v5jsHy5vDrAHM0XddeaZK+IBjhIpCsmR/2RIeprNMa
         B0e0JU6YbzcQ+5TIWgVjqtru1nqdqQcnUt+H+vsOBjU6fZXijMwHlxAtIxg66N9nh3O/
         8+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mcoM9Ax1uVbLecr06Jv1GjfyazYcAb1+Wc5JbxKbgLk=;
        b=6ckwBa6ut1JC+uLyMbIYUE2APx/UnYjfcGeqsPjtVxHv1Isnr+aFfU08OZ4WXFY3Jp
         qkN4bayUVGY0vTVd1ORGGMeVfieYWXG4DSfr5KfePg1dOT0AAWv2kc4xeKRpzR2IWtoH
         H5mcuFpAcKzduwkEiJ7Ios2mcRhf5EpbIgbFpl3J5DauKAc1uY8gFAEaGmnYiksB3Jm2
         forUn7tgwR0oFxp2xZBdYvEtal8bDDHCT7ZzGpFkRp215XiXR4UegkNeNyPFAJ6N6V5e
         MCiNLqgwWwvWt9fPJf84dam3DStOKfnoaiqfU3f1eEBEC+Ta5GP4t7XKFLZzx5A/rnXm
         CzQA==
X-Gm-Message-State: AOAM5321YujbnqPX0/SDCpJJ1V1Hn2Kzz/8Z3peMQxnlFDo/ieepRn9F
        ScmXBdVZwN+csFT/c5IE9yU=
X-Google-Smtp-Source: ABdhPJwfQiIXPLFnM45Qsq1mKLc+gw5v4w90DdqR/S/COVYdQgiDcGeqkBnZ70V6mO6ZWA17wweAIA==
X-Received: by 2002:a2e:a7c4:: with SMTP id x4mr11737287ljp.43.1639595949539;
        Wed, 15 Dec 2021 11:19:09 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id j22sm455282lfu.155.2021.12.15.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:19:08 -0800 (PST)
Subject: Re: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <Ybo6tsnQM6OacoZs@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <26af30a6-9606-72d0-9258-cf9627ddfe77@gmail.com>
Date:   Wed, 15 Dec 2021 22:19:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybo6tsnQM6OacoZs@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 21:57, Mark Brown пишет:
> On Sat, Dec 04, 2021 at 05:37:03PM +0300, Dmitry Osipenko wrote:
> 
>> I based S/PDIF patches on Arnd's Bergmann patch from a separate series [1]
>> that removes obsolete slave_id. This eases merging of the patches by
>> removing the merge conflict. This is a note for Mark Brown.
> 
> That's not in my tree so I'll need either a pull request with the series
> or a resend after the merge window.

This patch is included as a part of this series, please see the patch #6.

I saw that Vinod Koul already merged it into his DMA tree [1] a day ago,
but there is no stable branch there.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

>  It's also not clear what to do
> about the DRM bits, I guess it's probably easiest to just apply them
> along with the ASoC patches.

I already asked Thierry Reding to take a look at this patchset. He will
let to you know how the DRM bits should be handled. Hopefully this
should happen tomorrow.

We will know how to move forward if Vinod and Thierry will reply ASAP.
Otherwise this series will have to wait for the next cycle.

> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
> 

Noted; I see now that it's indeed not clear from the cover letter that I
included Arnd's patch into this patchset, sorry about that. I assumed
that you will notice this after looking through the patches.
