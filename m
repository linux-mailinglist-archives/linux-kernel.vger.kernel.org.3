Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0B4E7D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiCYVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiCYVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:39:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15122B2C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:38:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so7544080pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PuHsUaq4TWen0m4Y7rDmNwEey8fgTaVJmg38LULo9/w=;
        b=Oofnc375Mn2y4i69wLlFcctfpF3w8E992ImiFIIeP2aFb+VC4lLNgo+VeNIAGT1W0+
         KFLHAG7ixPMpASu41a2bofdKk0aq2+c4jSqgJBLRiLcjKL7f/BNjH0sHr6EbRLJB5epg
         yurV1Ff1dJIWIsYuGKGzq8NfXOx0OfFo5ATqagNI0U6GlHJyLqnRX6V2qzPca58u02MO
         Yqp5YXfv7+TW9TvUoKzJYdeXPCTJ4yTke2+i/1DQ99sS/ZVNbmBqRkXZQJPenh39S6a3
         r8o6Ap9m7yBjhcFhv1DYt/hXpgGGK5PcpHVGtYq7T5jENUPFPmp9sCpn3XpLrJw5DDgR
         7RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuHsUaq4TWen0m4Y7rDmNwEey8fgTaVJmg38LULo9/w=;
        b=NXmXMENAlEiD+Xis2iQg80GYkGLD49YUcmpHbInjlv04/k/rEALycb2E6QwN+FqV/S
         LtwUfBluA5gw6Zj8REGbGfULyUVd8fGswLu+LPsQarTVs9mJNoklv2+un5+uC2Kq/+Zn
         eqBHOXyiKlYARoJ3BfuBewx71lRvMTOGIEbZl9L7Q1ucWWZEpcXw7Iz7Z8in+fk/atUW
         ZSQ4Vl9BymtLxZPpnZu/vHTdNmnPXPo8R90wlEDM07gZU1k8uTTQehvHM87p64RiN13G
         h+eP772ozN2dTciy3K9bP5Gxg6G5bi8JFhtZPRt403uygmn46xJHi6RL+9jkM7wMLsnO
         Su7Q==
X-Gm-Message-State: AOAM53092ec5k146bJUd0n64+Oi7IbpG3tFQT+krlYE0cPMvZgdjZfrH
        H98aO+qBYokUNg22kO2kvCt8Cgsy6Ks=
X-Google-Smtp-Source: ABdhPJzqVzQKnLGQC7ymUDWU0PyrpbAsUdyqBAS0iL1jWJ1PayEgphuUvFrnviSyYYDzFseQCqmFJA==
X-Received: by 2002:aa7:943a:0:b0:4f6:adc9:d741 with SMTP id y26-20020aa7943a000000b004f6adc9d741mr12212375pfo.30.1648244290527;
        Fri, 25 Mar 2022 14:38:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e11-20020a056a001a8b00b004fab740dbddsm7686737pfv.105.2022.03.25.14.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 14:38:10 -0700 (PDT)
Message-ID: <faf91200-4790-1210-7ba5-7892c98fcb5e@gmail.com>
Date:   Fri, 25 Mar 2022 14:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/2] Sensor readings fixes
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com
References: <20211220174155.40239-1-cristian.marussi@arm.com>
 <Yj2qTMcW9sfMyvAc@e120937-lin>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Yj2qTMcW9sfMyvAc@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/25/22 04:41, Cristian Marussi wrote:
> On Mon, Dec 20, 2021 at 05:41:53PM +0000, Cristian Marussi wrote:
>> Hi,
>>
>> this was supposed to be an easy fix on how sensor readings are handled
>> across different FW versions while maintaining backward compatibility,
>> but the solution raised for me more questions than the issue itself...
>> ...so I posted as an RFC.
>>
>> In a nutshell, since SCMI FWv3.0 spec, sensors SCMI_READING_GET command
>> can report axis and timestamps too, beside readings, so a brand new
>> scmi_reading_get_timestamped protocol operation was exposed (used by IIO)
>> while the old scmi_reading_get was kept as it was, already used by HWMON
>> subsystem for other classes of sensors.
>>
>> Unfortunately, also the flavour of reported values changed from unsigned
>> to signed with v3.0, so if you end-up on a system running against an SCMI
>> v3.0 FW platform you could end up reading a negative value and interpreting
>> it as a big positive since scmi_reading_get reports only u64.
>>
>> 01/02 simply takes care, when a FW >= 3.0 is detected, to return an error
>> to any scmi_reading_get request if that would result in tryinh to carry
>> a negative value into an u64.
>>
>> So this should rectify the API exposed by SCMI sensor and make it
>> consistent in general, in such a way that a user calling it won't risk to
>> receive a false big-positive which was indeed a 2-complement negative from
>> the perpective of the SCMI fw.
>> 	
>> So far so good...sort of...since, to make things more dire, the HWMON
>> interface, which is the only current upstream user of scmi_reading_get
>> DOES allow indeed to report to the HWMON core negative values, so it was
>> just that we were silently interpreting u64 as s64 :P ...
>>
>> ...as a consequence the fix above to the SCMI API will potentially break
>> this undocumented behaviour of our only scmi_reading_get user.
>>
>> Additionally, while looking at this, I realized that for similar reasons
>> even on systems running the current SCMI stack API and an old FW <=2.0
>> the current HWMON read is potentially broken, since when the FW reports
>> a very big and real positive number we'll report it as a signed long to
>> the HWMON core, so turning it wrongly into a negative report: for this
>> reason 02/02 adds a check inside scmi-hwmon to filter out, reporting
>> errors, any result reported by scmi_reading_get so big as to be considered
>> a negative in 2-complement...
>>
>> ...and this will probably break even more the undocumented behaviours...
>>
>> Any feedback welcome !
> 
> Hi,
> 
> any feedback on this ? (...before I forgot again :D)

Sorry for the lag, I threw these into a build and the first thing that 
popped is the following warning on a 32-bit ARM build:

In file included from ./include/linux/bits.h:6,
                  from ./include/linux/bitops.h:6,
                  from ./include/linux/hwmon.h:15,
                  from drivers/hwmon/scmi-hwmon.c:9:
drivers/hwmon/scmi-hwmon.c: In function 'scmi_hwmon_read':
./include/vdso/bits.h:7:26: warning: left shift count >= width of type 
[-Wshift-count-overflow]
  #define BIT(nr)   (UL(1) << (nr))
                           ^~
drivers/hwmon/scmi-hwmon.c:88:14: note: in expansion of macro 'BIT'
   if (value & BIT(63)) {
               ^~~

Now, in terms of functional testing it did seems to work as intended for 
32-bit kernels not for 64-bit kernels where I got:

# sensors
scmi_sensors-virtual-0
Adapter: Virtual device
[   16.413590] hwmon hwmon0: Reported unsigned value too big.
ERROR: Can't get value of subfeature temp1_input: I/O error
avs_pvt_temp:         N/A
pmic_die_temp:    +53.4 C

whereas 32-bit would return the following:

# sensors
scmi_sensors-virtual-0
Adapter: Virtual device
avs_pvt_temp:      -6.7 C
pmic_die_temp:    +52.3 C

The firmware is version 1:

[    0.044969] arm-scmi brcm_scmi@0: SCMI Protocol v1.0 'brcm-scmi:' 
Firmware version 0x1

I will need to revisit the specification to make sure I implemented it 
correctly the first time in our version of TF-A.
-- 
Florian
