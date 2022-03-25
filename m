Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505E4E7C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiCYToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiCYTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:32 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17621F77C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:14:29 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id bg10so17230337ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UzIVRd1Kc8P6PiaoT+wC6AqMyIQsK4C2hvy4yYySj7s=;
        b=yWz4HbtZZmko1e2nU5LcYjmwMZQ6hNq//hjIeFwoUVsrrErDxLg6MupHeONjJd7Ouf
         glZMHV+5/3Ew/6tCHGNELoQWJFBmO5Xtt3vACn54FexNFIUFr55s2p5Nr0rOEAJU5xjE
         KlEuQcOwzpSzTaNaUHYDgcqYBKikNTKA5n5M+Jtw2BAxuCegTqOOng1aK4fHYZo3S9Bx
         3nd3Vn1ToKFF1t90clFZt22wUQMVJtfJB9FaepcVyVwbwsxcj7VhLYyyeBAFbz9Kik0O
         XfDQhNOC6VJol2CCe+RRLPdcpXiaMVOtF1Oac+XIZKMZGYcDsFOZmz11/BYcMJvrf6sM
         8RNw==
X-Gm-Message-State: AOAM533wAbYlimdgQx/TaNSpa8tjMIPREO/kaDK5OE53TTsAR4ieCAl4
        lMxIPBtYQbMjI2Ce9lj9/DL3xjdQFZzxIA==
X-Google-Smtp-Source: ABdhPJyFhblKMCSgf2oGabK22m+djFjB7qNxt2cuzfQF/9rVgpAfky3yK2v3OEdqIK8IhQmjRovtig==
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id q20-20020a170906771400b006ba8a6ab464mr12991783ejm.613.1648233873730;
        Fri, 25 Mar 2022 11:44:33 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id f6-20020a0564021e8600b00412ae7fda95sm3199030edf.44.2022.03.25.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:44:33 -0700 (PDT)
Message-ID: <6f2a3a99-0727-cf72-d512-332ca5731568@kernel.org>
Date:   Fri, 25 Mar 2022 19:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/3] sound: usb: Exynos usb audio offloading driver
Content-Language: en-US
To:     Oh Eomji <eomji.oh@samsung.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
 <CGME20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703@epcas2p2.samsung.com>
 <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 09:10, Oh Eomji wrote:
> This is for usb audio offloading. usb audio offloading processes usb
> audio stream data directly from the audio box even if ap usb enters
> suspend, there is no problem in stream data transmission. This obtains
> power saving effect while using usb audio device.
> 
> AP usb and audio usb f/w communicate via AUDIO IPC. By performing AUDIO
> IPC in the vendor operations, abox can access and control the xhci to
> transmit the data directly.
> 
> The types of commands and data delivered through AUDIO IPC include the
> following (AP USB <-> AUDIO USB f/w) :
> 1. usb audio connection/disconnection status
> 2. xhci memory information
> 3. full descriptor for usb audio device
> 4. UAC(usb audio class) control command
> 
> Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> ---
>  sound/usb/Kconfig            |   9 +
>  sound/usb/Makefile           |   2 +
>  sound/usb/exynos_usb_audio.c | 560 +++++++++++++++++++++++++++++++++++++++++++
>  sound/usb/exynos_usb_audio.h | 150 ++++++++++++
>  4 files changed, 721 insertions(+)
>  create mode 100644 sound/usb/exynos_usb_audio.c
>  create mode 100644 sound/usb/exynos_usb_audio.h

Similar pattern as XHCI submission - it looks like you do not work on
mainline kernel, but some other, private tree with other modifications.
It seems you created this series based on that private tree.

This is not the proper process.

Please rebase all your work on recent mainline kernel (v5.18-rc1,
linux-next) and work there.

Then you can start using get_maintainers.pl...

BTW, this v2, not v1, so please version it correctly. Add also changelog
to your series in cover letter.

Best regards,
Krzysztof
