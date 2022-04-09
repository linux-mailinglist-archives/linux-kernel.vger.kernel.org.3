Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF14FA949
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiDIPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDIPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:35:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7025AEE1;
        Sat,  9 Apr 2022 08:33:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e71so5507681ybf.8;
        Sat, 09 Apr 2022 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CNNYXuOr2RcG8eSzPuXT83KGiDGSucj1aFS0r5c1ZA=;
        b=dc+l+QFt+ZkI4ADTsbh1RkzZ7R3GKYOGpQPN5INmbHlFKc7ns4gaQ8MzsnTZxHC9VZ
         sbB+msnC5t+3A0if7JaXZ36vTXMRQDtmmNtdcUvAsD1GXSfjPe0XqX40aVc8WaaCdXR3
         FKbS96lEEYq8OvHfAKySYgRQOCU13wtfmO2z3cW4WuEOX/uFIHm22Bbt8NKrZTXdd5zn
         6Krcdg+Zap+0/M3Ee0533KHqgEnbVS/gOg93P/KNY4YLpf8ezcXDX6JTxgibmW/+PIEs
         IjtMFpEt+lHA9MZi3/RZ1SHRC7/jYdMqTmE6qz+mbwfHMbAv4TcYcVYzdKffy/eR2a9W
         nLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CNNYXuOr2RcG8eSzPuXT83KGiDGSucj1aFS0r5c1ZA=;
        b=sYSB9KLe7E34ii2Dd5aJRN93SaQ4oEAuoUvL8Df/6Cjkxpmc4eN7g6vGEqTRExZezH
         R8ws3Ro9ldFZqLlw/ewZgBwPxbXCoSHuZ1Sjq3kp/MYDLx5FwB7RD5tlmLVlBCJNJVqm
         qCsMBYycVoF2TGI6O9WhHtLiiuBR9ioi9ua6VEWHSr0fpp09odBmYyYo1cayO7Ua+BKG
         kuH6N6F0SbkqysePMnAPqPj53nnnFVDHgI63Vksg+i5c42nW53FLDlIGsWH/foCz1pHu
         quNBP86q3YcE2vBSmL2vXGD8QHrgfNezeK7Ge67BkUm5FZStJ7wLYzWxmv3npTLiTP0o
         tSHA==
X-Gm-Message-State: AOAM531T9tBiiq+M4pef5V9glJLl9KQnYyCAZY+qyZ3TsAI/7CpvVL8X
        BFtGfbQabsG9yWHmXYAqwSbvqDXf4WoRb2XAB5NQ9CzJe9Ujrfk1
X-Google-Smtp-Source: ABdhPJz+u2vMB6vK+JAGuD+cHl3/9qosUF8iC3kUhZx4Qftx7dvTPzvltpLQ174kmxzW5MzbnQt7E8oPwm5+FKTFhMA=
X-Received: by 2002:a5b:ac7:0:b0:633:cf3f:6d1b with SMTP id
 a7-20020a5b0ac7000000b00633cf3f6d1bmr17740849ybr.585.1649518390548; Sat, 09
 Apr 2022 08:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220408151237.3165046-1-pgwipeout@gmail.com> <20220408151237.3165046-4-pgwipeout@gmail.com>
 <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
 <CAMdYzYrK2KV1svrHS=zMjGYh=dUis-JKjgYHaeOB4LQWXM1+4A@mail.gmail.com>
 <trinity-7dbd5148-923f-479b-9eed-a75f000456e5-1649489032880@3c-app-gmx-bap35> <trinity-75c90ab6-a336-4f5d-972a-364b7f32c597-1649489861756@3c-app-gmx-bap35>
In-Reply-To: <trinity-75c90ab6-a336-4f5d-972a-364b7f32c597-1649489861756@3c-app-gmx-bap35>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 9 Apr 2022 11:32:59 -0400
Message-ID: <CAMdYzYqHLVnu7nwnGHAFGTEctnZuaRx515usYqeGmGnEpBb8Gg@mail.gmail.com>
Subject: Re: Re: [PATCH v5 3/5] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 3:37 AM Frank Wunderlich <frank-w@public-files.de> wrote:
>
> Got it,
> these Patches require different clock names
>
> ref_clk => ref
> bus_clk => bus_early
>
> after renaming usb works on my board
>
> will send an follow-up patch for this series
>
> regards Frank
>
>
> > Gesendet: Samstag, 09. April 2022 um 09:23 Uhr
> > Von: "Frank Wunderlich" <frank-w@public-files.de>
> >
> > at least i nailed it down to these 2 commits in drivers/usb/dwc3/core.c, without them it works
> >
> > 5114c3ee2487 2022-01-27 usb: dwc3: Calculate REFCLKPER based on reference clock
> > 33fb697ec7e5 2022-01-27 usb: dwc3: Get clocks individually
>

I've submitted a fix for the dwc3 issue.
https://patchwork.kernel.org/project/linux-rockchip/patch/20220409152116.3834354-1-pgwipeout@gmail.com/
The offending commit was: 33fb697ec7e5 ("usb: dwc3: Get clocks individually").
It breaks backwards compatibility with rk3328, which follows the
rockchip,dwc3.yaml dt-binding, and thus this series as well.

This fix is standalone and necessary no matter which route we decide
to go with this series (and the rk3328/rk3399 support as well).
With this patch, dwc3 is functional on the rk356x as the series was
submitted, so if we decide to fix everything all at once, that is a
viable option.

For those not following the other conversation, here is the TLDR:
- rockchip,dwc3.yaml has different clock names than snps,dwc3.yaml
- rk3328 and rk356x attach directly to the dwc3 core driver
- rk3399 uses the dwc3-simple driver, which still uses the clk_bulk api.
- commit 33fb697ec7e5 changed to individual clocks, which follow
snps,dwc3.yaml naming
- to correct this beyond my fix patch, we would need to align
rockchip,dwc3.yaml with snps,dwc3.yaml, which means rk3328, rk3399,
and rk356x will move to the snps clock naming scheme.

I think we need Rob Herring to weigh in here, as this is a rather
uncomfortable dt-binding issue.
