Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E439E558ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiFWV3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFWV3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:29:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE6527FC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:33 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31780ad7535so6892527b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlRmZ+LNINHQ0A4AK2ESdVrqQY5sFyzwJMR41lo+PS0=;
        b=D46X38KI4V4bLqQrvhwC0HZidzVCUrkJgWhfTTDo1V77zEnLjnevErQGc+xq7+WCN5
         i14fZrnQu7NWwiaPNsaakoiZKW8FZZ6tv3tY7gQ2KBQvbOzCox68WdIC24LuhE8949n0
         5Hbu5qqqFij/aAyKngVquo2EZp+l9Q47Szw2P1ogPhiCuQf+SjbG1C/He99wX/gqXC8j
         m0+NXYF32++mQ/+0uai9Xggk7srpmvninUIdtQP6QAzVVDxOhpWhQAZmTaVwQsSgLpfM
         TQZn2z0YRpD9PW0alZNqA+yHryTqziO2Hh4PvxFnt8ji1dFvdj7imFd45X9spaMu6uqg
         2lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlRmZ+LNINHQ0A4AK2ESdVrqQY5sFyzwJMR41lo+PS0=;
        b=cGW6j7qll0tph/oV3spZc32cSNpR61yGCswEgeiOQzS3zw5xW0IelJCmYCD+bKQk+7
         u97LfgTqDUSnopAmfOiLmL48bCVOZw34XdUVZe+7CFJjlyqsII/+VApvh7Ua6gHjePT1
         jXtQVa8awnQe4D4PUcBUhAf3qJlE6/62bw9FVPPulcK5sSaomXxuJu4rI/9MhdZZc6FT
         bkuls2y4Pvhn0k2aGJAJ7XEoEfNXbO448eYy9JuOn0nGX/usRB2YKS0QWEkFOSgcwawk
         trw4+lgnZkII5PR9TLCMfB4ZnjSQV7jXdUKI1tl4E3fh1EzRss1E5q7eT2gH03CiCLtA
         PLVQ==
X-Gm-Message-State: AJIora+q47v2BcjVlrG6vbAvxdjK34f3CVb4clhNwc+FWN5pwA+Jn9bX
        6NBTFy+XyO3WT442OrCXW4gvXQFdgKOfs892ttOdnQ==
X-Google-Smtp-Source: AGRyM1tKXIf7skJkbZ0Jt4ZId9hoRWdp5Q8Pt4jHVkRbzdTwfvr/3OUmPekxJ+PYT/zD3ZsbOrI0kk7lMccgy//k9bw=
X-Received: by 2002:a81:7557:0:b0:317:6536:d404 with SMTP id
 q84-20020a817557000000b003176536d404mr12390732ywc.459.1656019772443; Thu, 23
 Jun 2022 14:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
 <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
 <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
 <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com>
 <CAOMZO5A6Zn=6tXU2VQ+-cj=50mpxCmoZ8c437=w1Spd34k7T6A@mail.gmail.com>
 <CAGETcx-_nwrzJzaY3yc80g4AfydV5J9-JYE5h1m+5TT05jyKOw@mail.gmail.com> <CAOMZO5BvnBCza5HQVNUQqDBZR9WsXiK4RuVPh654GJGb2jw+1g@mail.gmail.com>
In-Reply-To: <CAOMZO5BvnBCza5HQVNUQqDBZR9WsXiK4RuVPh654GJGb2jw+1g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 23 Jun 2022 14:28:56 -0700
Message-ID: <CAGETcx8EsTWVQCFrw8vSs91i1LXj7Z1qW962ShxBDXwORwbHwA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, hvilleneuve@dimonoff.com,
        Lucas Stach <l.stach@pengutronix.de>,
        abbaraju.manojsai@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, t.remmet@phytec.deh,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
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

On Thu, Jun 23, 2022 at 1:51 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 3:58 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > Will do. I'm looking at the serial console code and I don't see a
> > difference between earlycon= vs console= handling. And I know that
> > earlycon= doesn't go through the driver core and isn't affected by any
> > of this. If you have additional pointers on where console= is parsed,
> > feel free to pass it on. I'll continue poking at this.
>
> It seems to be parsed at uart_parse_earlycon() inside
> drivers/tty/serial/serial_core.c.

Turns out it's kernel/printk/printk.c

-Saravana
