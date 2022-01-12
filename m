Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72BF48C453
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353323AbiALNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbiALNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:01:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D37C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:01:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e19so3974791plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vxuJ0eKUOzqs4BL3RXGtwRzHjP1ztp6I2cQyliBQvTM=;
        b=Lk0W06fl5Vk3upcZ1EWLPcM3OFdn+socWYkb5IOG1Env3+FN9hjj2qLQ4UG4FArLzq
         wkk025S6sO2GgaLwvzk0lDvfv9gbXwMliCfglmXilU9ww17qtoAFBY04Np2TP2Go1vWZ
         x6uzZ3xQf6hvJPLTXIMphSm/adRYLH2vJuVTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxuJ0eKUOzqs4BL3RXGtwRzHjP1ztp6I2cQyliBQvTM=;
        b=QhXju1PogYxyptYUTOuONdhJyVgooMlVaUJHi3zEtSIylbF8EwYSgzi/Silk+Ydl9q
         AjHgHUZxU6piSsaPJ6itPBiFRziT2tCP/n+HOtrc3+b5AJK9BJbO1lyiTsaAO2sL/fFB
         3QPZt4qAelAE/H2ZOhAawnC5V7M1AvXkPz4k1ErI9w+ejNywbRtub2VUiy0etQT9jKUE
         PAhQTk7e1TE61oB3Nuu3TObHCSo91kPDq+xgWdFeq/bHkvF35hdb8aD0z1hPPaSEPgp5
         /qTI5zyW6ebxpYokHdOKs8mnIKKWcoAIz+42LmlfJvUXQFNnr7mlF1lOuSiu47qnOpPq
         CXNA==
X-Gm-Message-State: AOAM530AjCi9vYGm5CyBO0stlqFS/MA6+NTSxpHTZpV3CGTo7mq7a3ky
        +fHew3wtOyG2w++Z77NkNOmmsQ==
X-Google-Smtp-Source: ABdhPJyLjY0Y/Ke21bvO+pWwfSSXV3kTTGk/pK3WXRsgY+aWMLqvk5tWT6NdISmYx1GUAIPZjR1COQ==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr8642773pjt.49.1641992481103;
        Wed, 12 Jan 2022 05:01:21 -0800 (PST)
Received: from p1g2 (2a01cb000f5a8200e371e4a5048c8b22.ipv6.abo.wanadoo.fr. [2a01:cb00:f5a:8200:e371:e4a5:48c:8b22])
        by smtp.gmail.com with ESMTPSA id q8sm9419877pfl.194.2022.01.12.05.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:01:20 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:01:15 +0100
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12-common: add uart_ao_b pins
 muxing
Message-ID: <Yd7RG80hhjZilGs7@p1g2>
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220103154616.308376-4-gary.bisson@boundarydevices.com>
 <fe58c139-f127-d102-a6a6-b8c2151aac20@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe58c139-f127-d102-a6a6-b8c2151aac20@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 09:33:42AM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 03/01/2022 16:46, Gary Bisson wrote:
> > - RX/TX signals can be mapped on 2 different pairs of pins so supporting
> >   both options
> > - RTS/CTS signals however only have 1 option available
> > 
> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  .../boot/dts/amlogic/meson-g12-common.dtsi    | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> > index af1357c48bee..3a7773ffbd08 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> > @@ -1952,6 +1952,33 @@ mux {
> >  						};
> >  					};
> >  
> > +					uart_ao_b_1_pins: uart-ao-b-1 {
> > +						mux {
> > +							groups = "uart_ao_b_tx_2",
> > +								 "uart_ao_b_rx_3";
> > +							function = "uart_ao_b";
> > +							bias-disable;
> > +						};
> > +					};
> > +
> > +					uart_ao_b_2_pins: uart-ao-b-2 {
> > +						mux {
> > +							groups = "uart_ao_b_tx_8",
> > +								 "uart_ao_b_rx_9";
> > +							function = "uart_ao_b";
> > +							bias-disable;
> > +						};
> > +					};
> 
> I'm not fan of these nodes namings.
> 
> Perhaps :
> - uart-ao-b-2-3
> - uart-ao-b-8-9
> 
> so the actual pins numbers used are more clear ?

Sure, I wasn't convinced by that naming either. I although thought
about:
- uart-ao-b
- uart-ao-b-alt

Let me know which one you prefer and I'll respin the patch.
Also let me know if I should re-send the entire series or just this
patch.

Regards,
Gary
