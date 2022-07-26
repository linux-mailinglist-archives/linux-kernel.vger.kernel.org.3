Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD10581C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiGZW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiGZW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64630559;
        Tue, 26 Jul 2022 15:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED0A616CB;
        Tue, 26 Jul 2022 22:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E1C433D6;
        Tue, 26 Jul 2022 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658876335;
        bh=95zhTF3RvSPpdIG4fmJ3Qawy4FvFggDDh2yy8qTKelU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JB9NLfp2xH0FofRGBLksoua8oV3DsjCIVChSnJpFO1XtWy4f4IoLCP/gShk/y6LqT
         FAHWIIxyQjul6m5yLpfedt74GPpB+lTKwmJqB76PNk9HeWAqg5R40lJyjxnVooYQjS
         9ClBvf6YE2QNbtvkA9jhtxxHwX0jY2y4RQstr1PH8AnaUKGKTrI8RTlRwJwuSEqss+
         1qqxR5IDUfYiCtwnqziueD2qeWnhcFZxbutTu6UDYdrEIX1rwBQPSEj90SxelXi163
         3ta1foNlveScUW5UGdbpxQUKFlklWAugeKMYhNz88g3HMGtBXGSPSeyqdgstU1kmTY
         nse+UJATCJVVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2118699.Icojqenx9y@jernej-laptop>
References: <20220719183725.2605141-1-jernej.skrabec@gmail.com> <a7a253a0-1cc3-61e4-ae59-fc299057974a@sholland.org> <2118699.Icojqenx9y@jernej-laptop>
Subject: Re: [PATCH] clk: sunxi-ng: Fix H6 RTC clock definition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, andre.przywara@arm.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
To:     Jernej =?utf-8?q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, wens@csie.org
Date:   Tue, 26 Jul 2022 15:58:53 -0700
User-Agent: alot/0.10
Message-Id: <20220726225855.615E1C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jernej =C5=A0krabec (2022-07-20 08:16:54)
> Dne sreda, 20. julij 2022 ob 02:21:29 CEST je Samuel Holland napisal(a):
> > On 7/19/22 1:37 PM, Jernej Skrabec wrote:
> > >=20
> > > Fixes: 38d321b61bda ("clk: sunxi-ng: h6-r: Add RTC gate clock")
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Reviewed-by: Samuel Holland <samuel@sholland.org>
> >=20
> > This bug also got fixed in passing by e1c51d31befc ("clk: sunxi-ng:
> > Deduplicate ccu_clks arrays"), but that won't land until 5.20.
>=20
> Argh, good catch. I will send your patch as fix then, otherwise there wil=
l be=20
> issues during merging.

This is a one line fix. I can just apply this and send this off and deal
with the merge conflict locally by taking the other side.
