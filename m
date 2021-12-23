Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF447E1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347794AbhLWKvh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Dec 2021 05:51:37 -0500
Received: from aposti.net ([89.234.176.197]:38442 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347737AbhLWKvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:51:36 -0500
Date:   Thu, 23 Dec 2021 10:51:28 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] dt-bindings: iio: Document "label" property
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Guido =?iso-8859-1?q?G=FCnther?= <agx@sigxcpu.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <S5EK4R.TVR7E86L755D@crapouillou.net>
In-Reply-To: <20211221133339.66766-1-paul@crapouillou.net>
References: <20211221133339.66766-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan:

Please ignore this patch for now - I will add a global definition in 
dtschema instead.

Cheers,
-Paul

Le mar., déc. 21 2021 at 13:33:39 +0000, Paul Cercueil 
<paul@crapouillou.net> a écrit :
> Document the "label" property, which can contain a descriptive label
> that allows to uniquely identify a device within the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: - Reword description and commit message
>         - Use > instead of | for proper multiline handling
> 
>  Documentation/devicetree/bindings/iio/common.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/common.yaml 
> b/Documentation/devicetree/bindings/iio/common.yaml
> index f845b41d74c4..49f9f62dbb3e 100644
> --- a/Documentation/devicetree/bindings/iio/common.yaml
> +++ b/Documentation/devicetree/bindings/iio/common.yaml
> @@ -32,6 +32,12 @@ properties:
>        considered 'near' to the device (an object is near to the
>        sensor).
> 
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: >
> +      Optional descriptive label that allows to uniquely identify a 
> device
> +      within the system.
> +
>  additionalProperties: true
> 
>  ...
> --
> 2.34.1
> 


