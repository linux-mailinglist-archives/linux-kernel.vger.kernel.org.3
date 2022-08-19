Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A1A59A47A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350038AbiHSR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349902AbiHSR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D95DF41;
        Fri, 19 Aug 2022 10:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037786184B;
        Fri, 19 Aug 2022 17:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610C7C433D6;
        Fri, 19 Aug 2022 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660931165;
        bh=pnoRxmb4SZjZlfuYaUMFVyBKjjD93ZdYQ8Neue15m8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uRVTyd4l5ZLWcOrKi+EKkuKe+a5XArPm3PoE01X9sXVuLCYe1oQFAUMWAoE1X88cr
         o67t7IVRrKQ60RPKyqnvIV9BgGelTRHRg2ocpPf0EjsyB34sPgmKkB5VI+aPNgTmPV
         fFubmnWsWeT/8H6d4OxwPFi4JVdPfQgFQQwJPeSRaWl9aWoduB/hpkasGM1mXpfF6j
         M7bDFA5h7YC+4Bb2DvLBbhvkgS6nh3uQu4cmdzZp0JV+uaJek3GRWDB5lZIQ07KXbC
         skZhy3x46TBjBn61jBuyBXwR4XnbuxTDL12WG42YZyi760jN7JCpSd4D0y2VTYjshW
         gsZ1POA4ar8rw==
Date:   Fri, 19 Aug 2022 18:56:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: Drop Tomislav Denis
Message-ID: <20220819185640.434b32b5@jic23-huawei>
In-Reply-To: <20220818145350.GE1829017-robh@kernel.org>
References: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
        <20220818145350.GE1829017-robh@kernel.org>
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

On Thu, 18 Aug 2022 08:53:50 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Aug 16, 2022 at 03:53:59PM +0300, Krzysztof Kozlowski wrote:
> > Emails to Tomislav Denis bounce ("550 5.1.1 User Unknown").
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml     | 2 +-
> >  Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git.
There is other stuff in there that needs a 0-day run, so for now pushed
out as testing.

Thanks,

Jonathan
