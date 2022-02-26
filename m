Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E34C58BB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiBZXzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBZXzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:55:20 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A036B71;
        Sat, 26 Feb 2022 15:54:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id z7so10508486oid.4;
        Sat, 26 Feb 2022 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=r6jKdM0HuBZeq4aVW6gFHo7REbACx5+xaWaSUSwuCIE=;
        b=YjpL3W8Gm2ES8UWk8biaFiX3NviQ9TP/VUQAELd79hKH40MKtJvObjSvqYQ4Gy7SMZ
         3p8nYpgEv/kl+Smrk1rOtOsperbt2/aRsIhLGF6CJsh0OlGywJHPnaq3hDD8clVI03/Z
         7XTrON/VDTjFLBy6pyf/XCkeEmH3TLrOcyCXZKetY13KT+06WP5UJ6xSq1at00bygFGr
         8OgVWDxSSkZXUpxQkS0ct75DXh2g4zZFk6LPNnGd86OOKenjPNnfzehQNQTaomGmdqMq
         2UVWsvA9DqR6KpQ4vxNykWoS4cU7DMuWvWBY1W7x4AwOL8YrKIXYfojZ1ZoGb26Rl5xv
         5Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=r6jKdM0HuBZeq4aVW6gFHo7REbACx5+xaWaSUSwuCIE=;
        b=Cl8kB87+BMsE1vPyzPeurnRuFgN81zv7pAWLgqFfibx02umBvVhRrK3iUlbC4zFMn4
         QMhtIjIvTTr/+ELT0OGrp0dahv2SCSY2qsOyipJ8R6eY9Omn7IunSeM9FAcHHSiIWujX
         eHqAPXTgLWf1hlrcdhALtq4KxZPmdSyNjE47MdZblQTiCy57w0DGGfTvRMhEXMvBuqre
         s0Ld2/+qmB/kX2+WnqWCPk+GsaSL8MmJQLQE7vX5RkEfJui/5Dhppso8NVBJ6vjyaiR2
         TLPaQ0Oq+OFhQZRCBWQ8PKlPFHbZztrv5yiTP8C5FixFOIJSwyE6tdzl3JW2ughqLKLG
         bMzw==
X-Gm-Message-State: AOAM530Uhu9oO2SvuHQINnna9AaiIPrwlC0RhHYxgHXNPfF8kRXjI1ln
        bfsxJlkt9cixXzOyNuVH2jNGGGJP8Hw=
X-Google-Smtp-Source: ABdhPJxW32Wm9Kb2Ve6njs2WxIPAMc+9wvdedlSRWuJ0Z0ejOuL9+8Eb12Hp0VpDjaBHxirAI6yzHg==
X-Received: by 2002:a05:6808:ec3:b0:2d5:47c9:6661 with SMTP id q3-20020a0568080ec300b002d547c96661mr3969280oiv.28.1645919684834;
        Sat, 26 Feb 2022 15:54:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s41-20020a05683043a900b005ad2328c137sm3147167otv.46.2022.02.26.15.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 15:54:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bcb89a9c-62d0-15b8-b46a-d3181db9dbe7@roeck-us.net>
Date:   Sat, 26 Feb 2022 15:54:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220226133047.6226-1-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/5] hwmon: (nct6775) Add i2c support
In-Reply-To: <20220226133047.6226-1-zev@bewilderbeest.net>
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

On 2/26/22 05:30, Zev Weiss wrote:
> Hello,
> 
> This patch series augments the existing nct6775 driver with support
> for the hardware's i2c interface.
> 
> Thus far the nct6775 driver has only supported the LPC interface,
> which is the main interface by which the Super-I/O chip is typically
> connected to the host (x86) processor.
> 
> However, these chips also provide an i2c interface, which can provide
> a way for a BMC to also monitor sensor readings from them.  On some
> systems (such as the ASRock Rack ROMED8HM3 and X570-D4U) this may be
> the only way for the BMC to monitor host CPU temperatures (e.g. to
> indirectly access a TSI interface); this functionality is thus an
> important component of enabling OpenBMC to support such systems.
> 
> In such an arrangement the Super-I/O chip is simultaneously controlled
> by two independent processors (the host and the BMC) which typically
> do not coordinate their accesses with each other.  In order to avoid
> conflicts between the two, the i2c driver avoids all writes to the
> device, since the BMC's needs with the hardware are merely that it be
> able to retrieve sensor readings.  This allows the host processor to
> remain ultimately in control of the chip and unaware of the BMC's use
> of it at all.
> 
> The sole exception to the "no writes" rule for the i2c driver is for
> the bank-select register -- while I haven't been able to find any
> explicit statement in the Nuvoton datasheets guaranteeing this, all
> experiments I've done have indicated that, as one might hope, the i2c
> interface has its own bank-select register independent of the one used
> by the LPC interface.
> 

That will a more detailed confirmation. Please explain in detail
the experiments you have done.

Other chips (specifically those served by the it87 driver) have the
same problem, and there it was never really solved. That resulted
in random crashes. I don't want to end up in the same situation.

> In terms of code structure, the approach taken in this series is to
> split the LPC-specific parts of the driver out into a separate module
> (called nct6775-platform), leaving the interface-independent parts in
> a generic driver (called nct6775-core).  The nct6775-i2c driver is
> then added as an additional consumer of the nct6775-core module's
> functionality.
> 

How about wmi ? Shouldn't that be separated as well ?

Guenter

> The first two patches make some relatively small infrastructural
> changes to the nct6775 driver; the bulk of the core/platform driver
> split is in the third patch.  The final two patches add DT bindings
> and the i2c driver itself.
> 
> I've tested the nct6775-platform and nct6775-i2c drivers with the
> NCT6779D in an ASRock ROMED8HM3 system (the latter driver on its
> AST2500 BMC); both seem to work as expected.  Broader testing would of
> course be welcome though, as is review feedback.
> 
