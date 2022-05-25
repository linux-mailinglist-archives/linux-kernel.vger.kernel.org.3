Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F7534627
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiEYWBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiEYWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:01:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903536308
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:01:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD421F8DC;
        Wed, 25 May 2022 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653516082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZTWk+nqmtrWxTo6wTFkZfE7MJ+b6KvQ4q/PEBxVNNQ=;
        b=0rlM6xczS7xOBWrIBlX+Hpmv+IYMDxBsc1k3bAOno5Bs6zpfJtQj193O/I9swzVYvCXD9J
        l2f0vcX7M4drEFLwwsP+xP/BA5oDrN/GEbH9wNyM3f9b68GLeAVuMu/6QMNqs5kDxx2lOW
        N5ln3pZQCZCjQV8QqGVds2muh1UM0xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653516082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZTWk+nqmtrWxTo6wTFkZfE7MJ+b6KvQ4q/PEBxVNNQ=;
        b=DYTNjD+zIxxy5r97/tgP3d9zFmuEf44ixt/GlRvpycsenmLEE8VXhxDUWyJ1bHvVkuUEEL
        AvxCW2r/IaithyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1F4313ADF;
        Wed, 25 May 2022 22:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0HkhNjGnjmITHwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 25 May 2022 22:01:21 +0000
Message-ID: <af059855-959f-95b8-afc4-fad97e52cb46@suse.cz>
Date:   Thu, 26 May 2022 00:00:06 +0200
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
 <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz>
 <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
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

On 5/25/22 23:36, Linus Torvalds wrote:
> Because it used to be that stack depot users were fairly easy to
> figure out. It was all about pretty special debug options that enable
> a lot of very special code (KASAN and PAGE_OWNER - is there anything
> else?).

Some parts of DRM debugging and looks like also recently networking
through ref_tracker, which also seems to be debugging.

> Very clearly just debug builds.
> 
> But this slab change means that now it's basically *always* enabled as
> an option, and that means that now it had better do sane things
> because it's enabled by default and not something that can easily be
> ignored any more.
> 
> The kernel config phase is something I'm very sensitive to, because
> honestly, it's just about the worst part of building a kernel.
> Everything else is pretty easy. The kernel config is painful.
> 
> That means that we should not ask insane questions - and asking what
> static size you want for a data structure that 99% of all people have
> absolutely _zero_ idea about or interest in is wrong.

Understood.

> So the problem here is two-fold:
> 
>  (a) it introduces a new compile-time question that isn't sane to ask
> a regular user, but is now exposed to regular users.
> 
>  (b) this by default uses 1MB of memory for a feature that didn't in
> the past, so now if you have small machines you need to make sure you
> make a special kernel config for them.
> 
> And (a) happens unconditionally, while (b) is conditional. And it's
> now clear exactly what all triggers the actual allocation in (b).
> 
> I _hope_ it's never triggered unless you actively enable slub debug,
> but at least from a quick grep it wasn't obvious.
> 
> For example, if you happen to have rcutorture enabled, do you get the
> allocation then just because rcutorture uses
> 
>        kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
> 
> even if you have nothing else that would enable slaub debugging? It
> *looked* that way to me from a quick grep, but I could easily have
> missed something.

Yes, running rcutorture will trigger that stackdepot allocation, but as
that's in RCU debugging part of config, I considered it in the same
category as enabling slub debugging.
But yeah I realize it might become a problem if someone wants to run
rcutorture on m68k :/

>              Linus

