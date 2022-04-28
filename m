Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02F1513C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbiD1Tjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD1Tjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB77246F;
        Thu, 28 Apr 2022 12:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70582B82F43;
        Thu, 28 Apr 2022 19:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9763C385A9;
        Thu, 28 Apr 2022 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651174587;
        bh=cSMidqnlE3j/eY2lhTjf9VRgCqtFpz9vGthamTRuL+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u9oSBje68Ff1k3S8mO/tdyHLAVrulHZfJGmJ3RxzFAvsdOB5UlGFIdkvZz585++af
         lKPOgEj+WJkFNq3wDBOy3YJFXiCLONuDzGE8GQw0vlMGzRv7jmuA0SPGc5cYSxRyYn
         vsIVeL9O70Tcw9cCElhDd4FHoN3/aVNSBIsPuHIjVR+bCyyoYKyCe9iVim6z40ABGX
         Gon1CgSBJgAtAHlosceV6sv05t5J79rnHJRpFUvtwohp15Pmg6SBC/dZXcg07StR9t
         evPITLosBjXK2IlUPEhlZ6A2hAT8JhIjzV379I2AP705syW24R+pEw/iGezPQxgt4K
         DRyQysF9rCrCw==
Date:   Thu, 28 Apr 2022 20:44:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571
 driver
Message-ID: <20220428204439.4ec2b4ae@jic23-huawei>
In-Reply-To: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
References: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
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

On Mon, 25 Apr 2022 22:46:30 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> The new chip works much like the other chips supported by the driver, so
> this is just adding another compatible to the list.
> 
> Chenages since v1:
> - Guenter Roeck noticed elsewhere that my mail setup was botched and
>   that my patches were clobbered. Hopefully fixed. *blush*
> - added tags from Sean Nyekjaer and Rob Herring

Applied.  Thanks

Jonathan

> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   dt-bindings: iio: ti-dac5571: Add ti,dac121c081
>   iio: dac: ti-dac5571: add support for ti,dac121c081
> 
>  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
>  drivers/iio/dac/Kconfig                                   | 2 +-
>  drivers/iio/dac/ti-dac5571.c                              | 3 +++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 

