Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEB4E9C65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiC1Qjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbiC1Qjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:39:41 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.196.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7116606E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:37:59 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 5662A1C1EF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:37:59 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YsNTntiIRRnrrYsNTn6kl4; Mon, 28 Mar 2022 11:37:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hiAxs7IHF0rwd27wBXL1/c9LFYx80jZfA+vxRKssdAY=; b=4hM99fFLGFCXB5cJDY8lo4Y7ea
        GLASzNOoPWsqoULbaTlRGwjF/QOLLXlc8yi+MGAwcm/I8HKXRe/BSYh9ey0j0XfdgxiWyxUqScm9P
        NLU3vUDD8AeKyBm/Pnw2nCiaob8IL7rHA9LLPel/dE/dimFV29Xlngfi1EFf4tXp40gWBYPFxVc57
        Jcird/H9E1noQxQ7lwoZmneXID0oSrCWLMfz5mojNKE1MWOO+KsWprsdYPaFACatosIn5XRwmriny
        7z5Dkqt+Sgv7rgS0MR2r0hmuKSR9e0E5UXYPmQrJqyvhgYl8uWcEDIQr3PxBB1r0v8sw4p+CLG5oX
        xNBQC7jg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54532)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYsNS-001jY7-Ud; Mon, 28 Mar 2022 16:37:59 +0000
Message-ID: <0b818aa2-e776-3554-8d7b-79fd856e2e1f@roeck-us.net>
Date:   Mon, 28 Mar 2022 09:37:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-5-michael@walle.cc>
 <2442b460-4c6d-0ac9-af08-ae4c25aed812@roeck-us.net>
 <9aab54bc48284c9e20cd76085cb9d83a@walle.cc>
 <4455ca4c-1ebb-41df-5f04-72a48e8ca7dc@roeck-us.net>
 <4e5c78ce651c258a4be33c01ec07a0c3@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
In-Reply-To: <4e5c78ce651c258a4be33c01ec07a0c3@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYsNS-001jY7-Ud
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54532
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 27
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 04:28, Michael Walle wrote:
> Am 2022-03-27 20:22, schrieb Guenter Roeck:
>> On 3/27/22 07:18, Michael Walle wrote:
>>> Am 2022-03-27 03:34, schrieb Guenter Roeck:
>>>
>>>>> +    /*
>>>>> +     * Data is given in pulses per second. According to the hwmon ABI we
>>>>> +     * have to assume two pulses per revolution.
>>>>
>>>> The hwmon ABI doesn't make any such assumptions. It wants to see RPM,
>>>> that is all. Pulses per revolution is a fan property.
>>>
>>> There is fanY_pulses according to Documentation/ABI/testing/sysfs-class-hwmon:
>>>
>>>    Should only be created if the chip has a register to configure
>>>    the number of pulses. In the absence of such a register (and
>>>    thus attribute) the value assumed by all devices is 2 pulses
>>>    per fan revolution.
>>>
>>> The hardware returns just the pulses per second. Doesn't that
>>> mean I have to divide that value by two?
>>>
>>
>> The above refers to hardware which reports RPM.
>>
>> It is up to the driver to calculate and return RPM. How you do it is your
>> decision. Drivers should report the most likely correct RPM value to
>> userspace, one that rarely needs manual adjustment. Almost all fans
>> report two pulses per revolution, so normally that assumption is used
>> to convert PPM to RPM. That isn't mandated (or supposed to be mandated)
>> by the ABI. I would call it common sense.
>>
>> I'll be happy to accept a patch clarifying this.
> 
> Where would that go? into the sysfs abi description of the
> fanY_input?
> 

For example.

Thanks,
Guenter
