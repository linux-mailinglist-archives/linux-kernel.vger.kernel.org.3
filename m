Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB77E4C4EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiBYTYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiBYTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:24:51 -0500
X-Greylist: delayed 6529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 11:24:19 PST
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738971EF36E;
        Fri, 25 Feb 2022 11:24:19 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D954B2A0;
        Fri, 25 Feb 2022 19:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D954B2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645817059; bh=eAsK8KjhF6vOJ6D38k1AV93Il3fx8B4v0KWORpTEC94=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AvVqaeT7mj4SSOF70xhBJAanen+NlOWgeSHzJabI2XvZfiWwVjU0VOnWnVVsGnHXo
         /MNE/a0KY2XPeRhvluLZY/d4FZxxy9qSgC4y7APLT05tlzRRuGYoRfWrqDwxDDmHMl
         PwZzAFI5LcKfCyTVqE0acKTs65TpR9W+2jqjvAjZYVPhtE7D8nOdPLvmcUuy65ivZh
         FZjKVu73obuBpsiVWyWxq+ag/U0YrIXMHckWy1TEdXGzRHoVlj1Y+agfhgPVfhb2BT
         Ga71gJUIvNQqNPAraoMtDFx2Oiso2sJl54/hAve3k62bo2/Z7rivux5rKp8MUwV/DM
         ljZ0daDBsG/Kg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH v2 09/11] sched: Introduce per memory space current
 virtual cpu id
In-Reply-To: <1317699329.108531.1645814360159.JavaMail.zimbra@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
 <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
 <87k0dikfxa.fsf@meer.lwn.net>
 <1323451367.108396.1645811762372.JavaMail.zimbra@efficios.com>
 <8735k6ke34.fsf@meer.lwn.net>
 <1317699329.108531.1645814360159.JavaMail.zimbra@efficios.com>
Date:   Fri, 25 Feb 2022 12:24:18 -0700
Message-ID: <87h78miwbh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> ----- On Feb 25, 2022, at 1:15 PM, Jonathan Corbet corbet@lwn.net wrote:
>> That helps, thanks.  I do think that something like this belongs in the
>> changelog - or, even better, in the upcoming restartable-sequences
>> section in the userspace-api documentation :)
>
> Just to confirm, when you say "userspace-api documentation" do you refer to
> man pages ?

No, I meant Documentation/userspace-api/.  But yes, even having the man
page in place would be a good step in the right direction.

Thanks,

jon
