Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D1534562
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbiEYU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEYU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:56:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF1B8BE8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:55:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8A4219EF;
        Wed, 25 May 2022 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653512157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkNtHHUbk34k9GTTfSiWqpyJtMifUO/9vR7vn76DJKY=;
        b=umH5R8nhEqs4aXQrapTm7n4iTga7w/P+L2kLmtFxmRRn2pNDpB2kH8V00BdboVD3iXylLs
        B/5J3rqMBEpz0eH3BREJZbP9P0VBSxzlnIxC0XOm2rqlmAOhMDdfbwju2MV+JcIojMGslS
        g+5eUpOKYAqDCRbAnrghN0sHqQpQcXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653512157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkNtHHUbk34k9GTTfSiWqpyJtMifUO/9vR7vn76DJKY=;
        b=+Bs2Mf9WblgLBm/kMvG4W2Qea84Ol5hF+3pegIgl+VBY8Hpm43tWyZ04GmGfHwNwBNmJ5Q
        WMD21gOhwZB+AUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DC2613487;
        Wed, 25 May 2022 20:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W6suFt2XjmJTCQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 25 May 2022 20:55:57 +0000
Message-ID: <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz>
Date:   Wed, 25 May 2022 22:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] slab for 5.19
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>
References: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz>
 <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Geert and Alexander

On 5/25/22 20:29, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 2:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>   The stackdepot conversion was already attempted last year but
>>   reverted by ae14c63a9f20. The memory overhead (while not actually
>>   enabled on boot) has been meanwhile solved by making the large
>>   stackdepot allocation dynamic.
> 
> Why do I still see
> 
>   +config STACK_HASH_ORDER
>   +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
>   +       range 12 20
>   +       default 20
> 
> there then?
> 
> All that seems to have happened is that it's not a static allocation
> any more, but it's still a big allocation very early at boot by
> default.
> 
> The people who complained about this last time were on m68k machines
> iirc, and 1MB there is not insignificant.

My main concern was that configs that enable SLUB_DEBUG (quite common)
shouldn't pay the stackdepot memory overhead if people don't actually
enable the slub object tracking on boot because they are debugging
something. It's possible I misunderstood Geert's point though.

> It's not at all clear to me why that allocation should be that kind of
> fixed number, and if it's a fixed number, why it should be the maximum
> one by default. That seems entirely broken.

As I understand it's a tradeoff between memory overhead due to hash
table size and cpu overhead due to length of collision chains.

> I've pulled this, but considering that it got reverted once, I'm
> really fed up with this kind of thing.  This needs to be fixed.

Right, I'll try convert stackdepot to rhashtable. If it turns out
infeasible for some reason, we could at least have an "auto" default
that autosizes the table according to how much memory the system has.

> Because I'm _this_ close to just reverting it again, and saying "No,
> you tried this crap already, didn't learn from the last time, and then
> did the same thing all over again just in a different guise".
> 
>                     Linus

