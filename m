Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073AA59ADAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbiHTLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345327AbiHTLwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:52:11 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5889E136;
        Sat, 20 Aug 2022 04:52:10 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3375488624aso153371847b3.3;
        Sat, 20 Aug 2022 04:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RZrX4TsmyKYIZeKVsYzl/dXGPxXgZPHqV4cddoyqRO0=;
        b=pwc04a5FVqjPOLPl6SiZ7b0z2LWHxvoDi5OpuXrWCagG1YT73sp3r/RouZyF4X3jNV
         n9mn2lKxeeurTdRDNynO9yCLvfJYG8A4O3NihZrFhbGGr2BClfDtbsiGAUSn2NX/QdU6
         Yu2YtVPpIQAGK72cmLijMMIaqAqJ9i7F862cDodYbTqiDed+DBJUBJYVt1VTEgWxItx9
         ke79XlS+dUb6SB0+E2kLSdvwDWuXzEqZY39znPu9DIapCi0s/0Yf+RAdfWwHZmWFWtrH
         c9yAj798LwHm403uXkkGmSGCs6Xk1KHr4fHK53l9XR96k2pKULsowcFedKVHbRA3ue6w
         ofCw==
X-Gm-Message-State: ACgBeo1eCJLhAgehHLIam8dM1lqeZJFr8x+sfosjJXcoawbSWQioe0tf
        sr3GHHddgbF9ChdwEMeQOanSzrpfkNyL3TSkRfE664Wr
X-Google-Smtp-Source: AA6agR7nqoBR/gw5q60Ast2lmIvmYz0AuT2Uxm2lMmepCX1F8NqJDPp5jnO5ykO3U6vwPYLsHFg9cnvO/VSQS1+7TLU=
X-Received: by 2002:a25:cbcf:0:b0:695:2d3b:366 with SMTP id
 b198-20020a25cbcf000000b006952d3b0366mr6051546ybg.365.1660996329583; Sat, 20
 Aug 2022 04:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <dbd20ef2-f109-0675-6fbe-8d08da5cc5a3@linaro.org>
In-Reply-To: <dbd20ef2-f109-0675-6fbe-8d08da5cc5a3@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Aug 2022 13:51:58 +0200
Message-ID: <CAJZ5v0jPm5+zu9ju=RAit01LC6Nc=wRK6T3y8HY-9rgKeXJ5nw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal fixes for v6.0-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 1:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
>
>    Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.0-rc2
>
> for you to fetch changes up to 8c596324232d22e19f8df59ba03410b9b5b0f3d7:
>
>    dt-bindings: thermal: Fix missing required property (2022-08-15
> 20:38:40 +0200)
>
> ----------------------------------------------------------------
> - Fix missing required property for thermal zone description (Daniel
>    Lezcano)
>
> - Add missing export symbol for
>    thermal_zone_device_register_with_trips() (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Daniel Lezcano (2):
>        thermal/core: Add missing EXPORT_SYMBOL_GPL
>        dt-bindings: thermal: Fix missing required property
>
>   Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
>   drivers/thermal/thermal_core.c                               | 1 +
>   2 files changed, 2 insertions(+)
>
>
> --

Pulled, thanks!

I will be pushing this for -rc3, though.
