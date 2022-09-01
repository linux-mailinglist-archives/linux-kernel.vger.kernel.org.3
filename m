Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767595A9832
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiIANMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiIANL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:11:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C899A9C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1E93B82656
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F2EC433D6;
        Thu,  1 Sep 2022 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662037615;
        bh=QjPV6teZb/2nUkANceDZc2UcnyxCWhu05Amx5RsPnWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOUT0dnZhugaZAw0r6E67EINME70y19u2oVtlg047rgf6SZF37rxFsRopsdMfnlt2
         Af45EzkCOKquvZA30YfN3z3gPRMgHvgu+Mt0L1tHp2npYLL8oGoykmZD4CdEEhIbTq
         ffLWo8qrQrizEcB/hOef030CNk3k243yjRAsvvnFPt+S2w4cua0CVLGNzQ9KZTEHlr
         Nj0xeFZyh1PWKt3Bv4puky/qBMn4JqtDMeLZRwVze6/WvZTRT/2cR0IK28Tr2e2zA6
         GPSj9qIhAq608iT7J61R/XgIVfhyS18vKlIlg5xgxZSnEerAR+p1BqO1vjO8fh/zDc
         0dBIt2hEAwh3w==
From:   Will Deacon <will@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, liqiong@nfschina.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm_pmu_platform: fix tests for platform_get_irq() failure
Date:   Thu,  1 Sep 2022 14:06:33 +0100
Message-Id: <166203010071.742097.8540261594747137317.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220825011844.8536-1-yuzhe@nfschina.com>
References: <20220825011844.8536-1-yuzhe@nfschina.com>
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

On Thu, 25 Aug 2022 09:18:44 +0800, Yu Zhe wrote:
> The platform_get_irq() returns negative error codes.  It can't actually
> return zero.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm_pmu_platform: fix tests for platform_get_irq() failure
      https://git.kernel.org/arm64/c/6bb0d64c1000

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
