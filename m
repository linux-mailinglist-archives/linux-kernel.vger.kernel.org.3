Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF058ED82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiHJNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiHJNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:41:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF1946D92
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:41:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q30so17763120wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rGP5GeklV5sYvo4vtTgYCA65Zl+6s2ik7WEi4stFPCE=;
        b=aQKijK28zoGuV84XdC62Cvvh84niNxkPtr5NhXGjEHyRQrunxHYA8+BuunqRjXq6g1
         xENmksC4VVje463bqODvDsthkPaBsiPcAdd8X+ThAPal8WINm1zsKbqdSu7ryff2d3EL
         7cgH5bXvKYAXHSJNSEAnLTUo8qrX4tMz6umKkAnY5gJJRm7o+IvC6MnW3mvhLMnXZP26
         JBHOE/DFOI4IZWYgriP5aCMWWdIfKLWvCD+eLa8La1tPv4g2LCZY4xkM0qgZiVR1dP5t
         YTzjZxNjm6Ih/h/Xe2NYbS8G9ZiFnrC1N3jKFstwbOUsNLUobE7LFU1ITRqzGyUrti7L
         vvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rGP5GeklV5sYvo4vtTgYCA65Zl+6s2ik7WEi4stFPCE=;
        b=VDAG937hImUrPzQ83SE23r7ZOfILMT4Dfnv2xMPkDZGMb3PImO9B2XBgKN6qQlx97U
         3GvNMvb8Pin4+FQ9KXr6hTTAtfxLT3Q1d1MeejX8Qbww0tS9Y1SZdIuxuQwZiC84TllM
         svw7jjL/z0C2R86HAYrq6QS4vGfprlEthjmW2trvL/xfM6BNMtbUwk52rAg9GRIB0O7P
         ch5ivemLo+3vouY6/GA3ym9K3AeJEAiFAIoLvVNPEQfR2ay3M19zudb+61zF3qLt4UkV
         WtmyincvZBQ4XFPZyPPncqUqieXYtsANRYTvzzMOeVVvg2YhZlbxv8MGX+4lK3l3ObYe
         J/2w==
X-Gm-Message-State: ACgBeo0VuHIPGFRTFfXKbQcY7iSZvtGG9v6zbLLbSsmAebZ9jrtPIz1R
        yY1AJBg2oy9I2C4BPfDRru5WYA==
X-Google-Smtp-Source: AA6agR7hqSLgdUcHVnV1a1G0PITSckyf7Kh30N3n6ZluCQ/1E0gsyeH1nQ2QNX+thQ2W5THNKIYLfw==
X-Received: by 2002:a5d:47c1:0:b0:221:7670:687d with SMTP id o1-20020a5d47c1000000b002217670687dmr14268120wrc.496.1660138861673;
        Wed, 10 Aug 2022 06:41:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a3-20020adfe5c3000000b0021edb2d07bbsm15809382wrn.33.2022.08.10.06.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:41:00 -0700 (PDT)
Message-ID: <200c59ca-dcfc-9ad8-aa1e-977708398c3b@linaro.org>
Date:   Wed, 10 Aug 2022 15:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/core: Add missing EXPORT_SYMBOL_GPL
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220810100731.749317-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iv4oMsZyUg7-YY6cD2jsYyLdi7sDeE0GEm814kCEAvmQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iv4oMsZyUg7-YY6cD2jsYyLdi7sDeE0GEm814kCEAvmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 13:58, Rafael J. Wysocki wrote:
> On Wed, Aug 10, 2022 at 12:07 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The function thermal_zone_device_register_with_trips() is not exported
>> for modules.
>>
>> Add the missing EXPORT_SYMBOL_GPL().
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> A Fixes tag missing?

He he :) Indeed ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
