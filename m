Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50560558D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFXB6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiFXB6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27785193E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F4862029
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61277C3411D;
        Fri, 24 Jun 2022 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656035879;
        bh=AvM2r2Dwmkrp7nXgI3/YdLz+CcrC6G/+zDSepL9bQeQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VavyeTXAbJB3UgTA1y4cRfrRCmV+QcK4jsZFnyj5E43eWud7//971HnGOkg4iNODz
         xZRQuZzehWXihDNmBMgvhYWz7qqbICA0rRvtPEVRCFqzaH1MX8ZRqRVd2ZNNfxlyGc
         NAiO8Idoc5EXVJUY9bjtq6YfRnq7BTpFCRAdNjHC+wlCjhOqxgGE3c+JLAxMk004ld
         7LckmdFgTkSXFIK+JQvxY9rV9vvkGCY0iCw5fF7GyqmF2mE5aLV9gmUEDEg0iroxGx
         0KiQ/lv3hJjwFmfw5CqBH1SIEnMkKRIwSSholq9EtSS3PFG5D9+xFzxCLxuEHknlU3
         qfEiKQLMVqQHA==
Message-ID: <ac0b07c8-0cd4-6ab4-2939-ead4c813ef78@kernel.org>
Date:   Thu, 23 Jun 2022 18:57:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
 <d104124c-5196-bc80-b3e3-0ab55f0cc35e@kernel.org>
 <89bc29c5-ad82-4f20-2855-44e57b043c49@gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <89bc29c5-ad82-4f20-2855-44e57b043c49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 00:56, Bagas Sanjaya wrote:
>> In an ideal world yes. But sometimes maintainer complain to break whitespacxe fixes and such into independent fix. Also as someone said later in the thread, for somebody just getting into kernel and figuring out patch submission etc this could be a perfect dry run and helps improve the code anyways.
>>
> Seems like you missed the point that it's OK to have typofixes while
> doing other real changes (like refactoring) in the same patch.

No I did not.

> Quoting from [1]:
>
>> My opinion is that trivial patches like this are fine as a starting
>> point for new contributors, which is why I acked the previous patch from
>> you guys. However, if we start getting two of these every week it just
>> adds more maintenance burden than it's worth.
> I tend to agree with the last sentence of above quote. Let's pretend that
> I'm the tree maintainer. Besides reviewing real change patches, I get
> flooded by these similar minor cleanup patches that I need to review.
> Some (but not all) these patches have issues (say subject or description
> error) that are repeated.

"Repeated" is the key - First time I'd politely tell them to DTRT but 
will just ignore if things continue.

> Lazily speaking, I'd like to privately notice the
> submitter about the situation, and I withhold these for now.

Funny that you say this: ever since this got posted I now see 3 patches 
for typo fixes :-)
But it is something in maintainers purview and for now i'm ok.

Thx,
-Vineet
