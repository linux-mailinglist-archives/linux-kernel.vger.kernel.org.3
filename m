Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A05589E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiFWURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:17:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22CE527E1;
        Thu, 23 Jun 2022 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656015429;
        bh=nY3T1c4qM2yuOPGpKm22MzL3Dp3XOLAxfo8t3uAnMW0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JhLO6qnJxCl0lmcSHO6IKOx03XJ3Fz7SXGOquKNagpFHTkwZGNUyXJ3dy11kr2JPC
         vpxOEePRoXsleVtG3vIldIcF42WgH1HLdkYkjwcbMGnhbDQIyZ59ctm9kH8IR9BNcU
         2zQTa3x1v/49WlIr+r1OC8WNrUkELMq1V4h22P64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1nIoS62r3r-00nRIC; Thu, 23
 Jun 2022 22:17:09 +0200
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-6-LinoSanfilippo@gmx.de>
 <YrSU4eL9hgISg3Y1@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
Date:   Thu, 23 Jun 2022 22:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrSU4eL9hgISg3Y1@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xk8oEt/xNT1GDPlq/rAOTCmrF9KpcAvXJypRogcgblZ/lBlQDNG
 V5hmtsdw9JALPfQi8KdnUe/KpwuzryvlCwVJpHDFvUkVxS0uhU41KsyCVGCt5EqA8aeJmEq
 Ih42FbW9f4g3j4M256sHtglAbrRZNAZt7yFCFmY8fh4aQ+bqZGfxmHKYkpEKk+WesuSIx/f
 6uc2PaZZhGloIUoIoqsyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6DaKaIxa2Y=:CVrHPL9qHm+9vkTj1nWlAa
 xxfgQ982InBhWVOrVVf4Q/9y5WfQbA8vk0xsteo7Y+MACpjcFimjn767zhSvCOFdBLfFOK15/
 w4oQDm6OXe4rpgV0pVIUH8A0B8d5ZHlEL+4I++KmGo7h/fOAVPlqK7ypbrbBDgNE1qLZk/RJS
 oIjSrnQjXsZahbH+TX1GlAIqM8oLtWVbbU2q/AvDfiUmfIwuF7QPPVgFiihWrLHGgwAYWMQIz
 B5zuN0zHmBMvNexRsaFFFwDII7qJSrK8umIXT4aYqFeLUzZgCxktHOFslxLbdfbr87Wrx+7Xc
 kUQ4ftQAwvExD0/g8niddw7OwwZpHAvNuKDes56gIqCYOGSKsQgHkoFGusKJxRcvwbcxyWwdt
 4QYrI8zAZDObtMO408hzl7tOHVEsScZ4YsGBMkqSlbc2i81bZafF6Dz9tV0M4mAcKtiTtAFSe
 kiihklyTAkXDxLavxvaehhQsTQOrkSJQDdfquoGfeIgWKyqsZZ6LD2FU1XnfcXy0UPrcR4lkC
 rECkWUXDrsixmvu3K+JymE4fh0XT4k4ZzmPFHGzcU8rW5JqA00GiYuG4u9Nl1ldovPRWVJw51
 OAiFqLfAeyowM+ETke5RE1l/z+3BG+6npeDV1KqyirdBRTkf5G/y4zOwG+kg+NPlBUjg9RyKE
 p8REHwAHoYoyN6q6WRq5WTEASnHdWKdH5EUoNtObvxOlFWzLv9oedBIG6R4c4WePVuvI+9nvP
 UvCN+CWcUs3KytOKNUqQ3L3YQ9Gtfq8BF9731R/tN9QLYsVcRfRx1xXpuQQCPYZBRMceaznAb
 gVqYwwjgoX9UcLkbCDMjSUwUh/aLT3AqeG4KFTtpk7Hkl/NC8IW59IdSpmn0ePLCZ1xgIgjha
 ZEjnY5yACTGCI2U3Vfhi+2RIYQ2iFTOHd6vXEzLgIn5x1cys6yai+9BLj9w+yL+NtkV8J5XRr
 on5VjGXm4a2r3AQlfxUdsjPT/gU+HEcjwrLHDfiQbafTqF/8+hSwztoZHYPsZhplheFiaYr6p
 sg1DvZsnTtfMzpZ9tZtiGojeU65V4LFbE6oZekXWaVik0dIs+PZe8bpMdgR9yqZWnsKmW/2tP
 d0ceY7t+raWJymXSgWmspGPtRAtCQ7UrwYqJj1qiILNzX8EgJ88i3LsHg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.22 at 18:29, Andy Shevchenko wrote:
> On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> The maximum allowed delay for RTS before and RTS after send is 100 ms.
>> Adjust the documentation accordingly.
>
>
> Is it only documentation issue? If the code allows this to be set higher
> than 100, we may not change the documentation since this an ABI (from
> firmware <--> kernel perspective) we need to support old variants.
>

Well currently the documentation claims that a maximum of 1000 msecs is al=
lowed but
nothing actually checks the values read from device tree/ACPI and so it is=
 possible
to set much higher values (note that the UART drivers dont check the delay=
s read from
DT/ACPI either, the only exception I found is max310x which clamps it to 1=
5 ms).

We already have a maximum of 100 ms defined for RTS delays set via TIOCSRS=
485. To be
consistent with TIOCSRS485 the same limit is used for DT/ACPI values in th=
is patch.

I am aware that this changes the firmware/kernel ABI. But we had a similar=
 situation when
the sanity checks for TIOCSRS485 were introduced
(see https://lore.kernel.org/all/20220410104642.32195-2-LinoSanfilippo@gmx=
.de/)
since before we did not have those limits for all drivers (some drivers cl=
amped the
values itself but many did not care).
Furthermore 100 ms is already a very high value for RTS delays (which are =
usually rather
in usecs range). So IMHO the risk is very low to break anything when value=
s are clamped
that are higher than that.


Regards,
Lino



