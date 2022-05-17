Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F75529A27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiEQHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiEQHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5545074;
        Tue, 17 May 2022 00:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B764615B6;
        Tue, 17 May 2022 07:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED728C34119;
        Tue, 17 May 2022 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652770887;
        bh=kk3k6llzVPvOiyVwtI1w8V49kIHd781E2pe6yqRZhys=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T3ArEvcAh5VKL8yv++QVhPTIi02OIM8W37fO+3AxNgX+3Sgoo0QkEHPEKhcNspyCk
         wjwR4ETj3RcNDvQsDhaL7UT0dbYNrpkMDPV6EofNA12peCuGfxm4+4GzfYLrpbXu8m
         JkgUXzz/6J4dgBs7JBWIjrJXitpStCDTFMZseR29pdCpEghhawxh2skPj+aMx9qs9I
         6oMGw7T7g8F/5owGtZVEQB0hllScacbe1eFPxvBtip3xvcmipFYWqs38RQxzT9kgp+
         XxcTWoFO/Wl1uArNOrSTK7Ygeu9LFHjdNvIk3t4vxe2TKfIZRRaLyKuEjEHVDKUIv1
         5rHn2D+LeyAig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220428183010.1635248-1-stefan.wahren@i2se.com>
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Tue, 17 May 2022 00:01:25 -0700
User-Agent: alot/0.10
Message-Id: <20220517070126.ED728C34119@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-04-28 11:30:10)
> The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> accidentially breaks the behavior of bcm2835_clock_choose_div() and
> booting of Raspberry Pi. The removed do_div macro call had side effects,
> so we need to restore it.
>=20
> Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-fixes
