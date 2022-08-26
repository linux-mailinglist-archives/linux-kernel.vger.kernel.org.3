Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B95A322C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbiHZWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbiHZWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:43:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA705E9271;
        Fri, 26 Aug 2022 15:43:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A02147C0;
        Fri, 26 Aug 2022 22:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A02147C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661553837; bh=QPv9b/l/XjD014iBnw+DC990uATHsSMCMy7WAR72wlk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SmSKM3hgSG8qvqvtmi4+TMCSXOa+gb7x7kSy+XH+2kktxh6O1xfQsnqd99zE2mRPr
         fGuiqH7couNr7bAQwvQOWpZcQUJoW0hODDubGbveN4QqBUuOq1LiM7RMy9zhZCF2gs
         SEob1Ga9/lgrAXPuleLyuHz+XEjlKElPsCeM3qzYrC7we6Hevrb+ngOnawYI5sunKD
         mU5TLFF7wSdMPzpbCS3XIjl1DHsfqAruy31qRW4P5E55I7wHGubJ8XtUCLru+7XVa2
         C97uz8tlgqbO5j8ShbkzyAUrqHZOsvKEiv9/tRHSUbF4TdncoTMis9zkLOhL/+dV69
         y4D8JJsnPPY5g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     menglong8.dong@gmail.com, sfr@canb.auug.org.au,
        bagasdotme@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
In-Reply-To: <20220826152711.6756e510@kernel.org>
References: <20220826160150.834639-1-imagedong@tencent.com>
 <20220826135839.39c7711f@kernel.org> <874jxyu32m.fsf@meer.lwn.net>
 <87zgfqsld6.fsf@meer.lwn.net> <20220826152711.6756e510@kernel.org>
Date:   Fri, 26 Aug 2022 16:43:57 -0600
Message-ID: <87v8qesk0i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 26 Aug 2022 16:14:45 -0600 Jonathan Corbet wrote:
>> Jonathan Corbet <corbet@lwn.net> writes:
>> >> You'll need to CC netdev@ for the patch to get into the net-next tree.
>> >> Since this is a pure Documentation/ patch get_maintainer.pl did not
>> >> produce netdev@ in the recommended addresses.
>> >>
>> >> Please wait for a review/ack from Jon before reposting, we need his
>> >> permission to apply this patch.  
>> >
>> > I could also just carry it through docs; I'm about to send a set of
>> > fixes Linusward in any case.  I wanted to run a couple of tests to be
>> > sure, but I don't expect any problems with it...  
>> 
>> The patch is clearly correct, it can go in via whatever path seems most
>> suitable.  Let me know if you'd like me to push it; otherwise:
>> 
>> Acked-by: Jonathan Corbet <corbet@lwn.net>
>
> Oh, if it can make it to Linus via the doc tree before the 6.1 merge
> window that's even better!

OK, I'll apply it and ship it, probably next week.

Thanks,

jon
