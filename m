Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC24E47BEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhLUL3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:29:09 -0500
Received: from www381.your-server.de ([78.46.137.84]:35608 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhLUL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=XAIzWHN8FTDDcXtJnRpWIyylmj5yDBO4/E5ACkN17U0=; b=Rq0PXRgEfSp52z3EloLYIbOxMZ
        EknfBS+dgW23/lUUAlKf9AF6gpUcJXutdKxBl3uYqvGUbkGk/8SH0N4N9tZt37gnoJix4PJuKtzAj
        K14ap2Pk2PrdpXtRrTCxGhZvg4EjPDt3MD9/EuuhHo9PK5pv2A9TEk7Pbge9yFr1u7KxeWihQ6xjO
        v2Xwbm/K3QYFg68VM0AklxoLHLVAVOEVgtjSCuWM38i+zlVqGSENjGuuYsCWwFXlCyGBjEws4JYWp
        RSH2C5m3BLIB3/Pb8o9az3gBlHA3t17hAXUrYcbkyYZtTIGhhJ3Qgy0hHhKxUsqpe4MAaaQqxghLr
        LP6zdMfg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mzdKL-000H2C-Dl; Tue, 21 Dec 2021 12:29:05 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mzdKL-000Xs3-3Y; Tue, 21 Dec 2021 12:29:05 +0100
Subject: Re: [PATCH] dt-bindings: iio: Document "label" property
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211221104354.35073-1-paul@crapouillou.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7718b4c6-59f8-c728-87ae-3c85e992e300@metafoo.de>
Date:   Tue, 21 Dec 2021 12:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221104354.35073-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26395/Tue Dec 21 10:18:41 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 11:43 AM, Paul Cercueil wrote:
> All iio devices can have a label, which will be carried on to userspace
> as a sysfs attribute. This is useful when having several iio devices
> that represent different instances of the same hardware, as the name
> attribute would then not be enough to differentiate between them.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   Documentation/devicetree/bindings/iio/common.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Documentation/devicetree/bindings/iio/common.yaml
> index f845b41d74c4..a90ad7718ecf 100644
> --- a/Documentation/devicetree/bindings/iio/common.yaml
> +++ b/Documentation/devicetree/bindings/iio/common.yaml
> @@ -32,6 +32,14 @@ properties:
>         considered 'near' to the device (an object is near to the
>         sensor).
>   
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      All iio devices can have a label, which will be carried on to userspace
> +      as a sysfs attribute. This is useful when having several iio devices that
> +      represent different instances of the same hardware, as the name attribute
> +      would then not be enough to differentiate between them.
> +

The description has a lot of implementation details of the Linux kernel. 
The devicetree bindings should be formulated operating system agnostic.

Something like:

A descriptive label that allows to uniquely identify the device within 
the system.

