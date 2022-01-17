Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1392490C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiAQQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiAQQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:35:01 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3CBC061574;
        Mon, 17 Jan 2022 08:35:01 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso20504309otr.6;
        Mon, 17 Jan 2022 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p3gG/uGYcRlUGoPgDwXdMzkPcoyd1UeEICXKBe487oM=;
        b=QiVDp2IE56rYB7csRiMySFukCBTP+2HJDXPgVrULlTGDurbgfYRVsgJVDGkwrv+dEH
         box9Jqwyqwv2E5SzxMqdmLPxUpnBaDyTs1F1N5Iv/PwqXw/S38HYSJ+kdEmBp68Haq/E
         OimQIKUfNV/ZOl+AQhZgkcK4yHI3CbE8+OTmiWnkacb6jml2tL8pY9P7UWIh32gxGoC1
         d4VfMxAEy1roKPgtQU1VQiPesqaio0SmD5f9XBNbXSX2QgKVyHlXkPWcowddnlZqCPJy
         ouuveDStvDjunnXBUDqcnrPPeLFJIcBJSFzVMqFbT2lnHvLHM736O/QAKf8r0xYQvR0t
         dYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p3gG/uGYcRlUGoPgDwXdMzkPcoyd1UeEICXKBe487oM=;
        b=behSu8RlbB3gIu4S9p30mDv/AvhUC9Xr+7BOVwvR45LoyZbpX35LJDfd5rC+NylO1l
         3CoejWpyFa+EPuhqdc7d5QDCgzhR4XnuWXspuE47NrvimlWwJxvwLbUjfGxA82NSLBmh
         f0z0VtEoNQunClozqUPZD8LoTc8qmWVA0E+4HBGHrK7/cNi3hL4L2j0efKpn0zZYyv/U
         xg/9H4+vJrdPm85+Qrgk9eoLNtAqJ+fNknCufmJdXdzTGmG0t14LpYFP3kKM5NT9iiyT
         9/70UnFl0+X8mYX2sQHpka9ccMZ3lmi2WzDY0pKa2CmExpOJF2Xd582HMa60CfVo+btc
         5YuA==
X-Gm-Message-State: AOAM531JPChFthqkhiUYvNM7XO9d1T5n4MnUqV4R5H2Htntscvdm39E4
        MxkBRKMj5qIumvOXz+xES6o=
X-Google-Smtp-Source: ABdhPJyK0Irotkr18SoI6ww//ipgY/CYXIrn7ww3l9mNRiGWugmMTHvzxGIOeJHYzS5QUnUYe/zIoQ==
X-Received: by 2002:a05:6830:4391:: with SMTP id s17mr17003236otv.108.1642437300631;
        Mon, 17 Jan 2022 08:35:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm5969418oti.35.2022.01.17.08.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 08:34:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Missing ARM TWD Watchdog driver?
To:     Boris Lysov <arzamas-16@mail.ee>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220117190112.2b2c2f53@pc>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <60dceae6-5c7c-9f2d-9fcb-5e849f1d8ce5@roeck-us.net>
Date:   Mon, 17 Jan 2022 08:34:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220117190112.2b2c2f53@pc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 8:01 AM, Boris Lysov wrote:
> Hello everyone,
> 
> I stumbled upon the ARM TWD Watchdog driver which seems to be missing (or I'm
> just blind).
> 
> As per commit a33f5c380c4bd3fa5278d690421b72052456d9fe ("Merge tag
> 'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux"), multiple
> device trees declare usage of arm-twd:
> 
> arch/arm/boot/dts/arm-realview-eb-mp.dtsi
> arch/arm/boot/dts/arm-realview-pb11mp.dts
> arch/arm/boot/dts/arm-realview-pbx-a9.dts
> arch/arm/boot/dts/bcm5301x.dtsi
> arch/arm/boot/dts/bcm63138.dtsi
> arch/arm/boot/dts/bcm-hr2.dtsi
> arch/arm/boot/dts/bcm-nsp.dtsi
> arch/arm/boot/dts/berlin2cd.dtsi
> arch/arm/boot/dts/highbank.dts
> arch/arm/boot/dts/mmp3.dtsi
> arch/arm/boot/dts/owl-s500.dtsi
> arch/arm/boot/dts/spear13xx.dtsi
> arch/arm/boot/dts/ste-dbx5x0.dtsi
> arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> arch/arm/boot/dts/vexpress-v2p-ca9.dts
> 
> and it is documented in
> Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
> 
> However I could not find the driver itself. I tried running case-insensitive
> grep and ripgrep to no avail. Does this driver actually exist? Is it gone?
> 

I may be missing it, but I do not see any evidence that it ever existed.

Guenter
