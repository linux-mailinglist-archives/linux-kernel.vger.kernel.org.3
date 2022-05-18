Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DA52BD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiERNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiERNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB11C72DF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE28B61839
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F1CC385A5;
        Wed, 18 May 2022 13:53:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Move sve_free() into SVE code section
Date:   Wed, 18 May 2022 14:53:37 +0100
Message-Id: <165288201290.993334.7332263537288070994.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cd633284683c24cb9469f8ff429915aedf67f868.1652798894.git.geert+renesas@glider.be>
References: <cd633284683c24cb9469f8ff429915aedf67f868.1652798894.git.geert+renesas@glider.be>
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

On Tue, 17 May 2022 16:52:03 +0200, Geert Uytterhoeven wrote:
> If CONFIG_ARM64_SVE is not set:
> 
>     arch/arm64/kernel/fpsimd.c:294:13: warning: ‘sve_free’ defined but not used [-Wunused-function]
> 
> Fix this by moving sve_free() and __sve_free() into the existing section
> protected by "#ifdef CONFIG_ARM64_SVE", now the last user outside that
> section has been removed.
> 
> [...]

Applied to arm64 (for-next/sme), thanks!

[1/1] arm64/sve: Move sve_free() into SVE code section
      https://git.kernel.org/arm64/c/8e1f78a92101

-- 
Catalin

