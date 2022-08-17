Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22A596BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiHQJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHQJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:24:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489924F18B;
        Wed, 17 Aug 2022 02:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF34B81C06;
        Wed, 17 Aug 2022 09:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F14C433D6;
        Wed, 17 Aug 2022 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660728265;
        bh=8+DNMt2OBUWg2pDi8QSy/mybuvQDeV4QyZVtGu+4vaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0Ytks26Zwu/w6D1bo0xAWF2o88FDyyCJfyBFdHx+G9M+3+xwNnk2+dEZZOnXxQ6U
         Y5TtHx9btoXxXVRk5jMtJTddt9FXIYIcb6HplUfChXFZXn8yyStclZOZTow1tDXd8h
         71MSeHBwK95wUkbTyiwxb4c7hdTeiqPj+1LjWE+cnUbvQLtdN8ASlaudiNwInigMHG
         8rI8P9DG3A4G039RDqmOEkO8jx5qTgrIHsHCJF+skVJYpOnyH3EBa1TCOPIckr1qFO
         iVVDol7AhWF0ZxtaCN5xgKeYofnQEoPd0XJd27/vITq67e7qXJ4cMrAAy06E7UoTU/
         JSUomrDo90zUg==
Received: by mail-oi1-f172.google.com with SMTP id m6so2923662oib.4;
        Wed, 17 Aug 2022 02:24:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo0HLsYVdQFjReVbOtO+GC+kLI6TyFPCx/oSQQDtam5k/tXmZ7ac
        9/dkX1CDQ2rZZJswxxhPNDf3GXx1qhwHvjpbFVU=
X-Google-Smtp-Source: AA6agR6rWYZPOrOOZ45KKqJXHC5r8rQJzkHMzXqfvHkZ2MYf7nQqouU3i53gQDbyOdKrIyTBV6kDT+yyxfYE2zZSlrQ=
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id
 ch6-20020a0568081c0600b0033a9b3bb3cemr1059923oib.53.1660728264832; Wed, 17
 Aug 2022 02:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com> <20220729104938.GA93488@francesco-nb.int.toradex.com>
In-Reply-To: <20220729104938.GA93488@francesco-nb.int.toradex.com>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 17 Aug 2022 17:24:14 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+8ZKwGSrZK=ia7qZ33Bfq+tjwzqHhwWsAGTx2DTwKOfA@mail.gmail.com>
Message-ID: <CAJBJ56+8ZKwGSrZK=ia7qZ33Bfq+tjwzqHhwWsAGTx2DTwKOfA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] arm64: dts: imx8mm-verdin: update CAN clock and
 interrupt type
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 6:49 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> Hello Shawn,
> just a gently ping.
>
> On Fri, Jul 08, 2022 at 02:42:03PM +0200, Andrejs Cainikovs wrote:
> > This patch set updates CAN controller clock and changes interrupt type.
> >
> > Andrejs Cainikovs (2):
> >   arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
> >   arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd
> >
> >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> It's too late for the merge window? These 2 commits do not have a fixes
> tag, but they are really fixes (we just did not bother having those
> backported initially).

Applied both as fixes, thanks!
