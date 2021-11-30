Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1822D4635E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhK3N6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:58:18 -0500
Received: from cpanel.siel.si ([46.19.9.99]:41486 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234735AbhK3N6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:Subject:Sender:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4GrTBbrBSIUJPUnHUuP+Y97Va2ThjHSn5LLuF+6XDlQ=; b=OlcES8s3yH7u5diGUmwtf0Lq4H
        5kGCXtNp5kcjZFBcwvzKKF/FCoTlJV3l8G5I2D2vpH0hyaFmaNVXfEF+OI6gLldwNkjTyafjnpP00
        81yHFF+7CNBzBee9B+bhoOucmVIZ9w+GWd65bf6oCR6XGMS6hmaA1vLbr41nxANBlGExE7en9UmIJ
        G4rcP0Nwi9i/xayYytAAnDKEDPIAoqFLtH0HnaC8ok3iOjWaWQSrQqcOu7EvbfUMBxTxzKAXbdvD0
        PQDn7XEiEBlqDb60ArxDMT1uG3G37djeuTeHAEicFPtVWZVzAV/qWfsrs5H1HRupEx8Vcq5KqzFO9
        clNwS3Hw==;
Received: from [89.212.21.243] (port=49970 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3as-003Au1-Sg; Tue, 30 Nov 2021 14:54:50 +0100
Subject: Re: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-3-andrej.picej@norik.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <14ac09ca-749a-0d4c-da1a-46ce7c4f2fc2@norik.com>
Date:   Tue, 30 Nov 2021 14:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-3-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30. 11. 21 14:42, Andrej Picej wrote:
> Document the watchdog timeout mode property. If this property is used
> the user can select what happens on watchdog timeout. Set this property
> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
> will go to POWERDOWN on watchdog timeout.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>   Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> index 950e4fba8dbc..e3e6e56cee21 100644
> --- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> @@ -10,6 +10,9 @@ Optional properties:
>   - dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
>   	Only use this option if you can't use the watchdog automatic suspend
>   	function during a suspend (see register CONTROL_B).
> +- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
> +	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
> +	POWERDOWN. Can be 0 or 1.
>   
>   Example: DA9062
>   
> 
Changes in v2:
  - new patch, document new DT binding
