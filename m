Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C407253BF02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiFBTlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiFBTlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:41:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD92AEF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74908B82051
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AF3C385A5;
        Thu,  2 Jun 2022 19:41:26 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: hibernate: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 20:41:24 +0100
Message-Id: <165419885870.2681883.11440522366442270490.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602180228.4259-1-wangxiang@cdjrlc.com>
References: <20220602180228.4259-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 02:02:28 +0800, Xiang wangx wrote:
> Delete the redundant word 'to'.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: hibernate: Fix syntax errors in comments
      https://git.kernel.org/arm64/c/189129aecb53

-- 
Catalin

