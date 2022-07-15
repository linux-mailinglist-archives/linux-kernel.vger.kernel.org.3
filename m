Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7A575AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGOEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGOEuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:50:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C13785AF;
        Thu, 14 Jul 2022 21:50:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so3674428pff.12;
        Thu, 14 Jul 2022 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kRLhZzbGYGaRDYFSzzNmS4CySIoJIiXGprjd8sj9K/0=;
        b=V+hoi62i9rmotV7C9un25P6iuXZO0dEMik9ZBz3EVv9NVFcXJN95QkPmfBncsjI/Ao
         FCxOTAqa8wvTsmNa1AOwYKeX3C3rL7cY5bTQBsQJUlcVD/Pkzfv/BmgwYTtEqzlYEqvK
         CY5SN2DJ0kyd6PoEAxwAOH5Zq2JwJEObsYuI7yoR08OxaaYfAYOE0lTxfzI5VYFrLJAh
         Ags94LXbQBlnBepEDdYxl8tpSLRTpMcG4ZTbO43dOwIoD56IHTdEMnPGbVG32oDhp5oZ
         a27iAGk2eDZeSJGEI7gP30qOS/i2Hti3D6xeHqSZ6Na1K9JIY/GvwP3QFrzHEgqACVQj
         ZSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kRLhZzbGYGaRDYFSzzNmS4CySIoJIiXGprjd8sj9K/0=;
        b=oL1us/M3kjElaTWFVbmBQDXaypBEIbX2OJDRC7/Z4aLjSUIPOzbTbtNElmNrBPPnzv
         OVpbQWYWztjzEFesGFYU6vEWP4bGfuXkoUJWC1cviJCv80L/wcVn0QEe5iNkTilJePPu
         +njIogTjgnu0lyktujf3AW2Cq4y1K617grdF2FbsNNIAyyUIH7KnWQZRno1Z4inX5rct
         Mo5gOfuPb0b77E87XIzny2xCw30gytf+ATF0ohdTG84R58Gpo+CmEWtweD8Lmy/PQE9F
         PAnrO5Y0AO0B9D1CPSCLoSXUzpW6SDd12g0BtGM81xDgWL5J2Xni2Q/WgBOTQzUgm4T6
         Ml6A==
X-Gm-Message-State: AJIora+0FyUUDrbcF50GbHLwSSmiDMEB2l+WywqEApU0ShzA64kg0X0Y
        UdHvSt89DAvtsLnaThSlE2/af6sC4Ns=
X-Google-Smtp-Source: AGRyM1u/RDFN0eyZrhqFr7v6lAykVv06aI/n1+Es6yulIiuzxUGnR3jVZSsEy1EL8D33z18/mQCqtA==
X-Received: by 2002:a05:6a00:8c5:b0:510:6eae:6fa1 with SMTP id s5-20020a056a0008c500b005106eae6fa1mr12333545pfu.12.1657860629806;
        Thu, 14 Jul 2022 21:50:29 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c2d200b0015e8d4eb1dbsm2389411pla.37.2022.07.14.21.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 21:50:28 -0700 (PDT)
Subject: Re: [PATCH 00/10] video: fbdev: atari: Miscellaneous fixes and
 cleanups
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
References: <cover.1657554353.git.geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d9af62bf-09f2-cfca-eeda-92dcb539b56e@gmail.com>
Date:   Fri, 15 Jul 2022 16:50:21 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

somehow this series slipped into my spam folder ... only saw it now.

Am 12.07.2022 um 03:50 schrieb Geert Uytterhoeven:
> 	Hi all,
>
> This patch series contains miscellaneous fixes and cleanups for the
> Atari frame buffer device driver, which were identified while working on
> the Atari DRM driver.
>
> Most of them have been tested on ARAnyM, and should be safe to apply,
> except perhaps for the last one, which is marked RFC.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (10):
>   video: fbdev: atari: Simplify atafb_pan_display()
>   video: fbdev: atari: Remove bogus FB_VMODE_YWRAP flags
>   video: fbdev: atari: Fix inverse handling
>   video: fbdev: atari: Fix ext_setcolreg()
>   video: fbdev: atari: Remove unneeded casts from void *
>   video: fbdev: atari: Remove unneeded casts to void *
>   video: fbdev: atari: Fix TT High video mode vertical refresh
>   video: fbdev: atari: Fix VGA modes
>   video: fbdev: atari: Remove unused definitions and variables
>   [RFC] video: fbdev: atari: Remove backward bug-compatibility
>
>  Documentation/m68k/kernel-options.rst |   4 +-
>  drivers/video/fbdev/atafb.c           | 101 +++++++-------------------
>  2 files changed, 29 insertions(+), 76 deletions(-)
>

Looks good to me. (I'll still try to test it on hardware this weekend.)

I'd suggest the last one be applied as well - if the regression can only 
be triggered by a X server resolution switch, I doubt it'll matter in 
practice.

Cheers,

	Michael
