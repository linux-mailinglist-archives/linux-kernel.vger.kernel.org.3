Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0C53ACBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356606AbiFASYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFASY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:24:29 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6AA5030;
        Wed,  1 Jun 2022 11:24:27 -0700 (PDT)
Date:   Wed, 1 Jun 2022 13:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1654107865;
        bh=6QDUqmhuM8l1tVdeJi5firhjmNHPasPFCys26Iie+VU=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=P1EAv5a9i3kopW4ykn8OWCntXzA5gWdkPwbERsEnYcy/tjRQveyLYsTwQphYppYkg
         vY/DjjN/zYCSSGli2wMbqrr16cYWnTVI3aZENthlFVht1jr/vUBu68fEHxPsS18HWe
         kuKcS1obKaJqlvVPh8fYsb0VD0w/AmUz6Ms/DirGW2NAnw15+/ydJPKJi6rfcsuLVP
         ZY/F4blN3h7f0Cwev/KOyE1FVIaH8s2PXlmxB6LQTeW4ovz+LVcCLGYSVZYuCRVJJg
         DM+p+GmiybFO0t1oXTpAX4PYIYLTufWrHsai6V6Mac7D7rCvWF7XFfcYkwlSjuCLPO
         LCDpcIHp5et0A==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
Subject: Re: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Message-ID: <20220601182418.okoofgannw6vbcxo@proprietary-killer>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
 <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
 <20220601110616.xmxih663kxgupszv@proprietary-killer>
 <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 01:09:28PM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2022 13:06, Marty E. Plummer wrote:
> > On Wed, Jun 01, 2022 at 01:00:38PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/06/2022 12:58, Marty E. Plummer wrote:
> >>> On Tue, May 03, 2022 at 01:37:42PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 01/05/2022 19:34, Marty E. Plummer wrote:
> >>>>> Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> >>>>> generates clock and reset signals used by other module blocks on SoC.
> >>>>>
> >>>>> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> >>>>> ---
> >>>>>  drivers/clk/hisilicon/Kconfig             |   8 ++
> >>>>>  drivers/clk/hisilicon/Makefile            |   1 +
> >>>>>  drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
> >>>>>  include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++
> >>>>
> >>>> Bindings go to separate patch. Your patchset is unmerge'able.
> >>>>
> >>> So, assuming I have the following patches:
> >>> 1: +include/dt-bindings/clock/hi3521a-clock.h
> >>> 2: +drivers/clk/hisilicon/crg-hi3521a.c
> >>> 3: +Documentation/devicetree/bindings/whatever
> >>>
> >>> In what order should they be applied?
> >>
> >> Applied or sent? The maintainer will apply them in proper order, this is
> >> bisectable.
> >>
> >>
> > Either or. Whatever makes the workload easier is what I'm looking for.
> 
> Sorry, you need to be more specific. Apply is not a job for you, for the
> patch submitter.
> 
> Then you miss here important piece - which is the first patch. DTS goes
> always via separate branch (or even tree) from driver changes. That's
> why bindings are always separate first patches.
> 
So, add a 4: arch/arm/boot/dts/soc.dtsi and 5: arch/arm/boot/dts/board.dts
to the above list, or should those be the same patch as well?

> Best regards,
> Krzysztof
