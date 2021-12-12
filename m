Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080EC47191D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhLLH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:27:27 -0500
Received: from marcansoft.com ([212.63.210.85]:37316 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhLLH10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:27:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C2FF4424CD;
        Sun, 12 Dec 2021 07:27:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/8] dt-bindings: arm-pmu: Document Apple PMU
 compatible strings
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-2-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <80072314-c765-3042-c08d-cd3357d5fc63@marcan.st>
Date:   Sun, 12 Dec 2021 16:27:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-2-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> As we are about to add support fur the Apple PMUs, document the compatible
> strings associated with the two micro-architectures present in the Apple M1.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> index e17ac049e890..1a6986b4e552 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.yaml
> +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> @@ -20,6 +20,8 @@ properties:
>       items:
>         - enum:
>             - apm,potenza-pmu
> +          - apple,firestorm-pmu
> +          - apple,icestorm-pmu
>             - arm,armv8-pmuv3 # Only for s/w models
>             - arm,arm1136-pmu
>             - arm,arm1176-pmu
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
