Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B650F96E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348385AbiDZKC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348107AbiDZKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:02:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D59C2A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:22:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so30882697lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stargateuniverse.net; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=PV73bocTIvCQn8NET1HiZ0/Dcwl7O5SOxSRVCwEBaag=;
        b=Wwph8JhPwKZsdLhcAKoOSuqPYggmwKqCOWc49/SwcAZ8Rrqz0Gl1G6Qm6XijWlBo4i
         KKYcE+AAt1gsZ0IX+d7EYnGBomeL/JbHbwd43Sa8AOlb4zqUnvu23d9dVNRQo5MASISP
         zi9Mlie0qdgOSV55KAdFSux+ZGc1dNPUmAJmo9/vP5O3jaz5amK45XrdqfqdyPwacQeJ
         9upZrcCozgMSCoSxRbHtfP8PJHEhA/IF6TVGxBFWQpzIuOIBFJSPVIhovAIsNCT3rKsS
         jCx8SlP6tXBujeJU0xeGdDcTybTq7ZHW4qpTs9py9cDUOLrlBPTWNmdXOL4c4RMWURAK
         wKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=PV73bocTIvCQn8NET1HiZ0/Dcwl7O5SOxSRVCwEBaag=;
        b=HsuT/hEur+tTJPeGwO7IojOU5XRlCq1wGdyGmcwL5o2f2C++0rzkiW7L5JfQF2zS2y
         vtXWpEIHfbkaiF11SCkfSTPJYGPR0G83CnBpsPH7NPOt+mhoCV8EOSb7EUjo0/3/tfhx
         zUoRpCJgzneKdVXvQDfmi/+EQTOMOXndSzLMHSm7acVJhURW4zxdZZpGzxv9dKKDHVap
         qH6lmrACFdRfMKqx8uuyqsdHTfBPGcxlmuKHQGpW5we93PQ0AL3usZ9AduGMumL0Ayf4
         6K4nUpGYIY7ZK3dbJxgB9dTlBxb3zk9chtwj+1iPHcaoLHIKQ3WFDQJeUAV6G3HRmkpq
         uV6g==
X-Gm-Message-State: AOAM533ZpZUAT2adjHA33T/SDms+XWlijhILYRiwOKwJp7hYa0YOYOSf
        Slccsp92UQedTgTXv99AIxXg2Q==
X-Google-Smtp-Source: ABdhPJxSBRMAWS0WtSGmShYwUnDkCEAh6zAEBYDGvaksZzP+5MpOUj4e4+boT9v2H1geOww0rLUBPQ==
X-Received: by 2002:a05:6512:1585:b0:448:3936:a5a0 with SMTP id bp5-20020a056512158500b004483936a5a0mr16005888lfb.108.1650964920785;
        Tue, 26 Apr 2022 02:22:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:9cae:8c00:9682:e720:334f:2fac? (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id h29-20020a19ca5d000000b0047052f6ed1esm1674942lfj.91.2022.04.26.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 02:22:00 -0700 (PDT)
Message-ID: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
Date:   Tue, 26 Apr 2022 12:22:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Kari Argillander <kari.argillander@stargateuniverse.net>
Subject: NTFS3 driver is orphan already. What we do?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After ntfs3 got merged and 5.15 got released ntfs3 maintainer has kept total
radio silence. I have tried to contact him with personal mails with no 
luck. I
have chosen bunch of people to discuss what we should do this driver as 
this is
already orphan. Feel free to add more if you think it is necessary. There is
lot of bug reports which are ignored completely. Lot of patches which nobody
applies.

He did some work after 5.15, but has not send PR for those [1]. I did 
also ask
to use fix and next branches seperetly and tag stable fixes, but he did 
not do
that eater. I think Konstantin did not yet quite understand meaning of 
stable,
next and upstream and it is not ok to applied every patch to same tree 
for any
point.

Personally I did my best try to help Konstantin with maintainer things, 
but I
have to say that it was quite difficult as he mostly ignored emails and 
do many
things like he wanted. He did not suggest anything to anyone if someone send
patch. He just applied those or ignored. Also sometimes he just applied own
patch without sending it to review process. Of course new maintainer 
needs time
to learn things but just wanted to say these so everyone knows how 
things went
so far.

I also did suggest that I could co maintain this driver to take burden from
Konstantin, but haven't got any replay. I have worker towards better CI 
system
for myself for ntfs3 which of course will be public in some point if we 
solve
current situations. If we keep this driver we really need very good fstests
support. But we also do not have very good open source utilyes for ntfs.
Konstantin said that he will open source those as well, but here we are 
waiting
and we will probably have to wait long time.

Now is time to think what we should do. Should ntfs3 just be removed? As I
really wanted to see that ntfs3 will be big thing I have to say that I 
vote for
removing unless someone comes to rescue this catastrophe. Yes we break
userspace, but we might break it silently if nobody is maintaining this. 
I also
do not believe that if someone is just accepting patches that it is enough.
Ntfs3 is not so ready that we do not need some ntfs specialist to 
maintain it
imo. Really public CI might save something if we keep this in and I will 
work
towards that if we choose to keep this in.

And if Konstantin read this please come and join this conversation.

   Argillander

[1]: https://github.com/Paragon-Software-Group/linux-ntfs3/commits/devel
