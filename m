Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05B487574
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiAGKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:25:18 -0500
Received: from foss.arm.com ([217.140.110.172]:38042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346679AbiAGKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:25:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A5013D5;
        Fri,  7 Jan 2022 02:25:15 -0800 (PST)
Received: from [10.57.38.163] (unknown [10.57.38.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A9053F66F;
        Fri,  7 Jan 2022 02:25:15 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220107103649.53774b30@canb.auug.org.au>
From:   James Clark <james.clark@arm.com>
Message-ID: <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
Date:   Fri, 7 Jan 2022 10:25:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220107103649.53774b30@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2022 23:36, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   e94f43ea200a ("docs: automarkup.py: Fix invalid HTML link output and broken URI fragments")
> 
> Fixes tag
> 
>   Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes

Hi Stephen,

Which validator are you using for this output? checkpatch.pl has a validator for commit references
and it actually complains _more_ if it's not wrapped at 75 chars. At least for ones in the
body of the commit rather than the fixes reference. Which is a bit confusing if there is
a difference in the rule.

> 
> Please do not split Fixes tags across more than one line.
> 

Is this just for the fixes tag and not for the one in the body? Would you consider adding
this check to checkpatch.pl and submitting-patches.rst as I don't see that rule mentioned there.

@Jonathan, I'm happy to resubmit with the changes, but it might be easier if you just
make the fix in place.

Thanks
James
