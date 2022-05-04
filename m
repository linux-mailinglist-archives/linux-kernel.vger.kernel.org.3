Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC98251AE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356688AbiEDUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiEDUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B12462E8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C10612C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF79C385A4;
        Wed,  4 May 2022 19:57:38 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] arm64: Set ARCH_NR_GPIO to 2048 for ARCH_APPLE
Date:   Wed,  4 May 2022 20:57:36 +0100
Message-Id: <165169425295.2576066.897612037721200908.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502091427.28416-1-marcan@marcan.st>
References: <20220502091427.28416-1-marcan@marcan.st>
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

On Mon, 2 May 2022 18:14:27 +0900, Hector Martin wrote:
> We're already running into the 512 GPIO limit on t600[01] depending on
> how many SMC GPIOs we allocate, and a 2-die version could double that.
> Let's make it 2K to be safe for now.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Set ARCH_NR_GPIO to 2048 for ARCH_APPLE
      https://git.kernel.org/arm64/c/5028fbad2d57

-- 
Catalin

