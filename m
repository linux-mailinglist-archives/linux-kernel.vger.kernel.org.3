Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8A532042
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiEXB21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiEXB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:28:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFE16FA11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:28:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so14570228plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRdkO9LWoK6gu3O6tCs/6pS6ffPvexve2L+r8+1P1Mc=;
        b=MR+QpekimCNHYVTg/y19FR/jbueG7WKak0RbDHffuGp91Uu9dUwWWsmwhZ1meXGDtH
         u96NPpxkfqqQl5rlTbk9qVerNPjsyG9j0sJWbLBUm0UrNi5iSS27bDVBJBtRnksauOTm
         K2hHqUZxln7S7HaaFH4vuNV38c4PL0lmy598DMZ3PA42tZNTn+ohVcPS2Wng03+EtV5A
         5AEEnVEKtMSacNFdvAkti8NswhlkJtJwDSv+0ASp9KafpHpHfZh0MHqzubbWuvwAkcNq
         tIy3FFCadANe4AiIpFQ4pjtAU5GV6U/NKOFLxtoe2VAXi14HvlCoKysEDynD/GE/ei3h
         r8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRdkO9LWoK6gu3O6tCs/6pS6ffPvexve2L+r8+1P1Mc=;
        b=rCMtuoOrFoePS2GjOjF1ppxJEMBOF6qQFKGVF+HewDT6TLPzVSJJ6euIYB5DIYHMLQ
         Ek0sR6bvnIokyBe3ehQDlzZb8J1vSDkW5c6RiWkFOQDA4dvFAjGbMu6/tzBh1bcKMOtL
         EdrTrKpDhZxIrRIVoIUMdUX7rTqXOHbC3r7/pmBNgg0Z8Ab/CWN07/VJhWmr9p1uJnto
         Nmi4O7G5LYyHmbN2cu5nDqhi8bYPd/sRW3JGyNCmVwfAXL6uNuUxd2hFdmmPmIeSgU1D
         Dr97TQ/4RkzQZ7oXWjozjFzW6wXM/PLSgmMafRV93fn6WGS+iDhB1fa0WB9tKJYbS0eq
         p9ww==
X-Gm-Message-State: AOAM533vRMVBoor1kgk9gudMVS1qYr8WR6YM0PmHb+bMEB7vbfWFSbsf
        uo2N+ctF5vzoe9DsfHftCQwxRTXNLxI+OpeyAomRlg==
X-Google-Smtp-Source: ABdhPJwD5caICs9kSETeFxAO9el0xMpeE855aAndFiUT36QQ7C+udGQBDWOTuISOgzhnsjSfpzdkzCz5zj3ruW6lPKo=
X-Received: by 2002:a17:903:40d2:b0:161:a2d9:3230 with SMTP id
 t18-20020a17090340d200b00161a2d93230mr25125435pld.57.1653355701583; Mon, 23
 May 2022 18:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220523090822.3035189-1-tzungbi@kernel.org> <165335341249.17704.13803710194044994542.git-patchwork-notify@kernel.org>
In-Reply-To: <165335341249.17704.13803710194044994542.git-patchwork-notify@kernel.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 24 May 2022 09:28:10 +0800
Message-ID: <CA+Px+wU_pbmWOmB9wSOOWCHqsBAGVHy3w6ya_6fj4d0+VtTmBA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] platform/chrome: cros_kbd_led_backlight: add EC
 PWM backend
To:     patchwork-bot+chrome-platform@kernel.org
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 8:50 AM
<patchwork-bot+chrome-platform@kernel.org> wrote:
>
> Hello:
>
> This series was applied to chrome-platform/linux.git (for-kernelci)
> by Tzung-Bi Shih <tzungbi@kernel.org>:
>
> On Mon, 23 May 2022 17:08:17 +0800 you wrote:
> > The series adds EC PWM as an backend option for ChromeOS keyboard LED
> > backlight.
> >
> > The 1st patch reorder the headers alphabetically.
> >
> > The 2nd patch separates the ACPI backend.
> >
> > [...]
>
> Here is the summary with links:
>   - [v4,1/5] platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
>     https://git.kernel.org/chrome-platform/c/a4da30150ab4
>   - [v4,2/5] platform/chrome: cros_kbd_led_backlight: separate ACPI backend
>     (no matching commit)
>   - [v4,3/5] dt-bindings: add google,cros-kbd-led-backlight
>     (no matching commit)
>   - [v4,4/5] platform/chrome: cros_kbd_led_backlight: support OF match
>     (no matching commit)
>   - [v4,5/5] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
>     (no matching commit)

No.  They haven't all got R-b tags and one of the commits was pushed
mistakenly.  I have updated the for-kernelci branch again to fix it
up.
