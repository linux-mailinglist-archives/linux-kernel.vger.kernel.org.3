Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5650D3D4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiDXRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDXRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:16:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501D366B1;
        Sun, 24 Apr 2022 10:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C63F7B80E60;
        Sun, 24 Apr 2022 17:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A212C385A7;
        Sun, 24 Apr 2022 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650820405;
        bh=54+FNxJrtS+PrIP/GplOrQ2ETgEi8Y4HA7qnqoDfr+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aKF3fshSlVNO57BiSKhBa+d043riqhvpRPuUC43Ab39oG1ORBKIrt8PjxsEQAuE3i
         mFAIGeDoWxiz3ebgfFnfBCmQ/Cz5D+DAQ750R6mak5O/AH7ArmKIXp6q3C1JmToXSa
         8D2CWKcQ4z7ucMNeeOOlyNWKOF7AdN3woFLomMNBvWLcLriB0thz8sH4CbJ1z2cWwm
         cMMPJpLRweU9qtWuOx/2m+cJY3e+vAFJ2VJraSDDYjUDS0VhHf/j/d2D90uWmX0Q4A
         ILO5NmOJd5VagCLv8zX1Wvxd8xzmqq5cISOwS2wd1j5iPSQpC3CZGqG1laWyf8B5bd
         PjzInJO/C1mNA==
Date:   Sun, 24 Apr 2022 18:21:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cixi Geng <gengcixi@gmail.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dt-binding
Message-ID: <20220424182131.0e0fc06d@jic23-huawei>
In-Reply-To: <2bcf42e0-c58e-99f7-b667-8c212022ff19@linaro.org>
References: <20220419142458.884933-1-gengcixi@gmail.com>
        <20220419142458.884933-2-gengcixi@gmail.com>
        <2bcf42e0-c58e-99f7-b667-8c212022ff19@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 09:01:51 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 19/04/2022 16:24, Cixi Geng wrote:
> > -  nvmem-cell-names:
> > -    items:
> > -      - const: big_scale_calib
> > -      - const: small_scale_calib
> > +  nvmem-cell-names: true  
> > +> +if:  
> 
> Better to include it under "allOf:" so next time you need more of such
> if-then, you do not need to change indentation. But anyway looks good:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I added the allOf: whilst applying.

Thanks,

Jonathan

> 
> > +  not:
> > +    properties:
> > +      compatible:  
> 
> 
> 
> Best regards,
> Krzysztof

