Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390D74A3653
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354649AbiA3Mp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:45:29 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59659 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240805AbiA3MpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:45:25 -0500
Received: from [77.244.183.192] (port=61998 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nE9a7-0009fc-63; Sun, 30 Jan 2022 13:45:23 +0100
Message-ID: <3a186067-50e9-ce20-0ed6-696ca658de4a@lucaceresoli.net>
Date:   Sun, 30 Jan 2022 13:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/9] Add MAX77714 PMIC minimal driver (RTC and watchdog
 only)
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <d8aacb8a-5e41-fd96-daac-e9257358ca71@lucaceresoli.net>
 <4532b372-f16a-7658-623d-71af93306e44@lucaceresoli.net>
 <900e896a-f1c3-aafa-2ed4-a23104d65b74@roeck-us.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <900e896a-f1c3-aafa-2ed4-a23104d65b74@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 30/01/22 02:48, Guenter Roeck wrote:
> On 1/29/22 00:40, Luca Ceresoli wrote:
>> Hi Lee, all,
>>
>> On 11/01/22 11:10, Luca Ceresoli wrote:
>>> Hi All,
>>>
>>> On 11/12/21 18:59, Luca Ceresoli wrote:
>>>> Hi,
>>>>
>>>> this series adds minimal drivers for the Maxim Semiconductor MAX77714
>>>> (https://www.maximintegrated.com/en/products/power/power-management-ics/MAX77714.html).
>>>>
>>>> Only RTC and watchdog are implemented by these patches.
>>>>
>>>> All implemented functionality is tested and working: RTC read/write,
>>>> watchdog start/stop/ping/set_timeout.
>>>>
>>>> Patches 1-3 + 6 are trivial cleanups to the max77686 drivers and
>>>> Kconfig
>>>> indentation and can probably be applied easily.
>>>>
>>>> Patches 4, 5, 7, 8 and 9 add: dt bindings, mfd driver, watchdog
>>>> driver and
>>>> rtc driver.
>>>
>>> A gentle ping about this series. It's at v5, all patches have at least
>>> one ack/review tag and most patches are unchanged since ~v2. It applies
>>> cleanly on current master.
>>>
>>> Is there anything I should do to help making progress?
>>
>> Apologies for pinging again... but as I got no further comments about
>> these patches I guess I can really do nothing at the moment.
>>
>> Lee, is this series completely in charge to you or should it be applied
>> by the respective subsystem maintainers?
>>
> 
> I hesitated to take the watchdog patches because an earlier patch of the
> series
> introduces MFD_MAX77714 and the watchdog Kconfig entry lists it as
> dependency.
> I now added patch 7/9 and 8/9 to my watchdog-next tree anyway. If the
> mfd part
> doesn't make it we can still decide to take it out at some point.

OK, thank you! In the meanwhile the kernel test robot also reported a
build failure due to missing max77714.h file, which is added by patch 5.

> Note that patch 6/9 has already been applied.

Indeed, it's in Linus' master already.

Regards.
-- 
Luca
