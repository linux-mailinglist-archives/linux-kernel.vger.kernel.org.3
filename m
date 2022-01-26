Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEA49D08F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiAZRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiAZRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:16:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DBBC06161C;
        Wed, 26 Jan 2022 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PDDX1wKG5hFVTVEzfMRB1AeOYAj6/ey3grH/4rL5ik0=; b=sSbgNeYjQBj/LEhgZMY+qH+KfT
        LFVskorPuMD84FiJUAYKagOUAU7ns0eQ0u2LEGiTHxckzt0SvzVZfdaOMtOPIDy92ItR1LAXsoTwi
        clBZtmRILDvBP/Ys3ae8MiPZ7QNjMfEVG3/LcI0lYKLN8rAl0hphDYmw6zJfJ72eoZMV3K5+LYANd
        DZJ7zb/Hv1Zyh2OEbaL7CdT/nhyLh5YmTIVLhrleSXwUr4xXF94Zj0oDq3cPbo4qqmyu8DFzLyQ4u
        Od99gfIfh5RJOuGe8ivWfiUK48vnJtRX7eU4RfXA9eO51LBRWLxByVmh571Md/fYJG24BlImx0clf
        sW4E9YDA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nClua-004Fb5-Ql; Wed, 26 Jan 2022 17:16:49 +0000
Message-ID: <4b433d55-95de-963b-7351-6db79855824b@infradead.org>
Date:   Wed, 26 Jan 2022 09:16:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] docs: add a document about regression handling
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1643110442.git.linux@leemhuis.info>
 <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
 <87sftbwemg.fsf@meer.lwn.net>
 <c8d7228a-2df5-df92-6d53-c3e940274dad@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c8d7228a-2df5-df92-6d53-c3e940274dad@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 06:10, Thorsten Leemhuis wrote:
>>> +The important bits for people affected by regressions
>>> +=====================================================
>>> +
>>> +It's a regression if something running fine with one Linux kernel works worse or
>>> +not at all with a newer version. Note, the newer kernel has to be compiled using
>>> +a similar configuration -- for this and other fine print, check out below
>>> +section "What is a 'regression' and what is the 'no regressions rule'?".
>> Can we be consistent with either single or double quotes?  I'd suggest
>> "double quotes" but won't make a fuss about that.
> Changed to "double quotes" everywhere in the text. But just to make sure
> I get things right: in this particular case this will result in
> 
> ...section "What is a "regression" and what is the "no regressions rule"?".
> 
> This looks a bit strange to me. Something in me really would like to
> quote the section's header in single quotes, but I guess grammar rules
> do not allow that, so whatever. :-D
> 

I think that it was correct with the mixed quotes. Using all double
quotes here is confusing.

-- 
~Randy
