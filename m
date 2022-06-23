Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5E55894F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFWTl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiFWTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CF443F8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D3DB82164
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCACC36AEA;
        Thu, 23 Jun 2022 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012719;
        bh=0/j55yxemsyKEa0fWyDmGdq8+hj/hz1sDX4BWaTTnmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqGmSrPpEcDQiAJw0NYXOc4USlHqP9J98E+VQiFzefxWRl4aVnpoJnr/EZOMoXwm7
         jem8zWED4oWgYXTR5GABs4TWejZbFVH3tIhXfJXM1LhS/7DI7MvcKWTL9W39I69T7S
         z8AH30rWojWt+TBUX3TgG/PQHbbhZAufcixMeSqaYwAdAd04nzsA0NS2TBMEORn6u6
         n24xFvClOy37EiaDPJs26aHmfa9lkp8CfUu8skzVPg1MnD28+WZCkhcyqX+/jZLOv+
         kOKFUozgNmIngF3LR5b9eL0o0dFGvKc4DUyN9rO6r2cflssdRtTZkxHzzIB/Z+/R1I
         XmiWOYvI8OSUQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: compat: Move kuser32.S to .rodata section
Date:   Thu, 23 Jun 2022 20:31:35 +0100
Message-Id: <165599650307.2989933.18162881906585322732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220531015350.233827-1-chenzhongjin@huawei.com>
References: <20220531015350.233827-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 09:53:50 +0800, Chen Zhongjin wrote:
> Kuser code should be inside .rodata.
> 
> Now code in kuser32.S is inside .text section and never executed.
> Move it to .rodata.
> 
> 

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: compat: Move kuser32.S to .rodata section
      https://git.kernel.org/arm64/c/2d304afaedc4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
