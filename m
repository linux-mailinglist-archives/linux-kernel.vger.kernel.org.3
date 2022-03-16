Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A254DB702
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbiCPRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiCPRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:22:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D95AA4F;
        Wed, 16 Mar 2022 10:20:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d19so4571637pfv.7;
        Wed, 16 Mar 2022 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q00tc0Jq4/avpRUI+W2YPMMtTK5TxCyKgnoT7tOZx6M=;
        b=e3LyYK82GkTpOeDruWPgkDxnEuqS1LiSMVXM8iPurdU3UDUky44tyOA8xekTWGWUgB
         nwWOg6kMAef5BImr4ZL7zQvOhnxJ2LrUubuqN9N917PPft8w+wYPhbDjA5I5okjIUDEy
         XAJ6OTKi5D2ge+4ua7vcIBPHW98xQdlu1t2yDQ5Tx9QDXfS6pl9VhuBPng/vuH8lHL2X
         /ush1kElO/+J4rNEn7tdZzgkmlRPbR8ugw6CRk9IwfPUv70QIiqKibKzZkTcxMlu3G7d
         dHmN+FzvGosRkA+LYxJJCwpfQZlB/1gGNaQQnkK/osWmUxwFg641SX6I+iUe69PcYOl/
         958A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q00tc0Jq4/avpRUI+W2YPMMtTK5TxCyKgnoT7tOZx6M=;
        b=JRHJeN+eaAaxiXg7P9DKAVXnq1iPU2579f/ZKPfqPDdgAmC9llq3XcWo1t/BJTspeI
         dSjSIUToEky319GJbyNMaWsKMC2dWJRD+3nzcIWXoRCk+9RwglM9L05wpMDj5xsDGGMK
         H1u4TM4L5LiXvuwjsMVJAm61R3ZbBItRxYPDjuaX6sQZiSqKeYcDBiXbkycM7fBNVZ2d
         ulse9+SFOhq0bnYeHj07puB6Y0w10OQeEqEilVQr2P02mQsFXgPf2MDX3EBGIhCKiF1s
         KMcsbqFa6MylC+EtpPJRbWDGgk8Da/pvq7wcH8rsgrvNlZZpxbjebDJAY6gMxjqCQE5p
         K/Rg==
X-Gm-Message-State: AOAM5307X8Mpu/BWozfJQVEX6J94sfzXb0CAFgmWbUKSzOkjqdjz9jP6
        0EOCWTLuT/mb7zPn17q2i1k=
X-Google-Smtp-Source: ABdhPJy+kQ+thgGrruOCz+9zl5Y+etvUgthRquFgSlpQ/CVeoZ4H5Q0DrEgjVc6QPbIn7YTiGE/s6w==
X-Received: by 2002:a65:5583:0:b0:380:d91a:8270 with SMTP id j3-20020a655583000000b00380d91a8270mr503520pgs.620.1647451256799;
        Wed, 16 Mar 2022 10:20:56 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00231200b004f72b290994sm3093703pfh.180.2022.03.16.10.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 10:20:56 -0700 (PDT)
Date:   Wed, 16 Mar 2022 22:50:51 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix dtbs warnings for arch timer
Message-ID: <20220316172051.GA21737@9a2d8922b8f1>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <5521012e957efa3c4afe2de996a1b5ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5521012e957efa3c4afe2de996a1b5ac@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:27:10AM +0000, Marc Zyngier wrote:
> On 2022-03-16 09:54, Kuldeep Singh wrote:
> > This patchset is an attempt to resolve 'make dtbs_check' warning for
> > arch timer.
> > 
> > Patch 1 is done in preparation for following patches which defines
> > compatibles order in more clear way.
> > Patch 2 documents arm,cortex-a7-timer entry in bindings similar to an
> > existing entry arm,cortex-a15-timer.
> > Patch 3 adds above 2 properties in of_match list to bring them in
> > use.
> > 
> > Please note, this patchset is based on
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, master
> > 
> > Kuldeep Singh (3):
> >   dt-bindings: timer: Rearrange compatible entries of arch timer
> >   dt-bindings: timer: Document arm,cortex-a7-timer for arch timer
> >   clocksource: arch_timer: Add arm,cortex-a7/15-timer in of_match list
> > 
> >  .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++--------
> >  drivers/clocksource/arm_arch_timer.c                |  2 ++
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> Please use my @kernel.org address exclusively. My @arm.com
> address stopped working over two years ago, and the MAINTAINERS
> file shows the right addresses.

Hi Marc,

I have tocmd and cccmd set in my gitconfig and it generated mail
addresses automatically so I assume it is correct.
tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol"

It seems your arm mail address got configured from binding file and not
from MAINTAINERS.

Regards
Kuldeep

> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
