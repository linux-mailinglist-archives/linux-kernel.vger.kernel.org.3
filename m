Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F248351AF88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378289AbiEDUoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378391AbiEDUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC311277E;
        Wed,  4 May 2022 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82D12B82949;
        Wed,  4 May 2022 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA24C385A5;
        Wed,  4 May 2022 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696821;
        bh=aXVyvWfDxf+r8P4NAgCnCJj/TrGjcm2Y20m+/fpSGRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXAZGtq/xcyCjYbAM605e+7L+PSL5pLriw5XZVhsNnocxU+8ZegluRgXL8dw73rdv
         8c7Kt3udXccgQ2l+Z1ZNyWD5JoavY80wRMTMUpc8lXwkvngiq4c0iZTOTlQ1I5UvHN
         EXijxrkT7j+NzjesFJjzcC3x7dEKzGHrot2GKCy0BJeuj86rQiJRKuwaHvfkP1U4Fn
         uYKjY1CpJJI9ejJ7RJqHVxNNkSr4De7QkoeC11gfKivn3hW0yf1+H98BAKkewt6eBS
         hCoaQNK8pU56uL5BnZmHizfWppbVmffeLKkqjDkM126S+9jL5I/A44IC0nRYZO1NX8
         wjUJeeR20e/xA==
Date:   Wed, 4 May 2022 21:48:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Rob Herring <robh@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <20220504214840.1ad32bff@jic23-huawei>
In-Reply-To: <20220504183716.shhpi5adcxz4ufvj@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-4-ddrokosov@sberdevices.ru>
        <YmhWic3rG8ERtCYY@robh.at.kernel.org>
        <20220504183716.shhpi5adcxz4ufvj@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 18:36:33 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Rob,
> 
> I've missed one note below, please check if possible.
> 
> On Tue, Apr 26, 2022 at 03:31:05PM -0500, Rob Herring wrote:
> > On Tue, Apr 19, 2022 at 03:45:58PM +0000, Rokosov Dmitry Dmitrievich wrote:  
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0  
> > 
> > These apply to 'reg' in a child node, but you don't have child nodes so 
> > drop them.
> >   
> 
> I'm afraid, I made a mistake in the previous reply. Here I applied
> address-cells and size-cells to show which type accelerometer's reg
> property has, like this one:
> 
>     i2c {
>         #address-cells = <1>;
>         #size-cells = <0>;
>     
>         accelerometer@62 {
>             compatible = "memsensing,msa311";
>             reg = <0x62>;
> 
> Above accelerometer@62 is child node for i2c bus node, so address and
> size cells mean accelerometer reg format. Am I missing something?

They are characteristics of the i2c master and hence
are listed in those binding docs, not the one for the accelerometer.

Thanks,

Jonathan
> 

