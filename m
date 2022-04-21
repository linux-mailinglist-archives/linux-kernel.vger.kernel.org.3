Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337A50A221
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389172AbiDUO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352115AbiDUO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:26:44 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBC3CA61;
        Thu, 21 Apr 2022 07:23:54 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id z2so5769417oic.6;
        Thu, 21 Apr 2022 07:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltsRnfamwtq0CQPhc5gTf9IyXvHEdaLupIo/2GTsf6M=;
        b=ZNs/w0gnTOCuOMZtM3R4PkyyRFKJNLg/UplsfGlfgvQqBsL9/YkzGDHNIi9euUxdRQ
         H4wbgRFuV+PCPMsOtV52PIMldTtcohXm9LkyOCbc2iGHgPbKMx1W51eQAifYTf3pbC3V
         QkMLHvr35e4gRNU+t7RFEIzDiEVrISUzxhYq0/3syWHBkZDeYdnH7yRb+RUB8cqXv4fc
         xOTOCgdBAraB9NxSMiG5ErMo7W6v2FdwQu3sED9I2jJBPezBvE8uaDa1L6zxtb7Ov5un
         yak+oTHIpfo/NMKvA1ZBSxSE0FkOkoYZ53Trk+a3Lh4ZMRhxSafsRPg+xBSzsbrkIBqE
         JHrA==
X-Gm-Message-State: AOAM530GNQxPOmgUZaR6D2Gk2N121C88IkKlQjjCov8UooZuNbj6K7JN
        C42XTSjSz3oCz6nwpNbHTDU3ovp3rQ==
X-Google-Smtp-Source: ABdhPJwR8TXnotKlPy21bKRlPaStjXgsL0FJOPRy9rOEUSB8MqwoYv6nPCiWA2vSys2iICB+uV9kQg==
X-Received: by 2002:a05:6808:180a:b0:322:bcd3:ddaf with SMTP id bh10-20020a056808180a00b00322bcd3ddafmr4228060oib.35.1650551033810;
        Thu, 21 Apr 2022 07:23:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a4a8ec9000000b0032438ba79b0sm7863670ool.0.2022.04.21.07.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:23:53 -0700 (PDT)
Received: (nullmailer pid 3421101 invoked by uid 1000);
        Thu, 21 Apr 2022 14:23:52 -0000
Date:   Thu, 21 Apr 2022 09:23:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, jerry.huang@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, shawnguo@kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Message-ID: <YmFo+EntwxIsco/t@robh.at.kernel.org>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421094421.288672-1-michael@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:21AM +0200, Michael Walle wrote:
> On 21/04/2022 11:11, Jerry Huang wrote:
> >> Please also answer Michael's comments.
> >> 
> >> [Jerry Huang] I double checked the MikroBus devices, we used two MikcroBus devices:
> >> BLE P click: https://www.mikroe.com/ble-p-click
> >> BEE click: https://www.mikroe.com/bee-click 
> >> Both of them are SPI interface connect to ls1028ardb through MiKcroBus interface.
> >> So the name "semtech sx1301" is not correct for this node.
> >
> > I asked to remove the words "Devicetree bindings" and this was not finished.
> > 
> > Now you mention that entire name of device is wrong... It's confusing. I
> > don't know what device you are describing here. I expect you know. :)
> > 
> > What is this binding about exactly?
> 
> I *think* it's just exposing the mikrobus connector as an spidev device.
> There was a former attempt by Vladimir here [1]. Now as it the nature
> of such a connector that you can connect a myriad of devices there, it
> doesn't really make sense to have a just particular one described. What
> happens if that one will switch from spidev to a real driver in the
> kernel? So using "spidev" for the compatible would be the first reflex.
> But as described in the spidev driver this is plain wrong (and also causes
> a warning/info message it) because it should describe the actual hardware.
> 
> Thus I proposed to use DT overlays which are loaded according to what
> is actually attached to the header, so a real driver could be loaded.
> 
> But there *could* be a sane default which then could be replaced in
> an DT overlay. Like "mirkobus-socket" or similar, which might expose
> spidev. Actually it is more than just SPI, there is GPIO and resets and
> I2C. Maybe it should be an MFD? I don't know. But that is something for
> the DT maintainers to decide if they'll allow such "generic" devices.

generic devices, no. MFD, no. 

What's needed here is a connector node (and driver) for the mikrobus 
socket. The connector node's purpose is to decouple the host DT from 
add-on board overlay DT. Something like this:

connector {
	// And a more specific compatible if pins can have alt funcs?
	// Spec version needed?
	compatible = "mikrobus-socket"; 

	// Will need regulators defined if child devices expect 
	// regulators
	vcc-33-supply = <&reg33>;
	vcc-5-supply = <&reg5v>;

	i2c-parent = <&i2c1>; // Already a defined property
	spi-parent = <&spi0>; // New

	// RST pin
	reset-gpios = <&gpio 4 0>;
	
	// remap 'INT' (index 0) to host interrupt
	#interrupt-cells = <2>;
	#address-cells = <0>;
	interrupt-map = <0 0 &gpio 3 0>;

	spi {
		//devices
	};

	i2c {

	};
};

The DT spec defines 'foo-map' properties extending interrupt-map. 
Currently only GPIO is defined. We might want to do the same thing for 
PWM. Or we make the connector node both a PWM consumer and provider.

Rob
