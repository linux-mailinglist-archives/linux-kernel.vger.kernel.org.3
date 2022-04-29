Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7251545F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380280AbiD2TXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380276AbiD2TXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B2C7F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD466624DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E5EC385A4;
        Fri, 29 Apr 2022 19:20:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] arm64/sme: Fix NULL check after kzalloc
Date:   Fri, 29 Apr 2022 20:20:03 +0100
Message-Id: <165125999970.375622.8354265292348811773.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426113054.630983-1-wanjiabing@vivo.com>
References: <20220426113054.630983-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 19:30:53 +0800, Wan Jiabing wrote:
> Fix following coccicheck error:
> ./arch/arm64/kernel/process.c:322:2-23: alloc with no test, possible model on line 326
> 
> Here should be dst->thread.sve_state.
> 
> 

Applied to arm64 (for-next/sme), thanks!

[1/1] arm64/sme: Fix NULL check after kzalloc
      https://git.kernel.org/arm64/c/2e29b9971ac5

-- 
Catalin

