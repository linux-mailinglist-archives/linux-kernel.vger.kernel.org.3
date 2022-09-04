Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639645AC55F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiIDQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiIDQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260233A0D;
        Sun,  4 Sep 2022 09:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD4C60FB2;
        Sun,  4 Sep 2022 16:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB51C433D6;
        Sun,  4 Sep 2022 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308335;
        bh=rg52SRXE804gIDaJwyrdD4Wv0s5nLGxTMdjesRTC8bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a3tlAKcMvqWDBkTmt1Nm0qeYz6WKzP+CBCg9g3o7TPupawhyzrSVUsV8fjfqL2uV3
         Hru1TkLeQSS6t15sG2bJOnDSSKf2GWG56DeFTMYp63t2JNsw4Z2KDM5owjdW/sIn/5
         XLlw+4yuLdbhWE3uJ79elr03j+ihqQNf8plH7ivEkWa5kyVnTSkgnNcjjC1wUdaXPp
         pc8hXhkXLUfXDw0aEgDhV2JtK5HytzvIHAK7OSXAOLzBmQzQS45rvIeiXDB90ECAjN
         pRngsAUE3ceUGJK3E5SSOrrSUZEx69oIvb8FCNr/udAaZTQWJ1tVKmS/rVayccJahh
         UjNBuRRslFRlg==
Date:   Sun, 4 Sep 2022 16:44:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bindings: iio: adc: Add max11205 documentation
 file
Message-ID: <20220904164447.5c748549@jic23-huawei>
In-Reply-To: <d33607e2-42de-ac4e-7ed0-4c25504ac092@linaro.org>
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
        <d33607e2-42de-ac4e-7ed0-4c25504ac092@linaro.org>
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

On Wed, 31 Aug 2022 16:36:25 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 31/08/2022 16:30, Ramona Bolboaca wrote:
> > Add bindings documentation file and MAINTAINERS entry for MAX11205.
> > 
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>  
> 
> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max11205a
> > +      - maxim,max11205b
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 5000000
> > +
> > +  spi-cpha: true
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator supply for the ADC reference voltage. This is a differential
> > +      reference. It is equal to the V_REFP - V_REFN. The maximum value is 3.6V.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +  - spi-cpha
> > +  - interrupts
> > +  - vref-supply  
> 
> If you are going to send a new version, please put the properties here
> in the same order as they appear in top-level "properties:".
Tweaked whilst applying.

J
> 
> In any case:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

