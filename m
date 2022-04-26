Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3450F54D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbiDZIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbiDZIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:38:31 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B71939C5;
        Tue, 26 Apr 2022 01:29:34 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 493324F;
        Tue, 26 Apr 2022 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1650961774;
        bh=SNEEfzyg9e7zSf3s0KHAajmviT5U9WD7JJYzw4V8nPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqRxQbsxJ8p4HT+cwT8K4Q7b5LlTTE6n0e/rtUTR9HdGsjyJV9OqppeQirLCrnoI3
         tgf8oUElUjUiyi8cP1ZmdF+J4lgpnso36G+aEM1cjtiy982UhhyjTQnR8oHyI6JjiM
         NvtgdkQtaIUQ2H6ztI3hAfNqZ8o+sc7aj4eaCAZk=
Date:   Tue, 26 Apr 2022 01:29:22 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, webmaster@kernel.org
Subject: Re: [PATCH v3 0/6] hwmon: (nct6775) Convert to regmap, add i2c
 support
Message-ID: <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
References: <20220426071848.11619-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220426071848.11619-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding korg webmaster re: list infrastructure]

On Tue, Apr 26, 2022 at 12:18:42AM PDT, Zev Weiss wrote:
>Hello,
>
>This is v3 of my effort to add i2c support to the nct6775 hwmon
>driver.
>
>Changes since v2 [0]:
> ...
> - Renamed drivers and Kconfig symbols to keep existing platform
>   driver as "nct6775" (SENSORS_NCT6775) and the core module as
>   "nct6775-core" (SENSORS_NCT6775_CORE) [Guenter]

Unfortunately while this was a simple enough change to make (a few 'git 
mv' commands and a handful of actual text changes), it ballooned the 
size of the diff for patch 5 to the point that vger bounced it for 
exceeding the 100K message-size limit.  As far as I can tell it looks 
like it went through elsewhere, but does leave a bit of a gap in the 
public list archives -- please let me know if there's anything I should 
try in terms of re-sending it.  (The only combination of 'git 
format-patch' flags I've been able to find that gets it back down to 
approximately its previous size is '-B -D', which isn't so useful for 
actually applying.)

I'm not sure how critical a limit that 100K is, or if it's something we 
might consider raising a bit?


Thanks,
Zev

