Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510052BEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiERQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiERQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:05:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B41DAF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652889949; x=1684425949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3euCKGvKwyKLln5ErCYPgdSqPR/sbrIxcH0pwTWC3p0=;
  b=b26ECYVzZGowkJTmGkDTx9/1okihywbYndHkcJzVuujajY9w30Q59WCI
   PPBYC/TMq9yDCZ3QzGGVc5hbhneQczSGng2MXmKEGIPs7ZIXXuqdy82nt
   1mGy3vn55ZwS7tBJOWcpe+a9/ctRpOXY5xI8p9vTz7omg1dLcV8yiOLqb
   HxArExY3rs9qSHbAoH5riGLJxQDj6gvcOaMxWRcfP6Du2T7VFsTHMI6xc
   TNaDvDUn4xUDllrcV3R5+u4eS54N1JGpLiNstZrX42YwdATzrjFvwhAPd
   5Q2je6TZQBUgXh3MVdtJskWAsRxBkPpP0j+WG2iB8FIegWfiw/4j/IpIr
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="96333410"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2022 09:00:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 18 May 2022 09:00:53 -0700
Received: from [10.12.73.39] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 18 May 2022 09:00:51 -0700
Message-ID: <b97221e1-dd43-e2e0-5c37-f86162768f00@microchip.com>
Date:   Wed, 18 May 2022 18:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ARM: configs: enable support for Kontron KSwitch D10
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
CC:     Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
References: <20220518141542.531148-1-michael@walle.cc>
 <CAK8P3a01B2uEP7=AkVBG5FYdfMHyReFP=120Ay3+s2EV9kO5Uw@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CAK8P3a01B2uEP7=AkVBG5FYdfMHyReFP=120Ay3+s2EV9kO5Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Michael,

On 18/05/2022 at 16:52, Arnd Bergmann wrote:
> On Wed, May 18, 2022 at 3:15 PM Michael Walle <michael@walle.cc> wrote:
>>
>> The Kontron KSwitch D10 is based on a Microchip LAN9668 SoC. It is a
>> managed ethernet network switch with either 8 copper ports or 6 copper
>> ports and 2 SFP cages.
>>
>> Enable all required kconfig symbols, either as module where possible or
>> compiled-in where it is not possible.
>>
>> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>> ---
>> FWIW, there will be a board in our lab in KernelCI using this config.
> 
> The patch looks ok to me, but normally I'd expect it to go through the
> platform maintainer tree unless there is a reason not to. Adding the at91
> maintainers to Cc here.
> 
> It's also a bit late for 5.19, but if everyone agrees, I can add the patch
> to the arm/late branch.

If it's possible for you Arnd, I do agree that you take it in the 
arm/late branch.

Thanks, best regards,
   Nicolas

-- 
Nicolas Ferre
