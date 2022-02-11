Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689BB4B2040
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbiBKIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:37:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiBKIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:37:40 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 00:37:38 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15EE59;
        Fri, 11 Feb 2022 00:37:38 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nIRQv-001oqN-BL; Fri, 11 Feb 2022 09:37:37 +0100
Received: from p5b13a545.dip0.t-ipconnect.de ([91.19.165.69] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nIRQv-000jOQ-3s; Fri, 11 Feb 2022 09:37:37 +0100
Message-ID: <4592b3f4-5213-72e7-e135-7e43c04fedc7@physik.fu-berlin.de>
Date:   Fri, 11 Feb 2022 09:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220130143333.552646-1-laurent@vivier.eu>
 <20220130143333.552646-5-laurent@vivier.eu>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20220130143333.552646-5-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.165.69
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 1/30/22 15:33, Laurent Vivier wrote:
> Add a clocksource based on the goldfish-rtc device.
> 
> Move the timer register definition to <clocksource/timer-goldfish.h>
> 
> This kernel implementation is based on the QEMU upstream implementation:
> 
>    https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
> 
> Details related to Goldfish devices can be found in:
> 
>   https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

It looks like this is the only patch in the series which has not been approved yet.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

