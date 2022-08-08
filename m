Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED558C79B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiHHLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbiHHLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:36:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE064E9;
        Mon,  8 Aug 2022 04:36:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k14so5823669pfh.0;
        Mon, 08 Aug 2022 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=erKTfVF3Cl59nU6n/dHOnidiI7U0M5LXZbUHkQc61+g=;
        b=BXHaXG6FNrVDOjCK0waYK/pc2lkH9GQMOsorfkEAltuRFICUZZAmN145Rjn/UNUkuw
         P2ocQUaYYaXJ7unDPfVaiAd98yrv7jqyNt2oORiR4zKvE98k4XApf031K+kKdgKk5Y2A
         Pe2goqGncc4LLERw/vS0/yCW8h0h9LhRkBqirR8vcWpExaB96NuGwYqDX9uLJ596Gay+
         kxrYvqxao7TAqhi4Ts8f/c1un4AbOe6terro054PCZTD6Wl5vOsHF+VUJ/VkyVl7/mI/
         B+3C8f8hJWddTcgbOZhecgL8G9odlAvShXHkh7EdI0gDDScvMWiLQ/FJ/XDDpRTsIC0O
         +4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=erKTfVF3Cl59nU6n/dHOnidiI7U0M5LXZbUHkQc61+g=;
        b=ROqS8+twt+Xy289FrD1dL1aLEy1/5CZ62cA09YpbpeLSYSNgSX+qb8UlM5Ja2G8Lel
         8OeTso9Y+aMX+JnjK/t6+QZuVDrWjqlse1gL4MHYCPqBOpBMihDFDE26UMFl2n9gwocp
         pmZN1TESdtWsj3BFx3Xs8yA3//XzMR2g75Tz/eY8p78BFqbdHKo/YYlPYJ+K1S85zwPa
         0tyi0ZWjrxwa5SWZZv1VuxwO1l3ixlpELnk7X+99VfKLe+wMdGBgTED2mOmJLfxf8Ob3
         EXiFZNqr502VsTszI/MYBLLQv1b6mBDrd6RUvu4VuD6/bIijOiVU9Q42bx5S1MBYWCae
         vt8A==
X-Gm-Message-State: ACgBeo3pLUBktQ079LCGz/aZlLrbx4Ji0JequAyB+YdgDnPCE0XQpbpa
        6JvTbjKBG7TlyPC4wNwSkDU=
X-Google-Smtp-Source: AA6agR4HtKbJ7eVsimEo3PkdAl37E3Cu1cGUZdUD1UTLtFrJDzw6dFZx3w2FuvME0TnZw7qpL3mpzQ==
X-Received: by 2002:a05:6a00:1d26:b0:52b:fb6f:e44d with SMTP id a38-20020a056a001d2600b0052bfb6fe44dmr18157022pfx.6.1659958606510;
        Mon, 08 Aug 2022 04:36:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0016a6caacaefsm8573966plg.103.2022.08.08.04.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:36:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5a1c9872-52b5-1f96-6931-801185b03fd4@roeck-us.net>
Date:   Mon, 8 Aug 2022 04:36:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20220806000706.3eeafc9c@endymion.delvare>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: wdat_wdt: Set the min and max timeout values
 properly
In-Reply-To: <20220806000706.3eeafc9c@endymion.delvare>
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

On 8/5/22 15:07, Jean Delvare wrote:
> The wdat_wdt driver is misusing the min_hw_heartbeat_ms field. This
> field should only be used when the hardware watchdog device should not
> be pinged more frequently than a specific period. The ACPI WDAT
> "Minimum Count" field, on the other hand, specifies the minimum
> timeout value that can be set. This corresponds to the min_timeout
> field in Linux's watchdog infrastructure.
> 
> Setting min_hw_heartbeat_ms instead can cause pings to the hardware
> to be delayed when there is no reason for that, eventually leading to
> unexpected firing of the watchdog timer (and thus unexpected reboot).
> 
> I'm also changing max_hw_heartbeat_ms to max_timeout for symmetry,
> although the use of this one isn't fundamentally wrong, but there is
> also no reason to enable the software-driven ping mechanism for the
> wdat_wdt driver.
> 

Normally I would reject this because it is not only unnecessary and
unrelated to the problem at hand (remember: one logical change per patch),
but it is hidden in an unrelated patch, it will only make life harder
later on if/when full milli-second timeouts are introduced, and it may
result in unexpected limitations on the maximum timeout. However, Mike
accepted it, so who am I to complain.

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc! Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Untested, as I have no supported hardware at hand.
> 
> Note to the watchdog subsystem maintainers: I must say I find the
> whole thing pretty confusing.
> 
> First of all, the name symmetry between min_hw_heartbeat_ms and
> max_hw_heartbeat_ms, while these properties are completely unrelated,
> is heavily misleading. max_hw_heartbeat_ms is really max_hw_timeout
> and should be renamed to that IMHO, if we keep it at all.
> 

Variable names are hardly ever perfect. I resist renaming variables
to avoid rename wars. Feel free to submit patches to improve the
documentation if you like.

> Secondly, the coexistence of max_timeout and max_hw_heartbeat_ms is
> also making the code pretty hard to understand and get right.
> Historically, max_timeout was already supposed to be the maximum
> hardware timeout value. I don't understand why a new field with that
> meaning was introduced, subsequently changing the original meaning of
> max_timeout to become a software-only limit... but only if
> max_hw_heartbeat_ms is set.
> 

Code is hardly ever perfect. Feel free to submit patches to help
improve understanding if you like.

> To be honest, I'm not sold to the idea of a software-emulated
> maximum timeout value above what the hardware can do, but if doing
> that makes sense in certain situations, then I believe it should be
> implemented as a boolean flag (named emulate_large_timeout, for
> example) to complement max_timeout instead of a separate time value.
> Is there a reason I'm missing, why it was not done that way?
> 
There are watchdogs with very low maximum timeout values, sometimes less than
3 seconds. gpio-wdt is one example - some have a maximum value of 2.5 seconds.
rzn1_wd is even more extreme with a maximum of 1 second. With such low values,
accuracy is important, second-based limits are insufficient, and there is an
actual need for software timeout handling on top of hardware.

At the same time, there is actually a need to make timeouts milli-second based
instead of second-based, for uses such as medical devices where timeouts need
to be short and accurate. The only reason for not implementing this is that
the proposals I have seen so far (including mine) were too messy for my liking,
and I never had the time to clean it up. Reverting milli-second support would
be the completely wrong direction.

> Currently, a comment in watchdog.h claims that max_timeout is ignored
> when max_hw_heartbeat_ms is set. However in watchdog_dev.c, sysfs
> attribute max_timeout is created unconditionally, and
> max_hw_heartbeat_ms doesn't have a sysfs attribute. So userspace has
> no way to know if max_timeout is the hardware limit, or whether
> software emulation will kick in for a specified timeout value. Also,
> there is no complaint if both max_hw_heartbeat_ms and max_timeout
> are set.
> 
As mentioned before, code is hardly ever perfect. Patches to improve the
situation are welcome.

Thanks,
Guenter
