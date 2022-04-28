Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EA5127E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiD1AFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiD1AFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:05:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117D82D0F;
        Wed, 27 Apr 2022 17:02:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r9so2789989pjo.5;
        Wed, 27 Apr 2022 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MQAHzj75bUL24cVXZai27Cp7fT8NBFoM4IN6VdxYD9M=;
        b=qrgstjD662uD0mASf4Lns6/fJJC8Tw6D60c8TonIiOHwaARfrwncV13tYmVyM4dxRf
         Xp5N9IIzn+L4Dn/v+Nicm554zwRblHhkT7QlMbIKLyJKPqmozxzf1aEI2NehOEziAGce
         h9ZWydlpd9ICko97l/P64TYeUxHYPz57A/rzewn6fGiFStDOhSqD8SbfnuoJIpP6gYqu
         rsMar46OapajVOcXf1Qym7RuOOWc8lQDH9rGGJrswsJqBN/RU0gYvo49pN5fnRrL6p56
         KC8Ig8QDfOHwousLQ6SXkfmKHTHuqeJ7snT58Fac3P60N6gOV//APIBU7P483/8tkpqb
         sLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MQAHzj75bUL24cVXZai27Cp7fT8NBFoM4IN6VdxYD9M=;
        b=ZGFU+le1lE0kr720aAsp6AXdUz31D1/7ZhMMLhdCCb4IJB8IlS/U80n2Lh5oEYIHjE
         wA9DSOCj7hN+UJGR8Xd0XB3tmBMEbpiO0nog5GISr1sHA+Ab0Bvfb9Q+pBH2tModjZaC
         xyPuL1PkdYgtxQEjl/LXBb9O3yA8CjVRjJ5FJfNt9ustRbdP/GZQqUk1lThGEuqLUWzW
         uzhH+d7dtBoeDWKoux1N/rt9ZdHjbOcSsbKmsUrTPuuRYb/t9lpLYhdA/6MipvRhF1ai
         yxFnhZ8o79CObM7FXPRXj4oik0RS5YMgZCwTclxrUN1Ycpdm/mrqA95W8wrLhybxg8cf
         ofpA==
X-Gm-Message-State: AOAM5325KyXnfT9VUBqhXgdIk9qHrm728RbKlMAT7UCfI8VSVg2S6WN6
        +G2iDt1ce8VRoRQxQ3rEzTWignLffng=
X-Google-Smtp-Source: ABdhPJzZHN/PJml0c5wTRNM4ywoHQ5+7W4SXdULxBRlC6dGLU7RIBY8NFxoHyuzclzXuZoehvRDd8g==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr30769629ple.19.1651104120170;
        Wed, 27 Apr 2022 17:02:00 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:7132:60ce:33ea:8830? ([2600:8802:b00:4a48:7132:60ce:33ea:8830])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm19612074pfa.138.2022.04.27.17.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 17:01:59 -0700 (PDT)
Message-ID: <21986066-f72c-83ce-d1b9-ef5767fdebef@gmail.com>
Date:   Wed, 27 Apr 2022 17:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 2/3] of: Add support for -@ when compiling overlays
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        sbranden@broadcom.com, soc@kernel.org, stefan.wahren@i2se.com
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
 <20220427185243.173594-3-detlev.casanova@collabora.com>
 <Ymm0l2/oGpt/SeDO@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Ymm0l2/oGpt/SeDO@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2022 2:24 PM, Rob Herring wrote:
> On Wed, Apr 27, 2022 at 02:52:42PM -0400, Detlev Casanova wrote:
>> This commit adds an option to compile all device trees with -@ to add the
>> symbol table to the Device Tree Blobs.
> 
> Why would we want to tie this to the kernel config?
> 
> Globally enabling it has already been discussed and rejected.
> 
>> It prepares the introduction of device tree overlays that are
>> not applied on device trees at compile time (dtbo files.)
>>
>> These device tree overlays will be used by either a bootloader or a
>> linux userspace tool to extend the base device tree.
>>
>> This is used e.g. for drivers that need device tree nodes for optional
>> non plug and play devices, like an external DSI touchscreen panel that
>> embeds different i2c devices to control it.
> 
> You can already set DTC_FLAGS per directory (and target?), so enable it
> for the dtbs that have overlays.

Looks like this patch series from Aurelien should take care of that:

https://lore.kernel.org/linux-arm-kernel/20220427233607.1225419-1-
aurelien@aurel32.net/
-- 
Florian
