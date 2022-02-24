Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183254C2F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiBXPZs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Feb 2022 10:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiBXPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:44 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7322A284;
        Thu, 24 Feb 2022 07:25:13 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:25:01 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] pwm: jz4740: Add support for X1000 SoC
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <PTET7R.D6X3F4XL0K3E1@crapouillou.net>
In-Reply-To: <YheK4+t9w5IeHiDT@orome>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
        <20220209231141.20184-2-aidanmacdonald.0x0@gmail.com>
        <2SMA7R.9OBQWV0ONR102@crapouillou.net> <YheK4+t9w5IeHiDT@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., févr. 24 2022 at 14:40:51 +0100, Thierry Reding 
<thierry.reding@gmail.com> a écrit :
> On Mon, Feb 14, 2022 at 12:02:26PM +0000, Paul Cercueil wrote:
>>  Hi Aidan,
>> 
>>  Le mer., févr. 9 2022 at 23:11:42 +0000, Aidan MacDonald
>>  <aidanmacdonald.0x0@gmail.com> a écrit :
>>  > The X1000 has the same TCU / PWM hardware as other Ingenic SoCs,
>>  > but it has only 5 channels.
>>  >
>>  > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>  > ---
>>  >  arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>>  >  drivers/pwm/pwm-jz4740.c              |  5 +++++
>> 
>>  Please put the driver and device tree changes into separate patches.
> 
> Seemed a shame not to take this, so I've manually removed the DTS
> changes and applied this to the PWM tree.
> 
> Aidan, probably best to resend the DTS snippet as a separate patch,
> unless Paul also wants to apply this manually.

I am not the arch/mips/ maintainer, so a separate patch would be needed 
anyway, yes.

Cheers,
-Paul


