Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170554EFA52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbiDATPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbiDATPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:15:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2465DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:14:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v12so5175277ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTRBtZGT8BtVw5zsFhiWCluDgulKA3oSoE7nkZmGGeQ=;
        b=bWkcNX1SCGfk89/b1oIPtwcBZ95PoBCpab48p/a44RYoYskq8HlTYvf/+WBMZsyeHm
         v8Mmtb+JqFjqDNT/GIrEsfL6Yu6p/h7LQ6uss7CLSBzDlqgFiVwo1DDmEw09dH0hGNg+
         NNljgzDmgpfwBld1PX8Mig99uGEfvh7v13cgPH6isWQQW3u3/LUCbaIR0JM7aPXWrapn
         1wOmaZqF7zhpcXZYk1TEokfsNnkvA9xMzF3wpURXmxXEGWpOcHeqwNX6m43S0hfKmfAK
         JhcqpImnfitPKpSZxnSr87vwHCVtiMAw7xaGoFN73W4MTNmKUK5QoeYOkuMw7hne/kyA
         BHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTRBtZGT8BtVw5zsFhiWCluDgulKA3oSoE7nkZmGGeQ=;
        b=LWr1WPUCPiab0mrAM6zOtZGB4HesaXugGtfP/rrUmcxTXAvfeDoRLUzp8eNcd36cf2
         tZkE7XEp9k88dNIc7cQHBYfuHKCX3T36fS+1GyT0K16jcCvnihRlWpdmGkGRaGZRk3WT
         3webk92ElYN8FqRfx3qadcgh+/1AMnSbyD/9cD4g/rqebLmMfiCdexkvbDyECwDgkDGe
         GJax+KpqJSGWobYZ3hpuRDOwKLNYrUf74/8U4SloM/cCialH5iOxqtjI8pFl4QxoDVJQ
         q16ha02AWAlNR0Yh6Ihb5ZmLYziVyzZj5cZYDhyiUvXG+S9wXZkXjeHOAyDxzTMRJsPF
         uMnA==
X-Gm-Message-State: AOAM530sWlAaIyUeBIcY9CU7eJG8eugSeIi9KHO6f51B3+i05Vs+yzFF
        sq98weMQmiLSa+Wukf11/CRG2nKRuJb+f5vAHNRp/+N6liM=
X-Google-Smtp-Source: ABdhPJw/1BErJf2YsIXa1Kl5uY4Bob/skl1WnEf3+Pb+Ap2phub/DgN1mXZqGV+3lFO1vfsRceu9D4X0N32XfymeAWU=
X-Received: by 2002:a05:651c:1507:b0:249:83b4:9a27 with SMTP id
 e7-20020a05651c150700b0024983b49a27mr14819100ljf.24.1648840438681; Fri, 01
 Apr 2022 12:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648839305.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1648839305.git.sevinj.aghayeva@gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Fri, 1 Apr 2022 15:13:47 -0400
Message-ID: <CAMWRUK4W6rRe=6dfZg4PsvD6nAxNSqtc0Q=6M3Ho=0JAs2hKWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rlt8723bs cleanup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
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

Oops, apologies for the noise!

I tried to send v2 of the patchset but I had older versions of the
patches in /tmp and since I specified /tmp/*.patch to git send-email
per tutorial, it ended up sending all of the files there. I will send
a v3 ASAP and update the tutorial to prevent others from repeating the
same mistake!

On Fri, Apr 1, 2022 at 3:07 PM Sevinj Aghayeva
<sevinj.aghayeva@gmail.com> wrote:
>
> These patches fix three categories of checkpatch warnings (redundant
> braces, redundant else branches after return/break, and constant
> placements on tests) in file rtw_mlme_ext.c, which is part of the
> rtl8723bs driver. False positives, such as
>
> if (foo) {
>         /* TODO: ... */
> }
>
> were not altered.
>
> ---
> v1 -> v2: Removing a redundant else branch left a variable declaration
> mixed with code, which was caught by the kernel test bot. Move the
> declaration to the beginning of a function.
> ---
>
> Sevinj Aghayeva (3):
>   staging: rtl8723bs: remove redundant braces in if statements
>   staging: rtl8723bs: place constants on the right side of tests
>   staging: rtl8723bs: remove redundant else branches
>
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 167 ++++++++----------
>  1 file changed, 70 insertions(+), 97 deletions(-)
>
> --
> 2.25.1
>


-- 

Sevinj.Aghayeva
