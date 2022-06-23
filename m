Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67B55895B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiFWTmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiFWTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466650E2A;
        Thu, 23 Jun 2022 12:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CE5CB82164;
        Thu, 23 Jun 2022 19:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F4C341C7;
        Thu, 23 Jun 2022 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012737;
        bh=7dpmsiu6uUrLA3URVq1PDlJfMCtSg8LYc+vJxyRfneg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlEa6e5TNPlfLdQ2DDKkAlvKzIcKtBC6pufySUatYo/ZRty0NIlrauDXU5B0JeqYv
         PmV5dTHtpE01MISMix1ILc5GdTFaCekgO28YXgr0KIXSNMwDqT4r8Wy3SPhT+FRXl9
         65rQcD1nA9FXHaNh1l01BL1qFhTvrZ/OJ6D8k2LaLW4nzSiS0iEC8eRmMm+4iBNZWz
         p1U5RYlF6MbWO3wVV25qVUuUWFxGycHpvMjTY+chC1p9D/331AUuJQA6dM2AhHrYYq
         4dsQ9ScmwtkCuaBfUgU61OeZRM1arsp6ejFG3jOaDsnr2oM9uM9Ht0t3jdNw7oLADv
         Yey8winmA2Jag==
From:   Will Deacon <will@kernel.org>
To:     elver@google.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        arnd@arndb.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm64: Fix kcsan test_barrier fail and panic
Date:   Thu, 23 Jun 2022 20:31:43 +0100
Message-Id: <165600569929.3001194.1449584909652898648.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
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

On Mon, 23 May 2022 19:31:24 +0800, Kefeng Wang wrote:
> Fix selftest and kcsan_test() module fail when KCSAN_STRICT
> and KCSAN_WEAK_MEMORY enabled on ARM64.
> 
> v4:
> - Use 2 spaces after a sentence-ending '.', suggested by Marco
> - Collect Ack/Review
> 
> [...]

Applied to arm64 (for-next/kcsan), thanks!

[1/2] asm-generic: Add memory barrier dma_mb()
      https://git.kernel.org/arm64/c/ed59dfd9509d
[2/2] arm64: kcsan: Support detecting more missing memory barriers
      https://git.kernel.org/arm64/c/4d09caec2fab

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
