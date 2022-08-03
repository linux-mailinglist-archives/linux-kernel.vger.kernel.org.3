Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF6588518
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiHCATN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHCATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:19:12 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F23BB1C11F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:19:10 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DE37272C90B;
        Wed,  3 Aug 2022 03:19:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A3E0A4A5088;
        Wed,  3 Aug 2022 03:19:08 +0300 (MSK)
Date:   Wed, 3 Aug 2022 03:19:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: tools/objtool: check.c:11:10: fatal error: arch/elf.h: No such
 file or directory
Message-ID: <20220803001908.snlwl25ha5ltkhmg@altlinux.org>
References: <20220801192016.raoab6wtuimosocg@altlinux.org>
 <20220803000739.h4bjjbrstenho7jp@lassen>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220803000739.h4bjjbrstenho7jp@lassen>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,

On Tue, Aug 02, 2022 at 05:07:39PM -0700, Josh Poimboeuf wrote:
> On Mon, Aug 01, 2022 at 10:20:16PM +0300, Vitaly Chikunov wrote:
> > Hello,
> > 
> > git bisect shows that commit b51277eb9775 ("objtool: Ditch subcommands")
> > included in v5.19 introduces build failure on aarch64 for tools/objtool:
> 
> Objtool doesn't yet support arm64, what are you trying to achieve?

IC. It was building successfully for our linux-tools package before (as
it seems it builds for Debian[1]) just as one of the tools. If it should
not be there, thanks for the elucidation, we will stop trying to build
it.

Thanks,

[1] https://debian.pkgs.org/sid/debian-main-arm64/linux-kbuild-5.18_5.18.14-1_arm64.deb.html



> 
> -- 
> Josh
