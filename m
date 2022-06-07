Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE953FF09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiFGMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiFGMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:40:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467EBE9;
        Tue,  7 Jun 2022 05:40:25 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-edeb6c3642so22993747fac.3;
        Tue, 07 Jun 2022 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=veXJPfHkMS+LtparZTe0eg0zxXaGbczedDsr7TOeC1g=;
        b=oSzAR8Eh6bpfrAeaxldZCXadsI8haXay3afMInYK9HhlYvEsXiYOgWZ/VNTDz25noI
         nNJiqtrVCyN15WKCLCSb7EH6FC+SUFjHQ0RTMSWId+pun/PUYqNkI4OxAb0MzSYFyqYS
         Hh2PReF7BV5sLKMJrACP3zOoxBSsguOR737fhcp/ZvOAccFuYLw3ph2ZL+foS3y/FJLo
         x0lH7wZDqTgzXgX2Q35/iDdfgPMeblWp6LND3q6NsjKDF1qVqGtXSrb/JDz3mDJ9V2XS
         mMAWTaL2JCHGTpsMMFfXujseHiWdgSoZO6gacwtIWWkOY/i7W4DqSo17dmY5JKNkLM3w
         88Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=veXJPfHkMS+LtparZTe0eg0zxXaGbczedDsr7TOeC1g=;
        b=G8EMo7wLCLyb0GPZwKFQNRMX6oY8VldW6oWH9S/hXgdo+Yj8i8Amh0j99NS+U7bZ1B
         7Qgcu79OT2Zc03/sLg+ZV57HTKtTfKbHayQbQu2+NP++qhUOQs3zkkfJ1bjiyB60lZGj
         tpMVakVILgnxm5DRpi1mLMWAJ4w10LK3GP/ASIpyopJ8EXRpiH7CwFBUuXssRerBlBqM
         9wJcnHOBJPKbqn5mnQYsFcqNdSdUQURvTW3r6B2XDXyeEXUG5l6rX1oHz0sHDpunYSsZ
         9Cydoon2bbpoYb07gKjYaRDSgSiosn5iOD9efAH/dwFszTp8I+cYrVjNyutMpbxSa6gp
         SgSA==
X-Gm-Message-State: AOAM530+kAm17r/h/RHd+bSzwR5Yywi84KahroSUlLxPitiweD4k0JQU
        jggKfdqgvH2Da+TK4582VMA=
X-Google-Smtp-Source: ABdhPJx9iIUqKOI6JhA/vc8xUWLUc/9nU/qd4Y/M+ng48dq5FhS3Hpa0ygnThnvEXqKSN0ggr3p+Jg==
X-Received: by 2002:a05:6870:4395:b0:f5:f122:f44d with SMTP id r21-20020a056870439500b000f5f122f44dmr16112071oah.273.1654605624679;
        Tue, 07 Jun 2022 05:40:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y93-20020a9d22e6000000b0060c06bc1230sm1008749ota.69.2022.06.07.05.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:40:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1b1a66b-7f92-931e-ad5f-8ffa87865c4a@roeck-us.net>
Date:   Tue, 7 Jun 2022 05:40:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build warnings after merge of the hwmon-staging tree
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20220607141958.1e31971d@canb.auug.org.au>
 <Yp8cQ1BcDXuZ9Cv4@debian.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yp8cQ1BcDXuZ9Cv4@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 02:37, Bagas Sanjaya wrote:
> On Tue, Jun 07, 2022 at 02:19:58PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> Documentation/hwmon/lt7182s.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
>> Documentation/hwmon/lt7182s.rst:75: WARNING: Malformed table.
>> Text in column margin in table line 33.
>>
>> ======================  ====================================
>> curr[1-2]_label         "iin[12]"
>> curr[1-2]_input         Measured input current
>> curr[1-2]_max           Maximum input current
>> curr[1-2]_max_alarm     Current high alarm
>>
>> curr[3-4]_label         "iout[1-2]"
>> curr[3-4]_input         Measured output current
>> curr[3-4]_highest       Highest measured output current
>> curr[3-4]_max           Maximum output current
>> curr[3-4]_max_alarm     Output current high alarm
>>
>> in[1-2]_label           "vin[12]"
>> in[1-2]_input           Measured input voltage
>> in[1-2]_highest         Highest measured input voltage
>> in[1-2]_crit            Critical maximum input voltage
>> in[1-2]_crit_alarm      Input voltage critical high alarm
>> in[1-2]_min             Minimum input voltage
>> in[1-2]_min_alarm       Input voltage low alarm
>> in[1-2]_rated_min       Rated minimum input voltage
>> in[1-2]_rated_max       Rated maximum input voltage
>> in1_reset_history       Write to reset history for all attributes
>>
>> in[3-5]_label           "vmon[1-3]"
>> in[3-5]_input           Measured voltage on ITH1/ITH2/EXTVCC pins
>>                          Only available if enabled with MFR_ADC_CONTROL_LT7182S
>>                          command.
>>
>> in[3-4|6-7]_label       "vout[1-2]"
>> in[3-4|6-7]_input       Measured output voltage
>> in[3-4|6-7]_highest     Highest measured output voltage
>> in[3-4|6-7]_lcrit       Critical minimum output voltage
>> in[3-4|6-7]_lcrit_alarm Output voltage critical low alarm
                          ^
>> in[3-4|6-7]_min         Minimum output voltage
>> in[3-4|6-7]_max_alarm   Output voltage low alarm
>> in[3-4|6-7]_max         Maximum output voltage
>> in[3-4|6-7]_max_alarm   Output voltage high alarm
>> in[3-4|6-7]_crit        Critical maximum output voltage
>> in[3-4|6-7]_crit_alarm  Output voltage critical high alarm
>>
>> power[1-2]_label        "pout[1-2]"
>> power[1-2]_input        Measured output power
>>
>> temp1_input             Measured temperature
>> temp1_crit              Critical high temperature
>> temp1_crit_alarm        Chip temperature critical high alarm
>> temp1_max               Maximum temperature
>> temp1_max_alarm         Chip temperature high alarm
>> ======================  ====================================
>>
>> Introduced by commit
>>
>>    3d6bcaa21fbd ("hwmon: (pmbus) Add support for Analog Devices LT7182S")
>>
> 
> Hi Stephen,
> 
> The warning above doesn't appear when doing htmldocs build using Sphinx
> installed from pip on my system.
> 

I already fixed it up.

Guenter
