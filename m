Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56B566FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiGENyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiGENxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E520252BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF8B661605
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F61C341C7;
        Tue,  5 Jul 2022 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657027891;
        bh=npirsgRuJLMHkalz1yMFsI5QwdR6Hgrio5vB6pWZO3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRKoVcZPu1Hhc6u5RpNobVkcs0r3oF9Ee9UWr+jhGFPIucyFuTxofMl5/PPznyT2g
         5x9UOz5IXb5PRtpoNLfAKL0O4G4qx1fmFLhjNrRpeNO/7FdndzdlkVFkkj7jVm0hUg
         ozwOa47U06A/4nmB+aGX7ocXLDu/EuwMf37A4WtH0Uk4IOoRXGPHXvyybS02jRcC2j
         ov/jmLRNA886sNSMz0c3Nq6VQADRvnduQ0T1FrUjSLNnEI8wFTuqKfbH9XM0fzyHkj
         N9wYfOWwYAbf+65FvgB1WImCiLpjHKlZrWq0yhgUjVe2hH2AnByx2iLZhg6ntKCwlE
         t9NI/MtkmtRsA==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Define defer_reserve_crashkernel()
Date:   Tue,  5 Jul 2022 14:31:24 +0100
Message-Id: <165701782797.3451241.5162192607922271419.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220705062556.1845734-1-anshuman.khandual@arm.com>
References: <20220705062556.1845734-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 11:55:56 +0530, Anshuman Khandual wrote:
> Crash kernel memory reservation gets deferred, when either CONFIG_ZONE_DMA
> or CONFIG_ZONE_DMA32 config is enabled on the platform. This deferral also
> impacts overall linear mapping creation including the crash kernel itself.
> Just encapsulate this deferral check in a new helper for better clarity.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Define defer_reserve_crashkernel()
      https://git.kernel.org/arm64/c/4890cc18f949

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
