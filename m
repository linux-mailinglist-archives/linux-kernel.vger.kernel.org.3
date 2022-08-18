Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA25982E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbiHRMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiHRMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:07:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE98A1F0;
        Thu, 18 Aug 2022 05:06:58 -0700 (PDT)
Received: from mail-ed1-f51.google.com ([209.85.208.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZCvh-1nuAym0vdR-00VAZs; Thu, 18 Aug 2022 14:06:57 +0200
Received: by mail-ed1-f51.google.com with SMTP id z20so1595334edb.9;
        Thu, 18 Aug 2022 05:06:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo0MB9nDRMSLQxs6JfQVyTEdizKgupWdcjoEHMWfw6bYtv0Sv1vT
        1d/uE1O53qj8L8u9eiNLWBUswB5PM7QOd7QXTtc=
X-Google-Smtp-Source: AA6agR7Sz6NPJtIQZSUoxG0aPUAHiTh3EAkYGAZrmlAF1RKyRr2hih2GPF/vQbUl19Y1aDytKituxOjsVxorJ/QDiyA=
X-Received: by 2002:a05:6402:520e:b0:43d:df14:fbed with SMTP id
 s14-20020a056402520e00b0043ddf14fbedmr2078468edd.16.1660824416882; Thu, 18
 Aug 2022 05:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-3-quan@os.amperecomputing.com> <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
In-Reply-To: <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 14:06:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com>
Message-ID: <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
To:     Joel Stanley <joel@jms.id.au>
Cc:     Quan Nguyen <quan@os.amperecomputing.com>,
        Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JKLMlusOHQn9+1OuVLpodoi7rsFpCc6dLhvfcsm3OGWp5n7IEhR
 f5y/re0fMmLE+es53frkP9JgTSl1YoVwcqoYNr14Wk0BFZSU4/S6Y5DRkhWaa9TokvAWjRs
 Gnyq+PXnd3xzeTttpj8YQWZpGJIgo3s6bh7hlxF3diBGGyi88dTv4R4YOUcOsPk/EnzSZsQ
 JQEyA/5N2QlsfKCDlvkMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CkVdAI9t/OQ=:SZT54HfEofwTFk3gqsxYmb
 H9FF1fdfGibWxsP90TTXwLR7DFzyKXgfwqcV5frPVbNaCGKQc0HhCrKo4VfElVF/1oA6UMIJW
 f/BXYiEU05XHBfv3AuOnAYK/8kDJt8gStrMHSy0BUfzozxj8ZgPLx7kYdQ36P/lgnDEOQM61H
 wWE8nlFVO8KN39Bg6Rp9aCk0EkiO3kqu9k+J8tEkuTL70PujmF58HHXDqIbh31gc/nLi/srlN
 Ij9hqy8tUtIlIn5NsCWiJMSfDmDf1McrhlO1oxe+pFrI4x/3HQRujeLFYEONAXflVhmI3H5Nd
 0iYaLvw0q9m1PPcntEsWCVRsSZoDOKETg+q/DhQW986CvFJTJcMA2nhus9RE2EK7gGhUtAWpp
 a1rei05oP2h8thggKevbunsyQr+EngUC6PX4aYoFHHO/fmUL7yePpg58MID7hm032Hx1PxYWW
 fxgA1TaDeUQ2UvVVwixk+eMb3W2Pb/4PouIU5YYCBUaSqxeSrFApy0BH/bo9SUAyGs/I6Fy8N
 EFua3Sse39EJJi1nrypznlrBKuf2uO2Sb+1fTjo65lSFiV7+yz1q6rID7v1i3yf39yUurpIFb
 /jIlS7nryw8RUxNKDhcmYAuWfiA2fEJOfKtpqMxIS18XqsU5969liS2gP7geZnyaNwHwWsU4q
 mvL91gXznbsigOabzzWufjqyiQLWhz51aTPxkzTLjEZEBoHXbXo5jEn/Z2zxX2AUyQH/2azri
 SM+tkbwD9ofAcDDcFbAd0CKMENSdcaU+rah3gYcRU/hXb+sd7VdOIjdhWdpYrCfiX/ofcgdsy
 luKN9pAv0+TzyVzifjzNmNggBuvAn1E3aUO8oFBhCVOCPjIkirNIM5he9tsH6vYhK6w08oXKU
 zj1UlN7+NJyzM0k+nH7A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:33 AM Joel Stanley <joel@jms.id.au> wrote:
> > +
> > +/ {
> > +       model = "Ampere Mt.Mitchell BMC";
> > +       compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
> > +
> > +       chosen {
> > +               stdout-path = &uart5;
>
> I know you've been told by Arnd and others to remove the default
> command line here, but without it your device tree fails to produce
> any output in my tests:
>
> qemu-system-arm -M ast2600-evb -nographic -dtb
> arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dtb -kernel
> arch/arm/boot/zImage
>
> Without a working test, I can't tell the difference between a broken
> device tree and one that omits the serial device on the command line.
> Can you work with Arnd to come to a solution here?

If you use qemu as the boot loader, I think the expected way to do
this is to use the "-append" command line argument along with "-kernel".

Is there any reason for this machine to be special here?

       Arnd
