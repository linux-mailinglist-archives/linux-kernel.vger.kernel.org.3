Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6755B48B242
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350037AbiAKQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349819AbiAKQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:33:31 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B50C06173F;
        Tue, 11 Jan 2022 08:33:31 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r138so1237204oie.3;
        Tue, 11 Jan 2022 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IW1TnZKKuBL8FKriO3RlguOvK7qrjKVXqE00ffr+uv8=;
        b=m2lnUJ9Gqd7bC0ksuj6kwcjZaJKgP9ffE67xw5DCNW6Qe4oBJz8qi6dpQP5JKXu3Ak
         ECZCEPw8RajmiISnZU7RlwE/ew1bGHXv1hBUPF8sfvutE+dXQf463HAiQCEx2jtyjGW4
         yNahyZ/H+p6M0YNRVxIIR4d2y2iBcPLEVuLd9jray6o5I1lXWbLijOTn4RYIhrbls/dM
         ssnVXLvwX9oTtjzPkpRfJuz/564J+5YG9hlcWsHRPSHIU4elULjhxD75PGZu5EHNl8o0
         evPkNCBPdUVBN450aHBzp930ZK9YUyPBvkSxh52Q2hTRj+mXEIq5UNP5g5ul4Etf4BBj
         Tbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IW1TnZKKuBL8FKriO3RlguOvK7qrjKVXqE00ffr+uv8=;
        b=DCO2dPi9PJWLe1wFtQHRzfK2MXNJlj8ePlBUDJUeuX8YycBF5g1n98k6+AZRWvQsDD
         leM/WiQ59qnqF284mhORQwHdnG0tU5hFrQXgpZoWdUoPWGRI1IMoOZSUrpXut7JwcU+b
         Fr4be34EcMgfZMXywcq3t/50nLH5WjCrUH5QDS/66SbLTK9BYegAADS5QLT22pdwe6D5
         M1s+3CdVmu8ggY9gBRQRbjecxuSVylJxz7ZCzAl84dI03vErdGWEWSUC4vEWMeBOkMUH
         X+6O5BB/r/4uWJcLqOEdOR3OrKHKD4e0O+SlbT8zts0pEjc2xElM3+PCq+6xT0FTnBp+
         h/SQ==
X-Gm-Message-State: AOAM5312a/+7LDCRtdDodM6cHfkrAFXKrmnmgOK+rTsAeQ3kJrGceKD6
        GoubugYW/YljRrOFgKbHkQ1cMWJ3dkI=
X-Google-Smtp-Source: ABdhPJxnDzMfs2T5pHZ+v06NTsDYP6B7CY+xTrZipsDZOztGj2T9xAwvuabXOTAkduq2zEKxDmpJ+g==
X-Received: by 2002:a05:6808:16a4:: with SMTP id bb36mr2361527oib.112.1641918810767;
        Tue, 11 Jan 2022 08:33:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb8sm1738030oib.9.2022.01.11.08.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:33:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a2abe48e-3547-be08-5f4e-1fb6fd47faef@roeck-us.net>
Date:   Tue, 11 Jan 2022 08:33:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111160900.1150050-2-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 8:08 AM, Eugene Shalygin wrote:
> This driver provides the same data as the asus_wmi_ec_sensors driver
> (and gets it from the same source) but does not use WMI, polling
> the ACPI EC directly.
> 
> That provides two enhancements: sensor reading became quicker (on some
> systems or kernel configuration it took almost a full second to read
> all the sensors, that transfers less than 15 bytes of data), the driver
> became more flexible. The driver now relies on ACPI mutex to lock access
> to the EC in the same way as the WMI code does.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Please version all patches, not just the intro. As it is, the version doesn't
show up in patchwork, which is confusing.

Guenter
