Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D595A0147
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiHXSWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiHXSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:21:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED074DE3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:21:56 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MekGB-1ozQTa1umD-00aqN4; Wed, 24 Aug 2022 20:21:35 +0200
Message-ID: <62ea701c-4a4d-876e-f9b5-db9013b38f04@i2se.com>
Date:   Wed, 24 Aug 2022 20:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rh-kdlp@googlegroups.com, Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <fc54a7a3-c67b-79ab-5e87-d468695e5553@i2se.com>
 <CABe3_aFJ0gkLDFB9k5FEn1SmupbLEKxAn8y=WTt-Rc0xUEK4Dw@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CABe3_aFJ0gkLDFB9k5FEn1SmupbLEKxAn8y=WTt-Rc0xUEK4Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u+zYdaH+2Cf/pioCd/p03u8AnGfLTzkjpU+kpsn3f2yUWDaLfDA
 cGoRkoW808AE1lIKI6TqKyrH+B8gw198KapcLQgdZlMeHVtfZFPzL0gBoKCB/gtg310fSL4
 XOBI1IX0ByzYaIHJApy34W6fQpgjt0ZzJ5OI5WEDivc8PwlioH1xL4koUg8F1UXThVn21K9
 Z2P+icZKNzkdK6lxWQfGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i6ApzL93+Xo=:rmdM/oTSqpAbLAycZBsETI
 JghU2EQrnxrp6K0F0p6DwqudAhGPwpTEndmqDVbROfE0FspNUFqgmzGevSU0nLv3zMWHDuxuV
 r6K/JhgPL8VKaUNOJ3o33kwch3rbhfDdzla8O95XSrmobG1lGRMmc03nXr/viUdGMZUEAOF0X
 Jrwec/zjjGDyyWzMzeZZ6b+I9oDDCMg8AzmxJgcn/xOrFLX/zUGCP9ePOGE/c8hzsDvAdLqnD
 T+Q/5IZxwSSGU3WOsSG7dMA9y+8XId77YCdH87wPnxUL5qN1VfB7Q/etbpxvzY51+tLgxiWZc
 TIaoniuvEiHbh5l5fg58Afuykm27fZkoVeX1KqZa5DNEi813dBOXwPthYvsgpEo+5aeRarv9d
 6ixF+A3hvM4o65mGm+5umuJVxTCbFJlK6+Ft6uEq6Dn9TeD0oKw9Ww98S4dEv4tkWrjg49VH+
 BCHEo2Bf41HdMuRCXpaLEUCMUlAFDl2mhhDB+4ZORor66FxUyIiBF43TtYH391cOhij7jqOx1
 o7LxkSIQCZT2HKnwd1UKK9jezYQCLbIMLXZRE+ttd59prl+glIZf3C6RWQE6a+FBr5omutklj
 xj1ID/RKB/ZAgwD2cHuSnXhei7iyB6SkZVo/bBjDrMfAhzQ7wbH2TvQe5DCpmSzNMaYHg20sF
 myT6R/70Vu1mUIGyNKdeivsfbXD18OiIY+SALXezjSQuFxB1X1JjfM4yN/7cRYzUnAZqIYjFn
 4cyFi4WLvd3btghdd/fDHNHK8f+S88xXfsKYv3Ob2y0sOZBjWI5rvsIxCYQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.22 um 14:06 schrieb Charles Mirabile:
>> In case you want to send a new version it would be nice to enable the
>> driver in bcm2835_defconfig for better test coverage. But this is not a
>> show stopper.
> Since I am going to have to send a v11 to fix Lee's email address I
> will look into this. Is it as simple as adding another patch that puts
> CONFIG_SENSEHAT_DISPLAY=y into the next version?
> Presumably I would also want to enable CONFIG_JOYSTICK_SENSEHAT right?
> Do I have to do anything special since both of those options have
> decencies (namely CONFIG_I2C for both and CONFIG_INPUT for the latter,
> and both select MFD_SIMPLE_MFD_I2C)?

make bcm2835_defconfig

enable both driver via make menuconfig

make savedefconfig

mv defconfig arch/arm/configs/bcm2835_defconfig.2

diff -u arch/arm/configs/bcm2835_defconfig 
arch/arm/configs/bcm2835_defconfig.2 > config.patch

manually add only the relevant changes from config.patch in 
arch/arm/configs/bcm2835_defconfig

generate the patch as usual

goal is to have simple patch which only contains the 2 driver changes 
without any clean-up changes

