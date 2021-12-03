Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C9467EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383006AbhLCULN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353573AbhLCULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:11:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9148DC061751;
        Fri,  3 Dec 2021 12:07:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n26so3890368pff.3;
        Fri, 03 Dec 2021 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BY4StM0qWwOHdEnKAlQTsARvzXKfpZF6VL/V+dFiAQ8=;
        b=de262HkpslGoIEW0WtQLDS673GV03/ENqYIlg6yu9c1QsZiln9CQd5RESPzST1Jyqr
         s81hLXgZdMfuOfbSxvVGRfZXQO5tThE96UjrXqcCBGspM46tNew8MC0za05BTW+r0kqf
         CGtVxrOXWZUYv0fPp+UG9wc0lV+1eO5IjhQImrERikihLTlIuCghNhRG4RlWhXoLj9lQ
         UTY5ZpoKj2w8vdqoEpbvy47W0vJM9qkq+2ruB9rLLr6WIiLXVnecqQNFcno7pVhuOji/
         SgYOYpXPMwn+1oPbAmtHWRxvoxyi42i8ksg4Dw1OaqoHnLACkQf/a2BbFK1XQI2ErX3E
         qVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BY4StM0qWwOHdEnKAlQTsARvzXKfpZF6VL/V+dFiAQ8=;
        b=Y2xECowcrmV8HTkj4cJRSNPOKf8HgAC1cud7D43J0S7uT5ayAkar4pBn9fTjUJqsMK
         Q88lc+PDPVL/WRvw5/4+vFwuH190r4b5L1fQlriMSmOVy9e+xAxrBwMQ7bSwtXW1NSrF
         fhBOhytZLNHl0plNMPyQOc12x2jUfAn40pmDN7AdOE3k6uw5ikV58aYLmphjjQGUUFR9
         oHkVoAmT/3fmlgoDk/M/tLfPBwwmaPkz5ryYNEfIQIQ933OqEhIhS1Q5pfUDoNjuGRD3
         Y9xedIyBNqxivM0nhd9Xr91TrUyWF9XtKZrJb7CQEj8VoNegj9W4zVq4xt6bI9/93DMz
         Fv9g==
X-Gm-Message-State: AOAM530fHtaGT80ak4owsJfcTRyIzUDJMIhAAa87r5FIzuth6Gq6NM2B
        Lcpcm1iq2WpACJUpTQ5OG/0=
X-Google-Smtp-Source: ABdhPJzjXSHYG1cNnHL9dHSHqe86N4xkrGq4yfOPjwAxw4i1pCePwxR/s4E7FnoqSsneLf7SXalN6g==
X-Received: by 2002:a63:2b08:: with SMTP id r8mr6242949pgr.211.1638562068049;
        Fri, 03 Dec 2021 12:07:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n16sm3156272pja.46.2021.12.03.12.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:07:47 -0800 (PST)
Subject: Re: [PATCH v5 0/7] Removal of bcm63xx-wdt
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211112224636.395101-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <78c9c9f7-7e7c-abde-066a-240d642f3412@gmail.com>
Date:   Fri, 3 Dec 2021 12:07:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211112224636.395101-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 2:46 PM, Florian Fainelli wrote:
> his patch series prepares the bcm7038_wdt driver to support its bcm63xx
> counter part, updates the MIPS BCM63xx platform code to provide the
> necessary information about the "periph" clock, and finally proceeds
> with removing the bcm63xx_wdt altogether.
> 
> This was only compiled tested as I did not have a readily available
> BCM63xx system to test with.
> 
> This should also help with adding support for BCM4908 which Rafal is
> working on.
> 
> Changes in v5:
> - removed unnecessary "bcm7038-wdt" platform devtype
> - added Rob's Reviewed-by tags to the 2 binding patches
> 
> Changes in v4:
> - fixed binding patch (Rob, Guenter)
> - updated Kconfig description title to mention BCM63xx
> 
> Changes in v3:
> 
> - added Guenter's and Thomas' tags to patch 6
> - added missing initialization of id_table
> - use Rafal's latest binding patch
> 
> Changes in v2:
> 
> - added Guenter's Reviewed-by where given
> - update binding patch to pass make dt_bindings_check (Rob)

Are we good with this version? If so, could it be picked up so we have
one less driver to care about, and we have one additional binding
converted to YAML?

Thanks!
-- 
Florian
