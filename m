Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8952E320
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiETD0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiETD0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:26:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D73B037
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:26:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so10380271pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H3VyJyYzyGl+bwWlPfM/C+xqUqwKodZh3oC5dIQJb8g=;
        b=AwN/O3Asl0gcWZcdhE9NIJP5pfBujS6ucL4RWcmhC+IwX5t26SWqzrMSCOmu4x87CJ
         EXAy/BekTbWA2UK4+5+NmfBrIrk0Hf3tkCc3MqWZW7GizzrbwVP42TbhlulYxrL5vrMA
         h5roqw3oYy1jkZ3cQdbEmR2Yxjd6hYoDbpAQF58lcqgwDkyIYBQpsK0EzwpB6pS+WbFY
         RjyMXbwFpJcbqy3CKdd1DN3yPEAD2FSrwDfL5s1oZSnBQfM/HSH3Lo2BhmoXa0I4eqVi
         2vBQXn+OgKrzMwnnqORx5/kU4rwTXMWML+1zV7oat8jgP/RqFqb0+tTzXkLpELUkEjfg
         3VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H3VyJyYzyGl+bwWlPfM/C+xqUqwKodZh3oC5dIQJb8g=;
        b=cDG2oTOyo36XC6q74AhW9tquTRWbGA33JNHPpJBYYOvQ6hh6DsJYV4OkpZ9m0wo5p7
         jU3riSJ+F2KjIg4zTw2X14JGYeh3QJsBJfeTv0/I25GBaoiWkXGVNS4cMscSZ9R5WHHC
         7wYQpS8LzxNPKbXamcP6VA3hyBhETNn4VaE9FRlOGGGM8QXCYSk796Je6+q3P1sPgoxs
         k6nP4NOKmgdGGsdWL6phVO2tRTOAQp9lGxoDuAknqCVdp+Us75SxlSYu6YGPo5BzB0D3
         jW/4TwshLzwZE0BasrfrIcDGQsGZjMKblZ2bYjqHQXMhk1k30+BHApeX0dIOmvcmre5l
         HtUw==
X-Gm-Message-State: AOAM531/X1PddsbuC/aJ1w5m9gEBuqfPDJLdLrLpWcp4cYYWJPsyGRIn
        gUeyK+aMejtGngX7MHUf05rC2Lq+0yKzOg==
X-Google-Smtp-Source: ABdhPJz5YLVpIXQZFKz5IvfX3ynX480UagoJcgM9QT+YK1tWoyRtQv7rNZ1srZURHMqBzImbbctoEA==
X-Received: by 2002:a17:902:d2d2:b0:161:be0f:ccd7 with SMTP id n18-20020a170902d2d200b00161be0fccd7mr7697007plc.98.1653017178987;
        Thu, 19 May 2022 20:26:18 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m9-20020a62a209000000b005185407eda5sm477650pff.44.2022.05.19.20.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 20:26:18 -0700 (PDT)
Message-ID: <25ec7b58-08bd-3732-2a2e-52b95cbffda0@kernel.dk>
Date:   Thu, 19 May 2022 21:26:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tytso@mit.edu, Jason@zx2c4.com, hch@lst.de,
        linux-kernel@vger.kernel.org
References: <20220519233137.20415-1-axboe@kernel.dk>
 <20220519233137.20415-2-axboe@kernel.dk>
 <YocGyl8mmG84tQD4@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YocGyl8mmG84tQD4@zeniv-ca.linux.org.uk>
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

On 5/19/22 9:11 PM, Al Viro wrote:
> On Thu, May 19, 2022 at 05:31:36PM -0600, Jens Axboe wrote:
> 
>> @@ -418,25 +419,23 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
>>  	 * the user directly.
>>  	 */
>>  	if (len <= CHACHA_KEY_SIZE) {
>> -		ret = len - copy_to_user(ubuf, &chacha_state[4], len);
>> +		ret = copy_to_iter(&chacha_state[4], len, to);
>>  		goto out_zero_chacha;
>>  	}
>>  
>>  	for (;;) {
>> +		size_t copied;
>> +
>>  		chacha20_block(chacha_state, output);
>>  		if (unlikely(chacha_state[12] == 0))
>>  			++chacha_state[13];
>>  
>>  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
>> -		left = copy_to_user(ubuf, output, block_len);
>> -		if (left) {
>> -			ret += block_len - left;
>> +		copied = copy_to_iter(output, block_len, to);
>> +		ret += copied;
>> +		if (copied != block_len)
>>  			break;
>> -		}
> 
> 		copied = copy_to_iter(output, CHACHA_BLOCK_SIZE, to);
> 		ret += copied;
> 		if (copied != CHACHA_BLOCK_SIZE) {
> 			if (!ret)
> 				ret = -EFAULT;
> 			break;
> 		}
> 	}
> 
>>  SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
>>  {
>> +	struct iovec iov = { .iov_base = ubuf };
>> +	struct iov_iter iter;
> 
> 	import_single_range(READ, ubuf, len, &iov, &iter)
> 
> (note, BTW, that this'll cap len)

Yep both of these are good changes.

-- 
Jens Axboe

