Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E551AE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbiEDUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiEDUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31630DF26
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC2860F38
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA25C385A5;
        Wed,  4 May 2022 19:57:51 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Orzel <michal.orzel@arm.com>, Will Deacon <will@kernel.org>
Cc:     bertrand.marquis@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cputype: Avoid overflow using MIDR_IMPLEMENTOR_MASK
Date:   Wed,  4 May 2022 20:57:49 +0100
Message-Id: <165169425294.2576066.15457281640319913128.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426070603.56031-1-michal.orzel@arm.com>
References: <20220426070603.56031-1-michal.orzel@arm.com>
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

On Tue, 26 Apr 2022 09:06:03 +0200, Michal Orzel wrote:
> Value of macro MIDR_IMPLEMENTOR_MASK exceeds the range of integer
> and can lead to overflow. Currently there is no issue as it is used
> in expressions implicitly casting it to u32. To avoid possible
> problems, fix the macro.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: cputype: Avoid overflow using MIDR_IMPLEMENTOR_MASK
      https://git.kernel.org/arm64/c/48e6f22e25a4

-- 
Catalin

