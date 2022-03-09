Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF84D2A61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiCIINi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiCIINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:13:36 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EAD457AC;
        Wed,  9 Mar 2022 00:12:35 -0800 (PST)
Received: from [192.168.0.3] (ip5f5aef7a.dynamic.kabel-deutschland.de [95.90.239.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4B77E61E64846;
        Wed,  9 Mar 2022 09:12:33 +0100 (CET)
Message-ID: <05667284-42f7-0df2-8fa0-463ad6ad9601@molgen.mpg.de>
Date:   Wed, 9 Mar 2022 09:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 0/6] hwmon: (nct6775) Convert to regmap, add i2c
 support
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rob Herring <robh+dt@kernel.org>,
        Renze Nicolai <renze@rnplus.nl>
References: <20220309005047.5107-1-zev@bewilderbeest.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220309005047.5107-1-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Zev,


Am 09.03.22 um 01:50 schrieb Zev Weiss:

> This is v2 of my patches to add i2c support to the nct6775 driver.
> 
> Changes since v1 [0]:
>   - Added preparatory patch converting driver to regmap API [Guenter]
>   - Replaced ENOSPC with ENOBUFS and removed WARN_ON() in
>     nct6775_add_attr_group() [Guenter]
>   - Added dedicated symbol namespace [Guenter]
>   - Removed nct6775_write_temp() and nct6775_update_device() symbol
>     exports [Guenter]
>   - Reordered patches to put dt-bindings patch first [Krzysztof]
> 
> The nct6775-platform and nct6775-i2c drivers have both been tested on
> the NCT6779D in an ASRock ROMED8HM3 system and the NCT6798 [1] in an
> ASRock X570-D4U (the latter thanks to Renze, CCed); both seem to work
> as expected on both systems.  I don't have access to any asuswmi
> hardware, so testing of the nct6775-platform driver on that to ensure
> it doesn't break there would be appreciated (Oleksandr, perhaps?).

I have an ASUS F2A85-M PRO with that Super I/O. (It’s running coreboot 
right now, but I can test with the proprietary vendor firmware, if you 
tell me what and how I can test this.


Kind regards,

Paul


> [0] https://lore.kernel.org/linux-hwmon/20220226133047.6226-1-zev@bewilderbeest.net/
> [1] Though it's physically labeled (mislabeled?) as an NCT6796, for
>      what that's worth.
> 
> A slightly edited version of the previous cover letter follows:

[…]
