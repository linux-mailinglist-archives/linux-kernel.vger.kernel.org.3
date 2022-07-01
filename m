Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6361A56371A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGAPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317563F89B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35AB6245B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA2C341CA;
        Fri,  1 Jul 2022 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656690107;
        bh=6r//clrzpV4KsFy8LsK8fXXEelgks/q5FuePxXgNTS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN2c977G2wL7gd/kv7ltc8b5JP0ow3iT+9zYOL/t4XtpE8DFvEILCG2lSLXemHiCG
         tyynOMTTn3VYAlswy6GMh8SEz79bMUyooiK7miKNO5T1Y9EwyWbfRLfUnpKuUCfOa4
         UCAdjm+Oc+1xIe4RGcbs6ngfhXmEd3oxV9Kuccn0jEEq5CieHDfOi+O8wsY/N1x8jH
         +y8DDI6AWRzaZQFif7hOOrTqxHQTi5VhRi116RHjnxkxxwMynF5FXx9+W7qOQyMxKh
         DGznTgm2l8gCdLRavHlpjjesWE3bnJBYxz67rfQLAnWsuH5IDv6haGEUVnygy7bjPv
         HIEaiBP+vCYaw==
From:   Will Deacon <will@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: compat: Move sigreturn32.S to .rodata section
Date:   Fri,  1 Jul 2022 16:41:27 +0100
Message-Id: <165667355941.570203.17492832237930153592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220701035456.250877-1-chenzhongjin@huawei.com>
References: <20220701035456.250877-1-chenzhongjin@huawei.com>
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

On Fri, 1 Jul 2022 11:54:56 +0800, Chen Zhongjin wrote:
> Kuser code should be inside .rodata. sigreturn32.S is splited
> from kuser32.S, the code in .text section is never executed.
> 
> Move it to .rodata.
> 
> 

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: compat: Move sigreturn32.S to .rodata section
      https://git.kernel.org/arm64/c/d9b728f8600b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
