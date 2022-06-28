Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B762F55EA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiF1RDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiF1RCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:02:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A41C924;
        Tue, 28 Jun 2022 10:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84D37B81F12;
        Tue, 28 Jun 2022 17:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B602BC341C8;
        Tue, 28 Jun 2022 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656435756;
        bh=DdmnVTonvb08oyxHeMdcY4gk5e2v7SgyNdBTw8QcCtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBE52dlO5TlmnGSw8Rxi7cwS+TtfjFXn/EZAYfflzWBSZKp05i+H0vSWcLPWFlWTi
         V08PLZxWAGLhaRnWMTtMNMuFT7EzX1ROp/QEusHqiJcjYAP1sZoo4s43y2iDvvIVX9
         Stmw3A/rDBrKNawUvGHSEkmGfZhYERlok2vixEZEuuMk8QAdRkEC9pcNJD3mePNEUg
         rb5C81UG9yxSKvzcqHcRPMggpgf07SdpvRWlCqsnxaAKaOeiUEFczkZp2EqPZd0WK7
         2Z0lWgA+jkJWX3bAbOhowYJAtcjRhzKa6IfHwPmzjalpP/jRRmDMXVODnI3qkx0Dvq
         SZ65moCI8p49w==
From:   Will Deacon <will@kernel.org>
To:     corbet@lwn.net, Liu Song <liusong@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] arm64: correct the effect of mitigations off on kpti
Date:   Tue, 28 Jun 2022 18:02:28 +0100
Message-Id: <165642528159.476075.2267547148245425040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1656033648-84181-1-git-send-email-liusong@linux.alibaba.com>
References: <1656033648-84181-1-git-send-email-liusong@linux.alibaba.com>
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

On Fri, 24 Jun 2022 09:20:48 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> If KASLR is enabled, then kpti will be forced to be enabled even if
> mitigations off, so we need to adjust the description of this parameter.
> 
> 

Applied to arm64 (for-next/kpti), thanks!

[1/1] arm64: correct the effect of mitigations off on kpti
      https://git.kernel.org/arm64/c/e92b25731ef6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
