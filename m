Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74A4F6F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiDGAUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDGAUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:20:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63B235752;
        Wed,  6 Apr 2022 17:18:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id x131so6858619ybe.11;
        Wed, 06 Apr 2022 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtOF1nVWWzBfSRUWOWe7k3Yt8TMXFfwKhuj0f8PfubU=;
        b=EO5VUUX/W80B+fBVBJsYEDOCsFaQiNMDW5beaVeF9HSLky0j1AS9GTxVJheOdMOmc1
         e/YsuilJIpJgpKvlE3bhGyG/BoK3T1QmAUvesn40GV6dArXl0Ji+HMvymm+6OZF1QIui
         4gKNuBn1B3ag4M2qJFi5LWntGs+gRmnFOdTOVqppF6ynv0O6+lh/BYwJzRyXjF3JZYQ4
         GHmF676qHtNSB14Ee/jsNZc2nzC3Xukq0DGB5s8mOlBxgAS7nkBQVnOl+hNTSrSSBYHS
         1/IVCQtj1+d5ryZJqWVHkr/zGCESn9s62AF2hVf6Gn/nNkNzi6A4zreq7lwRYLYzbxlS
         ZkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtOF1nVWWzBfSRUWOWe7k3Yt8TMXFfwKhuj0f8PfubU=;
        b=eMAbJo2OOQqfuYXSZC86JCD1UkfLcPt2UiyGNpFuvN0gKJdDy35mCeLQdpNtpMf5yN
         C7vIa4UMiHyQInoBgw7g3POEGNmVIozbm/+1JYjyxyzEuOhhbNqOm3VNPbFxqrwA4PCH
         CuyvMv+GKRxJyqA4hlF/xMVsF3t5JzsqqbAcIbgw19SsEVSP7bJLgI+skyIMqNRUIsfB
         22RaNAPUBq/eQTZ3y89VH80/T5yfiR+kSQo3fLOig7/eqQg7uWRownBbHVMblWbdGQzl
         Dpme/qP2z0A0CKmyb+dg+cZeZU7eWZMZ4JA/NnUTvHpsQ+jhLS4v+u1mVy3PWRDz5mal
         +DVg==
X-Gm-Message-State: AOAM530gC8KuqYk27GBfkqOdO63VXri3KO6vIus1gFVUmb/MeSSOim2W
        AXm4eP2EgrRMB26U/S/2tqhH6gYlkOCp1aX6UKc=
X-Google-Smtp-Source: ABdhPJwGTD192XDItbqnehwipWiszl88YKBj1/cCr8hW4ZcNNOR8Sh6kCNkZIWb8KmZt+rOlkcFI2tjFSvu2qaUleTw=
X-Received: by 2002:a25:fc27:0:b0:634:65f8:a757 with SMTP id
 v39-20020a25fc27000000b0063465f8a757mr8121122ybd.228.1649290717522; Wed, 06
 Apr 2022 17:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
 <CAMdYzYo9Y_pEAAtreQU0B9DVzGsbUgpTA2g7HGRyUXcSBjMy4g@mail.gmail.com> <CA+ASDXP46bVqZAyzgUQkZAqqVf6Yc5Zg9CZ_1k0XCYUSYq_QLg@mail.gmail.com>
In-Reply-To: <CA+ASDXP46bVqZAyzgUQkZAqqVf6Yc5Zg9CZ_1k0XCYUSYq_QLg@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 6 Apr 2022 20:18:26 -0400
Message-ID: <CAMdYzYqvjin-S0mKFZJ5pwe4yNhG9ZH77-VMNpnL3W2HSQ6gNQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] arm64: dts: rockchip: Enable dmc and dfi nodes
 on gru
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lin Huang <hl@rock-chips.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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

On Tue, Apr 5, 2022 at 10:05 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hello again Peter,
>
> On Fri, Mar 4, 2022 at 6:47 AM Peter Geis <pgwipeout@gmail.com> wrote:
> > Transitions anywhere from the default 800mhz cause a lock.
> >
> > I'm digging deeper, but I'm hoping you can answer some questions in
> > the meantime:
> > 1. Does this require something from firmware that isn't available on
> > Mainline ATF? (AKA special firmware to the Chromebook line)
> > 2. If not, do you have any recommendations off the top of your head?
>
> I may have a better answer for you now. In the intervening time
> period, I've discovered a potentially-relevant bug, involving
> interactions between the kernel power-domain driver and ATF. See this
> series for my current fixes:
>
> https://lore.kernel.org/linux-rockchip/20220406014842.2771799-1-briannorris@chromium.org/
> [RFC PATCH 0/2] rockchip / devfreq: Coordinate DRAM controller
> resources between ATF and kernel
>
> If that happens to help you (it may help, for instance, if your system
> was toggling NPLL off/on like mine was; it also may help if you're
> hitting a race on PMU_BUS_IDLE_REQ like noticed in patch 1), I'd love
> your feedback there.
>
> It's still possible your problems are completely unrelated though.

Thank you, that is certainly possible to be the problem here as well.
I won't have time to test them till this weekend, but you can count on
my feedback as soon as I get the time to do so.

>
> Regards,
> Brian
