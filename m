Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF750EE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbiDZB0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDZB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:26:32 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA650939A5;
        Mon, 25 Apr 2022 18:23:26 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CFE121B3;
        Mon, 25 Apr 2022 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1650936206;
        bh=nMPCdQ5YICk6b3UizKU0CL3dpjIZCdCxutVbgMKfh5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmUQiZcdTo4s2cU2D1R7/36+bmOZLfzMoSJZ/1tcBqAkDIf8/CEjSSRcI7aM0cqUT
         10DbMiRvCdnTFBxQ9LTNvVGsRPIBdA0J03udYTHlRJF6CJuvuvaZsYRr4uaaOon3T8
         Yd6JClM7orwtr30CWvfVpMWlhgJcptNJHQKA6llM=
Date:   Mon, 25 Apr 2022 18:23:21 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <YmdJibUk2cfOamMk@hatter.bewilderbeest.net>
References: <20220309005047.5107-1-zev@bewilderbeest.net>
 <20220309005047.5107-2-zev@bewilderbeest.net>
 <20220425150748.GA4165124@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220425150748.GA4165124@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:07:48AM PDT, Guenter Roeck wrote:
>On Tue, Mar 08, 2022 at 04:50:42PM -0800, Zev Weiss wrote:
>> These Super I/O chips have an i2c interface that some systems expose
>> to a BMC; the BMC's device tree can now describe that via this
>> binding.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
>This is still waiting for DT maintainer approval.
>
>Do you expect to add further properties along the line ?
>If not, you might consider adding the chips to trivial devices instead.
>

Additional properties seem possible, though at the moment I don't know 
exactly what they might be, so trivial-devices.yml probably makes more 
sense.

I'll send a v3 soon with that change and the Kconfig fixes in the other 
patches.


Thanks,
Zev

