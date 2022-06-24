Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD455A467
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiFXWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiFXWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:36:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F408150E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 15:36:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l24so4071087ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dzsFi3Tm31RRj46I6v9flRwI9+x4OGkpaqX7IUefLt4=;
        b=CbA4Yl+rqzLWL060P/BveqY+ySvMH5VQeADfk9tQbDsR6KT05Q3kdXRsbqKMlUrxMp
         RCpDwcoQ5cUSAunCOkGD+44dvHVlwM637WKU7gikMgTuArc9v27DnCth8BmxQKfNnDKR
         1WvtRxPF3ObkjonbrKj1or8JlDYUJYHled9qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzsFi3Tm31RRj46I6v9flRwI9+x4OGkpaqX7IUefLt4=;
        b=dpCfPAKfh2S3QyTsHWThRyjhvVDsMLnih49vwv2Rr/nXHcurRiGC0Q0MkTgYB75K4w
         dbNZvFd3s3MXLLYg6nJRgoYrJUVoYhVYn31GLbj7QKcQnuxGYXKAMlJim1b8cDV1RDJj
         br5o4mh2feBorjvxDPM2eep84Bn78dvFtONppkFkCW29fZZ9CpHHO2muPD9D346U6W0B
         KNtUkR2FIe1k370mCQOAovkiOTldfc4GqmLHIZi5nco4/kIJCd/CplkrHxG0mZpcbEJm
         IE3kb26NvBIkoTnVOLceqiAFLW/MrQ6f701l0B2YX9XBm6xPmOGbAnO15IG2GLX/Josp
         tr4Q==
X-Gm-Message-State: AJIora8UchrBk82XlhrxwxMdqXv+pPssR0FsnFbMM/Po6mTO8f4yypy1
        JJssJfPX2LFmtpDPUW0wvfK10Q==
X-Google-Smtp-Source: AGRyM1soQp0JvjN7IVr8qbseSCdVVA9ga4KCn7FFVmdaAMD3Wl7xuzZkWZHs68lMctYLlwyGzVc5oA==
X-Received: by 2002:a05:6602:2e8c:b0:66a:4455:f47f with SMTP id m12-20020a0566022e8c00b0066a4455f47fmr682243iow.117.1656110218051;
        Fri, 24 Jun 2022 15:36:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 126-20020a6b1584000000b0066579afd3cbsm1768780iov.50.2022.06.24.15.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 15:36:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
To:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220603195626.121922-1-dlatypov@google.com>
 <87pmix3ktq.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2c3399e9-4f4e-a71a-4030-e4e6d72b5d4e@linuxfoundation.org>
Date:   Fri, 24 Jun 2022 16:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87pmix3ktq.fsf@meer.lwn.net>
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

On 6/24/22 1:47 PM, Jonathan Corbet wrote:
> Daniel Latypov <dlatypov@google.com> writes:
> 
>> The information is duplicated now in run_wrapper.rst, which was added in
>> commit 46201d47d6c4 ("Documentation: kunit: Reorganize documentation
>> related to running tests").
>>
>> You cna compare these pages here:
>> https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/run_wrapper.html
>> https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/kunit-tool.html
>>
>> We should have deleted it in then but it got overlooked.
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> 
> So not that long ago these patches were going through Shuah...it seems
> that's not happening anymore?  I can pick up kunit docs patches,
> certainly.  I've taken the silence on these as assent and applied them.
> 

I am still taking ksefltest and kunit doc patches through my tree. I wait
for Brendan to ack at times. This one didn't show up in linux-kselftest
list it appears.

If you cc linux-kselftest and I get an ack from Brendan, I will take this
through kselftest tree.

thanks,
-- Shuah
