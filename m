Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D886255FC14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiF2JeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiF2JeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1A3A72A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D5C61E64
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9E6C341CD;
        Wed, 29 Jun 2022 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656495241;
        bh=J8i+l8xvoeG7OoleWylkhp5hukJMSqP43HeDa1swq34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCBG+ws3obV5VSKK9oGpT2O1x3YduDnzODt7ChgVVfJUmbaERyzcYapxYH7nMcp/0
         +RdXfXwv+OedUBPiobUo/jDy44asrihNpzUHzpj4ELejoNQkwaK3EOd7J8hfzJOyLg
         4L7kIKK1qFk1DWXBh/vTA6n84daYSMk8mjAj/KjrZXdj799P2eEwgNjOawZUBfFaIB
         XAZG36tNBsEBlEicSgtnkA4HzxKmorXXn6BTL+iMNkLnnncitvE5zuaX2HdIJvhzH8
         IIqBCsLMB+wVXhc2xilMs3fzgKn/zj6lJwrq++Bam3yA2Z/Kwl6JTfLJ8HekMqysAF
         BY93osDB+oKtw==
From:   Will Deacon <will@kernel.org>
To:     Schspa Shi <schspa@gmail.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        broonie@kernel.org, bigeasy@linutronix.de, geert+renesas@glider.be,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Remove duplicate SYS_SVCR read
Date:   Wed, 29 Jun 2022 10:33:51 +0100
Message-Id: <165649497050.3731145.1897443737940459015.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220629051023.18173-1-schspa@gmail.com>
References: <20220629051023.18173-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 13:10:23 +0800, Schspa Shi wrote:
> It seems to be a typo, remove the duplicate SYS_SVCR read.
> 
> 

Applied to arm64 (for-next/sme), thanks!

[1/1] arm64/fpsimd: Remove duplicate SYS_SVCR read
      https://git.kernel.org/arm64/c/4139320d19e6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
