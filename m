Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722884B2043
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiBKIjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:39:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiBKIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:39:03 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150091BF;
        Fri, 11 Feb 2022 00:39:02 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nIRPn-001o0H-O4; Fri, 11 Feb 2022 09:36:27 +0100
Received: from p5b13a545.dip0.t-ipconnect.de ([91.19.165.69] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nIRPn-000j9h-Gk; Fri, 11 Feb 2022 09:36:27 +0100
Message-ID: <0b488b58-3d13-e987-37c7-16bac7a313e0@physik.fu-berlin.de>
Date:   Fri, 11 Feb 2022 09:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v13 1/5] m68k: add asm/config.h
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
References: <20220129184225.407100-1-laurent@vivier.eu>
 <20220129184225.407100-2-laurent@vivier.eu>
 <CAMuHMdVmCV4v=LhGRB3d3hbyL4Etv_Wbb2VPhK5G9a2xB1Pm2A@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAMuHMdVmCV4v=LhGRB3d3hbyL4Etv_Wbb2VPhK5G9a2xB1Pm2A@mail.gmail.com>
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

Hi Geert!

On 1/29/22 20:05, Geert Uytterhoeven wrote:
> Hi Laurent,
> 
> On Sat, Jan 29, 2022 at 7:42 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> To avoid 'warning: no previous prototype for' error, declare all
>> the parse_bootinfo and config functions prototypes into asm/config.h
>> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> I have already queued v12.

I assume you're talking about this particular patch only and not the whole
series, correct?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

