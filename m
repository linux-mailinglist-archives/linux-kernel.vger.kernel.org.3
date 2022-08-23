Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411159E525
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiHWOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiHWOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:33:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D8923CF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55D7DCE1BAC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F861C433D6;
        Tue, 23 Aug 2022 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254472;
        bh=IfD1lH1wb1IrL+OUiHKFIFvNOy4QYWDWxvrxYjx7Lhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJcXfpBVItOlFUXwRJg+CN0+F01Dx+uRRpQvM4DwDTM+8wGXfXEYuck0xbgYtSWeA
         IEzsIWnrN4Zax2MaNPTOBKVkjoxLkJiENbR+AePsDcEhKDFZ6L2+zJAHcOSmp9p2/W
         xQV68y5byxuDWNCGtc8kbtl4lquSQEk8Sn/eqzq1ciVj0ZycBgb1ksfR/lc82K4RpP
         N1d/DCD9OHxGmtn8viObRJpUihNTvSnJ/lqWdF5CDNqflSbH9f1ptrxVgLQ7Cq1J13
         4poaqJ4iaLJbixVH8P+HptzBdRyCYmDxrXwfjJfHgd25G6nB7ya4356X7nvJm1cHQ3
         iHX8FrB1biLSg==
From:   Will Deacon <will@kernel.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinwen.chang@mediatek.com
Subject: Re: [PATCH] arm64: Fix comment typo
Date:   Tue, 23 Aug 2022 12:34:19 +0100
Message-Id: <166124841460.3123906.3945586739365029922.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220721030531.21234-1-Kuan-Ying.Lee@mediatek.com>
References: <20220721030531.21234-1-Kuan-Ying.Lee@mediatek.com>
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

On Thu, 21 Jul 2022 11:05:31 +0800, Kuan-Ying Lee wrote:
> Replace wrong 'FIQ EL1h' comment with 'FIQ EL1t'.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Fix comment typo
      https://git.kernel.org/arm64/c/729a916599ea

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
