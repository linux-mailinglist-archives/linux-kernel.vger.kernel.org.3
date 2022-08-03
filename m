Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42DF588EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiHCOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiHCOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:32:16 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0641C905
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:32:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r70so12988703iod.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/j3Fr9QfRk1x010uV68rYVXfeBewZsxPUcsGA68QruU=;
        b=ZT3M9S40JMm27FIyb88LE0A+y31FE3ad/p6C/2XVdnxiIhnM2OFNQ1iGSQ9l+zGNPL
         fhOl6eg9vCmzgIEHGt66RUNLluN+PHl9v8eoy9SDJkTtUBL8odKOA35IwkxOMPVfyAV9
         /2PiWH9AkH6iVsy/TEqhuNrzE+97ete50KaRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/j3Fr9QfRk1x010uV68rYVXfeBewZsxPUcsGA68QruU=;
        b=xqzNlDCmpS9N8wz301g5ewF+jwcw6yNMCmAaA8Ni+Fn78ugQ3eUyVv5NzMBOGFw2fM
         sez1nN/BNpkUt+b6/ZQf344J6aiSL8e0CpmiHggM1vdhyEJOYpxcLCunAlK2kZZaWFDK
         4lrSQfNi+Dwrkt5Bcy+od+lryCmReyPUERrZSMLJbXSfWmBLAg7xopGUY/pS6pAHe/h5
         v7DeEMU1oFR2/oujfMR1z67pnAkaeOFxEV6vcbNnvO5eb/mF7w0yV45tG3cnDyFawu3a
         UshScV1BxtAtM3xniM4+DsvCGzZpfepB4vKzmrSstDumyT7g7s4n6gkg6q9zhW6lnXQW
         O7jQ==
X-Gm-Message-State: AJIora9rlfNfUJFh4xvK+ctWis2nsPkcar0XDxYdLRvW41YarzXAIPIB
        DV/9XGrIzZxNl9G77hDageWeig==
X-Google-Smtp-Source: AGRyM1vZ69hqTbQsygxpXIz1EH0kGCtYdQTsYCzbIYHN2gVW/05TXgy8zPaYnUUdx0aEW/r+fqyxYg==
X-Received: by 2002:a6b:6911:0:b0:67b:f03b:74c1 with SMTP id e17-20020a6b6911000000b0067bf03b74c1mr8859031ioc.58.1659537134101;
        Wed, 03 Aug 2022 07:32:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z7-20020a056e02088700b002de213ddb31sm1721276ils.71.2022.08.03.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:32:13 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
 <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
 <84560b65-12ed-da24-3698-45484f80802a@linuxfoundation.org>
 <fa7fb9b3-169a-199f-22da-006777a14e03@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <15a23d4b-ee26-a6a1-a785-b640c550bfb8@linuxfoundation.org>
Date:   Wed, 3 Aug 2022 08:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fa7fb9b3-169a-199f-22da-006777a14e03@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 10:44 PM, Guillaume Tucker wrote:
> On 02/08/2022 15:29, Shuah Khan wrote:
>> On 8/2/22 3:51 AM, Mickaël Salaün wrote:
>>> Hi,
>>>
>>> This change breaks the Landlock test build when performed on the tools/testing/selftests/landlock directory because the (non-system/up-to-date) kernel headers aren't found. Looking at the use of top_srcdir and HDR_PATH, it seems that multiple subsystems are using this feature. I consider this change a regression.
>>>
>>
>> I did a build test from the top level before sending the pull request
>> and didn't catch this breakage as a result. This breaks when build is
>> run from the test directory.
>>
>> We have had several problems related to khdr_dir and target and decided
>> to move away from it with this change.
>>
>>> It also removes the check on up-to-date kernel headers (thanks to the Makefile's target timestamp).
>>>
>>> I wasn't CCed for this change impacting Landlock [1]. Please keep in mind to add at least maintainers and related mailing-lists for changes on related subsystems.
>>>
>>
>> That is the usual practice and if I notice missing maintainers, I add
>> them. We missed this one.
>>
>>> The following patch almost revert commit a917dd94b832 ("selftests/landlock: drop deprecated headers dependency") and partially fixes commit 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):
>>>
>>
>> Guillaume,
>>
>> Will you be able to look at this and send a patch on top? I will
>> send another pull request before merge window closes?
> 
> Sure, I'll take a look today.
> 

Thank you.

> Also I'll see if we can add some extra build tests in KernelCI
> for the kselftest tree to catch issues like these automatically.
> 

Yes. Adding tests to catch these automatically will be great.
Please refer to use-cases for kselftest for tips on tests to
add. Beig able to build from individual test directory is one
of the use-cases.

thanks,
-- Shuah
