Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92C471826
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 05:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhLLEE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 23:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhLLEEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 23:04:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257BC061714;
        Sat, 11 Dec 2021 20:04:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9D23C42598;
        Sun, 12 Dec 2021 04:04:50 +0000 (UTC)
Subject: Re: [PATCH 0/4] dt-bindings: Add trivial Apple t6000/t6001 SoC
 bindings
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211209051001.70235-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <6e79168e-4680-47dd-dfa1-f246fd02facd@marcan.st>
Date:   Sun, 12 Dec 2021 13:04:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211209051001.70235-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 14.09, Hector Martin wrote:
> Hi Rob et al,
> 
> This series adds trivial DT binding changes (compatibles and some misc
> changes) to support Apple's t6000/t6001 SoCs and the devices that use
> them. These changes are for devices that need no driver changes to
> support these new SoCs. Drivers that need changes (notably AICv2) have
> the binding change submitted as part of that series.
> 
> The only nontrivial patch is #3 for the PCIe binding, which grew a port.
> I tried to set it up so it'll fail validation if you try to have too
> many ports on t8103.
> 
> I'll be happy to merge this through the Asahi-SoC tree once reviewed :)
> 
> Hector Martin (4):
>    dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro 14/16"
>      compatibles
>    dt-bindings: i2c: apple,i2c: Add apple,t6000-i2c compatible
>    dt-bindings: pci: apple,pcie: Add t6000 support
>    dt-bindings: pinctrl: apple,pinctrl: Add apple,t6000-pinctrl
>      compatible
> 
>   .../devicetree/bindings/arm/apple.yaml        | 21 ++++++++++++++
>   .../devicetree/bindings/i2c/apple,i2c.yaml    |  4 ++-
>   .../devicetree/bindings/pci/apple,pcie.yaml   | 28 ++++++++++++++-----
>   .../bindings/pinctrl/apple,pinctrl.yaml       |  4 ++-
>   4 files changed, 48 insertions(+), 9 deletions(-)
> 

Thanks for the reviews! This is now queued in asahi-soc/dt.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
