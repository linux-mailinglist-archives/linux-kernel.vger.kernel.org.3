Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48154F6249
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiDFOyj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Apr 2022 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiDFOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:52:19 -0400
X-Greylist: delayed 2339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 04:27:52 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074C4E5D4C;
        Wed,  6 Apr 2022 04:27:52 -0700 (PDT)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuDoR-1nq8pN1sfF-00ua7I; Wed, 06 Apr 2022 11:41:00 +0200
Received: by mail-wm1-f41.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1232266wml.5;
        Wed, 06 Apr 2022 02:41:00 -0700 (PDT)
X-Gm-Message-State: AOAM532nots+nSUALq2sX+8t4yFa83Z0hnqRN2+LPukycXzuCmW5OmVI
        zgohL12wKb90MaWG5IcnjzZDov4cWCjAw8++KEk=
X-Google-Smtp-Source: ABdhPJzxUZX+E7XCtlp8CuL3coz4kajfPoqdCKk/EJtWFQ5dur8RDTboYWVRRTfTH1oiwHkEqf8zaBfFzz/1pPZluso=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr6846810wmq.33.1649238060031; Wed, 06
 Apr 2022 02:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220307091923.9909-1-ychuang3@nuvoton.com> <20220307091923.9909-4-ychuang3@nuvoton.com>
 <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org> <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
 <bba99b9d-6960-f6e8-0ee4-0b5fe8a5601d@linaro.org> <ab89589f-6dd7-d4ff-635d-ff8dbd2d3e02@nuvoton.com>
In-Reply-To: <ab89589f-6dd7-d4ff-635d-ff8dbd2d3e02@nuvoton.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Apr 2022 11:40:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a034bvYcD81h-jo92PbQwDDapa8JvS140fsBhaP7qrFXw@mail.gmail.com>
Message-ID: <CAK8P3a034bvYcD81h-jo92PbQwDDapa8JvS140fsBhaP7qrFXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ym5E5RCTMbe3WDe7e5tAv7Ns5tg0qVR7XTBsncM0V4ygUGzYLkX
 wVNMZVF4lA38S+Ax9xlUCP7lUFgv6Mo3+vKhVqN0weEC2oXc2EeHOxVIAPOcTcZktUvRYMM
 kqD/0uGLlOHjulxDn6dg4oh6Kwz3U5fDRYmeavTrJg/tjjmv5nd0bam+u3zhRNNEJ0iD0vA
 vIPUj1TkMFdLgXxHFz/Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FJFHUnyfrw=:M1ZZfWhg0NqGqONOnDrmqt
 YjskGH/X47PoWikYHCufKyZa4tD+iAvY8z0u9qhNkZrGLVdMlpcWo+y2nh3rukQIJ2WFm2UM1
 rnsJQ9WjRfU4xuyqx2mgevuwzv0FnFd6E/PUtNLMGCyWhSU2tLGHf6/itW/btxeSR3sEtuusY
 l2KsvKcpPk0zhwADNd6ekB9MEG87cVrHR8K+lasn5rKf50PUvyts/egDzKXk1y+3miL147uDx
 DHSN5phmvW5NzQ7HoF/FUl8c7FrNsHW7Wz93tJtZOo/b9XVE9gyHVzaTGfhwyLAgf9B1VZm8u
 NN0YnfLEBEl1Si6a6hcoXi1uGSaugNJcPV/mOlOfQatte+oDOSNpyHKrxpPTO2fVt+nOn6hoM
 JHwAVNxdyM0N99MkYiMK1Cw4lqSYSMEfPBR1e5svbEmrMgI+u6GnUORA5PO4mhtn1s5Raa4mW
 LPec6BwxC8LdxXj8eNsRQCEUGsI8fS87BsYxN5XgbzvzH54xSdcSzu5xXeqNfqIV8XR5Ax+nr
 gLXOk3wjIin8XGpWjcGwlWv8OAV/DxKh2/l3DFKz0iXjcCXhuE+gv9hLid0NhoKYHpdj4VHFk
 6kd2L1vhKPoibYC0l2vOQxit7nxU30ITOwtaMqBOy7/58JlXXV+PlkOtRy45ELUdIMx/95Iew
 lWcaw9ddPKiwq7gnktuagoRAv2yIdF242WA0db42RM9vKKQV8vFEfnmzALlOw1eulTQMK72Ae
 mZycrRY7LFQTPGwUtP9SjELIzfR99TIsC+zEGwQzFNAZh121MUWmMa94B88SHQKeEpe3ReYHc
 0HdrfQdExzmvhEZb/i2wolaxA0K2z1N4UFJGOB6Yh6BS8usfac=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 11:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
> On 2022/4/6 下午 03:14, Krzysztof Kozlowski wrote:
> > On 06/04/2022 04:58, Jacky Huang wrote:
> >> config ARCH_MA35D1
> >>       bool "Nuvoton MA35D1 SOC Family"
> > We do not add options for specific SoCs, but for entire families, so
> > ARCH_NUVOTON is correct.
>
> Yes, I would like to modify it as the following:
>
> config ARCH_NUVOTON
>      bool "Nuvoton SoC Family"
>      select PINCTRL
>      select PINCTRL_MA35D1
>      select PM
>      select GPIOLIB
>      select SOC_BUS
>      help
>        This enables support for Nuvoton MA35D1 ARMv8 SoC.
>
> (Currently, we have MA35D1 only in the support list for arm64 SoC.).

You could reword this to "This enables support for Nuvoton ARMv8 SoCs
such as the MA35D1", to prevent this from getting stale, or repeatedly
updated when future SoCs are added.

Another change you can consider is to remove the 'select PINCTRL_MA35D1'
here and instead change the pinctrl Kconfig entry to

config PINCTRL_MA35D1
           bool "..."
           depends on ARCH_NUVOTON || COMPILE_TEST
           default ARCH_NUVOTON

That way you get it default-enabled when ARCH_NUVOTON is
turned on, or disabled in configurations without ARCH_NUVOTON,
but can make a more fine-grained selection for a particular SoC
if you get more than one such driver in the future.

        Arnd
