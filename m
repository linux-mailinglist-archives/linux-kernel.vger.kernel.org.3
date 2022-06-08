Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F05421B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiFHFF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiFHFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:04:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA93221899;
        Tue,  7 Jun 2022 19:00:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f9so5912645plg.0;
        Tue, 07 Jun 2022 19:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qeGk0uHM1MEBKnnaIOerMEbRB5WBgqbjWAmmj8SYnio=;
        b=C0oG22CuP15MdIWo7qMhyoFFD5M6fPB0LwZW9YWE5m2ze1PXDgSFhrc7MIjieiUT4/
         JjXtWgPkXYyDeElLjn40R+rZUhphkM0gPnh6VlZSBIxTEBciQcRkSobiBD2qWA8QQQv+
         uwXb9VyiI01NVt+iXGh+mlJcxZCJQMkPaCA0iYLlXS+R5f7v5mHCPIm+PPalRSKp5jj9
         WAM+B+3bt4q3WpMxKoiJKYDDFRCZasU2dvC66/X04ut4PQcwfOzyE2B1hPrYeBP2+9lp
         EZ8rqITL1wJcSbZ3IDa2VdCbck3W3Mnc1js6jaLgzSAyRJEW2NuqrcVACoZzh7f9nijK
         j8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qeGk0uHM1MEBKnnaIOerMEbRB5WBgqbjWAmmj8SYnio=;
        b=lzjqfG4R4hiHyf7Dkf6ruD5FpQgwDSRjubISNfEQmRu0IjKOrtH30p2VixqDn4BtP2
         8XwDn9irqOK6Y9OQ0fP/8WaN4hN6Nv/UGzvsluonS2OJeRjvEZtZGlU6LBHRJpEqkJFI
         Awc5ZH9PtAXBSd2fYZ+N/2U/fOQLOfosg3E4KDzReh+izThBtZukcnjoGpPonod6PIjz
         eRJV1SqXVRatnB6kHdUFx5g7C53lcjaerPexSF4OorljeneCUk4FUeBk4f4QaRT3SGOV
         nLNIeWc+BSbya9IAWvb2YHWc4gnzBdWRNFbVo7zvVMz9RoF8QB2h8AJxHR7xN6qSl3aO
         yYQw==
X-Gm-Message-State: AOAM531N0JUVJCowcHBs3+6i8+UVKLt4iXz8vf1odqUKyqKx9O6WogEC
        ElGoXXV1+B/BhaY7I2KcvII=
X-Google-Smtp-Source: ABdhPJyFyYnNcVBwh41bhInabywP7HuEqCcWjJ5rfxBIR5zchJX0ePQCjRU9INhO/SMK0syn0CkIKw==
X-Received: by 2002:a17:902:b689:b0:167:8b69:d1a7 with SMTP id c9-20020a170902b68900b001678b69d1a7mr8744102pls.156.1654653652768;
        Tue, 07 Jun 2022 19:00:52 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n36-20020a635924000000b003faebbb772esm14154869pgb.25.2022.06.07.19.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 19:00:52 -0700 (PDT)
Message-ID: <d6fab7d9-cf22-cb64-d4dd-50cf8bdd4bba@gmail.com>
Date:   Wed, 8 Jun 2022 11:00:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
 <20220607133432.GA32701@willie-the-truck>
 <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Alan and Will for your comments!

On Tue, 7 Jun 2022 10:34:08 -0400, Alan Stern wrote:
> On Tue, Jun 07, 2022 at 02:34:33PM +0100, Will Deacon wrote:
>> On Sat, May 28, 2022 at 01:15:30PM +0900, Akira Yokosawa wrote:
>>> The term "data dependency barrier", which has been in
>>> memory-barriers.txt ever since it was first authored by David Howells,
>>> has become confusing due to the fact that in LKMM's explanations.txt
>>> and elsewhere, "data dependency" is used mostly for load-to-store data
>>> dependency.
>>>
>>> To prevent further confusions, do the following changes:
>>>
>>>   - substitute "address-dependency barrier" for "data dependency barrier";
>>>   - add note on the removal of kernel APIs for explicit address-
>>>     dependency barriers in kernel release v5.9;
>>>   - add note on the section title rename;
>>>   - use READ_ONCE_OLD() for READ_ONCE() of pre-4.15 (no address-
>>>     dependency implication) in code snippets;
>>>   - fix number of CPU memory barrier APIs;
>>>   - and a few more context adjustments.
> 
>> I suppose this isn't really a comment on your patch, as I much prefer the
>> updated terminology, but the way this section is now worded really makes it
>> sounds like address dependencies only order load -> load, whereas they
>> equally order load -> store.

I tried to address this in one of the hunk:

+[!] The title of this section was renamed from "DATA DEPENDENCY BARRIERS"
+to prevent developer confusion as "data dependencies" usually refers to
+load-to-store data dependencies.
+While address dependencies are observed in both load-to-load and load-to-
+store relations, address-dependency barriers concern only load-to-load
+situations.

I'd appreciate if you could come up with some improvement here for a
non-RFC v1 patch in a week or so.

>>                              Saying that "An address-dependency barrier...
>> is not required to have any effect on stores" is really confusing to me: the
>> barrier should only ever be used in conjunction with an address-dependency
>> _anyway_ so whether or not it's the barrier or the dependency giving the
>> order is an implementation detail.
> 
> It would be more accurate to say that address-dependency barriers are 
> not _needed_ for load->store ordering because the dependencies 
> themselves already provide this ordering (even on Alpha).
> 
>> Perhaps the barrier should be called a "Read-read-address-dependency
>> barrier", an "Address-dependency read barrier" or even a "Consume barrier"
>> (:p) instead? Dunno, Alan is normally much better at naming these things
>> than I am.
> 
> Well, "load-load-address-dependency barrier" would be okay as a generic 
> name, albeit unwieldy.  Note however that on Alpha -- the only 
> architecture to need these barriers -- they aren't anything special; the 
> actual instruction is the equivalent of an ordinary smp_rmb().  (Please 
> correct me if my memory about this is wrong.)
> 
> So in principle you could simply call them "read memory barriers" while 
> pointing out the need for special use on demented architectures where 
> address dependencies do not guarantee load->load ordering.
> 
>> Alternatively, maybe we should be removing the historical stuff from the
>> document altogether if it's no longer needed. We don't have any occurrences
>> of read_barrier_depends() anymore, so why confuse people with it?
> 
> How about relegating discussion of these barriers to a special 
> "historical" or "niche architecture" section of the document?  In a 
> separate patch, of course.

Another option would be to add a section on "Ordering guarantees by
dependencies", and explain three variants: address, data, and
control.  We have only "control dependencies" section at the moment
and uses "data dependency" without properly defining it. 

Address dependencies are special in that they can provide load-to-load
ordering guarantees as well as those of load-to-store.
Alpha doesn't provide these guarantees at the architecture level, hence
the implicit address-dependency barrier in READ_ONCE().

Also, IIUC, arm64's READ_ONCE() is promoted to acquire-load when
LTO is enabled.  It is to cope with the possible (but not observed
yet) transformation of address dependencies into control dependencies,
which can't provide load-to-load ordering guarantees.

These points can be added later in memory-barriers.txt, but I'm
afraid I might not be up to such involved changes.

        Thanks, Akira

> 
> Alan
> 
> 
