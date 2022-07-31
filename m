Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DB585ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiGaMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiGaMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD28D2;
        Sun, 31 Jul 2022 05:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15A5960CBB;
        Sun, 31 Jul 2022 12:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32468C433C1;
        Sun, 31 Jul 2022 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659269406;
        bh=4KI97k0DgnwajWPahn/uuCMNyFUWkGhGx/caSLwK5oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTOg0/evvI8G2UEoMi6Ik3I9xtfC+uogodP/AcWlep4N2rXzQIKyZDZOusdHdGWQM
         jh4SIazYlMWTHQAV29tEvm2Yg4KhYdf28B0I2jeWYwTo0y/kqKiODKS5W+QistXgUY
         9sBV4kQtIuh24r2lRPBrZDzAA1jBBXxLjKRpXOlhFwmebn4dYqWj05iFbivjAWKeKW
         CMf7N4b8L72gc2luv9CoUhneeimYLse6znzc4zH2OiTnyog2530oJD6LUfekvkUcoe
         IEvnByIyjCbBnTltWtci0+5vfYsw7M411W1iZ7W3v7vjAjhYwKFcz9/kxrP/Xd7eUk
         xkthq8UXcEwxg==
Date:   Sun, 31 Jul 2022 13:20:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: add ti,am654-adc
Message-ID: <20220731132018.058329d1@jic23-huawei>
In-Reply-To: <20220728151650.GA899095-robh@kernel.org>
References: <20220727155203.320929-1-krzysztof.kozlowski@linaro.org>
        <20220728151650.GA899095-robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 28 Jul 2022 09:16:50 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 27 Jul 2022 17:52:03 +0200, Krzysztof Kozlowski wrote:
> > Document the ti,am654-adc compatible already used in DTS:
> > 
> >   arch/arm64/boot/dts/ti/k3-am642-evm.dtb: adc: compatible:0: 'ti,am654-adc' is not one of ['ti,am3359-adc', 'ti,am4372-adc']
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/iio/adc/ti,am3359-adc.yaml    | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git, but note that I've sent my last pull request
for the coming merge window, so this is queued up for next cycle now.

Let me know if I should take this via a fixes path instead.

Thanks,

Jonathan

