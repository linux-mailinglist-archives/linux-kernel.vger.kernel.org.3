Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CC4C81DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiCAEA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCAEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:00:57 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C96F4505A;
        Mon, 28 Feb 2022 20:00:17 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id fc19so15780067qvb.7;
        Mon, 28 Feb 2022 20:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FtXyo60QZSjtghzy6Q0huqzwOiUzsZebKnUebVoTLPE=;
        b=j7N3DqDy8b4YVBCpv3fcLo/UQbC6MMUAeaQ4U6D1F9YtLt/dxM1mgJ5CHX3B1xKjXi
         rKUVdA64xlyMEq6gJEH4YsBRy++k3egJt1Y9//vE+6UOa6LLI6glhoKlDi74Pby1m3br
         0VK8Oq3pSWMUcELQCOx0dxFI2UbA67pr69s3N6pjgs9HsvqsLwfbTOGMTpAVmh3mgW7j
         0zEyZ9JCwUwDdMgvRm6AYopWLKNBp+PAEMbjPPefM64c8k2mYbbf4eHt7iE26xyzRr93
         6ep3eWoOVJ3a8BDzFeCSCwbYNAs9sQ6EzV0elhCTTVTFFYTu+LkDmjsWDr7QVCpbcdPP
         jkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FtXyo60QZSjtghzy6Q0huqzwOiUzsZebKnUebVoTLPE=;
        b=1W5lOOJ6Sekw/prQ4OI1YIDYbGX03h7EQyukDvubwCBpUeeNFHvPuTL6yHwaf+KEc/
         BaPJ/TwtGenApv6sbKI+sqWyS2rR/LRZmVKho9vE1M4QBFQ6+jq3fa8xb4dU6DJKEfQh
         XyOILJawQAQEZHXTmFHE+HB/09/I5+l59nLWrxHWh5mkywVCKAPzPZDjTJoE8phggWEg
         PMkVAd7KVxR5SVM6z6ZIp7SODux5oWk+C2Ah0SSgVHNSUlTXQrBPJnLPiOHfg/Q1tk/n
         3Hrrr13im2BFRFwHLqs7dALXRkiP6CHK2yXth227LRDGN5SYOWDkN0xzEd4r7iqlHcux
         fYVQ==
X-Gm-Message-State: AOAM531lzeJ2FScex4RXlOZkdVjInBmpeRPiOqW8gW/pO4+M8LYFjmZ+
        kyyXgAoekRWdFg+yg4jfdBWOFnXHhJ4=
X-Google-Smtp-Source: ABdhPJwfiOBSu/Ty7giTR3H87bg2AxgESx2gPXEQWljnV5lzzXXCiSTDh6BP12fjAveocrl9nIUWGA==
X-Received: by 2002:a05:6214:29cd:b0:432:3f0d:a071 with SMTP id gh13-20020a05621429cd00b004323f0da071mr16300852qvb.86.1646107216685;
        Mon, 28 Feb 2022 20:00:16 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:ed66:faaa:6559:18c7? ([2600:1700:2442:6db0:ed66:faaa:6559:18c7])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a14b700b00648eb7f4ce5sm5871313qkj.35.2022.02.28.20.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 20:00:16 -0800 (PST)
Message-ID: <db542880-304a-f48b-2159-d0955841c8e9@gmail.com>
Date:   Mon, 28 Feb 2022 22:00:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220201181413.2719955-1-frowand.list@gmail.com>
 <CAL_JsqKrWQ1Jn2HCxFsPKYcPXbYUgyPytvc_YrS=sgkWHv1hZA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqKrWQ1Jn2HCxFsPKYcPXbYUgyPytvc_YrS=sgkWHv1hZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 15:24, Rob Herring wrote:
> On Tue, Feb 1, 2022 at 12:14 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If unittest detects a problem it will print a warning or error message
>> to the console.  Unittest also triggers warning and error messages from
>> other kernel code as a result of intentionally bad unittest data.  This
>> has led to confusion as to whether the triggered messages are an
>> expected result of a test or whether there is a real problem that is
>> independent of unittest.
>>
>> EXPECT messages were added to unittest to report each triggered message
>> that is expected, resulting in verbose console output.
>>
>> scripts/dtc/of_unittest is a new program that processes the EXPECT
>> messages to determine whether the triggered messages occurred and
>> also removes the excess verbosity of the EXPECT messages.  More
>> information is available from 'scripts/dtc/of_unittest_expect --help'.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> permissions for scripts/dtc/of_unittest should be 770
> 
> Why? 755 is what the patch says and what most/all executables in the kernel are.

I based that on the permissions of other executables in scripts/dtc/

I do like 755 better, thanks for pointing out the wider population of
executables in the kernel.

-Frank

> 
> Rob
> 
>>
>> I will reply to this message with the usage message from
>> 'scripts/dtc/of_unittest_expect --help'.
>>
>> I will also reply with examples of raw and processed console logs.
>>
>>  Documentation/devicetree/of_unittest.rst |  27 +-
>>  scripts/dtc/of_unittest_expect           | 408 +++++++++++++++++++++++
>>  2 files changed, 432 insertions(+), 3 deletions(-)
>>  create mode 100755 scripts/dtc/of_unittest_expect

