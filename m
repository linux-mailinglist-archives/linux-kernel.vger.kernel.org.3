Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF44F5F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiDFNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiDFNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:10:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1442300A8;
        Tue,  5 Apr 2022 19:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6799DB80EEB;
        Wed,  6 Apr 2022 02:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DAAC385A4;
        Wed,  6 Apr 2022 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649212300;
        bh=f5hf7D5TOW99iCnwO8kt6lFjR6zeUwXI7tLm2to12Qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+0wVCvFuyDGt9jDtBmmeUHHtOs4eMMxrROWP8voKqq9/5n9bVhy1nR5JnT0Tu9ue
         NihknhiDf8bs9x8ouLFYDNZM0ki3+RoegUSj1Y1hNom9q5DgolipUBaA7Nz59JswNK
         m4UXP6gyZOrjoAcA22v8+obrSs93/5IBvSuqi3y15QeBjlnXcZ0HYAVhy0jiBEUBeb
         RJ7snLY3RS3JFoEpkQXgVVMVJgDFwqCi+j9oC206Ql/4/rgzt/rsq6iXYxepex3YbA
         HT8PsRsvbxlKai2UHs5BYItHx8JyytVt6S7BdVHbUKmcYpBG5Gp9i+Yruu5UjksmrL
         M0JJBIZ3WzGrg==
Date:   Wed, 6 Apr 2022 11:31:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220406113135.ce40e165654dbafcb78f980f@kernel.org>
In-Reply-To: <20220405110243.21cdee07@gandalf.local.home>
References: <164871505771.178991.7870442736805590948.stgit@devnote2>
        <164871509158.178991.12705786877340857725.stgit@devnote2>
        <20220405235548.38344aba5a7fcb059924c367@kernel.org>
        <20220405110243.21cdee07@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 11:02:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 5 Apr 2022 23:55:48 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Have you already picked this series?
> 
> No I haven't. I do not add any patches until after the merge window, which
> just ended Sunday.
> 
> > 
> > Actually, kernel test robot reported an issue in this patch today.
> > Here is the patch. Should I send v8 including this?
> 
> Yes, please send a v8.

OK, thanks for the confirmation!
Let me send v8.

Thanks!

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
