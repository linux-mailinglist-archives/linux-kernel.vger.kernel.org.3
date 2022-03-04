Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404A4CDA10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbiCDRVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiCDRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:21:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DD1520EF;
        Fri,  4 Mar 2022 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CH7QcMqwraV+tePSOfKGoron6GD0xdpdLgX8+rteWow=; b=uv1Al54t6vIc14pePuc5ns6yRx
        Vs2ijGWG39+uXUMxC9X9KBHhWH85RNQltC7n6XL1uykxj9BvmZlLACCHVxEQ1ssN34uXih0/PqDlw
        sFlJ7X0mwHCFfEba1SOYaWvKH2QPaHnuCVeU4mArJ93IC5h8hyIplYTcUAzZBD2w9sq5fZ9SlvC2e
        34hc6qo5IHbfWXFRVxD1Gqp1BzPo28/1mxleZiE3SleSmoP19ZbNtyDRY/9DFJ/aR1AAKSa1VGjgj
        YrP/qkD0ieEUoGHBy/Y/XX1yf4yNqNiynlcegnL+s5Z2KKL5vEJfq3M7jnVG9gfeV2jW2uD0nVwdn
        PlSz6CLg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQBbF-00CoyB-HS; Fri, 04 Mar 2022 17:20:17 +0000
Message-ID: <0e7a145e-d95e-a5ec-eb5b-729b48061200@infradead.org>
Date:   Fri, 4 Mar 2022 09:20:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
 <202202251044.F509C7F3@keescook> <871qzhhc39.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <871qzhhc39.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/22 09:16, Jonathan Corbet wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
>> On Thu, Feb 24, 2022 at 09:19:24AM +0100, Thorsten Leemhuis wrote:
>>> Hmm, the intro for "Documentation/admin-guide/" states that "The
>>> following manuals are written for users of the kernel", but the added
>>> text afaics providing nothing regular users care about. So wouldn't it
>>> be better if this lived below Documentation/process/ ? It might not a
>>> really good fit either, but I'd say it's the better place.
>>>
>>> But well, the best person to know is Jonathan, who is listed as a
>>> Co-developer above, so maybe I'm wrong my suggestion is a bad one.
>>
>> I started in process/ and eventually settled on admin-guide/ since that's
>> basically the "front page". But I agree, there isn't an obviously correct
>> place for it.
> 
> Sorry, been a bit distracted...when we were working on this I was more
> focused on the text than the location.  My own feeling is that
> Documentation/process is a better place for this - that's where we tell
> the world how to work with the kernel community, after all.  I'm not
> going to dig in my heels and fight about it, but that's my sense.
> 
> Otherwise, it kind of seems like this is ready to go in. I'd like to
> apply it before the merge window; lemme know where you want it in the
> end and we can get it done.

There is a v2 of this patch, but yes, it should be in process/ IMO also.

-- 
~Randy
