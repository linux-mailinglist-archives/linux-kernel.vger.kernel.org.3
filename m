Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCA4D1A15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbiCHOM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347358AbiCHOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0024AE16
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BA461328
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0967C340F5;
        Tue,  8 Mar 2022 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646748683;
        bh=YrplheNWY14vnzIzWrojPQm8f+ueariyPOIrXWVJaPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCdKMGR9NEvdj4ukohxfBInvwOe/nb7ZcVmbvQCibOMtSCd/Fli9JXkM9JoeBDFId
         xPS6fT4zwGSpCBvcPV4fpEp9Q3HKSoW+G4cIuCYu3vAvv0r3P4gM3WkPMns2Q2c2Aj
         KqRzoE5oezhZE5FwKTtP3/865Utm1aDpkPZHLSqJ9CfCijKo5VwFIy0S+pNwcacTTJ
         cgCCgERGzMHpWQoHsELEswYEoWtMKzPM7TFx+IZEy0j02JjikcoaxtVQghiz3E24ZJ
         ShtV8DxZc3FqCICN0H5tHr8vErJA3C4J8rBsCzMrQYFPBrHZ3t7UgKes15zhu1jcdy
         My9OLoqYQZ8ZQ==
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: clean up tools Makefile
Date:   Tue,  8 Mar 2022 14:11:10 +0000
Message-Id: <164673823050.1680750.13009088965481045383.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220227085232.206529-1-masahiroy@kernel.org>
References: <20220227085232.206529-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 17:52:32 +0900, Masahiro Yamada wrote:
> Remove unused gen-y.
> 
> Remove redundant $(shell ...) because 'mkdir' is done in cmd_gen_cpucaps.
> 
> Replace $(filter-out $(PHONY), $^) with the $(real-prereqs) shorthand.
> 
> The '&&' in cmd_gen_cpucaps should be replaced with ';' because it is
> run under 'set -e' environment.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: clean up tools Makefile
      https://git.kernel.org/arm64/c/819a47d24b61

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
