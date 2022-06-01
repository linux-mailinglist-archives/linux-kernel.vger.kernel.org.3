Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CC53A357
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351204AbiFAK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFAK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:58:56 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C963BCF;
        Wed,  1 Jun 2022 03:58:55 -0700 (PDT)
Date:   Wed, 1 Jun 2022 05:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1654081133;
        bh=xLfn3Y0/yusqS6Eog6u344rvDpPcQgkFd+Nc9svjBZc=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=yKR1FSWQZKbmWEJq56tQ7+c8inCVHzc/rmVKOXmTvPxNJFpV+LWFw5BanJCRftdiH
         P+xcq4HwEtf6xrHoas36nm9U5blUYUV4dPHXZUb4LkZruJoC4SFEk+l9CwXLLl+H08
         gi+Fr0mfxIsDMCNJr3YBNv2FCMJDM89OfpnOQrpny8JU0kgxu5nYrooYNWsRSY4pAK
         nLE7939OCvlXlFWiVLi/w2+7QBptE2o1wAgcBzfwHXyzgVLJ0UE7PjcrtyG7iIs0Nq
         Llsezfhj7YOheX1YykDGie3p5GrkY8a4UQ/SyAhc+uzxNVQORsQlEa+2HHM728LeDe
         pr+gnnUvXrpDQ==
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
Message-ID: <20220601105846.7hriawg3stxb657f@proprietary-killer>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 01:37:42PM +0200, Krzysztof Kozlowski wrote:
> On 01/05/2022 19:34, Marty E. Plummer wrote:
> > Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> > generates clock and reset signals used by other module blocks on SoC.
> > 
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > ---
> >  drivers/clk/hisilicon/Kconfig             |   8 ++
> >  drivers/clk/hisilicon/Makefile            |   1 +
> >  drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
> >  include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++
> 
> Bindings go to separate patch. Your patchset is unmerge'able.
> 
So, assuming I have the following patches:
1: +include/dt-bindings/clock/hi3521a-clock.h
2: +drivers/clk/hisilicon/crg-hi3521a.c
3: +Documentation/devicetree/bindings/whatever

In what order should they be applied?
> Best regards,
> Krzysztof
