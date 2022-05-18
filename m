Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F401D52BC69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiERNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiERNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF51C72E2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 189376182F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D37AC385A5;
        Wed, 18 May 2022 13:53:29 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        will@kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Kconfig: Style cleanups
Date:   Wed, 18 May 2022 14:53:26 +0100
Message-Id: <165288200320.993210.6191303648044664346.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517141648.331976-1-juergh@canonical.com>
References: <20220517141648.331976-1-juergh@canonical.com>
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

On Tue, 17 May 2022 16:16:46 +0200, Juerg Haefliger wrote:
> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
> 
> While at it:
>   - Add trailing comments to endif/endmenu statements for better
>     readability.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64: Kconfig: Fix indentation and add comments
      https://git.kernel.org/arm64/c/3cb7e662a930
[2/2] arm64: Kconfig.platforms: Add comments
      https://git.kernel.org/arm64/c/aea3cb356c96

-- 
Catalin

