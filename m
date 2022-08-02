Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDED5877A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiHBHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiHBHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:15:45 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A163B4BF;
        Tue,  2 Aug 2022 00:15:44 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIm7w-00072o-FH; Tue, 02 Aug 2022 09:15:40 +0200
Message-ID: <85f3afd9-0a16-a022-fcc5-18c64e3f90f2@birger-koblitz.de>
Date:   Tue, 2 Aug 2022 09:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
 <CAFBinCBq3ydoxtj1VG=kjqbq5NjP1ZnQe_dOAS2Gjm2fNkK9Yg@mail.gmail.com>
 <20220801152559.GA9041@alpha.franken.de>
 <0dbe47388183bf17830e5c77513ca78c58e32612.camel@svanheule.net>
From:   Birger Koblitz <git@birger-koblitz.de>
In-Reply-To: <0dbe47388183bf17830e5c77513ca78c58e32612.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;git@birger-koblitz.de;1659424544;4a2b01a6;
X-HE-SMSGID: 1oIm7w-00072o-FH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/22 18:02, Sander Vanheule wrote:
> Hi Thomas,
> 
> On Mon, 2022-08-01 at 17:25 +0200, Thomas Bogendoerfer wrote:
>> On Thu, Jul 28, 2022 at 05:50:10PM +0200, Martin Blumenstingl wrote:
>>> I think for the Realtek SoC's this would be problematic because it's
>>> using MIPS_GENERIC. My understanding is that in an ideal world all
>>
>> which SOC are these ?
> 
> That would be the SoCs supported by MACH_REALTEK_RTL. More specifically, the
> ones affected by this issue are the RTL8391M, RTL8392M, RTL8393M, and RTL8396M
> which have two VPEs.

There is also a multitude of RTL930x SoCs, which have the same setup as the
RTL839x SoCs regarding the VPEs and the same IRQ controller.
But they also have a broken MIPS Timer IRQ and we are not able at the moment
to get the second VPE up without running into immediate trouble.
For the moment we only need to take care of the RTL839x, though.

Cheers,
   Birger

