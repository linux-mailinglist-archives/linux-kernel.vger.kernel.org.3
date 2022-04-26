Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767735105ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiDZRzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353664AbiDZRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:54:00 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D9E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:50:49 -0700 (PDT)
Received: from [172.18.211.123] (unknown [46.183.103.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4756461E6478B;
        Tue, 26 Apr 2022 19:50:45 +0200 (CEST)
Message-ID: <5ee55a29-85de-b84c-abbe-7100aa297a26@molgen.mpg.de>
Date:   Tue, 26 Apr 2022 19:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Jean-Marie Verdun <verdun@hpe.com>, joel@jms.id.au,
        "arnd@arndb.de" <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <44c145a8-cbfd-c8e4-8391-76abb9562f97@molgen.mpg.de>
 <PH0PR84MB171823121FD62E90495BCB7288FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR84MB171823121FD62E90495BCB7288FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Nick,


Am 26.04.22 um 19:28 schrieb Hawkins, Nick:
> 
> 
> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
> Sent: Tuesday, April 26, 2022 3:26 AM
> To: Hawkins, Nick <nick.hawkins@hpe.com>
> Cc: Verdun, Jean-Marie <verdun@hpe.com>; joel@jms.id.au; arnd@arndb.de; openbmc@lists.ozlabs.org; Russell King <linux@armlinux.org.uk>; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP architecture

[OT: Maybe use an email program, that does not add an unnecessary header.]

[…]

>>> The GXP is the HPE BMC SoC that is used in the majority of HPE
>>> Generation 10 servers. Traditionally the asic will last multiple
>>> generations of server before being replaced.
> 
>> Please mention what kind of documentation (datasheets, …) are available.
> 
> Currently there are none available. The only reference I can provide
> will be arm documentation.

Too bad.

>>> In gxp.c we reset the EHCI controller early to boot the asic.
> 
>> Why does the EHCI controller need to be reset?
> This functionality was moved into the boot loader. This message is
> stale and needs to be removed. It was necessary for the chip to
> boot.

Understood. Please mention somewhere, what bootloader is used.

>>> Info about SoC:
>>>
>>> HPE GXP is the name of the HPE Soc. This SoC is used to implement many
>>> BMC features at HPE. It supports ARMv7 architecture based on the
>>> Cortex A9 core. It is capable of using an AXI bus to which a memory
>>> controller is attached. It has multiple SPI interfaces to connect boot
>>> flash and BIOS flash. It uses a 10/100/1000 MAC for network
>>> connectivity. It has multiple i2c engines to drive connectivity with a
>>> host infrastructure. The initial patches enable the watchdog and timer
>>> enabling the host to be able to boot.
> 
>> Maybe doe that in separate commits?
> Are you asking for me to have this paragraph in the other commits?
> Or perhaps not mention the other patches in this paragraph?

Yes, please move:

> The initial patches enable the watchdog and timer enabling the host
> to be able to boot.

in a cover letter for example.

>> Please reflow the commit message for 75 characters per line.
> I will verify all the lines are under 75 characters.

Please make sure the lines are as long as possible, while being at most 
75 characters long.


Kind regards,

Paul
