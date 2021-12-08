Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09F46CEC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhLHIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhLHIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:21:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F78C061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:17:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y196so1164280wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lefHfKE34iN2p1ZLfnnsya19wPeFFyglrNNbrUVmITA=;
        b=k/l3QcLPU8iWZY1229lunqMUPVkkT6K1yXj0wmGZ8bOvkgMaIeTa5yyg4muOyamaIv
         9m39fOS+2E57jztIbXvWk7unwxBtWLc+cV77DKSqGYkTsCP208JRJaJhjYBti+Jruu0i
         RNrSF1q+bKJsY+xhi1id/6SP84T0VysUgvnXkqq1b1fwS/pNtw1s7VDqF8DUtaTN7Fex
         1IvmxX78pvYw8ln06GdMmTCUmVUaRw1CiyzCkDuPg9eXf8nazLMKAxBrlg29A9mKQeLh
         ha4FJTiy2hZp9IMzZSEKCqYyBKXsAyEP62OVlwAuX3nxB6zPMGuEdDVrttGhsrUCYTEi
         IUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lefHfKE34iN2p1ZLfnnsya19wPeFFyglrNNbrUVmITA=;
        b=tAR+OJ/4xXaoJtmeeZY3pX/KMMKB0MCLXD1vnFdXaQq6NegxdocJSv5riMQwWX2QFu
         xxIlGZViUSWSvk7HRzfvU+f3GsVlRz1TDPqkiFMJPQUzx5NTwhGkPkNsPbTTCnnnxWxC
         COW+E/NaWCWrRZTwGgoDn2rmuFNLto/8cjCvyUzj2tcGx7mRSgVUc0LPSdvZLh9plFSH
         ea6XpBlRYKVXJr1NZnxcUkYWJJ20z2lGAocgMuJ28yox4KPUvPC5ASFPvhourJA8Vna0
         qaN3eLdGri1hqOtV++mIMPOc86pc7T3MoFm54cI0tS0psRuWLoSiWdgEhVRVRNCAZxPh
         b3lw==
X-Gm-Message-State: AOAM532jvEv/yJKBqUWwKeY9OBi68JHadb46Ysg5W9twd6aGo9l+RVN5
        kmlkTRhUHt5q6j4SerjxB1lI7gd+79pkM2Dz
X-Google-Smtp-Source: ABdhPJyrPpzIrMmzjZxmp1JOMP0OzoPDHXAMEAEuljzRqg3sM2iiawD2lnjSigiJ92Fl1wJQQUq2Bg==
X-Received: by 2002:a05:600c:4e51:: with SMTP id e17mr14077484wmq.127.1638951470915;
        Wed, 08 Dec 2021 00:17:50 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:5245:80ea:cf46:35bb? ([2001:861:44c0:66c0:5245:80ea:cf46:35bb])
        by smtp.gmail.com with ESMTPSA id o9sm2071298wrs.4.2021.12.08.00.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 00:17:50 -0800 (PST)
Subject: Re: [RFC PATCH 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Benoit Masson <yahoo@perenite.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-3-christianshewitt@gmail.com>
 <Ya/Qask7Fpb6mTxb@robh.at.kernel.org>
 <C1918DC0-F873-4832-AF1A-91AFEF4F7151@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b3307dfd-962c-73bb-1712-8dbbf977b6f5@baylibre.com>
Date:   Wed, 8 Dec 2021 09:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <C1918DC0-F873-4832-AF1A-91AFEF4F7151@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 05:44, Christian Hewitt wrote:
> 
>> On 8 Dec 2021, at 1:21 am, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Nov 30, 2021 at 06:05:16AM +0000, Christian Hewitt wrote:
>>> Add board bindings for the Amediatech X96-AIR STB which ships with
>>> model variants distiguished by Ethernet configuration: models using
>>> internal 10/100 PHY have a -100 suffix, while models using external
>>> Gigabit PHY have a -1000 suffix.
>>
>> Isn't the phy described in DT? Why do you need to describe this 1 
>> difference at the top level?

The difference is between internal VS external PHY, which means
difference in pinmuxing & settings for the MDIO mux selecting the
PHY interface.

The other issue is about the bootloader, the vendor bootloader is not
necessarily capable of detecting the PHY type, and correctly altering
the DT without a complex script.

Having a single DT adds a dependency on the bootloader, which for me isn't
acceptable.

Neil

> 
> Users who purchase Android STBs as a cheap Linux media device (or are
> reimiaging an existing device when they give up on Android) generally
> have no idea what a PHY is, so reading a device-tree file to pick the
> correct one is beyond them. Most people blindly try all dtb files for
> a class of device until they find one that works, so top-level naming
> is simply to hint the process and reduce guesswork. It’s not perfect,
> but it does appear to reduce the quantity of “Ethernet doesn’t work!”
> posts seen in support forums.
> 
> Christian
> 
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
>>> index 36081734f720..e9ab0ffe8be7 100644
>>> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>>> @@ -170,6 +170,8 @@ properties:
>>>       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
>>>         items:
>>>           - enum:
>>> +              - amediatech,x96-air-100
>>> +              - amediatech,x96-air-1000
>>>               - bananapi,bpi-m5
>>>               - hardkernel,odroid-c4
>>>               - hardkernel,odroid-hc4
>>> -- 
>>> 2.17.1
>>>
>>>
> 

