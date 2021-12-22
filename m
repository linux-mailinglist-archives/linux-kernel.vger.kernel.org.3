Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263FD47CFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhLVK20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:28:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37138 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbhLVK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:28:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3A961981;
        Wed, 22 Dec 2021 10:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357B9C36AE5;
        Wed, 22 Dec 2021 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640168904;
        bh=pRev/3Iu0KQQKhF3jpWLm/ftQPBNrPGf1Xl+zReVV+Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KE5v2barJrhspSY62q3P4vWw55llYiHVuGeLH9m0YY/6Ie8KThhBcBMS7a//A7rir
         aYf9RK4F6rTiWN9aBlPEoolKV3rMG85pUFMSZUKhTEnRQ2Y8sG3ONqChDDp0XwzQDX
         lm8ZAAKiS8IYzStGztEgcgjcVOUr1IjF0/aKpfHn3k2SUUocV9Y1T9YONtV5+Wt6k2
         bC2/wcK2e2kwiVk9ZeSma4ntQMGP/Lq7eMUs5EpAdDPsKNTchhbQ/clUV3Lkk7VTnD
         wC2zoTlS8d0GKkBKwq0tsdzUWGeY4Ep7ENoVKOarXSk6CKg4d0nBJZtF/wf/0tDhSB
         fCQ04UQH07IAA==
Subject: Re: [PATCH 1/2] memory: omap-gpmc: Use platform_get_irq() to get the
 interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-omap@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221203916.18588-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221203916.18588-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <fed1f0ad-0929-e114-37ad-ffd3eac696d1@kernel.org>
Date:   Wed, 22 Dec 2021 12:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221203916.18588-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2021 22:39, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
