Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8142F47AF92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhLTPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbhLTPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:13:02 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791CC08EC6B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:57:15 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z26so13565804iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TJdNUjWUdmPE7sfT2RNHjkzrtpwFJc2mp64as/HudCM=;
        b=jDdz/ozzcBHT16QK0aB+2kOAZgdLHgDzP2EnuoDKYFIsA+s8BQwOde7Q9B9UBWC9wg
         BYGT/sYwbWltq4FYYQWzmY6Yr1csC2oaElTe3LE//89ujPBqyrakXuX66qMjYDtLIXkD
         m0kTEI2pUi4G/1BoqqRdkF55zJzwaDMfvNr4gHk3JbGwGD0gjbk4TmGqehTuhp2c3m6O
         4bb9kDdIGZmC+PTpZ9XYwot+QCNzL5vv+ecUV3IWrjW9tVHQ2cFmrSYAGHSbfeFqMy9n
         sZPIwd64ab9/ufVq2//++zfu12+pTDSDziUTqPuuC228CYHrM0zGkiojxH9YWgq4BQwY
         bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TJdNUjWUdmPE7sfT2RNHjkzrtpwFJc2mp64as/HudCM=;
        b=2KRBYHeLyZR5Jew7zv9WADCnef/xovAWjaQA0eQNVJBTLL67SmtiCqNkQaU2fEvho6
         TLG0wjA8kMtndTJY//yuOEUizsJWqV5yGCR2WJLXu5Eonb7fyAIFVl7R239RKhJPdynQ
         p8DKp+XtwY5uClNFiX5Cwom8ZHhgE0m7YUbHeIphVwyhHlJy2d6tgDfh95WDf96sgyYM
         K8XCqdhn60sVrwLkzd1QOLziYeiRLI4xmPE8Y1wVglD5vTpILFgU8AzbAh4k9ua1emGt
         pYMf1YwR9aCed2LVrEVtjah/yVwOhBjwhDWPniWvVMstlaiNg9v1mkejxXIH5mSxtU20
         Ky6g==
X-Gm-Message-State: AOAM533xGQRWrOpC3mBOGP2YjHFKx7V1RbFjrRlbrkT4/HnqUKzZ3GGd
        T2Z8KpJHlp5btHqnumyYvZ+NyQ674iwbb+Ku
X-Google-Smtp-Source: ABdhPJw8nMQz2mCzXM8QGJ6RmKg0otw0hfGtCPZcgichfprE8dtR7mbV3Fy/Lz5YLSaalLN5CZJL5g==
X-Received: by 2002:a05:6638:1481:: with SMTP id j1mr9783902jak.59.1640012234690;
        Mon, 20 Dec 2021 06:57:14 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r3sm9174856iob.0.2021.12.20.06.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:57:13 -0800 (PST)
Message-ID: <e71e6496-aecf-8dbc-632f-807cc686a567@linaro.org>
Date:   Mon, 20 Dec 2021 08:57:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [greybus-dev] [PATCH] Header line: Coding style fix
Content-Language: en-US
To:     Mark Greer <mgreer@animalcreek.com>,
        Jorge Eduardo Fermino Oliveia Silva 
        <jorge.ubermensch@gmail.com>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <Jorgecommit> <20211217143408.10313-1-jorgeubermensch@gmail.com>
 <20211217233408.GA47062@animalcreek.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211217233408.GA47062@animalcreek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 5:34 PM, Mark Greer wrote:
> On Fri, Dec 17, 2021 at 11:34:08AM -0300, Jorge Eduardo Fermino Oliveia Silva wrote:
> 
> [Note: I am traveling for the next week so I won't be very responsive.]
> 
> Hi Jorge.
> 
> Before we get to the platch please remember that you should send all
> Greybus patches to greybus-dev@lists.linaro.org and
> linux-kernel@vger.kernel.org.  I will add them in now and leave all of
> the context so other can see what you sent.

Thanks for copying the list, Mark.  I concur with your response.

Jorge, this patch is not acceptable, but I have some suggestions.
Your change is very minor (and not technically necessary) but
if you want to try a version 2, we can reconsider it.

First:  Your subject line is not proper.  Patch subjects should begin
with keywords that identify what the patch affects.  If you run this
command:
   git log --oneline drivers/staging/greybus/audio_manager_private.h
you will see examples of commits that affect this file.

Based on that, the header for your patch should be something like:
   staging: greybus: audio: fix a checkpatch complaint
But I don't actually know why you are suggesting this change, and
that brings me to the second point.

Your patch description should be more complete.  Your one line
description says "Solve CHECK: ..." but it doesn't give much
context about that.  Maybe that shows up in a build?  I don't
know.  Your description might be more like:
   When running "checkpatch.pl" we get this warning:
     Lines should not end with a '('
   Fix this by re-formatting the line in question.

But again, I don't actually know where you are seeing this message.
Ideally, your description should be sufficient for someone to be
able to reproduce the problem you're fixing, and then verify that
your fix makes the problem go away.

Third, what Mark points out is absolutely correct, which is that
you are "fixing" one formatting problem but creating a new one.
There is no great solution here, because some of the symbol/type
names are very long.  I have two possible suggestions though:
- Leave it as-is, and accept that the line ends in '('
- Re-format this way, so the warning goes away, but the result
   at least has consistent indentation (even if it isn't aligned
   with the open parenthesis:

int gb_audio_manager_module_create(struct gb_audio_manager_module **module,

         struct kset *manager_kset, int id,

         struct gb_audio_manager_module_descriptor *desc);


Finally, if you submit version 2 of a patch, be sure your subject
line is clear about that, with "[PATCH v2] staging: greybus: ...".

I'll leave it up to you to decide whether to send version 2.  Note
that someone else might reject your patch (even if you do what I
suggest above).  Some people dislike patches which make minor and
unnecessary changes to the code, because of the "churn" effect
they have.

					-Alex

> 
>> Solve CHECK: Lines should not end with a '('
>>
>> Reported-by: Jorge Eduardo Fermino Oliveia Silva <jorgeubermensch@gmail.com>
>> Signed-off-by: Jorge Eduardo Fermino Oliveia Silva <jorgeubermensch@gmail.com>
>> ---
>>   drivers/staging/greybus/audio_manager_private.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/audio_manager_private.h b/drivers/staging/greybus/audio_manager_private.h
>> index 2b3a766c7de7..a17f09a19014 100644
>> --- a/drivers/staging/greybus/audio_manager_private.h
>> +++ b/drivers/staging/greybus/audio_manager_private.h
>> @@ -12,10 +12,10 @@
>>   
>>   #include "audio_manager.h"
>>   
>> -int gb_audio_manager_module_create(
>> -	struct gb_audio_manager_module **module,
>> -	struct kset *manager_kset,
>> -	int id, struct gb_audio_manager_module_descriptor *desc);
>> +int gb_audio_manager_module_create(struct gb_audio_manager_module **module,
>> +				   struct kset *manager_kset,
>> +				   int id,
>> +			struct gb_audio_manager_module_descriptor *desc);
>>   
>>   /* module destroyed via kobject_put */
> 
> The part you're removing has all of the parameters at the same
> indentation level and what you adding has them at two different
> indentation levels so I'm not sure this is a step forward.  Since the
> kernel coding style doesn't address this specific case, AFAICS, I would
> leave it as is despite the complaint.  If others disagree then go ahead
> as I really don't care much either way.
> 
> Mark
> --
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

