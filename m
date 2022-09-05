Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AB5AD944
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiIESv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIESvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:51:25 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573B275E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:51:24 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id k2so9568009vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=waVF2Zkls6p4dtc9CzOd8vWQdb3uv6Dg4aQ5i0JwEm8=;
        b=hDhsA6yF/4ikzlN3N0CsnwqUatKpLfnFtlo+o9Jy9dV7LBBiJXxwUNwDxmlYCdxwDy
         ZmkfEusO6Le69y7wgMsPThSUjNIv8cvcRj4+j5MhNGvhdqzwG8Ppl8NkPuc6G4d2yyfG
         ro3Xfc/UUFUo3O4h/xNF/qY2a5CQoXEGejzHJH0J+1sTxEUdYgwKGq0IaBtPaMU56ZJL
         3dyilnZy+Z1C1SfBL1PI7vBzbqMD+tQ535W+/CUT+vPlhtMmloOmczVBHkHKVpu5TDqX
         06DyKjwTD+IQawG83CzEWeqi1SwtmSBDJ3NFLvZBuONEPb998kXqF8xmmoI4KAWn9vpb
         zfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=waVF2Zkls6p4dtc9CzOd8vWQdb3uv6Dg4aQ5i0JwEm8=;
        b=Eylx6674PnfQ5AkOtYYLHtZRYeHA/tqLz+j/DwO4jg45qS8PH0FvcuaKhngk4EiLTS
         j1Wc1xBDycHf+r8IanAYqnpGBak1Mb5zBm6ASdiaygWJ6JY3htHZ+jhJOu6jvH1tSn20
         6KLOHbI4m5glXAHLj6cVeriEwI6XMtRSJ4azRtnYpig2TOcSkwrfUg9lfcKYJn46wihz
         7QAF+yGKWMfYQmP34C4RolLTruxC9JzPHUJ+7LmPDD4/U70YHkAHerjFxqa1jvsYUsN3
         Nl4wA9l7IjlzZMywaG5oGBxw2y0Id1oLYLy4i4yD1hUcGrFh/QlQeHEnoTTw/TmumanH
         pfXA==
X-Gm-Message-State: ACgBeo1GzRr7lSMvEeT1GZA/Q3BzyG2xLUZJtuB/gZqzJg9a0DNb4POB
        jeW29IS8GEDVaD5YY6eWCQdH8Sa+li7kjHoBk2hXtHr0ieoy/g==
X-Google-Smtp-Source: AA6agR7dtLL5IIGG1Q/HwqLtUVy0aW5huRLuhdjh+9IVyEmSMEPezwo1YJVez4ACu0dW/RjFjIMqh2TltCZbYsFY6g8=
X-Received: by 2002:a05:6102:5094:b0:388:6903:5f09 with SMTP id
 bl20-20020a056102509400b0038869035f09mr13679997vsb.46.1662403883854; Mon, 05
 Sep 2022 11:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220725091740.28188-2-alexander.sverdlin@nokia.com> <20220830030259.3503212-1-yuzhao@google.com>
In-Reply-To: <20220830030259.3503212-1-yuzhao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 5 Sep 2022 12:50:47 -0600
Message-ID: <CAOUHufY76AfTbz0wKixae=m0Zdh5P3fW2cosOvYKrJ-x0XpzJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
To:     alexander.sverdlin@nokia.com
Cc:     cminyard@mvista.com, joe@perches.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, tsbogend@alpha.franken.de
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

Hi Alexander,

On Mon, Aug 29, 2022 at 9:03 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Hi,
>
> This commit produces a bogus error message on systems that use the
> default value. Please take a look.
>
> Thanks.
>
>   Linux version 6.0.0-rc1 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
>   Failed to allocate CAVIUM_RESERVE32 memory area  <<<===
>   Skipping L2 locking due to reduced L2 cache size
>   CVMSEG size: 0 cache lines (0 bytes)
>   printk: bootconsole [early0] enabled
>   CPU0 revision is: 000d9301 (Cavium Octeon II)

Following up on this. Please take a look. Thanks.
