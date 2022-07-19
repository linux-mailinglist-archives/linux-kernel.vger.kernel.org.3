Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37757A08F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiGSOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiGSOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:07:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1040BEB;
        Tue, 19 Jul 2022 06:24:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ABEBF221D4;
        Tue, 19 Jul 2022 15:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658237062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPdCgEGkqmYALIjHObF/Xf5AEs+Yv9Mg7nPMxUm1HHU=;
        b=glHLUsQdKpTWdbmbib0nIJbrxjsBriOkiV2hMyLVMOW2VV1NQ2btYDx7cnfZpTvpTs4cEW
        Q4QUXIFlwVhTDqd66FyHqgrbFVA3kp/vKAFt/zzyVK2yHnviXK+qM8VCe7RgLsnJ/CPa+u
        8nEhMsPYs9aDFzLlXIcX/Vm8oGmKoPU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jul 2022 15:24:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
In-Reply-To: <07af76d1-3aa8-3067-f92d-120ad385b698@microchip.com>
References: <20220707132500.1708020-1-michael@walle.cc>
 <7ee463db-3cb5-c340-ac1d-1dfcd2b87dcd@microchip.com>
 <07af76d1-3aa8-3067-f92d-120ad385b698@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9a3a5d9633cd8397f98cf2c4056e9864@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Am 2022-07-12 09:22, schrieb Claudiu.Beznea@microchip.com:
> On 11.07.2022 10:15, Claudiu Beznea - M18063 wrote:
>> On 07.07.2022 16:24, Michael Walle wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>> know the content is safe
>>> 
>>> The clock controller supports an optional clock gating register. This 
>>> is
>>> necessary to expose the USB device clock, for example. Add it.
>>> 
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>> 
>> Applied to at91-dt, thanks!
> 
> Actually, I will postpone this until [1] is accepted as current driver 
> may
> fail if this patch is applied.

Which was picked today :)

-michael
