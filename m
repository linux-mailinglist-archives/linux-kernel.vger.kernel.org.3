Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077804B03A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiBJC5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:57:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBJC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:57:31 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E53240B8;
        Wed,  9 Feb 2022 18:57:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d7so3649823qvk.2;
        Wed, 09 Feb 2022 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DveL08cBpQyT38jrCHqG38StDpIpjTtO5x5RxN2qOLY=;
        b=kOFXR7ExGrn1+/9lTrSbG9/68OlOMqhrankhZRfVeox04sGJXOXIneDj+Kh9aYk9tJ
         wtjeJSXf3+Gdy0L+ToO6JOfg7Y7Cp1d3EsAVwsCJJZ3kRx6Uxo1GDPMMccv5o3uRcZl3
         vyuQn9dAlZTxe4kii5JYVp23OS6coTVJ5ixy3cJegneqY6p+7opCUQIL05JtjpzzeJVc
         BmRBJqPg4juTeRc698tkabUNgu6+ZoT7sw+TfByysGvcGD8wFc3OfbosfnElTjS+gdi3
         e8C8/r4IGogqWxIhtAJ1Wz2IYF7t2MNffE5N3Rvs6XLTVasfS8ly3HDEwLfAY/ThBFrm
         EbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DveL08cBpQyT38jrCHqG38StDpIpjTtO5x5RxN2qOLY=;
        b=nGy5rM5kW+xmpOKwHgLEiNh+aZQGjrMNj9W2MXCzWagBWIBCJBTOyqv2vcx/d75Yk1
         VVGnhfVgrn70Hcli6OcVQR12k6YM9+R4JmF+KEHIHJjXpLrE/aM1+ukb82vHoRNTqhcc
         jsy5n1UF4odBzExMqbIThD1JXHm/PaJ2Gnvua8ODphQCMc6/r8T/oFnwo9yiBTfnqJAF
         v/QKTzf1zY2VjR4WzGKbngaUGZWavbLSwdIoC+kySOT7YCYMed5FlYUc/N/zeLyuheK2
         SV2qN5VD8WIRqTCNgaIZ5qwjDmrzk8YoGDM1Wos94HCxg+um+kKQjUjnhxGutUdNpefz
         j6Fw==
X-Gm-Message-State: AOAM532WoHa8WP/iA1VVWDvZEH5PTbaP0iYZM4Nd3fdFnoQzAb6a7Izs
        Z/GWU+acTgsEPIKSWUIJRlc=
X-Google-Smtp-Source: ABdhPJynjNToCd5PPegiDDI59TPQmtFEuHnh/crKpgATDReo+lOqVn+E2kR11jsiXN51nK/RiEY5Bw==
X-Received: by 2002:a05:6214:1c8d:: with SMTP id ib13mr3673192qvb.81.1644461852770;
        Wed, 09 Feb 2022 18:57:32 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id s1sm10088441qta.0.2022.02.09.18.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 18:57:32 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at same loglevel as
 fail
To:     Rob Herring <robh@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220203211150.2912192-1-frowand.list@gmail.com>
 <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
 <24652725-91d8-9db4-e14a-e1bb5ded87b1@gmail.com>
 <YgRdqe0+8fqSYi2T@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a746aad8-694a-85f7-7cbe-e0831b4b42da@gmail.com>
Date:   Wed, 9 Feb 2022 20:57:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgRdqe0+8fqSYi2T@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 2/9/22 6:34 PM, Rob Herring wrote:
> On Thu, Feb 03, 2022 at 09:41:45PM -0600, Frank Rowand wrote:
>> On 2/3/22 3:40 PM, Rob Herring wrote:
>>> On Thu, Feb 3, 2022 at 3:12 PM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Printing the devicetree unittest pass message for each passed test
>>>> creates much console verbosity.  The existing pass messages are
>>>> printed at loglevel KERN_DEBUG so they will not print by default.
>>>>
>>>> Change default to print the pass messages at the same loglevel as
>>>> the fail messages.
>>>>
>>>> The test community expects either a pass or a fail message for each
>>>> test in a test suite.  The messages are typically post-processed to
>>>> report pass/fail results.
>>>>
>>>> Suppressing printing the pass message for each individual test is
>>>> available via the kernel command line parameter unittest.hide_pass.
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>>>  drivers/of/unittest.c                           | 17 ++++++++++++++++-
>>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index f5a27f067db9..045455f9b7e1 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -5997,6 +5997,10 @@
>>>>                         Note that genuine overcurrent events won't be
>>>>                         reported either.
>>>>
>>>> +       unittest.hide_pass
>>>
>>> Can we rename the module name to include 'dt' so we're not taking a
>>> generic name.
>>
>> I got most of the way through writing a reply to the various questions, then got to
>> the point where my answer to a specific question ended up being something to the
>> effect of: "this line of code (where a change was suggested) will end up being
>> replaced when I convert the unittest messages to KTAP format".
>>
>> Then I got sidelined by going back and re-reading the KTAP specification email
>> thread from August, then discovering that there is also a patch submission email
>> thread from December where a KTAP specification is accepted into the kernel tree.
>>
>> Being KTAP compliant does not allow for suppressing the individual test pass
>> messages, so I think I should just drop my desire to be able to do so.  That
>> would reduce this patch to a one line change to print the pass messages at the
>> same loglevel as the fail messages.  And I would prefer to not worry about
>> whether the pass message is 'pass' vs 'PASS' since that text will get replaced
>> by the KTAP syntax anyway.
>>
>> Would you be ok with that one line patch?
> 
> At info level, yes. If not, how soon until using ktap syntax?

OK, I'll redo the patch as a one liner, printing pass messages at the info
level.

The KTAP syntax is going to depend on KTAP specification version 2.  I have
a patch series against version 1 that is at version 4.  I think that series
is likely to be accepted with no further changes.

There was a big thread last summer about what to add to the KTAP
specification, but most of the suggestions (even with much agreement) did
not get into the KTAP version 1 specification that was added to the kernel
tree in December.  Once my KTAP version 1 specification clean up patches
are accepted, I will move on to pulling items from the August thread, one
item per patch series to focus discussion, to create KTAP version 2.  So
timing will be based on the review timing.  The involved parties have been
responsive, so I expect the process to move fairly quickly.

-Frank

> 
> Rob
> 

