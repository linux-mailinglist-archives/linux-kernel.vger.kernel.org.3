Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7813F591B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiHMOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHMOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F56BF79;
        Sat, 13 Aug 2022 07:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1A960DEF;
        Sat, 13 Aug 2022 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87AC433D6;
        Sat, 13 Aug 2022 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660402479;
        bh=N4kjUi4PTo0aa0MQR9hcV00wsscIFyN4QydIKOaekVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vEWAmtylEsAaz9sRfKNI1rrv/BMqyZ4ZJUF1H1orjJXnEyhYNUeE3pI3zpwCr1kTf
         BmLuFWw3QxsmuiIgUibCYimqbg2pRi0hmXfK27e/S9yKgHbBJyNv51mJiueVzi2pGA
         U04Lz/yNTfJ1h2u7GBohGoVlEyCHbdbWyAwFeCo1HitQxQgnkZFkNs+lEyjv3eKJkF
         w2rzkXCU+06L7LJj75hdt5SdpYQjTJ1WUEfwNyWAVdLhR7ATMlyo2vbEfzvOa9jLsO
         q2wO/uAKz7hjsHqnxzsBIMfc/DtXsmGrO/pyepz98F2HELOBVpaRSx4J4rNPsmiCCD
         zdQRipfyv2FYg==
Date:   Sat, 13 Aug 2022 16:05:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: stmpe: Remove node name
 requirement
Message-ID: <20220813160506.04be3760@jic23-huawei>
In-Reply-To: <YvJ/N2zulizbiU6u@google.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
        <20220712163345.445811-5-francesco.dolcini@toradex.com>
        <20220809134607.GA44926@francesco-nb.int.toradex.com>
        <YvJ/N2zulizbiU6u@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 9 Aug 2022 16:37:27 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Tue, 09 Aug 2022, Francesco Dolcini wrote:
> 
> > Hello Jonathan, can you pick this? Patches 1 and 2 were applied to MFD
> > tree.  
> 
> Sending out nags whilst the merge-window is open is seldom helpful.

Agreed, next week would have been better.  I happen to be queuing stuff
up ready for a rebase this cycle though so applied this one to what will
be the togreg branch of iio.git after rc1 is available and I've rebased.

Jonathan

> 
> Also, please refrain from top-posting.
> 
> Thanks.
> 
> > On Tue, Jul 12, 2022 at 06:33:44PM +0200, Francesco Dolcini wrote:  
> > > STMPE driver does not require a specific node name anymore, only the
> > > compatible is checked, update binding according to this.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> > > index 9049c699152f..333744a2159c 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> > > @@ -13,8 +13,7 @@ description:
> > >    This ADC forms part of an ST microelectronics STMPE multifunction device .
> > >    The ADC is shared with the STMPE touchscreen. As a result some ADC related
> > >    settings are specified in the parent node.
> > > -  The node name myst be stmpe_adc and should be a child node of the stmpe node
> > > -  to which it belongs.
> > > +  The node should be a child node of the stmpe node to which it belongs.
> > >  
> > >  properties:
> > >    compatible:  
> >   
> 

