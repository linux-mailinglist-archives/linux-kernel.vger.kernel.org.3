Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E2564B27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGDB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:27:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2C638E;
        Sun,  3 Jul 2022 18:26:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d17so7617263pfq.9;
        Sun, 03 Jul 2022 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ieZM4I/lSEfirwlIwobyMNES9mlZjAb1KZ9UDR8eVQs=;
        b=XnQq5hlK2N+hRyvrjNLjpLJxsMHm3bWK65AXU/TfUx8/auS6lmw2hdsUfnocriR7Ok
         Dc8kA5jHIX+YqVoHqwGWCHeWvo5goc1GA7ZyswOEb5xIPmGb6j3p/l1joBBEXEBufA8l
         VFAC99aIVy5wvF+mhcorm6Mi2h/+rgxMt8GF/OI051NVoy8FpjF0Iw9ErwdCugd2Lh0C
         XtHZnBfquwh0zck3j/jwsgNScVKg2QXxZ4raEVlfm+I2T5Ba6bNUPoUK7diyMGFbQqzq
         h1iRK4DJLknqLlRqSqBd7uMT/0l56x9WodUL4LaGmfZCE+MDjFSKvk8uP52gLsMNCYcC
         EzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ieZM4I/lSEfirwlIwobyMNES9mlZjAb1KZ9UDR8eVQs=;
        b=31eEIGWxo4wCH1WEOOmiCX6lAZCBnlc/NUBHJg5+EXDXp1wWQ72llIEEm9Eyl4/6eG
         hfyJyaAfEf4S4oWYUEKxPY5B5yMaQVKnaj7gkf4JxmlIVEVIb4MYj2EtTCkoUjZQbTMt
         uA8vKOea18SPg+RKbFAnMg5ZhKr5fLrALmzzXY4pAfSDuoU5Hb7Hz5Y1YZihDPGrOb3u
         vDkYSRdZzjazudRLpi9yQhs2E2mYObGri5icsY15rB1ZdIY8Ns9rhmO5Icyk/eYjaIuX
         F6F0Zb6qpCWDrSMHYmkMU/VIUFDK2M2yCNxk/rcyCA26DqZ+nCDkXE3Swhyg1/JGisJz
         ZR3w==
X-Gm-Message-State: AJIora/HvCGEySnd7jOszAGa8Qh3Tl+TgPZU3BgTZ8nuNsvB9qgecYyK
        078AXJc0mqI+DrGjaPNw5bjVKtZHl8Glzw==
X-Google-Smtp-Source: AGRyM1vFEzEcbjfeZ5EqUl+MJbcxqNhift0Wr6mUunN7zlINYGfehD2Q/K+TJgVbvKqqzjiOwzG6PQ==
X-Received: by 2002:a63:4b20:0:b0:401:ae11:2593 with SMTP id y32-20020a634b20000000b00401ae112593mr23436243pga.375.1656898017461;
        Sun, 03 Jul 2022 18:26:57 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id 132-20020a62198a000000b0051bc5f4df1csm19664185pfz.154.2022.07.03.18.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 18:26:56 -0700 (PDT)
Message-ID: <3c0df530-d512-9012-8bc6-2ff56e860dbd@gmail.com>
Date:   Mon, 4 Jul 2022 08:26:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: htmldocs: Documentation/ABI/testing/sysfs-bus-iio-sx9324:2:
 WARNING: Unexpected indentation.
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <202207021703.lEW6FLT1-lkp@intel.com>
 <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
 <20220703105734.05076795@sal.lan>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220703105734.05076795@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/22 16:57, Mauro Carvalho Chehab wrote:
> Em Sun, 3 Jul 2022 10:29:44 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> escreveu:
> 
>> On 7/2/22 16:23, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   089866061428ec9bf67221247c936792078c41a4
>>> commit: 4c18a890dff8d95ca234d184773910383a978d45 iio:proximity:sx9324: Add SX9324 support
>>> date:   5 months ago
>>> reproduce: make htmldocs
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>   
>>>>> Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.  
>>>
>>> vim +2 Documentation/ABI/testing/sysfs-bus-iio-sx9324
>>>   
>>>    > 2	Date:		November 2021  
>>>   
>>
>> I'm not sure how to fix above, since the Date: field looks OK to me.
> 
> This one is trivial: just add a blank line. I already provided
> Jonathan a feedback about that:
> 
> 	https://lore.kernel.org/all/20220626234411.227c1a87@sal.lan/
> 
> Regards,
> Mauro

Ah! I don't see that.

In mean time, Akira has sent the same fix at [1] and I gave the
Reviewed-by: tag

[1]: https://lore.kernel.org/linux-doc/abcaa4f5-7a9b-56b5-c11a-a88fef9d1e0a@gmail.com/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
