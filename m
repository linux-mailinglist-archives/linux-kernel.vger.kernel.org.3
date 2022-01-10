Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF911489659
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiAJKaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:30:25 -0500
Received: from foss.arm.com ([217.140.110.172]:59592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235505AbiAJKaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:30:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED3DED1;
        Mon, 10 Jan 2022 02:30:23 -0800 (PST)
Received: from [10.57.34.253] (unknown [10.57.34.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B4D3F5A1;
        Mon, 10 Jan 2022 02:30:23 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220107103649.53774b30@canb.auug.org.au>
 <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
 <2359d7d0-3530-c849-5a52-d7b362df2dd1@infradead.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <527649a0-9c1e-f9cf-62aa-d13af10930e7@arm.com>
Date:   Mon, 10 Jan 2022 10:30:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2359d7d0-3530-c849-5a52-d7b362df2dd1@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2022 16:19, Randy Dunlap wrote:
> Hi James,
> 
> First of all, don't always believe what checkpatch says.
> Just take it as a hint.
> 
> On 1/7/22 02:25, James Clark wrote:
>>
>>
>> On 06/01/2022 23:36, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> In commit
>>>
>>>   e94f43ea200a ("docs: automarkup.py: Fix invalid HTML link output and broken URI fragments")
>>>
>>> Fixes tag
>>>
>>>   Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for
>>>
>>> has these problem(s):
>>>
>>>   - Subject has leading but no trailing parentheses
>>>   - Subject has leading but no trailing quotes
>>
>> Hi Stephen,
>>
>> Which validator are you using for this output? checkpatch.pl has a validator for commit references
>> and it actually complains _more_ if it's not wrapped at 75 chars. At least for ones in the
>> body of the commit rather than the fixes reference. Which is a bit confusing if there is
>> a difference in the rule.
>>
>>>
>>> Please do not split Fixes tags across more than one line.
>>>
>>
>> Is this just for the fixes tag and not for the one in the body? Would you consider adding
>> this check to checkpatch.pl and submitting-patches.rst as I don't see that rule mentioned there.
> 
> submitting-patches.rst says:
> 
> If your patch fixes a bug in a specific commit, e.g. you found an issue using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> parsing scripts.  For example::

Thanks I missed that bit.
> 
> 	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> 
> 
> Yes, checkpatch warns about that. Just ignore it.

I looked into adding a line break warning in checkpatch for 'Fixes:' but it's not easy because it seems like
the fixes field is more permissive than the other one:

	o Fixes: style doesn't require ("<commit_description>")
	parentheses and double quotes like other uses of
	git commit ID and description.

> 
>> @Jonathan, I'm happy to resubmit with the changes, but it might be easier if you just
>> make the fix in place.
>>
>> Thanks
>> James
> 
