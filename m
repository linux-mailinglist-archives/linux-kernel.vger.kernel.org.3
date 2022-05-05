Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0351C450
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381468AbiEEP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381457AbiEEP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:58:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38305C34A;
        Thu,  5 May 2022 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651766058;
        bh=OZPw31eDi3knqjv/5JX7svy8ZOi10sgL+1UBIT7O9hA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VPgKzqK3v9rsJuPUzzZdLF9vobW+4Iy8lwwwRG1x9FSOCDHVfDpJdpgVY63PaqBPW
         87JjH+ITRev8lg/rN9JC1mElcqL8Is/xB/8EDxSMGOHjs6hynLO4fA7OR6jG0ChGmX
         LFTPqlP+N5h835ymU3ZM1nPPlvxZ03BdA8lqGY/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.208] ([217.61.145.208]) by web-mail.gmx.net
 (3c-app-gmx-bs47.server.lan [172.19.170.99]) (via HTTP); Thu, 5 May 2022
 17:54:18 +0200
MIME-Version: 1.0
Message-ID: <trinity-6a6249b9-69eb-459c-96f1-dbf8f031a86f-1651766058085@3c-app-gmx-bs47>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Aw: Re: [RFC v1] opp: add config option for debug
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 5 May 2022 17:54:18 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
References: <20220504174823.156709-1-linux@fw-web.de>
 <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JjduCuy3fMLSoCYKA+wbDZgJVEMTvSr/Ee7dpRQd+Ou029TLzUuMdZTMe9kWdAGoO0JwZ
 uCD3Pmr5HT0ZLOald0gZZq0R2vpMR+JbiXX1PifMhhh6FinR7iJbagfUyhn92lo8nQLLgIK9YZez
 Qp5oOG/lJ/9V+s4Z0rAoN/Jzx1zZq6wcAPlLN77z6i7lX5r3Gxx6kwUQ8KiMzcFRsABdSoTeZUto
 +zCJ22IjDwbY3Rg+jTEkV0WYsjQr9rMicnJUigY2AOALJPyR4l0c8gPdi+F7eCoA7lnfVFWmaRXc
 lA=
X-UI-Out-Filterresults: notjunk:1;V03:K0:KnF/vpqsQGY=:3vPuSDaC4JWuuJfCu9W3gn
 ax+NYjBqoTnGxJEsKRyIQaKfY05OLni/CAWgwlw1EsR6fKcTDZRo4kl+wXzg+Er4hEcqXNonu
 rYHg2aLh3enVIZfXz1cIQeQ5nAZyw/TIM41ScmFWQ9835RUG2WyepXJYxipVRtUXzkaFHFjcC
 6WQGuvosI5VZyaPZ1ONCw/zJgSy4TN5VEnVCLnPLzrql0s1wAXYsE/TQNrn0FqCeDauI9CtCk
 C0zHKm0FV3pj05TYT9C5CM2CqtI1eioq0v3vgmUgS4DFDLIbUapw5LmJ/czkC9WnmmiIseodL
 6h+Gixl+aSpxAgFgPO/2VuScSCPCBlB5+t2LN71kjPWriSD+ShLRuPegqbqNQPpy261kjUoVx
 48OUkmFcfAQidKVzGm5B3RQFwKbM3oF1xvgIiuip7qVCvyRrP5FRuLxaIKrNxhKaYxwuJF1fR
 4y9aj8BEaw1oAbFysJEIIbIDWjQDNWxlldt6enMqGpl2wk32GEhpIoGM1Lcgnc78sLTF3vNQS
 DneJmuOfT8UuqxHX8zBtv17GRVBPMfHSW/83gs+ihWtUJLPIKBo67uqpSAsgNlfpdp3upDMR8
 mZJwCa29Pm6SCFcpp5jDbacoDTq4qxGMxQE7oJi7OZyuJh7+r2VW6YA+pIkZlmA5MyzlMV3HR
 cPQ8aS2+qjadiXFomckMhH3lPBWKnIycECbNpjqtfI0l//0vkwrMvq+u2LcZTcU7xualjm+Hp
 y3lSzVJgjftIAwKUFEP6XUuWwYAIu/4w5oWw2yc0xJQXJdj8a5uoqwlcEHvoK3/vAcPdds5QF
 q2z2mZT
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Donnerstag, 05. Mai 2022 um 07:58 Uhr
> Von: "Viresh Kumar" <viresh.kumar@linaro.org>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Cc: linux-pm@vger.kernel.org, "Frank Wunderlich" <frank-w@public-files.d=
e>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"=
 <rafael@kernel.org>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon=
" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel=
.org
> Betreff: Re: [RFC v1] opp: add config option for debug
>
> On 04-05-22, 19:48, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
> > driver debug and opp floods serial console. This is annoying if opp is
> > not needed so give it an additional config-key.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  drivers/base/Kconfig | 1 +
> >  drivers/opp/Kconfig  | 7 +++++++
> >  drivers/opp/Makefile | 2 +-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
>
> Isn't something like Dynamic Debug helpful here ?

you mean something like this:

https://www.kernel.org/doc/html/v5.17/admin-guide/dynamic-debug-howto.html=
#debug-messages-during-boot-process

so enabling debug only with cmdline-param...

have you a simple example how to implement it? have not done anything with=
 dynamic-debug yet...seems mighty but not trivial to implement.

currently dev_dbg() is used for the messages that i try to disable...but s=
how others from driver_debug at debug level.

What needs to be changed to filter it via DYNAMIC_DEBUG?

found this, but i'm not sure if i interpret it the right way...

https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/acpi/utils.c#L49=
5
defines __acpi_handle_debug
called via acpi_handle_debug macro
https://elixir.bootlin.com/linux/v5.18-rc5/source/include/linux/acpi.h#L11=
36

so basicly convert dev_dbg to __dynamic_pr_debug

at least much more changed code because all dev_*/pr_* needs to be changed=
 to own handler which does the switch based on CONFIG_DYNAMIC_DEBUG set or=
 not.

regards Frank
