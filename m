Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9304A3724
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbiA3PCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355307AbiA3PBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:01:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B24C061714;
        Sun, 30 Jan 2022 07:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A096121F;
        Sun, 30 Jan 2022 15:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35F5C340E4;
        Sun, 30 Jan 2022 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643554913;
        bh=1iy0rridhHP3rIhCcS7NLyfngfPFw4RvnlskGAg2JVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hLZfo48DvP8yr9IpfiNdrOd5hofgTTUyvUREPpSQM34wozKSd6C7c/5IN3KV2y6Sr
         Ikl4LGE4ayZEWUs0IYmLufyJ2/9VDMJe4aXot7t9SmOh6vSq2XctLV7MgSBDMW+ksN
         WthRgcwA74jdqxPmv7sV/qXG4LOG6xjDucEkxWcwQ/pYW4DDCiNhV22olsWWT/vRvk
         KDT8iMPFfYv4OiFFZf5XG84r+lKe62tUAY45sJWy1pK3aHU4CvIhlJYjczl5NWV+s7
         syPt3MIuko0oQPJqzzCg3VlKpBsvVFG54vDc77z5jPtc/8yCNj59A7ZhDrKN8bOSxA
         MKy2EUvT02CsA==
Date:   Sun, 30 Jan 2022 15:08:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: atmel,sama5d2-adc: make
 atmel,trigger-edge-type non-mandatory
Message-ID: <20220130150803.1112cba7@jic23-huawei>
In-Reply-To: <YcIYOh6TmtVElt05@robh.at.kernel.org>
References: <20211217095401.583821-1-eugen.hristev@microchip.com>
        <YcIYOh6TmtVElt05@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 14:08:58 -0400
Rob Herring <robh@kernel.org> wrote:

> On Fri, 17 Dec 2021 11:54:01 +0200, Eugen Hristev wrote:
> > The atmel,trigger-edge-type was never imposed by the driver.
> > Make things right and remove this property from the mandatory list.
> > This will not break existing nodes because according to the binding they
> > should have this property.
> > However, the driver does not impose it and it works without it, the property
> > selects the trigger type, and without it, the driver will have no trigger
> > available, which is the case on some boards which do not have access
> > to the trigger pin.
> > This will avoid generating this warning for example:
> > 
> > */arch/arm/boot/dts/at91-sama7g5ek.dt.yaml: adc@e1000000: 'atmel,trigger-edge-type' is a required property
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

oops. I lost this one until doing a cleanup of patchwork.

Anyhow, now applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Sorry for the delay!

Jonathan
