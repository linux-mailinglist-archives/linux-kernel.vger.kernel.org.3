Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BE46FC82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhLJIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLJIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:20:24 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FBEC061746;
        Fri, 10 Dec 2021 00:16:49 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7C46446D;
        Fri, 10 Dec 2021 00:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1639124208;
        bh=aCwwobdpEi3sNsLc8ASXHTj3fg8LMPfWjPCABMYSkuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBbfNOrHQPA7wsLz8VKiLNZN1oBPFlpmETyg8N5SuOiNy+d7ndEkU6jC1z8IfvjqK
         Lhpmjft4Flh//zcn+KuiXCC9b2rVNoOuwtverSUIo3J+2NRMhv7AxDFTMEjhOE/Fxl
         CsQiVmc4LfgJfeRpFV9SyvbdRwCEFQzznK/7TVEs=
Date:   Fri, 10 Dec 2021 00:16:43 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) add support for TSI temperature
 registers
Message-ID: <YbMM63VKYBTmZYiX@hatter.bewilderbeest.net>
References: <20211110231440.17309-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211110231440.17309-1-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 03:14:39PM PST, Zev Weiss wrote:
>These registers report CPU temperatures (and, depending on the system,
>sometimes chipset temperatures) via the TSI interface on AMD systems.
>They're distinct from most of the other Super-IO temperature readings
>(CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
>monitoring and are in a different (higher resolution) format, but can
>still provide useful temperature data.
>
>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>Tested-by: Renze Nicolai <renze@rnplus.nl>
>---
>
>This patch has been tested on NCT6779 and NCT6798[1] hardware on
>(respectively) ASRock Rack ROMED8HM3 and X570D4U boards, and seems to
>work as expected; the implementation for the other chips supported by
>the driver is purely based on the datasheets and has not been tested
>(for lack of available hardware).
>
>[1] Or at least, its chip ID registers identify it as an NCT6798 and
>it seems to behave consistently with that, though it's actually
>physically labeled as an NCT6796.
>
> drivers/hwmon/nct6775.c | 136 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 130 insertions(+), 6 deletions(-)
>

Ping...any thoughts/feedback on this patch?


Thanks,
Zev

