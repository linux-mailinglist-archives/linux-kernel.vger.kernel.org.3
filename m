Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4548AB12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348440AbiAKKKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:10:12 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58829 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237384AbiAKKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:10:11 -0500
Received: from [77.244.183.192] (port=64326 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1n7E6T-000ER6-CL; Tue, 11 Jan 2022 11:10:09 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v5 0/9] Add MAX77714 PMIC minimal driver (RTC and watchdog
 only)
To:     linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
Message-ID: <d8aacb8a-5e41-fd96-daac-e9257358ca71@lucaceresoli.net>
Date:   Tue, 11 Jan 2022 11:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hi All,

On 11/12/21 18:59, Luca Ceresoli wrote:
> Hi,
> 
> this series adds minimal drivers for the Maxim Semiconductor MAX77714
> (https://www.maximintegrated.com/en/products/power/power-management-ics/MAX77714.html).
> Only RTC and watchdog are implemented by these patches.
> 
> All implemented functionality is tested and working: RTC read/write,
> watchdog start/stop/ping/set_timeout.
> 
> Patches 1-3 + 6 are trivial cleanups to the max77686 drivers and Kconfig
> indentation and can probably be applied easily.
> 
> Patches 4, 5, 7, 8 and 9 add: dt bindings, mfd driver, watchdog driver and
> rtc driver.

A gentle ping about this series. It's at v5, all patches have at least
one ack/review tag and most patches are unchanged since ~v2. It applies
cleanly on current master.

Is there anything I should do to help making progress?

Regards,
-- 
Luca
