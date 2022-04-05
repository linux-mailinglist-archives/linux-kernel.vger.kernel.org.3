Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518284F4F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838747AbiDFA4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiDEOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:42:05 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.48.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E6B27CD8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:18:06 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 4BB4A15945
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:18:06 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bj4Qn7J6zdx86bj4QnY5ew; Tue, 05 Apr 2022 08:18:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x+f3jWcojSlFA+ZZ0pJlnzELpcaYSX7f8bbsqUkUiLc=; b=SeH0C6R6Bg1boiO9t0nVHpAKJH
        LD5kJXC20mkbH2n9LpvZwPvz1L+0YmglCdasF7qeiDMddy6SlslCZxA6Q2na94TAyUP7BwFqVIvEM
        XHVj+PxWxn8k2PxR/3lAAcgNbOUasmxTUXZZArZkPH/r3IXR1dpK9sDHV7ShrhTUGNgk3acJ7Av6Y
        rWl7FPSX7ueoF+uQJOZMR1hqiV4k8gf45i8VEHKU/D0JcDdpUjnz3sWrMYjyont9U6qLlApmkDKmP
        ldwUXYCSwP/QIl4o3Ap9YpeKGU3u/Wrjlb3gHmlEsgQ94VCUUcJee6WZ+uAYGRzFWKCeJTnKlrC1L
        yLg1Fm7w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54730)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbj4P-002s2v-Um; Tue, 05 Apr 2022 13:18:06 +0000
Message-ID: <dc26e88b-ab7e-755b-13fd-8710883ac80b@roeck-us.net>
Date:   Tue, 5 Apr 2022 06:18:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Linux 5.18-rc1
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net> <YkwzzANkBRzrYAuq@debian>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YkwzzANkBRzrYAuq@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbj4P-002s2v-Um
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54730
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 15
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 05:19, Sudip Mukherjee wrote:
> On Sun, Apr 03, 2022 at 07:22:39PM -0700, Guenter Roeck wrote:
>> On Sun, Apr 03, 2022 at 03:14:19PM -0700, Linus Torvalds wrote:
>>> So here we are, two weeks later, and the merge window is closed.
>>>
> 
> <snip>
> 
>>>
>>> Go test, please,
>>
>> Build results:
>> 	total: 151 pass: 142 fail: 9
>> Failed builds:
>> 	alpha:allmodconfig
>> 	arm:allmodconfig
> 
> Apart from the ones Guenter reported, arm imote2_defconfig fails due to:
> 28f74201e37c ("ARM: pxa: remove Intel Imote2 and Stargate 2 boards")
> 

Not entirely surprising, since its support was removed with that patch.
The error is "arm-linux-gnueabi-ld: no machine record defined", which is
consistent with that removal. So the fix would be to remove that
configuration file.

Guenter
