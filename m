Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4002487A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348278AbiAGQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiAGQfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:35:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6CFC061574;
        Fri,  7 Jan 2022 08:35:02 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 596EE385;
        Fri,  7 Jan 2022 16:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 596EE385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641573302; bh=YhgZI0FFIn0hZaq5zbXIpWpArNqcf+xaFaMH98W3O7s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gTjKnqYjVLLwUDWp64VbAkskquX2XUz9xQJ8vRD7IsI0mZm22pbQZdmvb0APZcq6M
         OzTcRyrmK6awej83cn0KhEWaDSJJbXwzjrV0tyUQdftmMlfpotBRdZZycfLWxQRnwu
         FkwVi15P5z6ilqv5JHYtCljs2ySVSVNJLajatC6uHownbh2OTNoZmSOnlD8EwVkxWF
         XZ9+FaWk754mukv+S3FI+uQBA6iJnZJHVCEw1kKqq8hmdkQ6iL2mPnQuawHd8KsJ5e
         /EsBJPX7zlvnLesLSCUjCAmueO9yMxKDHtOvD/uXkDRwbFFTrz450u2PMzgcg3cIeG
         +gRLXcDp7pNrw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     James Clark <james.clark@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the jc_docs tree
In-Reply-To: <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
References: <20220107103649.53774b30@canb.auug.org.au>
 <c13988e1-fd85-03e5-a05d-7bfee16d4c8d@arm.com>
Date:   Fri, 07 Jan 2022 09:35:10 -0700
Message-ID: <87lezro669.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Clark <james.clark@arm.com> writes:

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

[...]

> @Jonathan, I'm happy to resubmit with the changes, but it might be
> easier if you just make the fix in place.

I've fixed it, no worries.

Thanks,

jon
