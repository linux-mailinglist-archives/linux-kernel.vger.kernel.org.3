Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124FA4D0A75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiCGWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiCGWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:04:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1E536320
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E06AB8172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0EC340E9;
        Mon,  7 Mar 2022 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690622;
        bh=W5Ekk0cpj1eu0WqG0e0IVt+jxiqqtBgSpE2sl1rYOCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHhNMj4apPvIpC+3JqHn3OLGZrTKDxZ7HBXikTG0sjfc0ZLZTjYGITlucByZMKXxF
         N2DgvQZDr1qFjqghX7+1tqGuQxMwHSf2HtW4++C7bhK7OtI5QmfB8awmXge9GpnIWH
         pgDtOWA7aXtrFC2jpNCb1cAzcy+Id8ZtIfeexHMaRv8EnSVx83TK0XG4u51mecadW+
         5YRhwC8McJPIZuoWdL/fSKQHbjTyvYDiSU4T/YzciEzuEBvmmX8n8sSbYxMBBp8X5o
         usByqCmg4uxjuTvjMhkgyLo6eb1AdGarJSkeM6vL2ChXLzRpcxY0etZstnr7VVH5Yh
         r6KDALDLVfqkw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop use_1G_block()
Date:   Mon,  7 Mar 2022 22:03:24 +0000
Message-Id: <164668946262.3276921.12274527029958883032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1644988012-25455-1-git-send-email-anshuman.khandual@arm.com>
References: <1644988012-25455-1-git-send-email-anshuman.khandual@arm.com>
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

On Wed, 16 Feb 2022 10:36:52 +0530, Anshuman Khandual wrote:
> pud_sect_supported() already checks for PUD level block mapping support i.e
> on ARM64_4K_PAGES config. Hence pud_sect_supported(), along with some other
> required alignment checks can help completely drop use_1G_block().
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Drop use_1G_block()
      https://git.kernel.org/arm64/c/1310222c276b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
