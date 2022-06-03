Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20153C93B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiFCLWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiFCLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:22:39 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8735846;
        Fri,  3 Jun 2022 04:22:37 -0700 (PDT)
Date:   Fri, 3 Jun 2022 06:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1654255355;
        bh=BVv2NM9n65XEgstvWZEX3Zz0IsWB0nQDd9CmGlBZ1e8=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=TaHE9+rTyTn3uo0Ihyw9XeRywIri5CokHtUnXmvWBUvxj7QpMfl659rYDDUthemfw
         JDXglecgRmHRtFhUnE1pBX1ZZ1mYxZGxXQKGGGio2/2sQaTIJaQk+P77qZGnX3F2Xr
         0bGtgjEq3muByV8xMktfZAv+1DCRVp102o9UNJp9qUslKCDlOG9BrpoxI75ANeC75s
         ef1ed+r/fYmYby6gCAporGN0ySGZPSsQfNaTbQLfklIQcllOmGlTp/aO+NTRC7sqju
         qgU2F3/onmtQaBr9ql/yiVstsBoMbSkwLAX+Zh2/8K/IxsuiRJfbWuPnoly64ueyNm
         jSBSc8cPAkN3g==
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
Message-ID: <20220603112227.hmzwy7xxl6ddezqh@proprietary-killer>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
 <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
 <20220601110616.xmxih663kxgupszv@proprietary-killer>
 <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
 <20220601182418.okoofgannw6vbcxo@proprietary-killer>
 <b1b87be5-a048-b713-c9f2-84b948aa6718@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b87be5-a048-b713-c9f2-84b948aa6718@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:37:43AM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2022 20:24, Marty E. Plummer wrote:
> 
> >>> Either or. Whatever makes the workload easier is what I'm looking for.
> >>
> >> Sorry, you need to be more specific. Apply is not a job for you, for the
> >> patch submitter.
> >>
> >> Then you miss here important piece - which is the first patch. DTS goes
> >> always via separate branch (or even tree) from driver changes. That's
> >> why bindings are always separate first patches.
> >>
> > So, add a 4: arch/arm/boot/dts/soc.dtsi and 5: arch/arm/boot/dts/board.dts
> > to the above list, or should those be the same patch as well?
> 
> For me does not matter, sub architecture maintainer might have preference.
> 
Fair enough. That being said, for the dt-bindings patch, is it
permissible to include #define CLOCK_FOO 1337 and so on for clocks which
haven't been wired up in the driver yet? As in, you know they're there,
and are important enough to model, but you haven't gotten to that point
yet?
> Best regards,
> Krzysztof
