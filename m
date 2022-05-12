Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7C524D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbiELMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbiELMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:47:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972939167;
        Thu, 12 May 2022 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=E7JXfgKDXyXBuDHtThgJmopN/mj/yocwISb9cNT//xM=; b=lzvobPJpPlp7weaceib4oOVQx9
        qi0PA9B9wsGk1IHh9oBx6iTmD2+Rq9Qvn+c6MaFmzXtKY/cXhTfuyCuAUdDoZQRadRAnBfd/W0fsR
        Y2J+Flows69UiKNtrPTpSZ8Fza1jJaK/T2sB7sLeKrs5G8Fhh9qm6DDRyL8eOTwKHvGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1np8Di-002S27-1F; Thu, 12 May 2022 14:47:06 +0200
Date:   Thu, 12 May 2022 14:47:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada
 98DX2530 SoC and RD-AC5X board
Message-ID: <Yn0ByoU6Ta5Kmq0u@lunn.ch>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu>
 <YnviMOtXX+us+IA4@lunn.ch>
 <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
 <YnxXWIloDzfg8bh0@lunn.ch>
 <BN9PR18MB4251F84C9D4C538DB6D63CFCDBCB9@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR18MB4251F84C9D4C538DB6D63CFCDBCB9@BN9PR18MB4251.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically, the cpu-subsystems of Prestera 98DX25xx (AC5) and Prestera 98DX35xx (AC5X) are the same.

Great, thanks for the conformation.

> The DTSI Chris proposed had the PCIe portion removed.

> We have PCIe support for AC5/AC5X so we would obviously like to
> include this portion in both the DTSI and as a patch to the Armada8K
> PCIe driver.

So you can add the needed node to the .dtsi as part of the patch to
the pci-aardvark.c driver. That sounds O.K.

    Andrew
