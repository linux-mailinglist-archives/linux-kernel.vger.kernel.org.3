Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314984C71A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiB1QZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiB1QZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:25:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20575E7B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646065507; x=1677601507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=et847OQQ3mcoZ5+BEptPvOyvcAVF4lTBNLhOTaaoa3U=;
  b=sQmyt9i0LmrHB6EEb0UrUpZJ43SEBPQFRWDlIhin8CjbJwMgQAXRwr0h
   r29sKDiniYuZ9HZsRq0Cj862YTla6pvXQ9K45fOuuKmEV5Q8+lFMwgZtc
   maMxXhjX+cLdFu6aq2m1HRwiqIXZrztKlwOvqXyHEsPixMCxJyH3yanXw
   KR2htLcZOHZigiEFjHJgia1Kt/D1lHokPi9nr/VouT3MycBHaCIAZUEmJ
   99gtLPcWrMl2XHjSK+KdGpWLARDeAgp4xpeC/E0DgPrYt1j2K/itbJ0aC
   JC7eGf2Bttkfcj206+Re1W/hZzJEU6YiODnV03URJxQR3Bb4Hn8kh2L3t
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="150257703"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 09:25:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 09:25:06 -0700
Received: from [10.12.72.64] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 28 Feb 2022 09:25:05 -0700
Message-ID: <e2a05dbb-8687-6a14-71f9-9dcf2260f5d7@microchip.com>
Date:   Mon, 28 Feb 2022 17:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] soc: microchip: make mpfs_sys_controller_put static
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Conor Dooley <mail@conchuod.ie>
CC:     <conor.dooley@microchip.com>, Olof Johansson <olof@lixom.net>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220226124826.1564871-1-mail@conchuod.ie>
 <CAK8P3a2y2j=zSsPtAFDZxv9b_e2SG6V5DBy__voiHRnDw5n4Aw@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CAK8P3a2y2j=zSsPtAFDZxv9b_e2SG6V5DBy__voiHRnDw5n4Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 at 16:42, Arnd Bergmann wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Sat, Feb 26, 2022 at 1:48 PM Conor Dooley <mail@conchuod.ie> wrote:
>>
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> dsafsdfd0054 ("soc: add microchip polarfire soc system controller")
>> incorrectly exported mpfs_sys_controller_put. Remove the export and make
>> the function static instead. This fixes the "no previous prototype
>> for 'mpfs_sys_controller_put'" warning spotted by the kernel test robot.
>>
>> Fixes: dsafsdfd0054 ("soc: add microchip polarfire soc system
>> controller")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Conor Dooley <mail@conchuod.ie>
> 
> For reference, I saw the same report and added a different fix for  this
> at first, but replaced it with this patch now. No need to add it to the at91
> tree. Nicolas, in case there is another problem with this patch, let me know.

Ok Arnd, thanks.

For the record:
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>


-- 
Nicolas Ferre
