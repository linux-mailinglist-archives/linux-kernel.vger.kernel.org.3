Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933FB4AC69C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356100AbiBGQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391951AbiBGQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:49:22 -0500
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:49:18 PST
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net (p3plsmtpa09-10.prod.phx3.secureserver.net [173.201.193.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A9C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:49:18 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id H7AKnDbUXApSlH7ALnd9Bd; Mon, 07 Feb 2022 09:47:01 -0700
X-CMAE-Analysis: v=2.4 cv=G8PZr/o5 c=1 sm=1 tr=0 ts=62014d05
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=2kAAarxy9VumCd_w3i8A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Mon, 7 Feb 2022 16:46:59 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220207164659.ap42at2nphxu4q6o@ava.usersys.com>
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
X-CMAE-Envelope: MS4xfIIP/gozzRca46HAMgtbNxlM88SmUAYVFUTUVULzz9RI4E7KbG7Hppy3y3R5XZmICdyxGrEHvphguxwTZchx6L/p5YdM0Qgkpprm0S/IYGXhaQO3uTh0
 U3khktuuYFCAW64IolFGGSSJODOc6JcJcEmdyO6pnzDbg99NgnlPqASloJQzFlIOUVMz2hPd4t8lO/Puzu05agrXl9AnQK/swFoI4iX1anmHlkK5x2K7wie8
 ohK9ppjHkxyhsH1iBp8LehTSInyBQOSh0eeL0yFPMGRqHLYXIp0cwldrRO6B9Td/cC0BYRR/SRSk/ldy4aT9T0PzWrfOfYjxAB6pgw20wTZFD74YfZxxqY0Z
 RxkBIwxHFCqnj8daSf1AA0ZE39fymqZKiZ4aqSaw41PZg5wxtQOrWZK5nKv7PgieTLHmm9TPItv0MHXem4GI0R38HSm+pkheSljgQPsBmcfAB78H79/hTMrm
 bzGbM2Jr8d2j4BiGwKZVZrJHXoek1t21/0rW/JYL+CdAxZl+cqeHekwEKgrOVgsddZmDRWe5DttopKpMwDQJoITHS1rgVfonXVYSgyKJKqiwOrMbAUaFSVTa
 Ph7rC1IHzL+kp/6gpdNWcMOPccsH+4B6exgW23xr9vcWyBZgTW8k/+un3AM6+txgW9g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 18:01 +0000, Christophe Leroy wrote:
> I don't know exactly what was the motivation for commit 93651f80dcb6 
> ("modules: fix compile error if don't have strict module rwx") at the 
> first place but it is just wrong and we should fix it.

Christophe,

I think we are in agreement. If I understand correctly, it should not be
possible to enable CONFIG_STRICT_MODULE_RWX without
CONFIG_ARCH_HAS_STRICT_MODULE_RWX (or inversely), as per arch/Kconfig:

  config STRICT_MODULE_RWX
	  bool "Set loadable kernel module data as NX and text as RO" if ARCH_OPTIONAL_KERNEL_RWX
	  depends on ARCH_HAS_STRICT_MODULE_RWX && MODULES
	  default !ARCH_OPTIONAL_KERNEL_RWX || ARCH_OPTIONAL_KERNEL_RWX_DEFAULT

The objective of Linus' commit ad21fc4faa2a1 ("arch: Move
CONFIG_DEBUG_RODATA and CONFIG_SET_MODULE_RONX to be common") and in
particular commit 0f5bf6d0afe4b ("arch: Rename CONFIG_DEBUG_RODATA and
CONFIG_DEBUG_MODULE_RONX") does seem correct. So, architectures that would
prefer to make this feature selectable rather than enabled by default
should continue to have this option.

> module_enable_x() should work just fine regardless of 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX.

As per the above, we should fix commit 93651f80dcb6 ("modules: fix compile
error if don't have strict module rwx") so a stub for module_enable_x()
would no longer be required, right?


Kind regards,

-- 
Aaron Tomlin
