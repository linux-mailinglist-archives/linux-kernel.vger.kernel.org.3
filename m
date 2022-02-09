Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD94AEED4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiBIKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBIKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:01:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DBE022AFC;
        Wed,  9 Feb 2022 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644400900; x=1675936900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MhAPRdsDHJ8uaTiaXrdti0+yuDAFi7HzI4SCxA0SdwE=;
  b=kDRvREpgXdAEbnewnAhcIryVqOlyrDOTT6EmjfwQQpZs2nzGK27FfDkj
   s6nxLXf/Mk/OETA8z4FTsT1/Sd+8IbRhB+nfghKczHUdutOxdZziaRRS9
   1a1kzSmfBnuq1JfXEWdY0cwryuYd29KTgPC4HuUevihF27hOt8TeMvrvs
   mMFvhAMcO0ql7IZ++AOOchIsmGn3dW5dBgVEQSz9kGZL6UkO0f/V7CvS0
   IsEEwIqYd6OUaDMPUBaVttCMn3OaNZgubb5rvTka6uHw5d6H6lZOZ1hUa
   iTZ+eZAZAEN2ykskKZ+fBbRCCoraCQFk4UaaHIoOD+8siGfBcEpztxNUf
   A==;
IronPort-SDR: DAFonjqizeKbuF+rjvTc3HLhKHGwG5r1ik+WiwDX6aW3TOztVim+344xEWbXB1UWjb7vP2l1bf
 vst6jHQ9NJuSSPe73oZvyclrZHdAJ/jGDBTsatHSqS7ptmHzblFalSgxoBdSNLQTRCsMV6fVPs
 4y06RfNUlXogXdl1OpIFf/PWfrELUNC+inD6KaS7NumTjAJFbOzUgNt0sqD8/1af1AlpeTevcC
 LPE0EPAza8+5NM3HXoGwz2JtJN5f7F/rTFZ84hfWMQi1Wh7a4GYNt79r2EZEnjeLJCYMfCmly5
 lnZO3lV8B+AKD6niql2Defy7
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152967185"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 02:56:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 02:56:25 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Feb 2022 02:56:23 -0700
Message-ID: <ee9826d1-216e-45b0-e48b-700ec41b3683@microchip.com>
Date:   Wed, 9 Feb 2022 10:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
References: <20220113080017.30155-1-kavyasree.kotagiri@microchip.com>
 <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com>
 <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 at 17:08, Arnd Bergmann wrote:
> On Thu, Jan 13, 2022 at 9:33 AM Nicolas Ferre
> <nicolas.ferre@microchip.com>  wrote:
>> On 13/01/2022 at 09:00, Kavyasree Kotagiri wrote:
>>> This patch adds basic DT for Microchip lan966x SoC and associated board
>>> pcb8291(2-port EVB). Adds peripherals required to allow booting: IRQs,
>>> clocks, timers, memory, flexcoms, GPIOs. Also adds other peripherals like
>>> crypto(AES,SHA), DMA and watchdog.
>>>
>>> Signed-off-by: Kavyasree Kotagiri<kavyasree.kotagiri@microchip.com>
>> Looks good to me:
>> Reviewed-by: Nicolas Ferre<nicolas.ferre@microchip.com>
> I'm not quite sure what to do with this, as this was sentto:soc@kernel.org,
> which is normally for patches that are already reviewed and should just
> get applied.
> 
> I can apply this, but I would normally expect board files to get picked up
> in the at91 tree first. I'll drop this version from patchwork for now, as I
> also have a couple of comments:

I have the intention to take this patch when it's ready in the at91 tree.

Thanks for your feedback Arnd. Best regards,
   Nicolas

-- 
Nicolas Ferre
