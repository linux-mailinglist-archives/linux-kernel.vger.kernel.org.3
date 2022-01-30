Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531B4A3735
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355413AbiA3PTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:19:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59154 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbiA3PTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69B0BCE0FC9;
        Sun, 30 Jan 2022 15:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3921C340E4;
        Sun, 30 Jan 2022 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643555957;
        bh=gqZKjFiI669q0gnS/jVPy4eF6e3RL32aeL9cHh4hGBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KyRnbaqFAK+nA9fhN2VtkQpD/lSC+SORK4ahJNndfScSUw343/mnE0tfnEkQCSGit
         /nPfhF6D1gCzxmi+K4kkhZsFXp8QrJYwzJOwcdKYE9M4JEBwiC0sBWsqMObkV7evYU
         sEUsHuvfS9P2iJcOLKIviv3Rv14Au2D/rSib9z+x8SS7OPkQy4fNwZzyO/mLhm/RQS
         0ts1urKPEl77crlCKxgGOpe7lyTyipRoO1ZjJotdTdR2TY7w5ZaGJWLGO8wFNLi4kU
         Z7AhZSg3ifSZ6tJ5ngAUZwe3SBQONL/1tO0njody7SgCsMT3KvEhZeQcH/uiPiASA/
         bS5izFbYgDcCQ==
Date:   Sun, 30 Jan 2022 15:25:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: at91-sama5d2: update
 maintainers entry
Message-ID: <20220130152541.5772d4ad@jic23-huawei>
In-Reply-To: <6acdb66592baf395a77a431c0cb9a37b0f178097.1643554065.git.nicolas.ferre@microchip.com>
References: <6acdb66592baf395a77a431c0cb9a37b0f178097.1643554065.git.nicolas.ferre@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 15:50:08 +0100
<nicolas.ferre@microchip.com> wrote:

> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Update the maintainers entry to match the changes made back in
> mid-2020 with 853fa48717c2 ("MAINTAINERS: adc: at91-sama5d2_adc:
> remove myself as co-maintainer").
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at other things I applied today.

Thanks,

Jonathan

> ---
> Hi,
> 
> Patch for new MAINTAINERS entry is here:
> https://lore.kernel.org/linux-arm-kernel/23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com/
> 
> Regards,
>   Nicolas
> 
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> index efed361215b4..9a2292e7defc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: AT91 SAMA5D2 Analog to Digital Converter (ADC)
>  
>  maintainers:
> -  - Ludovic Desroches <ludovic.desroches@atmel.com>
>    - Eugen Hristev <eugen.hristev@microchip.com>
>  
>  properties:

