Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96494C04C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiBVWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiBVWiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:38:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C355F1275F6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85DA5B81A2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AE7C340F0;
        Tue, 22 Feb 2022 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645569497;
        bh=0OsmxL6ibpriknf3yJ+6RQb2PuF55rEZFzJwzAUdei0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFrZo3IpX2gMzkHs1q4BHXZK8E9mRxvqA5CsB3Q3vcEddpPLdMgKPd5/cUmSdwK8H
         f+DUVP4HBR8Vu1g1xrnAks1DEiHgFByvqvxTshCExyG+52GaV72Qcvcy9SEbfiXp1f
         yVZLBVYMqW8T5wh9lK4+mhUibHqG5/BWNzKN4bQA2v7bnuVi0ygnt3MzWeJuXUtCo4
         /43Z9VTSf2cGMNEPUYWpe6d200TmyrCd97n/xmjeo9gfqEnn5ySqepLb28c3lPhn+b
         pClp9Yi6ff7q0AZ+vOeNlnmYxAP+zqQf72XDTbgwfFKFqLT4xpeogcQoZxJ3V7ffTH
         VsBH5E6iKuehg==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        bp@alien8.de, ardb@kernel.org, broonie@kernel.org,
        dave.hansen@linux.intel.com, jpoimboe@redhat.com, acme@redhat.com,
        mingo@redhat.com, jslaby@suse.cz, joey.gouly@arm.com
Subject: Re: [PATCH v4 0/4] linkage: better symbol aliasing
Date:   Tue, 22 Feb 2022 22:38:03 +0000
Message-Id: <164554689454.798651.14045173364982958108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220216162229.1076788-1-mark.rutland@arm.com>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 16:22:25 +0000, Mark Rutland wrote:
> Catalin, Will, Peter: I think this is ready now and would like to get it
> queued, but it looks like this may (trivially) conflict with other bits
> we'll want to queue in either the arm64 tree (Joey's string routine
> changes [4]), or tip tree (Peter's IBT series).
> 
> I assume the best thing to do would be to have a stable branch merged in
> both of those. I've tagged this such that it can be pulled (details
> below); Peter also suggested he could make a stable branch in the tip
> tree. Any preference?
> 
> [...]

Applied to arm64 (for-next/linkage), thanks!

[1/4] linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
      https://git.kernel.org/arm64/c/e0891269a8c2
[2/4] arm64: clean up symbol aliasing
      https://git.kernel.org/arm64/c/0f61f6be1f7f
[3/4] x86: clean up symbol aliasing
      https://git.kernel.org/arm64/c/7be2e319640c
[4/4] linkage: remove SYM_FUNC_{START,END}_ALIAS()
      https://git.kernel.org/arm64/c/be9aea744004

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
