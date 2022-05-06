Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E5351DAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbiEFOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442377AbiEFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1026AA5E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978EE62166
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48437C385AC;
        Fri,  6 May 2022 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651848227;
        bh=s3pTOmpiMt6nPNPlGC+5S/1+VmRIyxZXW7DmIl/XnSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+6UVcfcoLMGXsvHwzHGAVpQBs9/JjTIprGmD9o/iVcE3N/Cz5+z2p/VI/9+POFVR
         Yoyzj7KCMHh08RpHExjDxL8yCzxP9ZM/yBYN9OICsd0UdrHrJS7vwNgDbnhkPHCv0A
         scbHJ66MmUcuNZCo2tocHJa1ZfsoyqTuOKrxSSoT4lOki9uI3W36ojhXLg0fOOHyR9
         CqCCX73reTF2ZpBmYKJSYtQO2qGAQxkYz91vlV1qeHbu+rSYDkkNPnUOr/xjdaWlbg
         /pMIKwmEn0w0YAlAR8bVXMKUbrGHwmZxfJInkI7l3uGoFEEFfMielgPXDEI6PvL2B2
         0y5Ii9woSwS3A==
From:   Will Deacon <will@kernel.org>
To:     Ren Yu <renyu@nfschina.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, liqiong@nfschina.com,
        mark.rutland@arm.com, yuzhe@nfschina.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: check return value of armpmu_request_irq()
Date:   Fri,  6 May 2022 15:43:31 +0100
Message-Id: <165184588835.742838.14238155155626074837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425100436.4881-1-renyu@nfschina.com>
References: <20220425100436.4881-1-renyu@nfschina.com>
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

On Mon, 25 Apr 2022 18:04:36 +0800, Ren Yu wrote:
> When the function armpmu_request_irq() failed, goto err
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: check return value of armpmu_request_irq()
      https://git.kernel.org/will/c/4b5b7129095b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
