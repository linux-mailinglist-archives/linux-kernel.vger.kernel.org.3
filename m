Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12514A7986
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiBBUcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:32:31 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50266 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiBBUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:32:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212KWIfM117784;
        Wed, 2 Feb 2022 14:32:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643833938;
        bh=sbQXzvwL+XaVbzlnAzXBMyJbFK3rlOJ8p8aDN+VKeLE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xEqSeedddQkYBz1UitkGB2QpkeWG6UV7V52yZl9FK0z34eWzbADFJ2p6HJZaA4XJg
         JP19dageajXB9uovDhBWTxF5TbKd5W1rLlvn6Yk0Hx0hfMY5eZciVDeK60Wf74a9nd
         nlez345i6maiKip8zUCZICfUXGcEG28iRHruoF+E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212KWIsL064212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 14:32:18 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 14:32:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 14:32:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212KWHRF038994;
        Wed, 2 Feb 2022 14:32:17 -0600
Date:   Wed, 2 Feb 2022 14:32:17 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
Message-ID: <20220202203217.sf2cr4orwl4usvyf@starry>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:25-20220111, Matthias Schiffer wrote:
> All peripharals that require pinmuxing or other configuration to work
> should be disabled by default. Dependent DTS are adjusted accordingly.
> 
> The following nodes are now "disabled" according to dtx_diff and were not
> overridden to "okay", as they define no pinctrl:
> 
> k3-am654-base-board:
> - mcu_i2c0
> - mcu_spi0..2
> - cal
> - main_i2c3
> - ehrpwm0..5
> - main_uart1..2
> - main_spi1..4
> 
> k3-am65-iot2050*:
> - mci_spi1..2
> - cal
> - ehrpwm0..5
> - main_spi0..4
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


Jan: you ok with this series? Please ack.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
