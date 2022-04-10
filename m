Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03944FAD12
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiDJJfu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Apr 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiDJJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:35:48 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66640E4F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:33:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 804176081103;
        Sun, 10 Apr 2022 11:33:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0I2AQ11rsG8P; Sun, 10 Apr 2022 11:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0882A6081105;
        Sun, 10 Apr 2022 11:33:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TrnisQUZSPhL; Sun, 10 Apr 2022 11:33:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C487C6081103;
        Sun, 10 Apr 2022 11:33:33 +0200 (CEST)
Date:   Sun, 10 Apr 2022 11:33:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Message-ID: <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
In-Reply-To: <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com> <Yjt31seiNv18HYrf@dev-arch.thelio-3990X> <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: fix error return code in winch_tramp()
Thread-Index: ceNsql/27C1J+1g3RguAZ58F1pmPwg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
> 
> Zhen Lei, Richard, what's up here? Below regression report is more than
> two weeks old now and afaics didn't even get a single reply.

Sorry, but UML is leisure pursuit, so I can only work on it when my
schedule permits it.
 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> 
> 
> On 23.03.22 20:41, Nathan Chancellor wrote:

[...]

>> in case it helps. I am happy to provide more information or test patches
>> as necessary.

Nathan, can you provide me the error code from os_set_fd_block()?
My best guess is that setting the fd is optional here and UML does
not expect failure here.

Thanks,
//richard
