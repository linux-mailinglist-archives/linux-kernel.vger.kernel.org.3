Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB005A693B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiH3RFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiH3RFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:05:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F82A95D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:05:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p7so5269968lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lYF9MfFRrV4XpO3M6oKX5MFynoiXFXl2xfJRMlgcOXs=;
        b=rB3ailKFlhr99Dkue6ZGBuSHO9P3bwRGe2PybLNl5asBy4gk90PC+I8SZ7UYBGHtnf
         GTKvRRMbww2USQdgxG5P1qHbHdDZMp4NJ0dGuk0Mj8S5QmXpH3f/o3Yg7olp5XkMwgI+
         kqiFkgPMOOZ+5qXlpQ5h0BnUxsZY3/OJE0xJGn7SwtfSK0ZMgn/U4AFoADbLehvIMEcK
         mL/+51NGwtJ3I1KgxqC14NKhNpBFjdjeDFGblMYhvQp4ZkSVYlcxKQPICVvEloEybmTj
         M+8NwZkZDBVExXZcuPCAwcU31pzNAjPvcUUqbTDTP/cmr2Oz3m0o5yUlVuX6cQCi4uqP
         0tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lYF9MfFRrV4XpO3M6oKX5MFynoiXFXl2xfJRMlgcOXs=;
        b=1Czw8A57pPgWFD2Q650kNf+TAiRcrboidh5tPW1JlIQyOt/HJgw/yBaTv8vHtBk47X
         gTrlQvLJdAWBAE00z/e0UxkINlEcN+MBHmp/RfElO89sTvxJ1M6zMB9Y55fOJCNLuBYz
         MYxsGnoUx8zqUXOCbw2Q2DolHWRu24VsB3+INgA1wwNc+022alo1TYdY4QqilN/C9d9b
         zQhgF2IU4NUJLkVOp6kkQK6kr5HN2qCZcJGaxMdAea/qs/AXEgwJe2NkUrR1N+/g1P+D
         89xcEpuNQvfSlmgKEVQ8AhEEoDAPbZ1fwUn2ET4Gd6yod64y5JvItjNv5WixZ/Z78BSq
         crvg==
X-Gm-Message-State: ACgBeo03Emuggw+WU+ET1OzqmU3p+IjvkKMcCaHWEsWDYAmDYxs8ho+M
        KjUdpHiKXvgu77MzeGfTB8GkKg==
X-Google-Smtp-Source: AA6agR5zsSe2GoY9FGRHRGqwJpl24jp7i1Y4rLceq6QeFcpwm/RG2tjItVfcPEQK/WUD7mvmIZ4gFw==
X-Received: by 2002:ac2:4f02:0:b0:481:43a8:e368 with SMTP id k2-20020ac24f02000000b0048143a8e368mr7672885lfr.65.1661879135404;
        Tue, 30 Aug 2022 10:05:35 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id b22-20020a056512071600b0049467f0194csm960467lfs.265.2022.08.30.10.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:05:34 -0700 (PDT)
Message-ID: <8b9f49c6-86fa-b072-9cd0-5e363596593c@linaro.org>
Date:   Tue, 30 Aug 2022 20:05:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: at24: add new optional power-supply
 property
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, Rob Herring <robh@kernel.org>
Cc:     brgl@bgdev.pl, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, dwmw@amazon.co.uk
References: <20220822105830.22790-1-farbere@amazon.com>
 <20220822105830.22790-2-farbere@amazon.com>
 <20220822214623.GA907654-robh@kernel.org>
 <9e8a39d0-6267-cbac-da29-00e41871e14b@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e8a39d0-6267-cbac-da29-00e41871e14b@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2022 18:45, Farber, Eliav wrote:
> On 8/23/2022 12:46 AM, Rob Herring wrote:
>>>  Documentation/devicetree/bindings/eeprom/at24.txt | 3 +++
>>>  1 file changed, 3 insertions(+)
>>
>> This file doesn't exist any more. Use the latest -rc1 kernel unless
>> there is a reason you need a different (even later) base.
> I applied the change on top of v6.0-rc1

Not really. The file is gone since v5.5-rc1 as you can easily see in the
sources.

Since you did not Cc-me, it's another proof you based your work on some
old kernel.

Best regards,
Krzysztof
