Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3946B65C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhLGIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhLGIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:51:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20BC061748;
        Tue,  7 Dec 2021 00:47:41 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id i63so26088508lji.3;
        Tue, 07 Dec 2021 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=0uSyaAUNppffTOcVSgH8pF3DWHllS5e4jSCWi3CbVRU=;
        b=DLhE/wJtJGzkmzn6YdOY285UPhKw3ior+eCjvDV79MEijP9C8rGpWH5OZR3XwvfyNY
         iMAZH709PlWmdRKeR9bE29QDAXM9HcigJIT5aC24E34gEIB7yuBSXf19mBA9xaALuOzu
         Bhja3WSixwiCc1Ve3NhlMsrast3nWRCiM7TroabUwGDZ1PnjIwGf6qmX7sp+hwboQ8li
         8gf0XcU8CBRDbJBtytLCCGPOr+alvraWawXDDWT8S/LLoF6ywOExH/cif2NK43F9E38+
         04wv0s9rsFa0lCanCoROIWe9EoTl/JQ8uYjfqqiug1sNgnes7s3LfNB6+gmQSR/Whek/
         FCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0uSyaAUNppffTOcVSgH8pF3DWHllS5e4jSCWi3CbVRU=;
        b=25VPnMMD1wc3VC7cmxeEc3YOV4BAzgh1HL/kirrcvxW+v7TCddvlp0diXg/2n4xYhf
         vEHnF87sSWo8L6adSXhyHc2cg8LRuQ+YltAeb1ri8xmUdLiCnSGybQ8bvTf+7z9OgOni
         QYtYNUGKu7G2AdxBM3804/2k5V3Y++TBeJDujkfi5SzUGSfp/6OEelZqw12TQU9Mtw4p
         HddPGIbQQztyIITWCdzviMriyE9wWN398MV79ZfpbhhXPUqGBgi9YqIweOznsZuRkIi2
         aoJvg0diZfdcf6vuveLUZWakoliKZzv3dZeE3H/3bJNuCf7g3yZRokLHDJH1PRaLVlKr
         X+cQ==
X-Gm-Message-State: AOAM530Rk1Ko09vrB38LAFv6nJJzK6IXxEICS16ByGktxW9pdikIcMJ6
        AzcEcbm7Mufk5qtyIeZ5CnU=
X-Google-Smtp-Source: ABdhPJxA60eQmQODrZjSo13ntrCNG2of1qXkEz0ceSr5uIL9jxgV9DCNDho+mgwSqw1fleO/JFY3AA==
X-Received: by 2002:a2e:b816:: with SMTP id u22mr41598831ljo.51.1638866860217;
        Tue, 07 Dec 2021 00:47:40 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id s4sm1579690ljp.40.2021.12.07.00.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:47:39 -0800 (PST)
Message-ID: <c2afe6fe-d4d2-c9c3-eb36-90969a0b657d@gmail.com>
Date:   Tue, 7 Dec 2021 09:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH REBASE] dt-bindings: pinctrl: use pinctrl.yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        patches@opensource.cirrus.com
References: <20211202063216.24439-1-zajec5@gmail.com>
 <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.2021 23:50, Rob Herring wrote:
> On Thu, Dec 2, 2021 at 12:32 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Also fix some examples to avoid warnings like:
>> brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pin-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'
> 
> I think you missed some. linux-next now has these warnings:

Oops, sorry, I think I didn't test MFD bindings *after* modifying
pinctrl bindings.


> /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml:
> codec@1a: $nodename:0: 'codec@1a' does not match
> '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml

I'm not sure how to deal with this one. If you take a look at
cirrus,madera.yaml it seems to be some complex MFD that is a sound
device with pin controller and regulator.

I'm not sure: is using pinctrl@ node for that hardware is a correct
choice?
