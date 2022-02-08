Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED884ADF13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiBHROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378791AbiBHQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:44:22 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34AC0613CA;
        Tue,  8 Feb 2022 08:44:10 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy20so5085644ejc.0;
        Tue, 08 Feb 2022 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/We9yqvOLbUXSssHcpaNdlRzNEjNOvG/0v7Svvaz5Q4=;
        b=etIp6yJwuUC0V7khhdsusLxvPXiPT+dRuZBkg698TYSH2APvgEepxO8VjEB5b2jjRf
         1KjOTgRrHmP/RicAU/bAK+3+uSoRil9NYIXqcK7NeV02U5P1YT+azxRRcFbbDxULK/Q7
         aKWvmKrebIiaCb/xB6c8Kr7V6gW0+7obnMCOHU3RU04pYdE8ZLvtd4EtiL0mO5GPf27l
         DxR1CUmghwRONkCW06ee8wmNoSXWuAndU7p1fo+ziOJCnVPJSHydn+0hMvoqmDqmy8ID
         G1WKFuZ5GMJJcLwvNjDk7SChsTJJuEWIRTmQ/NL7eKakfELMfdGRDbUTtA1z5lTvm6+a
         Vybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/We9yqvOLbUXSssHcpaNdlRzNEjNOvG/0v7Svvaz5Q4=;
        b=vezbfo/adeL48kQmcVPP/lF/MOye5yazOUkm4EXhzRJ+YN+q2miJxUSFJo82WsWubB
         xwslDKYIH2Jfj1VfLbM7IQfO5zjKgEh+wu6s0jJ7bz7J+Tc2IswnRHnl6P5Rsy08/bOM
         gwmuTtzr4M5wemioon/A677seZvuU0gkcnTq5Yz+3od+AeMkiLU6EF583lSl2iWk4GTa
         iesnzPCT39rVhfCSk21RShJ2zwKQKsY3QgmGNgM+dMGcv/lYkol7ogybjkypvKpgZsH1
         jSD25FZs3KjKzZCPG+3IcCK8vwEcFLBF7sioaJlkw70urA8O8nPTmcHLqA9T6p9grZiu
         +OGA==
X-Gm-Message-State: AOAM5315hNfjE7BSSMTGDsc8WfQHPDeUWETpgmReW0jfnede+y5653KO
        uClTwj167iUcihqrSg5utxXSTw392FGw6A==
X-Google-Smtp-Source: ABdhPJwKzRMW1NRUfd4q6aN58onV1rkH2NmYV61FvRyQm4XbQPZZuMy0OLPsE/mnRya9v/1R4RUwxw==
X-Received: by 2002:a17:907:1b24:: with SMTP id mp36mr4422564ejc.519.1644338648635;
        Tue, 08 Feb 2022 08:44:08 -0800 (PST)
Received: from p200300c58721e9a997b21f6340834df8.dip0.t-ipconnect.de (p200300c58721e9a997b21f6340834df8.dip0.t-ipconnect.de. [2003:c5:8721:e9a9:97b2:1f63:4083:4df8])
        by smtp.googlemail.com with ESMTPSA id n25sm3561260eds.89.2022.02.08.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:44:08 -0800 (PST)
Message-ID: <35b4b69826a6295c7e5141934290812277d8b411.camel@gmail.com>
Subject: Re: [PATCH 0/5] Use of_device_get_match_data() helper
From:   Bean Huo <huobean@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Eugen.Hristev@microchip.com, adrian.hunter@intel.com,
        nicolas.ferre@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Date:   Tue, 08 Feb 2022 17:44:07 +0100
In-Reply-To: <CAPDyKFqDk3Jik5tXoKNbQijZTd08nTcHgv_Z-D2DbV_TUM+76w@mail.gmail.com>
References: <20220202180648.1252154-1-huobean@gmail.com>
         <CAPDyKFqDk3Jik5tXoKNbQijZTd08nTcHgv_Z-D2DbV_TUM+76w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 16:12 +0100, Ulf Hansson wrote:
> On Wed, 2 Feb 2022 at 19:07, Bean Huo <huobean@gmail.com> wrote:
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > *** BLURB HERE ***
> > 
> > Bean Huo (5):
> >   mmc: wmt-sdmmc: Use of_device_get_match_data() helper
> >   mmc: sdhci-tegra: Use of_device_get_match_data() helper
> >   mmc: sdhci-omap: Use of_device_get_match_data() helper
> >   mmc: sdhci-of-at91: Use of_device_get_match_data() helper
> >   mmc: davinci: Use of_device_get_match_data() helper
> > 
> >  drivers/mmc/host/davinci_mmc.c   | 6 ++----
> >  drivers/mmc/host/sdhci-of-at91.c | 6 ++----
> >  drivers/mmc/host/sdhci-omap.c    | 7 +------
> >  drivers/mmc/host/sdhci-tegra.c   | 6 ++----
> >  drivers/mmc/host/wmt-sdmmc.c     | 7 ++-----
> >  5 files changed, 9 insertions(+), 23 deletions(-)
> > 
> 
> Series applied for next, except patch3 that seems to need some minor
> adjustments, thanks!
> 

Thanks, I will update the patch3.

Kind regards,
Bean

> Kind regards
> Uffe

