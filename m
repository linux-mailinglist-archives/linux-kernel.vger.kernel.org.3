Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD54D1100
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiCHHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbiCHHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:30:09 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E932EF8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:29:13 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 4AB231817C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:06:41 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id RTvdnY3Nt22u3RTvdnKmJU; Tue, 08 Mar 2022 01:06:41 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JXhrv67z7cxiudNnqeOxqEIuKpACEtGFDAz2/DdGsRk=; b=bkUMoPg4c22wQgIXq6b8gWZweo
        JDm0c18r2wV1cVvk2vAgV0JsSoyEy+5G0VRDekEvV98Wq8xdJANMvBtdC0HzWm+CR6A5EMD5BstBX
        5zrd/v4cmYwlHsmOsqToDdJUmsZmBPe0E+1qUgn9XUq6dxNbwdOs4mjy89539GBr4E1RfF0xB+iJv
        /FsCQMYHgzJ2WZXJr/tnjc1ItiXmUano9DADLwNNmkjPCrQ9JJs+T7u99yYq9abBmszoqzZfpwqZp
        OIBqCFavcv9897eaML8/GVGzvoJeTOSXEuNOF0c82p6r755xUaF+oAB/p7eajc3szXLGfVpBWYfqs
        q0vV7sbg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38100)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nRTvc-000jqO-Gm; Tue, 08 Mar 2022 07:06:40 +0000
Message-ID: <142b1c42-a8d5-3885-0af0-e07c9d4dd887@roeck-us.net>
Date:   Mon, 7 Mar 2022 23:06:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/ directory
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220307090929.701137-1-xji@analogixsemi.com>
 <4252cd9d-a761-e064-58cf-eebc3b9d0bb7@roeck-us.net>
 <20220308022638.GA964343@anxtwsw-Precision-3640-Tower>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220308022638.GA964343@anxtwsw-Precision-3640-Tower>
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
X-Exim-ID: 1nRTvc-000jqO-Gm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:38100
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 3
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

On 3/7/22 18:26, Xin Ji wrote:
> On Mon, Mar 07, 2022 at 06:49:03AM -0800, Guenter Roeck wrote:
>> On 3/7/22 01:09, Xin Ji wrote:
>>> Move tcpci.h as a global file, better for other USB Type-C driver
>>> access.
>>>
>>
>> The idea was to have tcpci compliant drivers in the tcpm/ subdirectory.
>> If I recall correctly, the reason for having this driver elsewhere is
>> that it doesn't support tcpm. That should be explained here.
>> "better for other USB Type-C driver" is not a reason for moving
>> a header file.
>>
>>> Fix compiling error after moving tcpci.h to include/linux/usb/.
>>>
>> I don't think this should be part of the commit description.
>>
>> Guenter
> 
> Hi Guenter, OK, got it, this patch is recommended by Heikki, as our
> driver will refer some TCPCI registers, he prefer to move tcpci.h in to
> global directory.
> 

The patch itself is fine. My concern is the description which, in my opinion,
does not adequately explain the reason for the patch.

Also, "Fix compiling error after moving tcpci.h to include/linux/usb/"
sounds like a change log, which should not be part of the description either.

Guenter

> Hi Heikki, please help to give your opinion, thanks!
> 
> Thanks,
> Xin
>>
>>> Signed-off-by: Xin Ji <xji@analogixsemi.com>
>>> ---
>>>    drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
>>>    drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
>>>    drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
>>>    drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
>>>    {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
>>>    5 files changed, 5 insertions(+), 7 deletions(-)
>>>    rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
>>> index e07d26a3cd8e..9c907296596f 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>>> @@ -13,11 +13,10 @@
>>>    #include <linux/property.h>
>>>    #include <linux/regmap.h>
>>>    #include <linux/usb/pd.h>
>>> +#include <linux/usb/tcpci.h>
>>>    #include <linux/usb/tcpm.h>
>>>    #include <linux/usb/typec.h>
>>> -#include "tcpci.h"
>>> -
>>>    #define	PD_RETRY_COUNT_DEFAULT			3
>>>    #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
>>>    #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
>>> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
>>> index df2505570f07..4b6705f3d7b7 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
>>> @@ -11,11 +11,10 @@
>>>    #include <linux/module.h>
>>>    #include <linux/regmap.h>
>>>    #include <linux/usb/pd.h>
>>> +#include <linux/usb/tcpci.h>
>>>    #include <linux/usb/tcpm.h>
>>>    #include <linux/usb/typec.h>
>>> -#include "tcpci.h"
>>> -
>>>    #define PD_ACTIVITY_TIMEOUT_MS				10000
>>>    #define TCPC_VENDOR_ALERT				0x80
>>> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> index f1bd9e09bc87..9e0338bce7ef 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> @@ -11,10 +11,9 @@
>>>    #include <linux/of.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/regmap.h>
>>> +#include <linux/usb/tcpci.h>
>>>    #include <linux/usb/tcpm.h>
>>> -#include "tcpci.h"
>>> -
>>>    #define MT6360_REG_VCONNCTRL1	0x8C
>>>    #define MT6360_REG_MODECTRL2	0x8F
>>>    #define MT6360_REG_SWRESET	0xA0
>>> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>>> index b56a0880a044..3291ca4948da 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
>>> @@ -10,9 +10,9 @@
>>>    #include <linux/i2c.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/gpio/consumer.h>
>>> +#include <linux/usb/tcpci.h>
>>>    #include <linux/usb/tcpm.h>
>>>    #include <linux/regmap.h>
>>> -#include "tcpci.h"
>>>    #define RT1711H_VID		0x29CF
>>>    #define RT1711H_PID		0x1711
>>> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
>>> similarity index 99%
>>> rename from drivers/usb/typec/tcpm/tcpci.h
>>> rename to include/linux/usb/tcpci.h
>>> index b2edd45f13c6..20c0bedb8ec8 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci.h
>>> +++ b/include/linux/usb/tcpci.h
>>> @@ -9,6 +9,7 @@
>>>    #define __LINUX_USB_TCPCI_H
>>>    #include <linux/usb/typec.h>
>>> +#include <linux/usb/tcpm.h>
>>>    #define TCPC_VENDOR_ID			0x0
>>>    #define TCPC_PRODUCT_ID			0x2

