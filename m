Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB125749D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbiGNJ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGNJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:57:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B74630D;
        Thu, 14 Jul 2022 02:57:06 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oBvaj-0006rx-02; Thu, 14 Jul 2022 11:57:05 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 03A31C0493; Thu, 14 Jul 2022 11:55:42 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:55:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
Message-ID: <20220714095542.GC10086@alpha.franken.de>
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:07:39PM +0200, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> See: https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
> ---
>  arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>  arch/mips/boot/dts/ingenic/gcw0.dts           | 31 +++++++++----------
>  arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>  arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>  .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>  10 files changed, 37 insertions(+), 57 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
