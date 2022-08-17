Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F7597257
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiHQO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiHQO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA504B4B3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B87DEB81E09
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C668CC433C1;
        Wed, 17 Aug 2022 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660748321;
        bh=EBnv9EUoG//Wn2I98BWbmCT/zzRp6hcNHEkf3HxPkMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRFFVIAsDOa04HeN+Amc2txicsry8dPJNdIUi3h2sdF2Vg+SDUTWB1koNBUjprM5D
         WUeN3ygtMMuoLGPdFyWy1znwdhWzfO0iGDBefbjPtLzLk/JgKfYQV4CJMaqFiz1SLu
         wJcvKn76vqxNbKOjnJFdX0dedlLQQmBwLuHPKbpSgcLRnG6LxhdrkKavh61XPLp4iy
         or6+mhmu1EM0I11AHqS69CCRRpKN1c1J/MaIvQdp2YDmF1M9m8iJcNIA5TYS34a8IN
         aKVLmqMEmiGV1kZ86oecWT8+el7aM426qMRgxuZubqk6YgAcnCtoQ8mnLYlZLQMI5X
         GSTrh5VmTMraw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Shreyas K K <quic_shrekk@quicinc.com>,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: Fix match_list for erratum 1286807 on Arm Cortex-A76
Date:   Wed, 17 Aug 2022 15:58:33 +0100
Message-Id: <166074391776.1237678.1997580226876658229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220809043848.969-1-yuzenghui@huawei.com>
References: <20220809043848.969-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 12:38:48 +0800, Zenghui Yu wrote:
> Since commit 51f559d66527 ("arm64: Enable repeat tlbi workaround on KRYO4XX
> gold CPUs"), we failed to detect erratum 1286807 on Cortex-A76 because its
> entry in arm64_repeat_tlbi_list[] was accidently corrupted by this commit.
> 
> Fix this issue by creating a separate entry for Kryo4xx Gold.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Fix match_list for erratum 1286807 on Arm Cortex-A76
      https://git.kernel.org/arm64/c/5e1e087457c9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
