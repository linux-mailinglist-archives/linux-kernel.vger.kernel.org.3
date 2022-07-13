Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477257403C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiGMXw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiGMXwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:52:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A554641
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:52:48 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x185so560453oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xlTQqbw7uDh4SuPsuMIuNWyY8gGG3CCpf0R5mOWG5uo=;
        b=GmdSul5V0h0l9vx6e6MKTO5tR7iI4VBAnIruDdHRvVtsL+ZN9U0erJYaKhBmX31wxN
         YJXKxJHDNRUvUZlxQaEVQ5WBdXsRH2CPxsnKx1NG1u/890cWUrlWSrBht9zPQIPh63kS
         QZSuoffMnAwsyl0W4LDEnhfBH4Ajgxk51V3Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xlTQqbw7uDh4SuPsuMIuNWyY8gGG3CCpf0R5mOWG5uo=;
        b=pQPgMmPZbblL4gIC0bA8H2lE2AwRWYtMxfmlQR0StFk5ssIhh5mUgLZaRnPhecP7iy
         4KHNrnjOPzNBggEswIsLHFStNzTwGL9W6pEr/QFl4OVJNGfiwtkdmlTEJ2/RHVbI+9c8
         4n0MuVralvbO8oWtcojNaYDDSXgm/RBl89XG12HEnmG+y6mvNft+11smoklM3upLou9k
         UykkA8Cdi5fc70cu3VMFv+ePtcjYWxlVbuly/vYeXmwHcU1yY2TFXlZRuiDJGdtQHjel
         blRzjcx99nr1iZ9dNp+Q/oNmKxUIXpyZHxBnKU7EMSaAbAg6JlakGNW8ZU0kZIJBAsQK
         dmwA==
X-Gm-Message-State: AJIora9+JNfKN/wZ+uzAEkyi3/3uhLfOtZk/I5B0p2LJWoG8xoEzn19S
        H659SL5Yz0Pv4Lhd86WqB7QxfiLDiU9Nbg==
X-Google-Smtp-Source: AGRyM1t8Oyx9JiN9pS02uZRL8cVCdFOv/rC2q7vL2hNTcSFUdc52uoNQSfKVpumlzFL3QKzMw1yZTg==
X-Received: by 2002:a05:6808:1183:b0:2d4:5eeb:1ca3 with SMTP id j3-20020a056808118300b002d45eeb1ca3mr3002185oil.8.1657756367781;
        Wed, 13 Jul 2022 16:52:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o10-20020a056808124a00b0032f51af1999sm56286oiv.42.2022.07.13.16.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:52:47 -0700 (PDT)
Subject: Re: [PATCH] selftests/kcmp: Make the test output consistent and clear
To:     Gautam Menghani <gautammenghani201@gmail.com>, shuah@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220629192822.47577-1-gautammenghani201@gmail.com>
 <YsuljDee9KGDPfsH@fedora>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bdcac68c-e227-6376-9d71-aa667596c4e6@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 17:52:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YsuljDee9KGDPfsH@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 10:22 PM, Gautam Menghani wrote:
> Hi Shuah,
> Please review this patch and let me know if any changes are required.

Remember to bottom post.

> On Thu, Jun 30, 2022 at 12:58:22AM +0530, Gautam Menghani wrote:
>> Make the output format of this test consistent. Currently the output is
>> as follows:
>>

Now what is inconsistent. It is not very clean from the output. Please
add more information on how the current information is inconsistent and
how you patch makes it consistent.

>> +TAP version 13
>> +1..1
>> +# selftests: kcmp: kcmp_test
>> +# pid1:  45814 pid2:  45815 FD:  1 FILES:  1 VM:  2 FS:  1 SIGHAND:  2
>> +  IO:  0 SYSVSEM:  0 INV: -1
>> +# PASS: 0 returned as expected
>> +# PASS: 0 returned as expected
>> +# PASS: 0 returned as expected
>> +# # Planned tests != run tests (0 != 3)
>> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>> +# # Planned tests != run tests (0 != 3)
>> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>> +# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>> +ok 1 selftests: kcmp: kcmp_test
>>
>> With this patch applied the output is as follows:
>>
>> +TAP version 13
>> +1..1
>> +# selftests: kcmp: kcmp_test
>> +# TAP version 13
>> +# 1..3
>> +# pid1:  46330 pid2:  46331 FD:  1 FILES:  2 VM:  2 FS:  2 SIGHAND:  1
>> +  IO:  0 SYSVSEM:  0 INV: -1
>> +# PASS: 0 returned as expected
>> +# PASS: 0 returned as expected
>> +# PASS: 0 returned as expected
>> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>> +ok 1 selftests: kcmp: kcmp_test
>>
>>
>> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
>> ---

thanks,
-- Shuah
