Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB3E4E7EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiCZEY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiCZEY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:24:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142424B5C8;
        Fri, 25 Mar 2022 21:22:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t14so7994952pgr.3;
        Fri, 25 Mar 2022 21:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxM5E5iwPaWD/zmuce/0lb3P0pktJgSBEdl/ZqKET2o=;
        b=RyuRg5AGHUOoLeVm5/obKVUZb1f9ErJFcNG13Wqhjfivi7xdKCrfMwUu2ZunL9X+W0
         sRB7WSpP2C0VK6kpqgubm2r5wlI66YyKF9VaMhOzUWHleFNB2cMWLHd7TwNS74K+aqYL
         k+O8Akt3g9oaZQHhyFJu9XQmfOIB0tLd7vnrRDYu9iTgj4Sh89pBu6mBlwhkFyou1u8C
         LOj76NgGZi4VjdwgOXFoBtsjtY1gD6dtxezRhkqQEkhsUS/1XDo4A8d/YGGp/t/5jVho
         EYdvdTOt+87+kpLcUqUzl1K+gyy/rNWwkrYyPseWh9Fk4abmMgNG3F97xIUqdxU4xl5X
         Orvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxM5E5iwPaWD/zmuce/0lb3P0pktJgSBEdl/ZqKET2o=;
        b=CQOMI7Z7gk9uGf5OY+6VBIkC1gJ5uvfK3DH3q0qxv+WejXyNM4/oW3iL1bHaRD+fCZ
         ErQqh+0l0dGtAg7n1yP0rEbynoTl84SKIRlw6ss21/cuXoxDPSqqg40I3iW+18Xnupo7
         Fkbe+O2E+OlEf90T6h7bK8W2qu3U7grRpGuOoTHtuQBui4l3MgAHy2lC2gSL5QZJTK5u
         7icQeFJeftKC9nccMIWRx4ByuQV6huAqIqRYzz39mNvIOKqtmQtYWlXK8Xv8VWKwxRG1
         LE7y9Mm95JySyLIg2mMlvP+/0mS3Ot7pZVR9g/kwSvRaD373dS4mpUYiS9LvSCcwCqn8
         a85w==
X-Gm-Message-State: AOAM530DsZgvFTfIY49Ct+ITYbGb246+pBIhEuoDbSVCjNApudkkcGhR
        RCH0wf3FCMB6IJ1Zp/WO2KYmU8cZSreTXQ==
X-Google-Smtp-Source: ABdhPJzK0NzNtz09Sbgc1U+uX/o0ahjP3Qniyv4jE1qR/XUyjsAe5TD03oM6nv209g73xIGEabDLXQ==
X-Received: by 2002:a05:6a00:849:b0:4fb:1112:c19f with SMTP id q9-20020a056a00084900b004fb1112c19fmr6421680pfk.74.1648268571254;
        Fri, 25 Mar 2022 21:22:51 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004faabba358fsm8744612pfj.14.2022.03.25.21.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 21:22:50 -0700 (PDT)
Message-ID: <136a0e9e-98ff-68d2-b2a3-147f3910e0a0@gmail.com>
Date:   Sat, 26 Mar 2022 11:22:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND] Documentation: add missing page title for
 kernel-doc.rst and sphinx.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220322113645.502544-1-bagasdotme@gmail.com>
 <87v8w1esqg.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87v8w1esqg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/03/22 02.29, Jonathan Corbet wrote:
>> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
>> index 79aaa55d6bcf2b..de47b20c806acf 100644
>> --- a/Documentation/doc-guide/kernel-doc.rst
>> +++ b/Documentation/doc-guide/kernel-doc.rst
>> @@ -1,3 +1,7 @@
>> +==========================
>> +kernel-doc Comments Format
>> +==========================
>> +
>>   Writing kernel-doc comments
>>   ===========================
> 
> Honestly, I think this is better fixed just by promoting the existing
> heading up a level.  It describes the file nicely, and we don't need two
> headers there.
> 

OK.

>> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
>> index bb36f18ae9ac3e..140507de5a85e0 100644
>> --- a/Documentation/doc-guide/sphinx.rst
>> +++ b/Documentation/doc-guide/sphinx.rst
>> @@ -1,5 +1,9 @@
>>   .. _sphinxdoc:
>>   
>> +=============
>> +Sphinx Primer
>> +=============
>> +
>>   Introduction
>>   ============
> 
> Here, perhaps, replace "Introduction" with "Using Sphinx for kernel
> documentation" or some such and make that the document title?
> 

I agree with your document title suggestion.

-- 
An old man doll... just what I always wanted! - Clara
