Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB54588508
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiHCAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiHCAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58B1BE9A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4DF60FFD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A5DC433C1;
        Wed,  3 Aug 2022 00:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659485261;
        bh=d0it+tTIu8FBLY5Yk/ljCD/nQEcE55pR62Gz3GBcV8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXZZHBiMczRcWDXdb9A0P2cCYvWUXNo0d8sskO+1ZGJv7gxzKZ8EULRfZ0Xl0jAta
         932qOHzPz7KBzuPopBsGSulRZMqkHK+pI/50LebQ+MxjkARYzRWEswMxEcViVt524F
         Z1JVUV98eM5kf8MznDrtehRliVJcU+pdAkIbZ4lUO5sox4FGAO3091SNVwEH7Nb2jx
         ntIaKOjWd/NjP7FIFfWUeycmAvsgYI0njsbEFcJZj1QTYM/PsIVHVdbz1k/CWag1JU
         0B4WAqPcJwegJJioEvLsoXZ0PZaNtpTtYCMXLsZFRcTRbCLkOjfkGdnjIDZf4tswKb
         kYGM3Fby5+IQg==
Date:   Tue, 2 Aug 2022 17:07:39 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: tools/objtool: check.c:11:10: fatal error: arch/elf.h: No such
 file or directory
Message-ID: <20220803000739.h4bjjbrstenho7jp@lassen>
References: <20220801192016.raoab6wtuimosocg@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801192016.raoab6wtuimosocg@altlinux.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:20:16PM +0300, Vitaly Chikunov wrote:
> Hello,
> 
> git bisect shows that commit b51277eb9775 ("objtool: Ditch subcommands")
> included in v5.19 introduces build failure on aarch64 for tools/objtool:

Objtool doesn't yet support arm64, what are you trying to achieve?

-- 
Josh
