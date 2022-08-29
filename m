Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AEC5A51DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiH2QeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH2QeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:34:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7A8F97A;
        Mon, 29 Aug 2022 09:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FEC3B81160;
        Mon, 29 Aug 2022 16:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BADC433C1;
        Mon, 29 Aug 2022 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790853;
        bh=EHNP4RzQnuQOX+7RxLEAqc1syZDl49UGa8ehhKTXRQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cDp7X8gBmpAOAKJ8Rlu6UmYCh/TwfAd+Jwhm1G1Jt0ADl/0+xpDQqwt1xfPELrpMx
         ldgBmtZYVf7Ppsyy3Pytt6xBmXCK6ejuba3d7PxD8NolqsJPBsZepd0w9dBLtnRFfV
         ONSDgqTK/PV84hBTcRtABTBs1RaIeKNRoOpAa3CJOPACNNqoRQ8KCvkDNT7jCAuU0S
         kb2ekjtAWyRQD1WjoPZRpVw+FP+Oe+/QVHD6QAmMR/6FyMdCw2MqByS5BbA8lB9y4G
         04a3AvVZ9ZNMS6LkZqYUQinoBzbvgdpDDaze8B1XDISXxfQSH8AviJsLmWtCdeHzfX
         fOJH30FPzz/NQ==
Date:   Mon, 29 Aug 2022 16:59:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220829165950.268433ca@jic23-huawei>
In-Reply-To: <20220829141029.GA1470207-robh@kernel.org>
References: <20220823145649.3118479-2-robh@kernel.org>
        <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
        <20220828180050.51c3e857@jic23-huawei>
        <20220829141029.GA1470207-robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 09:10:29 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Aug 28, 2022 at 06:01:41PM +0100, Jonathan Cameron wrote:
> > On Thu, 25 Aug 2022 15:04:33 +0300
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> > > On 23/08/2022 17:56, Rob Herring wrote:  
> > > > In order to ensure only documented properties are present, node schemas
> > > > must have unevaluatedProperties or additionalProperties set to false
> > > > (typically).
> > > >     
> > > 
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> > to poke at it before I push out as togreg for linux-next to pick up.  
> 
> Thanks.
> 
> > Side note. Some odd entries in your cc list...  alsa-devel?  
> 
> Blame MAINTAINERS:
> 
> STM32 AUDIO (ASoC) DRIVERS
> M:      Olivier Moysan <olivier.moysan@foss.st.com>
> M:      Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
> S:      Maintained
> F:      Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> F:      Documentation/devicetree/bindings/sound/st,stm32-*.yaml
> F:      sound/soc/stm/

There is some logic to that entry I suppose.

Thanks for explanation!

Jonathan
