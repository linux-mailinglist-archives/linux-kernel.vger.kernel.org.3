Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2499D55CF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbiF1GkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbiF1GkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:40:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7E63F2;
        Mon, 27 Jun 2022 23:40:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g7so6588032pjj.2;
        Mon, 27 Jun 2022 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=848y7OmN/dIZCIAzBJGTHR8HNayws7paGz0ESeqcH9o=;
        b=dcaL0fZSh8ryoX5MQKDMBs0IC/70LH1ACpYnnR7PJ6wHW4incbzaiCIdUnVPQ7dno+
         r2Wd5+k45iF8e8uYgHR2m0+rAN1lDv7LGggEfkgP3Izd69GnCy1KaFMS6p97yJ/A03mQ
         6wSvzpQ/SdZ13Zan0F4gVcAgwZnz7v9TvML36/WG1NZKUvjIplXr4EHC7uqzglqPCo22
         feHLAX5MovFRRGWT6f82Eq61XTNTfdN5vFDgkkRwtdhkVjARNQ6hovhOiUrK0okyDEh/
         ytQuN6bE/0HeS9exViLm0CeA/HT/sFh4cnLTHlLQ4Ai0ZlizYEkMf/silf/2xj5iqB6c
         cB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=848y7OmN/dIZCIAzBJGTHR8HNayws7paGz0ESeqcH9o=;
        b=mYW1+gD/lsyFee/PWMQLti8fmgr0V79C01vUsQRfE4aeFf8mk4heuEKCLjLHuoLoWh
         GPULbKcRPE1pjCjYulKNFA/ljy0ohaLz0yRoMMZtBPq47lWWPU/x4r+ThGxXM8J/jSrw
         fA3eseuUpTqHa+cXBiRBXXNEIA0zx4IoJiSTcWQM2IK4itZ8XQwl/glCDsBhKXzsVuze
         dI4zCXei9oD3m/Umle3K44oVeovOnBS5knStUx2Vt3xztlZKAG+FhPGlL73ZkJUI+IN/
         6uHYlIdQI4ue29CLtpifKXJpZePSsKEl0H8aZzWimpW6CzBMsbDGCiPEIC+nHqKbZO4s
         wnYQ==
X-Gm-Message-State: AJIora9QIi3xt9Rbf8vn55ASZKI0G3Pn7NqL8wFr5gbwlekm9S5m222b
        8E7KwEtcQgOGhS/A7RQWZjw=
X-Google-Smtp-Source: AGRyM1s7gB+nTUKS+E2u5Usv2nf0ofJHOp4omLoe4xJo9w7IdloS7aXgYr/f+kVRI8tFPZTMi6/5+g==
X-Received: by 2002:a17:902:9004:b0:16a:6808:e602 with SMTP id a4-20020a170902900400b0016a6808e602mr2187166plp.94.1656398419420;
        Mon, 27 Jun 2022 23:40:19 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-55.three.co.id. [116.206.12.55])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b00168c523032fsm8328401plk.269.2022.06.27.23.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 23:40:18 -0700 (PDT)
Message-ID: <e8605c72-7807-ee03-83eb-6744bb3dbd47@gmail.com>
Date:   Tue, 28 Jun 2022 13:40:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 06/11] docs: process: remove outdated
 submitting-drivers.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-7-lukas.bulwahn@gmail.com>
 <bd2957f4-3793-d876-8b1f-1dbb9cf160d1@gmail.com>
 <CAKXUXMz58KV5m2HzYTwG7eq=2n4TMOT_F4Q8fL0Tn-7VAgtHAg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAKXUXMz58KV5m2HzYTwG7eq=2n4TMOT_F4Q8fL0Tn-7VAgtHAg@mail.gmail.com>
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

On 6/28/22 12:00, Lukas Bulwahn wrote:
> On Tue, Jun 28, 2022 at 3:21 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 6/27/22 22:18, Lukas Bulwahn wrote:
>>>  There are numerous sources of information on Linux kernel development and
>>>  related topics.  First among those will always be the Documentation
>>> -directory found in the kernel source distribution.  The top-level :ref:`process/howto.rst <process_howto>`
>>> -file is an important starting point; :ref:`process/submitting-patches.rst <submittingpatches>`
>>> -and :ref:`process/submitting-drivers.rst  <submittingdrivers>`
>>> -are also something which all kernel developers should
>>> -read.  Many internal kernel APIs are documented using the kerneldoc
>>> -mechanism; "make htmldocs" or "make pdfdocs" can be used to generate those
>>> -documents in HTML or PDF format (though the version of TeX shipped by some
>>> -distributions runs into internal limits and fails to process the documents
>>> -properly).
>>> +directory found in the kernel source distribution.  Start with the
>>> +top-level :ref:`process/howto.rst <process_howto>`; also read
>>> +:ref:`process/submitting-patches.rst <submittingpatches>`. Many internal
>>> +kernel APIs are documented using the kerneldoc mechanism; "make htmldocs"
>>> +or "make pdfdocs" can be used to generate those documents in HTML or PDF
>>> +format (though the version of TeX shipped by some distributions runs into
>>> +internal limits and fails to process the documents properly).
>>>
>>
>> Did you mean "beware that TeX distribution version as shipped by distributions
>> may fail to properly generate the documents"? I have never tried pdfdocs,
>> since the dependency requirement can be huge (hundreds of MB needed to
>> download packages), so I can't tell whether the phrase is relevant.
>>
> 
> I only touched this sentence with 'make pdfdocs' above to reformat the
> paragraph after deleting the reference to submitting-drivers. Maybe
> the statement on make pdfdocs is outdated already or we should refer
> to the documentation build page instead?
> 

I think we can say "The kernel documentation subsystem (kernel-doc)
uses Sphinx. Refer to Documentation/doc-guide/sphinx.rst for more
information.", at least.

-- 
An old man doll... just what I always wanted! - Clara
