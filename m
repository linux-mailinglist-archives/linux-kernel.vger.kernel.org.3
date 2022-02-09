Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE45D4B0165
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiBIXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:37:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiBIXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:37:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDAE053733;
        Wed,  9 Feb 2022 15:37:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fy20so11293682ejc.0;
        Wed, 09 Feb 2022 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5kaUwuqIGj0ojEY7kPnRejH2UYzI/SB/FogOwRyp+Ho=;
        b=VZmjjhFtkYFT0IBAeyge4aSOGp+VmKZLadIKkutYStfpbL4u5wkZ2aqJA44LaD+Pw0
         yh2qNKvkj0sDhnG56xYMRbnkbLQkk6zUFVjViRGMQmUY+v2WhMrEC8ZVa1fO8KR5LmmD
         978OJyklk5H4HSl0zmK1M8CWkN+7/qs+57uZI0geiw4fQvonyXp5w56Nc/MiQ336ZOKf
         jkpdwEY1J8MkU8UwVpu6AvqPszIfaZS611DYLDEejkP487q24C83reHtf2hn9sSXp1VH
         WY90S2gXRmyBqylrLUFKYkerWA/oL0UZt8tm1pEb6Erqv7DtaIY0vW1uihk/4TtaXuK1
         ERHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5kaUwuqIGj0ojEY7kPnRejH2UYzI/SB/FogOwRyp+Ho=;
        b=0BgyvF05A8c3g4Sh5hbrAlVyqRGaEU1Ia4gVEqzTa7eDxL93ZGfwJWcVWkdj8x2RKi
         JMC2Yb98zqL/tTyAIQQvfP+/QBYbpA0zlGEdXapiVhOg809/DbtornJurxnw5HWsYOFG
         1WTTTlKYSsC70wJNLshc9Z5yaQLLskvChd/y+5Nme5r/4QlLmNfLWj0i2mdRJCLhqKcq
         xPMzNv0i6P/DglrPV6i/n4YEfPK8T1W8NT8fWYmCLpDyPz9EVm+Qh+0rfYwz4obUqGTT
         oQCdnHMivXAYzK2beC8viIDApyjUFvGThjVMAhaYtO5G0jtCYqbNmbLk3tncX5iKCxSg
         1NNQ==
X-Gm-Message-State: AOAM531ZvK6zQqbrH223+Y35zVue0zNIBYZG+XbFtUbyRt0J1Xhqb4cB
        N5UqY1ymqxgcefZ1E7Le/WA=
X-Google-Smtp-Source: ABdhPJxQsHHLXQBSb3idLFqni/LQQQUhHNhAtw/fi4ys+azzvFiVE/1CQd7ocFAKt5W64Owy2tVrEw==
X-Received: by 2002:a17:907:e86:: with SMTP id ho6mr4113841ejc.61.1644449849556;
        Wed, 09 Feb 2022 15:37:29 -0800 (PST)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id qw28sm5283992ejb.0.2022.02.09.15.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:37:29 -0800 (PST)
Date:   Wed, 9 Feb 2022 23:38:01 +0000
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Clock fixes for Ingenic SoCs
Message-ID: <YgRQWfUmdXZU606t@localhost>
References: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
 <EPN17R.TB21BVY3XDUH1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EPN17R.TB21BVY3XDUH1@crapouillou.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:44:02PM +0000, Paul Cercueil wrote:
> Hi Aidan,
> 
> Le mar., févr. 8 2022 at 01:00:45 +0000, Aidan MacDonald 
> <aidanmacdonald.0x0@gmail.com> a écrit :
> > I ran across a problem trying to get Linux running on an Ingenic 
> > X1000 SoC:
> > since the memory clock isn't referenced by any driver, it appears 
> > unused and
> > gets disabled automatically. After that, the system hangs on any RAM 
> > access.
> > 
> > There is a hack in board-ingenic.c to forcibly enable the CPU clock, 
> > but this
> > is insufficient for the X1000 since the memory clock has its own gate 
> > and mux
> > that isn't tied to the CPU.
> > 
> > This patch series fixes the bug by adding CLK_IS_CRITICAL flags to 
> > important
> > clocks, which seems to be the approach used in many other SoC clock 
> > drivers.
> > 
> > It's my first time submitting patches to the kernel so let me know if 
> > I
> > messed anything up.
> 
> You did everything good.
> 
> I think the CI20 suffered from the same problem, it would only boot as 
> long as the "clk_ignore_unused" flag was added on the command line. I 
> will need to try it there to see if it improved the situation.
> 
> I tested the patchset on JZ4770 and it works fine. So:
> 
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> 
> @Stephen: I don't see any changes pending on board-ingenic.c so it 
> should be safe for you to also take [PATCH 3/3] in the clk tree.
> 
> Cheers,
> -Paul

Thanks Paul. I've just sent two other small fixes which are basically
independent of this series, if you want to test them at the same time.
One is for the TCU driver and the other is for the pinctrl driver.

Regards,
Aidan

> 
> > Aidan MacDonald (3):
> >   clk: ingenic: Allow specifying common clock flags
> >   clk: ingenic: Mark critical clocks in Ingenic SoCs
> >   mips: ingenic: Do not manually reference the CPU clock
> > 
> >  arch/mips/generic/board-ingenic.c | 26 --------------------------
> >  drivers/clk/ingenic/cgu.c         |  2 +-
> >  drivers/clk/ingenic/cgu.h         |  3 +++
> >  drivers/clk/ingenic/jz4725b-cgu.c |  2 ++
> >  drivers/clk/ingenic/jz4740-cgu.c  |  2 ++
> >  drivers/clk/ingenic/jz4760-cgu.c  |  2 ++
> >  drivers/clk/ingenic/jz4770-cgu.c  |  1 +
> >  drivers/clk/ingenic/jz4780-cgu.c  |  3 +++
> >  drivers/clk/ingenic/x1000-cgu.c   |  3 +++
> >  drivers/clk/ingenic/x1830-cgu.c   |  3 +++
> >  10 files changed, 20 insertions(+), 27 deletions(-)
> > 
> > --
> > 2.34.1
> > 
> 
> 
