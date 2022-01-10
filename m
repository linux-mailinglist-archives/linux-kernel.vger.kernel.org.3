Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8087F489524
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiAJJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbiAJJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:25:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA0C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:25:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l25so14603692wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iXRcQtW/RqOfyLEuPiv/rc/ZOHCOx0ZmI+mS8uhOeao=;
        b=vHSXBHa+8Dng6wkLUU8WVk6FiH3tcp1ac53WDMyiK06jdNJO6yDaUKb1hIKjClIN0q
         NX+RqkVx162MbZkD21ndK6jb+NgeVtgJP3vsrxMcEqtjLZYbxSDif0f0JYjgkY6FEkL2
         zFvRBkp2wiup0bJ7mVwYV2iYzH6g7IC/dCzqmSY9iUFsKqLe0LE5D7O1SmQMzNstn7nX
         mq8Ophn1E1auqBvr8o5ktZT4ChPhUKh+YoQUJY2KjvbUzNVEF+EgdSrZwWN8bD6Gim2P
         hCyt5V32cqiOfpJuUbhwTZ0hX/+ZbzjaKGjwR9BgUXCNwNNCtsHqzsZk3kTfN4teh6kB
         tpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iXRcQtW/RqOfyLEuPiv/rc/ZOHCOx0ZmI+mS8uhOeao=;
        b=T3a7heOMeqmYNa/9PKXx4+8ayLd4RPWBMuYnpRnu2Ah7vPvzUWlcJaZhTEPvGCTEq+
         1BBmx3LQq1ZNIY2aG0hWpKOqNOUmtfWR2G86pd4jxdQLpVoJreb5maoh3tySm6icE0gx
         Q/rgqaBniixf4RyD69fM+ThFRoMyOBUJQPIHqouVDqmRZhKjJaepgAFco09wQBOeSjz2
         Doe4c+zVHkqWC9osVOoMHgbs67da8CF2YuYAJmrngAaa86DLhi1bM7Z8Ny5ZaXq8dddd
         UiJV+eOXsj3g86hJ6G0UJ/yZQwR2wnKiTVKr3w8/VXL1PxSmVj/I3Hd2w9XdNfzOmx4e
         H+Tw==
X-Gm-Message-State: AOAM532yAL7LQNgrF5vLNsPvwdy60Z1fH5jJgO53Zy9HjVSry4M9E3aO
        ptdQyIdOjN1pTX6uQ/gyPgI6pe0M8ZecyA==
X-Google-Smtp-Source: ABdhPJyvmN1IIelz0OaL6TWjryajCQAa27psvjcxhcDCQvdNj0GmndfkDN8HvgK50DPa6wDpPBMwpg==
X-Received: by 2002:adf:e188:: with SMTP id az8mr20152428wrb.670.1641806701770;
        Mon, 10 Jan 2022 01:25:01 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id q14sm6330055wro.58.2022.01.10.01.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:25:01 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI
 D-PHY bindings
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220107150512.614423-1-narmstrong@baylibre.com>
 <20220107150512.614423-2-narmstrong@baylibre.com>
 <CAFBinCDRx6VaaAubr6VRLnX=G4Ez8cGg-=6e-9GWrH8FwwBs-g@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <fad140b9-2940-a24a-ba70-9849bacf617d@baylibre.com>
Date:   Mon, 10 Jan 2022 10:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDRx6VaaAubr6VRLnX=G4Ez8cGg-=6e-9GWrH8FwwBs-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 23:13, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jan 7, 2022 at 4:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#phy-cells"
> I also found a "MIPI DSI PHY clock" and "MIPI DSI PHY interrupt" in
> the datasheet.
> I'm no expert on this and I'm just asking in case you have missed one of these:
> Can you confirm that these belong to some other IP?

Indeed the name is misleading, both go to the DSI Transceiver IP (dw-mipi-dsi)

Neil

> 
> 
> Best regards,
> Martin
> 

