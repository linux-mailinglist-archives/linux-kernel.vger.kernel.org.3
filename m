Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCD536475
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiE0PBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiE0PBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:01:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41211E489;
        Fri, 27 May 2022 08:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A7BECE256E;
        Fri, 27 May 2022 15:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C537C385A9;
        Fri, 27 May 2022 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653663655;
        bh=w2NpgxycBt0MlxXt3B1Zn+UQJWJ0TS1e6pxN8egk8P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK3T7dG5/k2NysuzvqujWInfNl0CLANvUvpi+c8CIZv6Hn5aN1yYEG9bjZQLe+RbW
         6LrdLBsmidPVkPvTXUIHLv3G117tOTGXXdxU1PzChfvY5W/bGUCDojDoNoNexF1ZOm
         C/xB/WknfheckSX/W3m4P1WrNu21YsdjClQSG5KVQv/B/X6qG6nOsUV5eCTvXO8M+j
         wBVISt1eB1TzvzczPRIeg2HngrJx5y9xAV+iRm0Hw2Wxi/lyzR6e/CfOebL1ldiSM0
         jX/2+y1P/u2CH9qLsdsXTmm4ERiLI/crehQ1AWDVhAOZWOwBMyHSN0v5XCEG+5CTeb
         TlLwMG5+cQI0A==
Date:   Fri, 27 May 2022 08:00:53 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v7 1/8] kbuild: replace $(linked-object) with CONFIG
 options
Message-ID: <20220527150053.4khs5rlu4vetoxca@treble>
References: <20220527100155.1996314-1-masahiroy@kernel.org>
 <20220527100155.1996314-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527100155.1996314-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:01:48PM +0900, Masahiro Yamada wrote:
> *.prelink.o is created when CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT
> is enabled.
> 
> Replace $(linked-object) with $(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)
> so you will get better idea when the --link option is passed.
> 
> No functional change is intended.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
