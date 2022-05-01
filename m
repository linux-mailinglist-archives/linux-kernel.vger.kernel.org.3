Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319451643B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbiEALkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiEALkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:40:11 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADB1D0C2;
        Sun,  1 May 2022 04:36:45 -0700 (PDT)
Date:   Sun, 1 May 2022 06:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651405003;
        bh=EJO0qMWBy/NTbXIPnclz3OjTdOhNYK7qnowCOESkQMQ=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=1GkHYQ+nXQJZ0rOe+wnMncD7WAwPzJoAAy5gW75ZaUQu0gaJKJFvGWOjAABwvJ9V1
         J5Lg5e64FxO1vLE6ML96bhxf/9+HjEidWnIYpcrq8ZMPjRBGV6abkOvWT8zCVdCH0Z
         S/Oifi+QYBq3/Mm3jlalB32FyHgyYWz+EUQFaSLkUR9sSHvsGDtsPuc29hGEEw/Cf3
         bnzorcFCDKqYScuFAa6+rD7OTKgGylAtORFO4pddnjGIuOlB8uCQZk1OO0kXs1rVSj
         oS54EBJkTWRQWAZV+ZiqrG45AwrkUtBFeRVzQ+jr/6uT5aE0qzV/BOVNUYaIslsxUm
         GyQ0xxhXL9vrg==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Message-ID: <20220501113215.rh6he5344hssziy7@proprietary-killer>
References: <20220501051020.2432338-1-hanetzer@startmail.com>
 <20220501051020.2432338-2-hanetzer@startmail.com>
 <0b66148a-c65f-2acf-9751-ae931778ad45@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b66148a-c65f-2acf-9751-ae931778ad45@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 10:35:37AM +0200, Krzysztof Kozlowski wrote:
> On 01/05/2022 07:10, Marty E. Plummer wrote:
> > Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> > generates clock and reset signals used by other module blocks on SoC.
> > 
> >
> (...)
> 
> > +		return;
> > +
> > +	hisi_clk_register_mux(hi3521a_sysctrl_mux_clks,
> > +				ARRAY_SIZE(hi3521a_sysctrl_mux_clks),
> > +				clk_data);
> > +}
> > +CLK_OF_DECLARE(hi3521a_sysctrl, "hisilicon,hi3521a-sysctrl", hi3521a_sysctrl_init);
> Missing bindings.
> 
Assume you mean the Documentation/dt/binding/... file? Will do. I
probably should have prefixed it with RFC, as I'm mostly hoping to get
the attention of the hisi people to see what's the deal with the mtd
reads being borked.
> Best regards,
> Krzysztof
