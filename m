Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D65778B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiGQXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:02:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260312618;
        Sun, 17 Jul 2022 16:02:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p9so10196109pjd.3;
        Sun, 17 Jul 2022 16:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9duI1rSpswAXnRq3urEW1hM9QxHEE1skc8fMorpNRtM=;
        b=Bx419kWJ5uk7pbzZCokXEhQ7DRPh7mtVCaztg7LXosqvEYYqxHD/NfuIYwQfJpz/4i
         lqPECExSYKWZ9/9zx0mxoHwPZv2d4MtmTZTJEd42aqZQ0fkkWHVogmEXWAjN2sqIvGUk
         A8b9mCQcU5RUfk+Ln51//K+Sz2mthahh1rAdzDKJVrwYnKGqoNgHuDVmPP/yb50zYnm0
         GvNLc7XqQkhi0xZaS0+OWmAb6NPRasw5DSnyUcVsYFiv3RQ/qklRt5gDTPIDM0dkPa7h
         kMHKBIC0F+AozCbKsaGvdsOGOjbbnfqskEYMG1qjgoExvS/sES1Vu+qEajndEYcOq4Ox
         UXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9duI1rSpswAXnRq3urEW1hM9QxHEE1skc8fMorpNRtM=;
        b=YhUXjkOMGh97xVG5nN+05q310g220CgXvaDMvBNRWDNHK3MOJqoMxV6iRXZNxgkwzH
         gV+4RsKl6cTAYGe2ngRT5poZjM/fPFw8GjaXKHQOYgU5PRE/wFgVujwG2BuD7A0O3JGY
         Q6p9okAqUJeP2uq0ZDhUDlXQXCknzmGV0Cts4w5wg2PMDoHMQoXaYx3Xa9zY1CpZQwaf
         svBgUsQREP0cN+2DCtPIySBYFesYLdhtxYmbD7AAWkRWRfBmjjxz+dPTehCdHaOjwSGG
         A1cmZpNnbsTggA7suLrBg7GPKJbUJjj7lADihJxyiDjK/Ems0HkOSbkgMEpnMavYbhIU
         lXeQ==
X-Gm-Message-State: AJIora9cbfXBhQHl/8nJQFXP+m8dClbnvadbnf9tMVaz7aQjY2lfD9/s
        kWGqEVXmsq9UsVAfvPI1Pdo=
X-Google-Smtp-Source: AGRyM1s2OwobGDzORrPZHucygkybI/3hmpBr8Ni1Lah7murhJ3EfiGFcUanLyWGjdHC/P7DK+DlDgA==
X-Received: by 2002:a17:90b:3502:b0:1f0:986:e36b with SMTP id ls2-20020a17090b350200b001f00986e36bmr35970479pjb.154.1658098962056;
        Sun, 17 Jul 2022 16:02:42 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:6c17:ca15:3733:a6a1? ([2001:df0:0:200c:6c17:ca15:3733:a6a1])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b0016be96e07d1sm7766371plk.121.2022.07.17.16.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 16:02:41 -0700 (PDT)
Message-ID: <77ecffbd-7568-f653-5273-1f3dffb17891@gmail.com>
Date:   Mon, 18 Jul 2022 11:02:36 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 00/10] video: fbdev: atari: Miscellaneous fixes and
 cleanups
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657554353.git.geert@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 12/07/22 03:50, Geert Uytterhoeven wrote:
> 	Hi all,
>
> This patch series contains miscellaneous fixes and cleanups for the
> Atari frame buffer device driver, which were identified while working on
> the Atari DRM driver.
>
> Most of them have been tested on ARAnyM, and should be sa<fe to apply,
> except perhaps for the last one, which is marked RFC.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (10):
>    video: fbdev: atari: Simplify atafb_pan_display()
>    video: fbdev: atari: Remove bogus FB_VMODE_YWRAP flags
>    video: fbdev: atari: Fix inverse handling
>    video: fbdev: atari: Fix ext_setcolreg()
>    video: fbdev: atari: Remove unneeded casts from void *
>    video: fbdev: atari: Remove unneeded casts to void *
>    video: fbdev: atari: Fix TT High video mode vertical refresh
>    video: fbdev: atari: Fix VGA modes
>    video: fbdev: atari: Remove unused definitions and variables
>    [RFC] video: fbdev: atari: Remove backward bug-compatibility
>
>   Documentation/m68k/kernel-options.rst |   4 +-
>   drivers/video/fbdev/atafb.c           | 101 +++++++-------------------
>   2 files changed, 29 insertions(+), 76 deletions(-)
>
Works OK on my Falcon (except for the falh* modes, but that is not a 
regression - might be something I miscoded in these modes, ages ago).

Tested-by: Michael Schmitz <schmitzmic@gmail.com>


