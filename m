Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A3546A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiFJQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiFJQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B743B28A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF9262073
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DA9C34114;
        Fri, 10 Jun 2022 16:35:35 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/fpsimd: Fix typo in comment
Date:   Fri, 10 Jun 2022 17:35:33 +0100
Message-Id: <165487890511.2163242.5439051065944960894.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610070543.59338-1-wangxiang@cdjrlc.com>
References: <20220610070543.59338-1-wangxiang@cdjrlc.com>
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

On Fri, 10 Jun 2022 15:05:43 +0800, Xiang wangx wrote:
> Delete the redundant word 'in'.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/fpsimd: Fix typo in comment
      https://git.kernel.org/arm64/c/bb314511b6dc

-- 
Catalin

