Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08844C33EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiBXRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiBXRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:44:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D707279469;
        Thu, 24 Feb 2022 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645724664; x=1677260664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w+eRayVZZcZOJSIf26OxbCM047bckFwiqON3Og5Kb5w=;
  b=l93MDrxZaaQywVFEOtdygINYOb4u3CdEi0uXBNxZkAMFcoRvNCEwSBy1
   /jPEOtk7VllViDjj38BS6cOAprPUkI+fP1FJ8oXIBYpaRUQmS1+G6aNbc
   NmNMvx4gZPOBx2RUNsadlqIzoZQq0LGN0XCTxhEfm1ecXPXTHyHOUES/T
   +yutEER08+oJwwpCv2cRfH96V1otOsRM2gE1WUxvYCvQxK+WDtmZ83Cl8
   jaoZC6DAYM6m0ERbCUpM6wqQPPEWNOjpMmdmOluPr29Cv8/SRhtrZSUWi
   XYtgbeLVOW2qwFoq/0zxKliJCesiw7WPvsTsW+Wg+/Fm0wXPzjZnfs8On
   g==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154300078"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 10:44:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 10:44:22 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 10:44:20 -0700
Message-ID: <3cd1fd6b-d3a4-5ac5-22fa-c854e2f25a65@microchip.com>
Date:   Thu, 24 Feb 2022 18:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Content-Language: en-US
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches - M43218" <Ludovic.Desroches@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220111130556.905978-1-tudor.ambarus@microchip.com>
 <2fa34fae-7736-670a-1d31-7928fbcf95bd@microchip.com>
 <c708f761-aad4-a2f2-9255-01bcb6ad73de@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <c708f761-aad4-a2f2-9255-01bcb6ad73de@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 24/02/2022 at 16:49, Tudor Ambarus - M18064 wrote:
> On 2/24/22 17:04, Nicolas Ferre wrote:
>> On 11/01/2022 at 14:05, Tudor Ambarus wrote:
>>> Add NAND support. The sama7g5's SMC IP is the same as sama5d2's with
>>> a slightly change: it provides a synchronous clock output (SMC clock)
>>> that is dedicated to FPGA usage. Since this doesn't interfere with the SMC
>>> NAND configuration, thus code will not be added in the current nand driver
>>> to address the FPGA usage, use the sama5d2's compatible and choose not to
>>> introduce dedicated compatibles for sama7g5.
>>> Tested with Micron MT29F4G08ABAEAWP NAND flash.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>>> ---
>>> The patch depends on the following patch:
>>> https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u
>>
>> Patch seems taken, so I add this one to at91-dt branch for 5.18 merge window.
>>
> 
> I think it depends on who gets to next first. If at91 gets before clk,
> there will be a build error, isn't it?

Clk patch is already in linux-next, so no worries.
Moreover, I don't get why there could be a build error as there is no 
build dependency between DT changes and C changes.
Sorry but I'm puzzled... Or I'm not looking at the right patch.

Regards,
   Nicolas



-- 
Nicolas Ferre
