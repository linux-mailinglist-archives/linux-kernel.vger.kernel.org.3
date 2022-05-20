Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C752E1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiETBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiETBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:11:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0C248E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:10:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c22so6491933pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W1tiYidB9VbdEzAyF+NhHjubEysTDlNRhrUd/eA+Ohk=;
        b=Eoe4LeOynIcxC6493WrqpLFDgXJ015hlZEm33YCOqHuyQslWcUo+zsFQelUeiPghU4
         uvIBsTHDjpX2WGGfPRycvvNxh2dyEvnvN8npb+wgrQBYOGb3wGzWwiGX8imSf+yRSuB0
         nY5NiWwXMvVZ5Fj3FvgJXvcnwIYaqdRczdVKrxtVBeXFN8+xN1fYUa/9eAWL3T1E1gF8
         kE+0K1jzjdB0YylcCKbK7kfpPFkD21eNwHOQ41VFLXmpGZ8H4/vgWo0MGXjPZCrK0Jxf
         KHboaupHaCtNLchLY/SSNlI4Acw/LPhtJnOZcAVCxjpiMT89UanLSbicBx/RLpKc7QJp
         6wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W1tiYidB9VbdEzAyF+NhHjubEysTDlNRhrUd/eA+Ohk=;
        b=SrnXd5zz2O5tXWMjbcg37JaGXOFR+NAtKuLPwNjbP0xrUPCFQlM1ZZ29ZV3HQBMOTg
         IC+YZsEgTvyortYmmKNKdQkVpS7ENJmP6epyRe77NTY2upJbvZJkWrWpYQu/s4r4QOFp
         jr9djPuSO6cydVNWF25ynfymWJYY+Kxv/tNuZPBtH/IJEYOHz+JnqPHdQ5QziLR4fAn2
         8TD4QuBVwyubcnZycr2gjcYyXSkQeLIc4dPh07FQGQNUHytbBIADKSTbr5qHkdbEXBDp
         PPYlpUSPHrydyhltX7XPSggQCYi8PwzZx71+RGqd5o79E5sgce+nC6MJ+ZExlQPuP7Rd
         EQqQ==
X-Gm-Message-State: AOAM532xSdLA84Oy+sGI+XIZnbuixPZ/ia91iRMz9Mfj2cIbokd6vE0a
        YLA3SsTg5B4CCrKXYH73z9ISQ1tG82qqew==
X-Google-Smtp-Source: ABdhPJwcj3YBUD1wXbxinW6AUwLS8DdyQQLMFOvsbI3s732XF8KMRsEdteZkeIVAIJsQapG2J0IfDg==
X-Received: by 2002:a05:6a00:238f:b0:4f6:b09a:4c63 with SMTP id f15-20020a056a00238f00b004f6b09a4c63mr7614917pfc.35.1653009058222;
        Thu, 19 May 2022 18:10:58 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090a380c00b001df1f7c5941sm455440pjb.16.2022.05.19.18.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 18:10:57 -0700 (PDT)
Message-ID: <435cc499-7564-13e2-c4ef-a71119379cf0@kernel.dk>
Date:   Thu, 19 May 2022 19:10:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk> <YobldmDn6pU9mr4f@zx2c4.com>
 <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk> <YoboEokc00YACuha@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoboEokc00YACuha@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 7:00 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 06:56:12PM -0600, Jens Axboe wrote:
>> On 5/19/22 6:48 PM, Jason A. Donenfeld wrote:
>>> sendfile() returns -EINVAL even with your patches. Only splicing to pipes
>>> seems to work.
>>
>> Huh, that really should work. Are you trying to sendfile() to random? If
>> so, you need that last write_iter patch too, and add the splice_write as
>> I mentioned.
>  
> No, I've only tried the read side so far. I made a little program:
> 
> #include <sys/sendfile.h>
> #include <stdio.h>
> 
> int main(int argc, char *argv[])
> {
>         ssize_t s = sendfile(1, 0, NULL, 0xffff);
>         fprintf(stderr, "ret: %zd\n", s);
>         return 0;
> }
> 
> Then I ran `./a.out < /dev/urandom > /dev/null`. Fails. OTOH, if I
> replace /dev/urandom with an ordinary file, it succeeds.

Here's why, it's limited to regular files or block devices:

if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
	return -EINVAL;

in splice_direct_to_actor().


-- 
Jens Axboe

