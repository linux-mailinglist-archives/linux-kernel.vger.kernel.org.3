Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24A4A3697
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354954AbiA3OFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:05:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiA3OFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:05:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351F761193;
        Sun, 30 Jan 2022 14:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6520BC340F0;
        Sun, 30 Jan 2022 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551547;
        bh=OO5FkFuFfJwcPYSFa+GXosL1yGNT8VeA5s9UGFeBx1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SmsH8BbYG8IIVjPrFLxxIGPrjkIdheqTwz4j/ekOu7eBXOmeuVC9CpcQ5MXy9TbfT
         n3MVebVg3aW+nmH908C1UFS1IXZlQTvt2Gsvh3V3kSKDTMBExDLBpnMms2+FF5m3CF
         c9aNnRtZhPDM6dR/jDH0F1UKmR/rSYiyGD8WtJZ50CtGg/JbjV6s0Ht0XrAtivzhoH
         5H/BYuMnLsnRxMtkwqobbDkjXql6yxt0DXftDS2RgDW41pChVuAQVzfa/hZBnkKgwe
         tAvhp9ADSZ0Rssxewp8vr4hsnM3ueIWY0yqCKqz3e63YXqAKQIxc+D6JcoR5e4Qwc+
         pIl+xBEfH2W6Q==
Date:   Sun, 30 Jan 2022 14:12:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: st: Add Silan SC7A20
 accelerometer
Message-ID: <20220130141211.19a61569@jic23-huawei>
In-Reply-To: <20220130034441.15474-3-samuel@sholland.org>
References: <20220130034441.15474-1-samuel@sholland.org>
        <20220130034441.15474-3-samuel@sholland.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 21:44:40 -0600
Samuel Holland <samuel@sholland.org> wrote:

> This chip appears to be a clone of the LIS2DH, as the register bit
> definitions match exactly.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index 71de5631ebae..70f755041d8a 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -24,6 +24,7 @@ properties:
>      oneOf:
>        - description: STMicroelectronics Accelerometers

It's not an STMicroelectronics part, so add a new block for silan ones.

Thanks,

Jonathan


>          enum:
> +          - silan,sc7a20
>            - st,h3lis331dl-accel
>            - st,lis2de12
>            - st,lis2dw12

