Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EDC4CD9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiCDRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiCDRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:17:47 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDC1CD9FB;
        Fri,  4 Mar 2022 09:16:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D2D902C0;
        Fri,  4 Mar 2022 17:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D2D902C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646414219; bh=fmFzS+MsVogVoM8EQElzON04Qt45ag1MEZQ4omlt00s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Awy3x6wC6HmEJtnx+WGj5N/u1bExg4vlLF6PvR+4X+TGT+Ja7x1paArqSoCce9aD1
         aUFt7B56ZVkgya6L9V+CC/PUE9zLFFV2RWnkedN8yF6I/yqZxVkct23GAAPH+v7s88
         69Bkhpl9LZ/qfS+PliPIA4+RxjtPJKoC7zFWTTTkzou67PGnUX3wLhOoBIYWLBY5XJ
         BV6OMzjq0xz9WiNgAyQOU949MRL4D+ONqz+kvWUWs5fgOwQeIfR/y1tIQY9KOkmuUE
         XEim1+y/qGf1tSlDt2jgSFdv67nq8bnyG923M29vsJliRBmfGNS28BuRGHYWVrsSeB
         kWp/MCizFn4SA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
In-Reply-To: <202202251044.F509C7F3@keescook>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
 <202202251044.F509C7F3@keescook>
Date:   Fri, 04 Mar 2022 10:16:58 -0700
Message-ID: <871qzhhc39.fsf@meer.lwn.net>
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

Kees Cook <keescook@chromium.org> writes:

> On Thu, Feb 24, 2022 at 09:19:24AM +0100, Thorsten Leemhuis wrote:
>> Hmm, the intro for "Documentation/admin-guide/" states that "The
>> following manuals are written for users of the kernel", but the added
>> text afaics providing nothing regular users care about. So wouldn't it
>> be better if this lived below Documentation/process/ ? It might not a
>> really good fit either, but I'd say it's the better place.
>> 
>> But well, the best person to know is Jonathan, who is listed as a
>> Co-developer above, so maybe I'm wrong my suggestion is a bad one.
>
> I started in process/ and eventually settled on admin-guide/ since that's
> basically the "front page". But I agree, there isn't an obviously correct
> place for it.

Sorry, been a bit distracted...when we were working on this I was more
focused on the text than the location.  My own feeling is that
Documentation/process is a better place for this - that's where we tell
the world how to work with the kernel community, after all.  I'm not
going to dig in my heels and fight about it, but that's my sense.

Otherwise, it kind of seems like this is ready to go in. I'd like to
apply it before the merge window; lemme know where you want it in the
end and we can get it done.

Thanks,

jon
