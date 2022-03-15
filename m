Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF694D923C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiCOBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344258AbiCOBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:24:02 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F742631
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:22:49 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 43A59EF8CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:22:49 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id TvtgnV4saXvvJTvtgniQWJ; Mon, 14 Mar 2022 20:22:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fc/4aRBBd782zT03Q+OtnIHUlfYCyQpFz9VTJ95xqw0=; b=Aiu4sgtrBZIxQom1IJFTXQlYMf
        XXEPlmcOo8p2oLHBKqBakYnc/m6R2+1Bs1YAFCGPUv9wiGxMT+zfj1fDo/ctGcbyALGZyohE9Ov3k
        m3FF6CTCZlluksBwui4rwcBUsJiAI1uvn4xsnFP5yO6bL9e0GgvRRb2ZZQZrrLL0TC+iNaGV1bxqS
        vwnTfpixjFmG0Hludn9z+JWyMK6BDMSgPiHCn5rEOKEJtcZt6EcgSTtULEkKJftYMFjWMUXdCeA1t
        Fig+BTUMo6mIFyW1m0EfdAI0ToWtfkNepcUoZEFBRIrdL47brqEBVLwts9JT0Jk8L9dZ7Lo7ptTlp
        7uzqgc1A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54266)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nTvtg-004GEG-E6; Tue, 15 Mar 2022 01:22:48 +0000
Message-ID: <3dac349c-6470-1673-effb-354da2b52481@roeck-us.net>
Date:   Mon, 14 Mar 2022 18:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <51ea03f0-627b-2e9d-5972-2053fa12b9b5@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
In-Reply-To: <51ea03f0-627b-2e9d-5972-2053fa12b9b5@nokia.com>
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
X-Exim-ID: 1nTvtg-004GEG-E6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54266
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 12
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

Hi Agathe,

On 3/14/22 08:46, Agathe Porte wrote:
> Hi,
> 
> Le 2/22/2022 à 11:36 PM, Guenter Roeck a écrit :
>>   of_property_read_string(child,"label", &data->channel[channel].label);
> 
> Upon trying to merge v7 in our codebase, our static analyzer tool detected that the return code of this function was not checked.
> 
> As I guess putting a label is optional, maybe we should add a `(void)` on the same line just before the function call to clearly indicate that not checking the return value is intentional and that it is not a coding mistake?
> 
> EDIT: As I was reading the implementation of of_property_read_string [1], it will not touch the destination string in case of error. Which means that labels may sit uninitialized and contain garbage data?
> 

Thanks for the feedback.

If of_property_read_string() returns an error, it will not set the pointer
to &data->channel[channel].label, which by default is NULL because the
data structure was allocated with devm_kzalloc(). That means tmp464_is_visible()
will disable the label attribute. I don't see a problem with the current
code.

There are lots of examples in the kernel where the return value from
of_property_read_string() is silently ignored. Not a single one of
those uses a (void) typecast. I don't really want to start making
such changes just to make static analyzers happy.

Thanks,
Guenter
