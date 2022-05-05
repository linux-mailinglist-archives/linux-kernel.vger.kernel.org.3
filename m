Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0304B51C372
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381092AbiEEPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiEEPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:11:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F638BDA;
        Thu,  5 May 2022 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651763249; x=1683299249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ofOX12TGojhwMN/6KVsscVM33pqSCNg+r9yu6HGPdus=;
  b=cGLpXgNbtVFx4D+CRdVFagqWeSrVVAncL5Ipx/wq/bQEbvxaINDVv3PL
   reOProTAjqEUoy9xpNsVDs09UIyfDcC/M8I5/UtashDpe6uM1F3ORwqtj
   gLeJhiX9taAB15DYOpIrZkZvgFT65T4+fD+Gv6BGp6hjpME1PEu2aTL1w
   D9CsZMOmLNGpsqN/Vq9593xiQQaQfBYWbWe4d0479eDaASSbRQUxFj3E0
   PzQusMaUhCXrnMTx0xCybhc7Hngikd6Fodnt8hKWY61RN1p0+LYJbLJ28
   gb4gLHgkH6bEwF2FEqs85RGCbBQW18Hh6l077fyL7WXGg6JAAo13jHyQG
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="157932577"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 08:07:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 08:07:27 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 08:07:25 -0700
Message-ID: <ce1eeb0f-7211-f865-39d8-c0cc758de947@microchip.com>
Date:   Thu, 5 May 2022 17:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] ARM: configs: at91: sama7_defconfig: add MCHP PDMC
 and DMIC drivers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, <Codrin.Ciubotariu@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-7-codrin.ciubotariu@microchip.com>
 <d84e0e48-cf35-ae1a-e384-067d361457ba@microchip.com>
 <77c2b348-b7a6-458d-21b6-68c54efc317f@microchip.com>
 <YnPmyEujwByeFDdp@sirena.org.uk>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <YnPmyEujwByeFDdp@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2022 at 17:01, Mark Brown wrote:
> On Thu, May 05, 2022 at 02:47:04PM +0000,Codrin.Ciubotariu@microchip.com  wrote:
>> On 05.05.2022 16:58, Nicolas Ferre wrote:
>>> I'm fine with that, but I see that some Kconfig entries "select" this
>>> SND_SOC_DMIC directly (amd, intel, mediatek, stm).
>>> If it's absolutely needed for PDMC to work, what about doing the same as
>>> it would prevent some broken configurations?
>> The only way it makes sense to me to have this driver selected somewhere
>> is in a sound card driver, used for a specific board, which we know it
>> has PDM microphones. Since, for now, we use the simple sound card for
>> our audio interfaces, we have no place to add this select.
>> The reason I do not like to add this select under the controller driver,
>> as some of the vendors did, is because, in the future, we might have
>> different PDM microphones that might not work with SND_SOC_DMIC and
>> might need a different driver.
>> I don't have a strong opinion on this. If you think I am overthinking,
>> please let me know and I will change this.
> It's unlikely but possible that there could be some other device
> connected (eg, you could have a DSP or something that generates PDM
> output).  If the driver doesn't directly instantiate the DMIC itself
> then it's probably reasonable for it to be user controllable if the DMIC
> driver is there.

Fair enough, It makes perfect sense to me as it is then.
Thanks for the feedback!

Best regards,
   Nicolas

-- 
Nicolas Ferre
