Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19F5A70C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiH3W0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiH3W0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FE82840;
        Tue, 30 Aug 2022 15:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725766148F;
        Tue, 30 Aug 2022 22:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4218C433D6;
        Tue, 30 Aug 2022 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661898185;
        bh=nMbtkeQ9N+G/3qW+szRqP1EagN2/R5jQ5O9x2R0M2fc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kej1EbhpcpLSl+FuH5wkI3kbnlzJNBYm5J7uYzRLS/oZEx4VicJ7jiWm0HH1X0yof
         I/u241YCYVin6na4Fvf2fEN/w8DnxMTXoobsvKfL9JTY3B6WLnkAGdWRZBJquNjEiq
         1no/O5D0YpOtchVVFfJYb5UtI8VILDBin6zPHftEUkEC+g76kiFx0Nv07FXv+IA+Yo
         VOr9mnzoMkeX8SINSTTdZPur63yXuQEFR7pjyARtgK3adeTkV8u9cvYbbHD9AdWe66
         6mtLfvX6M/hw5hrW4WVm//JmkRWyzbqC5ZfjmUWT4h1GFCmZrULXwt0Tgb96uqMAXW
         IcoRyXK5Ime2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220817075517.49575-5-sergiu.moga@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com> <20220817075517.49575-5-sergiu.moga@microchip.com>
Subject: Re: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for UART/USART
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergiu Moga <sergiu.moga@microchip.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>, admin@hifiphile.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kavyasree.kotagiri@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        robh+dt@kernel.org
Date:   Tue, 30 Aug 2022 15:23:03 -0700
User-Agent: alot/0.10
Message-Id: <20220830222305.B4218C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergiu Moga (2022-08-17 00:55:17)
> Add the generic clocks for UART/USART in the sama5d2 driver to allow them
> to be registered in the Common Clock Framework.
>=20
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---

Should I pick this up to clk-next or did you want to take it via another
tree?
