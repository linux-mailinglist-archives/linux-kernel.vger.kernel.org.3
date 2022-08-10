Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64458F191
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiHJR3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHJR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:29:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACD7C761;
        Wed, 10 Aug 2022 10:29:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 130so14274295pfv.13;
        Wed, 10 Aug 2022 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=34705Dk7z1CDpglKH7KFE9HELCHPVR8p7W65TbqfbNQ=;
        b=MmW0k9gSgYUjhhkdgJ7h0IqLb2+sZ82lpyr7sCjju0IZEjCwSHArNeJ9dj4Fdp/2SA
         aagCHn3QdHTJOWJwBW2YHCQUcm3rH3D3PkWpsusWxlZRoNo7+MAkfD22KAaxJV2JsD4x
         YIjLCNRyB51+Sduu08kzsiFwLSOvxdHaeqetAN0hs2yX1MC5/8hgIXaVPFgPQhMM0M+N
         4mfyktrFqn2caj4M9rJH58ZuKdETdM4hys5j/13VVww9g58SyUHevPbJ3oyUDungYaqc
         QIb1v7+c4GT31xIPG7XrGC0eDMxUKZ/SAP/eBUcZrrV6YlAjOXwATSrk2ndlaVU2UVTZ
         nLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=34705Dk7z1CDpglKH7KFE9HELCHPVR8p7W65TbqfbNQ=;
        b=5j1+MgotFvAPIWuqP/3a87m8gH5TmEVOeUkPMGidh7YPlApsr+CYgWhE2NvyTSvk1J
         DUIJdIEWH42iPvz7QcicY8mPWV0Ns9siqyPu32wIi+QtNOMkWupVYkt9IpaKvjQwxYoZ
         A4z+9QSzUJr0oboxcPLMwuY5gNGxjFUz+X3YxUqsVqdF8stpHWWNMkl9zeYk8nziiahg
         jtZ24hL0RiKzO7zt+YIO8kEmyCFBxX2s3/lx+w5snKVp6/yj1K0wgEL0TDO7xbKntKCW
         uM7jg4Aw4gB5O5fhoz6WejRgoPrhJFcThsAZLOor5wGQfvB4n+c46ZRUsho36WMTtnhw
         UFZQ==
X-Gm-Message-State: ACgBeo1GaJE07ecn8xxRhB4DyE/rbQ6Ir4W00ORNvcTJO8zLNfwARJQQ
        YsA+7qT1tTfJNo0VvdDns1PH5eNF4uE=
X-Google-Smtp-Source: AA6agR7E9E7qbRSyFAPJdj+HuPR/K3uGYi5oXuSr6oMa4HAVlrTQUuTQF8uQd18nzgxlRGu75aGZHA==
X-Received: by 2002:a63:191f:0:b0:41c:e4a0:1e1d with SMTP id z31-20020a63191f000000b0041ce4a01e1dmr23751168pgl.618.1660152550476;
        Wed, 10 Aug 2022 10:29:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090ab28d00b001f04479017fsm1950539pjr.29.2022.08.10.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 10:29:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
Date:   Wed, 10 Aug 2022 10:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
 <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
 <20220810185658.6e27d9bd@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
In-Reply-To: <20220810185658.6e27d9bd@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 09:56, Wilken Gottwalt wrote:
> On Wed, 10 Aug 2022 09:31:21 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 8/10/22 06:53, Wilken Gottwalt wrote:
>>> Add reporting if the PSU is running in single or multi rail mode via
>>> ocpmode debugfs entry. Also update the documentation accordingly.
>>>
>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>> ---
>>> Changes in v2:
>>>     - fixed spelling issues in commit message
>>
>> You did not address or even provide feedback on my second comment.
> 
> Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
> answer the earlier mail and think about it.
> 
> Though, maybe you can help me with that what keeps me so busy. Would it be okay
> to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
> with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
> used to set a sample/update rate in a sensor (-register), but this USB-HID
> approach is a pure polling thing. It seems to work quite and enables the driver
> to collect data quite early in the boot process.
> 

It really depends. Is it _necessary_ ? The pwm-fan driver uses a timer for
periodic polling, but that is because it has to. We should not do it purely
for convenience, and from the code I don't immediately see why it would
be necessary.

Guenter
