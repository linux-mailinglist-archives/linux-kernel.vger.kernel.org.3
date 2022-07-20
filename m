Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D809B57BFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiGTVc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:32:25 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5F5C37A;
        Wed, 20 Jul 2022 14:32:24 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id v185so15346197ioe.11;
        Wed, 20 Jul 2022 14:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEhi57WmV6vrOiB/vf1RLTBq1jdQw+2dkpgn4DkEspM=;
        b=KECqqnQt1FQp2iPwXYYB1wmPsQ5Y0NHMLC+BPljX+Yx9qYQTolnHGYs+P1dveO2mGC
         hQMBpIcyMcJPblWQwe/dKZDqgrTltyhzulC2CfiJIEzDj6doZAkiLo3lB0tMfBEbuybU
         TEawyGi41fHDcyUcpIkmGNXVvOXulxegsDc1PwY831h/VCgu9IH7C/aTMhV1U8PGG7q0
         5cbA2a+DHJ2hq0myw7CzKCU0t8LnJB9k4dx/EUCvkjruKboK8hLPkDE2FB/oLJxMhXlK
         pDmpnk04Ayjz24z7Vd5eiEyocrDdAfFjjl21GxwzSkMEPmZmLAtqLll6Vmx4FRpEX5ju
         kFyg==
X-Gm-Message-State: AJIora/lTRylZcnA/9ZzNx5vtD3P58pihXYJh7ahyK++GCxc7HY0Pk0q
        TdUanArWrtQPMV5BxRuFBg==
X-Google-Smtp-Source: AGRyM1uRk1cUUMfIOOuBQo+vOAc//HNUMNLhFImebvXMMdzLHV6+08VwDde0y0o6nFy2RZAn5Ji8bQ==
X-Received: by 2002:a5d:8582:0:b0:669:835f:48b0 with SMTP id f2-20020a5d8582000000b00669835f48b0mr18271339ioj.146.1658352743669;
        Wed, 20 Jul 2022 14:32:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d4-20020a0566022d4400b00678e1d1b2c7sm141866iow.0.2022.07.20.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:32:23 -0700 (PDT)
Received: (nullmailer pid 4017951 invoked by uid 1000);
        Wed, 20 Jul 2022 21:32:21 -0000
Date:   Wed, 20 Jul 2022 15:32:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Message-ID: <20220720213221.GA3987398-robh@kernel.org>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:25:08AM +0000, Oleksii Moisieiev wrote:
> Introducing the domain controller provider/consumenr bindngs which allow to
> divided system on chip into multiple domains that can be used to select
> by who hardware blocks could be accessed.
> A domain could be a cluster of CPUs, a group of hardware blocks or the
> set of devices, passed-through to the Guest in the virtualized systems.

'domain' is entirely to ambiguous. We have clock domains, power domains, 
interrupt domains, etc. already. This needs to be specific about what is 
controlled/provided.

> 
> Device controllers are typically used to set the permissions of the hardware
> block. The contents of the domain configuration properties are defined by the
> binding for the individual domain controller device.
> 
> The device controller conception in the virtualized systems is to set
> the device configuration for SCMI (System Control and Management
> Interface) which controls clocks/power-domains/resets etc from the
> Firmware. This configuratio sets the device_id to set the device permissions
> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
> There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> determine device_id is not covered by the specification.
> Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware.
> This property is used by trusted Agent (which is hypervisor in our case)
> to set permissions for the devices, passed-through to the non-trusted
> Agents. Trusted Agent will use device-perms to set the Device
> permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> Agents concept is described in Section 4.2.1 [0].
> 
> Domains in Device-tree node example:
> usb@e6590000
> {
>     domain-0 = <&scmi 19>; //Set domain id 19 to usb node

Don't use this pinctrl construct with a number suffix. That was entirely 
because 1 pinctrl entry needed to reference an arbitrary number of 
nodes. Follow the standard producer/consumer pattern where each entry is 
a phandle with arg cells. You've mostly done that, but we don't need 
'domain-0', 'domain-1', etc.

>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>     power-domains = <&scmi_power 0>;
> };
> 
> &scmi {
>     #domain-cells = <1>;
> }
> 
> All mentioned bindings are going to be processed by XEN SCMI mediator
> feature, which is responsible to redirect SCMI calls from guests to the
> firmware, and not going be passed to the guests.
> 
> Domain-controller provider/consumenr concept was taken from the bus
> controller framework patch series, provided in the following thread:
> [1].
> 
> I think we can cooperate with the bus controller framework developers
> and produce the common binding, which will fit the requirements of both
> features
> 
> Also, I think that binding can also be used for STM32 ETZPC bus
> controller feature, proposed in the following thread: [2].

Hopefully someone speaks up. If not, then rejecting past proposals must 
have been the right decision. Must not really have been needed...

Rob
