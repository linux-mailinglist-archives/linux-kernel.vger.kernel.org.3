Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E55489463
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiAJIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:55:44 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:19223 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiAJIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:54:41 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Jan
 2022 16:54:39 +0800
Message-ID: <f16843d4-c3c7-9b24-e262-3ca5472e07a7@amlogic.com>
Date:   Mon, 10 Jan 2022 16:54:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] dt-bindings: serial: meson: Drop compatible =
 amlogic,meson-gx-uart.
Content-Language: en-US
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110082616.13474-1-yu.tu@amlogic.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20220110082616.13474-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	I'm really sorry for sending the wrong specified file. Please ignore 
the email. I will resend V4.

On 2022/1/10 16:26, Yu Tu wrote:
> Deprecated, don't use anymore because compatible =
> amlogic,meson-gx-uart. Don't differentiate between GXBB, GXL
> and G12A which have different revisions of the UART IP.
> So it's split into GXBB, GXL and G12A.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 72e8868db3e0..ad9f1f4537a0 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -28,7 +28,10 @@ properties:
>                 - amlogic,meson6-uart
>                 - amlogic,meson8-uart
>                 - amlogic,meson8b-uart
> -              - amlogic,meson-gx-uart
> +              - amlogic,meson-gx-uart # deprecated, use revision specific property below
> +              - amlogic,meson-gxbb-uart
> +              - amlogic,meson-gxl-uart
> +              - amlogic,meson-g12a-uart
>                 - amlogic,meson-s4-uart
>             - const: amlogic,meson-ao-uart
>         - description: Everything-Else power domain UART controller
> @@ -36,7 +39,10 @@ properties:
>             - amlogic,meson6-uart
>             - amlogic,meson8-uart
>             - amlogic,meson8b-uart
> -          - amlogic,meson-gx-uart
> +          - amlogic,meson-gx-uart # deprecated, use revision specific property below
> +          - amlogic,meson-gxbb-uart
> +          - amlogic,meson-gxl-uart
> +          - amlogic,meson-g12a-uart
>             - amlogic,meson-s4-uart
>   
>     reg:
> 
> base-commit: 99a507a8ea28542ec196e2dd80096708e2482735
