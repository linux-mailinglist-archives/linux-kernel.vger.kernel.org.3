Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB6586C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHAOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:07:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6D1759C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:07:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d16so2434987pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KXRHooAKp8lJMCsyLPrXClHqY60FiEvjC4GCVlS1kYM=;
        b=LZgC777P8F+nWqEHaVOTTn3qXZ5NYO4gN3RMYOlR567D+cMNr8Nqi9m+pE4Dvhckv6
         viwg84jKHzufFyBbG0RVhWw5S+Z0KKSiAYEMmE9yMDVHcyrmA1vnLc/Q6i033hAPxGqu
         ALMxNBvAjiADAWDBh+llV4tUmJu0oWqcVaLFxekM6iUibqBcQ74WCcuDTL9DYMNLN8O5
         CW5WHXA+Za4FlCwDcPcHjwzCyAgc7G6Y3axwV9xXYeUL5vrO9+NaV2vmj5RT66LEO/3I
         0WXOrOZDWFzN0xOkDbldkguOtjzpQ1YPtiu0TZ69OjnGa9JgGdM4GF8mCuQDHvJxaDD5
         8vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KXRHooAKp8lJMCsyLPrXClHqY60FiEvjC4GCVlS1kYM=;
        b=SvJhUCoXPdAqEPpu7EuqJpFInYHMdptHQMNxSNEMUkpQP8m+Q61SVOl6a9EZngHlja
         Rc4XOuoASGj+Bx0WE8JGLvOoU7Os0MYrSeA8v8ULLdfJWaQXxfPEWDVzXrqPOoHT+nqh
         Ti3bhCQfSMZ4vp1Mr++Rov2c0Aw4+dyhZIITj9kk9WW1sk9b08EWMbT7ob5a74+DFkF1
         rlkAtj78LD15q1znfFin1SdCFiqjXhVV5Ub5jjePDA0cSOG8H+Sfp4gBahLJ7yIwQt0/
         nHc3/Lt6lcfjrp1+Vk+ZD66xfSav9UYSVozT5KUrW6QR2hVlmhn4GOJuzimJMj606SvN
         UdYA==
X-Gm-Message-State: ACgBeo1Np1l7LJahTbh38saqQWtH3p8ng1Uw3oyz/inJx+gUVROqWe+6
        sAC6BLPCQCBNdGhHfNHpzcQDqX1jdWPRUw==
X-Google-Smtp-Source: AA6agR6FusBcc8iIc2v9qLfwgyQS1RXFkKDyuMZsHKAgvxgv2xpXssx7BXuAw+qFtnW5Au6XKKABHA==
X-Received: by 2002:a17:903:264b:b0:16d:b891:593 with SMTP id je11-20020a170903264b00b0016db8910593mr17355407plb.133.1659362836258;
        Mon, 01 Aug 2022 07:07:16 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.144])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f64300b0016d66d49b85sm9594636plg.239.2022.08.01.07.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:07:16 -0700 (PDT)
Message-ID: <f594a252-a4f4-3a9a-8f62-51ee887a8b71@gmail.com>
Date:   Mon, 1 Aug 2022 20:06:58 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com,
        khalid.masum@aol.com
References: <000000000000bbdd0405d120c155@google.com>
 <20220730081246.4567-1-khalid.masum.92@gmail.com>
 <20220801104343.GA3438@kadam>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <20220801104343.GA3438@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 16:43, Dan Carpenter wrote:

> 
> These are precendence bugs.  The ! will be done before the >=.  Write it
> as:
> 
> 	if (pos < vc->vc_origin || pos >= vc->vc_scr_end ||
> 	    ret >= vc->vc_scr_end) {
> 
> 
>>   		/* Should not happen */
>>   		x = y = 0;
>>   		ret = vc->vc_origin;
> 
> regards,
> dan carpenter
> 

Thanks for the catch. I shall send another syz-test patch with these fixed.

thanks,
   -- Khalid Masum

