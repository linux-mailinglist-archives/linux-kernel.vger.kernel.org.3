Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E1487A38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348200AbiAGQUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348184AbiAGQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:19:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B7CC061574;
        Fri,  7 Jan 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JvvUXPky0B7kxP/6smFokZYD+5GbbZFeVRl5OiVQfgQ=; b=GZed5XQKepvZPFkKZlnKep5xx4
        0p0TBlDKazGWyOjgKRJCuZQBigYO52Y6veJpWgoNvkEB3KarxV41i0n4uX2+aO3INUr604SM1INVl
        2LaNJ+HqznXoaFC2TYhQIwNXdl4KMKg2z2cpYoCBlArIAvGAboNKZs0OqLh0XLOxkNytD+GPOjWa2
        nhyoSixTz51rAdLEfHMzS5c3XTB0LAzgNlS7tvn8h12S6naS8mwzu4PPEwBeUBPKqXWz/22hd2aDE
        iz+amSeEZ1oHsAwQtG7H9f9FQdWoO5ZB44jKGMAwjjYYK/+zBwJSmIUZ2JpYIaqtKVIxcX7/khJZg
        2jKW4YlA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5ry1-005rcH-Fv; Fri, 07 Jan 2022 16:19:49 +0000
Message-ID: <2359d7d0-3530-c849-5a52-d7b362df2dd1@infradead.org>
Date:   Fri, 7 Jan 2022 08:19:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220107103649.53774b30@canb.auug.org.au>
 <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

First of all, don't always believe what checkpatch says.
Just take it as a hint.

On 1/7/22 02:25, James Clark wrote:
> 
> 
> On 06/01/2022 23:36, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>   e94f43ea200a ("docs: automarkup.py: Fix invalid HTML link output and broken URI fragments")
>>
>> Fixes tag
>>
>>   Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for
>>
>> has these problem(s):
>>
>>   - Subject has leading but no trailing parentheses
>>   - Subject has leading but no trailing quotes
> 
> Hi Stephen,
> 
> Which validator are you using for this output? checkpatch.pl has a validator for commit references
> and it actually complains _more_ if it's not wrapped at 75 chars. At least for ones in the
> body of the commit rather than the fixes reference. Which is a bit confusing if there is
> a difference in the rule.
> 
>>
>> Please do not split Fixes tags across more than one line.
>>
> 
> Is this just for the fixes tag and not for the one in the body? Would you consider adding
> this check to checkpatch.pl and submitting-patches.rst as I don't see that rule mentioned there.

submitting-patches.rst says:

If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts.  For example::

	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")


Yes, checkpatch warns about that. Just ignore it.

> @Jonathan, I'm happy to resubmit with the changes, but it might be easier if you just
> make the fix in place.
> 
> Thanks
> James

-- 
~Randy
