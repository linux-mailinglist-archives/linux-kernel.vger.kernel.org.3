Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1149EAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiA0SyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiA0SyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:54:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3DC061714;
        Thu, 27 Jan 2022 10:54:02 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 076B237C;
        Thu, 27 Jan 2022 18:54:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 076B237C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643309642; bh=jtk/KW+m1IYL06hk5WX5d6y8yOstM3j8jRuf438cZ5w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LfYJQ5qH671bolRDkVUx5Jka9GmV8s9BWDtBhu5ot9FYvIJ//RLhKItmYhoaOu4LP
         YUiUC9WsmK1wZ+PP7mJemvWQjDs2CvwrONLllC21Sf/Q97OL5DjmTdStL0ACgTYbcM
         tmoEqhbvmClTDWAOL2cmjHb6BjaUmnnBRiWBQVhH1UrWtIaOvOQlJpVClq2Q1LN/Y8
         L5z0RlGz6s5H2BBh77TiHDqu12WMeiUUh61uP/DbatrVigc3ILU1+edVEE8klFs0A3
         fXWdnxgNpnT3MT1KjyoWv/qbTsAe1jYuYMqcLE4LC/uHrnXvooRBkOYlOBjpsIUDzM
         1WfM3vb6nSHDQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v2 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
In-Reply-To: <1e2e99f6-e9bf-7d93-9629-3d70275c77f4@infradead.org>
References: <20220127163258.48482-1-andriy.shevchenko@linux.intel.com>
 <1e2e99f6-e9bf-7d93-9629-3d70275c77f4@infradead.org>
Date:   Thu, 27 Jan 2022 11:54:33 -0700
Message-ID: <87h79pqaae.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 1/27/22 08:32, Andy Shevchenko wrote:
>> It's unclear from "Submitting Patches" documentation that Reported-by
>> is not supposed to be used against new features. (It's more clear
>> in the section 5.4 "Patch formatting and changelogs" of the "A guide
>> to the Kernel Development Process", where it suggests that change
>> should fix something existing in the kernel. Clarify the Reported-by
>> usage in the "Submitting Patches".
>> 
>> Reported-by: Florian Eckert <fe@dev.tdt.de>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v2: rephrased as suggested by Jonathan
>>  Documentation/process/submitting-patches.rst | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index 31ea120ce531..fb496b2ebfd3 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
>>  The Reported-by tag gives credit to people who find bugs and report them and it
>>  hopefully inspires them to help us again in the future.  Please note that if
>>  the bug was reported in private, then ask for permission first before using the
>> -Reported-by tag.
>> +Reported-by tag. The tag is intended for bugs; please do not use it to credit
>> +feature requests.
>>  
>
> LGTM.
> Although it could refer to Suggested-by.  :)
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
