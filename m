Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951464C58CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiB0A2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiB0A2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:28:34 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F967DAB8;
        Sat, 26 Feb 2022 16:27:59 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 03CF4586;
        Sat, 26 Feb 2022 16:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645921679;
        bh=5WFoesqJ/+akiaoM7kBR726dsvyDNXMcep+15oG4IPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bV2tJCFMwdzMP+o8AP09JuDaQEdndvdhEuiTp6pV/e+vgHr+IwbDVVNtnJiCt4roy
         7l15H16sLOT87luHy9uqViMh3cNNqa6Gspc6Y9pe44/UdV8hfIMMRkBPr/xt4mi5jW
         I7N6P14s0QlrK75rsM0BOhl7DGciDIfH3qkwicsA=
Date:   Sat, 26 Feb 2022 16:27:55 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: (nct6775) Add i2c support
Message-ID: <YhrFizhgOpZbi3dE@hatter.bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
 <2620147.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2620147.mvXUDI8C0e@natalenko.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 04:14:12PM PST, Oleksandr Natalenko wrote:
>Hello.
>
>On sobota 26. �nora 2022 14:30:42 CET Zev Weiss wrote:
>> Hello,
>>
>> This patch series augments the existing nct6775 driver with support
>> for the hardware's i2c interface.
>
>Is it something I can test on my ASUS Pro WS X570-ACE board as an ordinary user, and if so, how?
>

You could certainly test that the nct6775-platform driver still works as 
it did previously, which would be good to confirm -- you'll need to 
enable CONFIG_SENSORS_NCT6775_PLATFORM now to build it.

 From what I've been able to find about that board though it looks like 
it doesn't have a BMC, so testing the i2c driver on it probably isn't 
going to be possible.  (Even if it does in fact have a BMC, it would 
require at least a partial port of OpenBMC or similar, and re-flashing 
your BMC firmware with that, and is hence a non-trivial undertaking.)


Zev

