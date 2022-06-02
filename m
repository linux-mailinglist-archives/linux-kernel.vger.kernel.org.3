Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAA53BEFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiFBTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiFBTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:41:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A23FD8B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D66FB8214F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFD4C34114;
        Thu,  2 Jun 2022 19:41:15 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, patches@lists.linux.dev
Subject: Re: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
Date:   Thu,  2 Jun 2022 20:41:12 +0100
Message-Id: <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602022109.780348-1-swboyd@chromium.org>
References: <20220602022109.780348-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 19:21:09 -0700, Stephen Boyd wrote:
> A static key warning splat appears during early boot on arm64 systems
> that credit randomness from devicetrees that contain an "rng-seed"
> property. This is because setup_machine_fdt() is called before
> jump_label_init() during setup_arch(). Let's swap the order of these two
> calls so that jump labels are initialized before the devicetree is
> unflattened and the rng seed is credited.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Initialize jump labels before setup_machine_fdt()
      https://git.kernel.org/arm64/c/73e2d827a501

-- 
Catalin

