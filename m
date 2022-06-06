Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D80C53EC04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiFFLfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiFFLfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:35:08 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AE1B79D;
        Mon,  6 Jun 2022 04:35:06 -0700 (PDT)
Date:   Mon, 6 Jun 2022 06:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1654515303;
        bh=mpbBAztguTTQhW8kMhRiNpwOFt1Qp+y0cn4YlTLDqU8=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=QIRX6sLoDs7XzIES1QbkQlBAdvLFB3+wHstX4KHaYKoYZGM7W0jLDNOuiPtKin7eK
         XWs9DZQenKc4on+0PYYYNEo61rQtGTgm4zAyTn/cF90hcppkMWPNSz+YLpYf2QP9e6
         aVpldliyDEUeeSNx7Khu7Zmu3h7Jzht5DiAEVy3if3t/wfPOON8eiruiU+WzHjkc1y
         Wqp2CP4OLCsH8WqdWj65VflnPSLSfREfTCXLbuC2yJYbBdzIj72wE3NkjZs3ufNNtg
         zRkUVrec5B9d19oaODMXL94ARZ7107f7ZgUw4gfU/oLJgbF7Ej1oXVdzjyi75zXAn3
         l3cu65Qs0MNgA==
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
Message-ID: <20220606113455.7dv6bnk25ki6tau7@proprietary-killer>
References: <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
 <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
 <20220601110616.xmxih663kxgupszv@proprietary-killer>
 <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
 <20220601182418.okoofgannw6vbcxo@proprietary-killer>
 <b1b87be5-a048-b713-c9f2-84b948aa6718@linaro.org>
 <20220603112227.hmzwy7xxl6ddezqh@proprietary-killer>
 <34e6715e-795c-3d64-1341-31da9bd27563@linaro.org>
 <8e81de5f-dfb7-e34f-ff5f-44b52421fa24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e81de5f-dfb7-e34f-ff5f-44b52421fa24@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:29:59AM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2022 16:54, Krzysztof Kozlowski wrote:
> > On 03/06/2022 13:22, Marty E. Plummer wrote:
> >> On Thu, Jun 02, 2022 at 08:37:43AM +0200, Krzysztof Kozlowski wrote:
> >>> On 01/06/2022 20:24, Marty E. Plummer wrote:
> >>>
> >>>>>> Either or. Whatever makes the workload easier is what I'm looking for.
> >>>>>
> >>>>> Sorry, you need to be more specific. Apply is not a job for you, for the
> >>>>> patch submitter.
> >>>>>
> >>>>> Then you miss here important piece - which is the first patch. DTS goes
> >>>>> always via separate branch (or even tree) from driver changes. That's
> >>>>> why bindings are always separate first patches.
> >>>>>
> >>>> So, add a 4: arch/arm/boot/dts/soc.dtsi and 5: arch/arm/boot/dts/board.dts
> >>>> to the above list, or should those be the same patch as well?
> >>>
> >>> For me does not matter, sub architecture maintainer might have preference.
> >>>
> >> Fair enough. That being said, for the dt-bindings patch, is it
> >> permissible to include #define CLOCK_FOO 1337 and so on for clocks which
> >> haven't been wired up in the driver yet? As in, you know they're there,
> >> and are important enough to model, but you haven't gotten to that point
> >> yet?
> > 
> > What would be the benefit to include them now? I imagine that if you
> > plan to add such clocks to the driver in next week or something, and you
> > need to use them in DTS, then it's fine. If that's not the case,
> > probably there is little sense in defining them upfront...
> 
> Actually I see one more benefit - since IDs should be incremented by
> one, you can define all of them upfront thus having some
> logical/alphabetical order/grouping. If you extend the bindings header
> with new IDs later, they must go to the end of the list, thus maybe
> ordering will not be that nice.
> 
> If you want, go ahead with all IDs. Just remeber that these must be IDs,
> not register values or some programming offsets.
> 
Yeah, this was my intent. There are a number of non-standard,
proprietary IP blocks on this soc who's 'organized clock number' come
'in between' the more standard bits, depending on how you decide to
organize them (based on their parent clocks, based on the order they
appear in the crg register block, whatever). I *do* intend on hopefully
putting together drivers for these as well, though that's a long-term
stretch goal.
> Best regards,
> Krzysztof
