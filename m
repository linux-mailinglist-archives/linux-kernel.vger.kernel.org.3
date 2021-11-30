Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619984636C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhK3OgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhK3OgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:36:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A792C061574;
        Tue, 30 Nov 2021 06:32:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t23so41610652oiw.3;
        Tue, 30 Nov 2021 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LLwxz7SFD0/zX8V9RD59BizGhzKcy4KZ67rMTjYc8Kk=;
        b=OViSCVRoEqVSygJrCSpQyhT6cmkJNP3vr/izo8plBCxe+hFGKi1mczQMVHoIE8FThk
         E515M3/LE+V602oggPHC+bFFFr2Lll0z5rHarPhn76c4P6WD95UDry944juV3R9rEhOc
         KJcg8Klm1epavV5fsAwMnByag2pTpjInCqEhmAEgkMGWG7f3Y+z+a7stIj85ZETf0q9u
         MO6islpSyCflnmXBXgr7gXN2C1kVOpjDUO2t+hlj1NNPCDhvqxgEeVu4kTyyKh+TC5fk
         8h8UbVa3Lo8AXkH0/6AjwPMD05BmPNxQymfUcQ3qEEsa4NUkZwXomXGMHaVMmPGDQHBZ
         mKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLwxz7SFD0/zX8V9RD59BizGhzKcy4KZ67rMTjYc8Kk=;
        b=nlTRdA+ZOTqiDUt1n4xTwCrTLDxL4Z3OKFD3ehix6WpF3oz3jSxyIZMLHd5vD956Xj
         H+myNOxbVkpmzCM2V0RlaaPRDuH9c5+a9P7yyNAw5Via7aidHZMv+n7+KU1IJnX/93KP
         xodGg3M2VBpJBb2Msfqr5rZZXLe7FhBzTWy6heSp2rBTg79j+qQ6ZwKkySOe9SJiAR6g
         cC8pLAO5Xd7LPyFoYEPGk/irT5xS9iJ8BF0XasM7JOdSkN6yK0Zh0QGG9szBPtrLKeur
         tU0jrMP0UCdKCNoFQN1LzRYmJmlV7FVAEBJFzFN/IEnVPFqoP6i7TOPtjfDEF6zpp5XW
         s8OQ==
X-Gm-Message-State: AOAM533182JFYwiqzkj9EUhVJX8b8UyQISTz6ciaQfGNqwPAG73ZHN/w
        nJQWxM8NwChpxtpf8gkvCxwq32rHWyc=
X-Google-Smtp-Source: ABdhPJy+9kI4mY22RgVBh+6yLQ65HqbIuahK0rru/6vF3iYXu7m6xkerBVmyeHc73/MAWOuGfkYYsA==
X-Received: by 2002:a05:6808:dc5:: with SMTP id g5mr4462456oic.58.1638282771857;
        Tue, 30 Nov 2021 06:32:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm3864156oiw.8.2021.11.30.06.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:32:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-3-andrej.picej@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4591cdd6-9a7b-cd1d-817d-8950c8976d10@roeck-us.net>
Date:   Tue, 30 Nov 2021 06:32:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-3-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 5:42 AM, Andrej Picej wrote:
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

Why does it need a value ? Why not just bool ?

Guenter
