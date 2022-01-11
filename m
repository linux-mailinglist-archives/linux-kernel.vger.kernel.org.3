Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0075548B25C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbiAKQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350053AbiAKQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:38:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF51C06173F;
        Tue, 11 Jan 2022 08:38:24 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id w188so2308293oib.7;
        Tue, 11 Jan 2022 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42h2BzV4OudUpbHBWx6uWYa35E6/jTpt7Oqh0+V9eCY=;
        b=LfxEIQmZ5D1o6iVdXJCvryq2pBjf/TTUwC3yvuRMxcWcKQEfF8+IGnIR+piRDqYl3g
         R4B27dkbbyR92UxzKuHALMpDNs0PrmX1gSWVklcpSbm3+sg79W0nidWYhqMSj4OnC7zs
         TLez9X7QHYDrxREMY02aP04jqkapSWr8kf5KKw+Rp6JKh9bOaSCvORta77m5MuHS3UKi
         6IPq+3aagdAW+986jt4aJNDDUQG9VT5ZCKpHli12mVXlx2W3vrCX+0V0gslVIFb5QJQn
         tRYx9CYVrepA1e9rmvAekPPxYpNx5NX/nQeUMzY0ICtNceduWPqmscPBctkoDbIyWL7z
         zu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42h2BzV4OudUpbHBWx6uWYa35E6/jTpt7Oqh0+V9eCY=;
        b=8IGFCsGrHFfrxMpw1CKKSaNaH/quYMlgxhHxlpbtm/Ak9ijZgHTwaB/21w5a2JcrxR
         KbCN8njHQW+G3qDZNFy60l4Wm/4vxo0fELxmwAw1mK+KxV/GDKUohCA+bxyM1FRUGL8a
         SfwztMQlj3ZnLq57av5RXkmT7ep4KJCbdnapoZ50qJH/GFhYBKZPvaiYjU4k4U3Dy2uz
         VEs23vTT9EZCAlCZIpSsVvdbTeGEJrWuUrEcAEyNUeCuPsxD+hsqIh709hHq54rJwNee
         b37Gz0WC+TLJykctwpzISvg+vMPpZDWh1ZB7AN1X3TxajW9n1g6IF0aTIp50dACQiuiF
         x1oA==
X-Gm-Message-State: AOAM530VuG26GwSKaIGG2OUXYoFsBu1/bcBI+ujuNdorHcofMEEAWoG4
        pt8FHQrMBLQsIwgCAm8Ka1XJPWng9T0=
X-Google-Smtp-Source: ABdhPJy5fggybeRefMggpwkNd1KgbBJ96Nz/FLADWcBOYt62C1b/Gz5zj1G5r7OwOfRfi9XU8kFbbg==
X-Received: by 2002:aca:ad17:: with SMTP id w23mr804974oie.38.1641919103342;
        Tue, 11 Jan 2022 08:38:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x14sm252507oiv.39.2022.01.11.08.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:38:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: PATCH v3 ASUS EC Sensors
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a520f11e-c495-b456-0216-e57ad21c4182@roeck-us.net>
Date:   Tue, 11 Jan 2022 08:38:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 8:08 AM, Eugene Shalygin wrote:
> Changes in v3:
>      - Removed BIOS version checks and BIOS version dependent mutex path.
> 
> 
Subject should start with [PATCH v3 0/3], and there should be a proper introduction,
not just a brief change log for the last version.

Guenter

