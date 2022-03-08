Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956464D1249
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiCHIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiCHIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:32:59 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0D3F89E;
        Tue,  8 Mar 2022 00:32:02 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 63ED422236;
        Tue,  8 Mar 2022 09:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646728319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfR7qXhkac8MSMxxEBCzNKSqcYpP/Fvc4ZBkig2QdMY=;
        b=XbZPeUjeqMbsMTn+pgnhV1fh+dPTvBgBu+XJez+SynmGrdQ6DJSdoUQHzh1lxpGWMvrxSw
        6VpHQIhMqWcMFhXiNntw/3roMadgW4RUwbjWfxOGd0kQqDeYXclRPLDTKFMm9Y5rlPrh7W
        JAvgk7mO1860qg25FWheWoPIZooft5Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Mar 2022 09:31:58 +0100
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     andriy.shevchenko@linux.intel.com, colin.foster@in-advantage.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix the pincfg resource.
In-Reply-To: <20220308083023.frr7qz2xga2tas5r@soft-dev3-1.localhost>
References: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
 <20220307124501.3487932-1-michael@walle.cc>
 <20220308083023.frr7qz2xga2tas5r@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <691cc39a667d6284fa25bc47f6855152@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-08 09:30, schrieb Horatiu Vultur:
> The 03/07/2022 13:45, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> > The pincfg resources are in the second memory resource. But the driver
>> > still tries to access the first memory resource to get the pincfg. This
>> > is wrong therefore fix to access the second memory resource.
>> >
>> > Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
>> > Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")
>> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>> 
>> There is already this patch pending, which does exactly
>> the same:
>> https://lore.kernel.org/linux-gpio/20220216082020.981797-1-michael@walle.cc/
> 
> Sorry, I have missed your patch.
> Should I resend this series where I will drop this patch? What is the
> correct approach?

Actually, I don't know. Maybe you don't need to do anything, Linus?

-michael
