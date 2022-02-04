Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419074A93AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiBDFf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiBDFfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:35:55 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A1C061714;
        Thu,  3 Feb 2022 21:35:55 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m9so7280973oia.12;
        Thu, 03 Feb 2022 21:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K+717NKX936wQ1aYhlbjA5VAAzQM/QdZyfYA0VeTi10=;
        b=oUE/v0USlPhaF9IzRS9lk/8QMhs7pXCzKx30YtcCe7gFcN6f5UFMlZzer0dX6qlMaj
         gGv4xOXpcYdozXkqo+/+hv0wnpMS3Efghlh0w1zrSLO3jRf/3R0/HvIkOuW9Qv33ptE/
         5riQNQ5TWTokR2hbd+TgCQT5I0dw61jofJO6GeSHT+XdRHNFbqLSTs4BF0YnvVpztFjS
         b76LPscq2NXSTydadFMHWO+ql3ludW8406u6N0viTAJ8/P1MwRr4ZxMVcgiRqr8IOGht
         IS9FjBPPyxdPm2fW0L3CKhF9MU5bO0GVRZd/cT38Y3PeNXg91ozB2JcRkEg8mLwVZjj7
         ocWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K+717NKX936wQ1aYhlbjA5VAAzQM/QdZyfYA0VeTi10=;
        b=hrVpejFTtV+p0Id6wK6hqcBz/Jq7bCDvoC4x51IiNBUS105NlsFQQUGWw7+wuGZw4K
         YXVEv6Z+CEli/iIpat9SYeRkZ4Vtnl75V6FatL/uuwPd1GRGwDmXEDPvFyZkuQ4caNQm
         N1Lw+Qu39SgylgolDiHg4UHaBVw0o/DufIreN8+kaxo+/FtOO+/RNhUAH8iHUMNydAjp
         wZPHa1wtXgg4usm+Ulz1Q1psIHunoTOyVI7qTtLY52oiLGIZ5Y8II5S3BFtOB9wGrTbY
         mWhtcd5zCaaDFSJKSdPbi/d5ZHoiBLg0G0h+mOPkdo4/Q02j+3wYvjcph8pUbysOA8wQ
         +p0g==
X-Gm-Message-State: AOAM532O+1frp83QnHVnusVU94cXBwnRKI/YHHYV5JA7I98YiVByoX+v
        xMvL3UbPXrCPVVMPign+E78=
X-Google-Smtp-Source: ABdhPJxpSJ2QjgGxli1SQHTBRsLg11FwHnNq2TrL6ikekVJq6dxaC7aBqzF+Ppo30pGgGyNIqrpx3A==
X-Received: by 2002:a54:4785:: with SMTP id o5mr585592oic.96.1643952954302;
        Thu, 03 Feb 2022 21:35:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g34sm360552ooi.48.2022.02.03.21.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 21:35:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <40c67c87-3929-b042-0cdd-429bb002d864@roeck-us.net>
Date:   Thu, 3 Feb 2022 21:35:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: fix documentation index
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220204052258.556667-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220204052258.556667-1-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 21:22, Eugene Shalygin wrote:
> Replace asus_wmi_ec_sensors with asus_ec_sensors, which should have been
> done in d4b4bb104d12.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>   Documentation/hwmon/index.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index df20022c741f..1bad4e6116e4 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -43,7 +43,7 @@ Hardware Monitoring Kernel Drivers
>      asb100
>      asc7621
>      aspeed-pwm-tacho
> -   asus_wmi_ec_sensors
> +   asus_ec_sensors
>      asus_wmi_sensors
>      bcm54140
>      bel-pfe

I already did that in the original patch, and I undid the removal of
asus_wmi_ec_sensors.

Guenter

