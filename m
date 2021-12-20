Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B156047B2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhLTShD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:37:03 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:33452 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhLTShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:37:02 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 36F1020A6FCC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: document snps,dis_split_quirk
 property in dwc3
To:     Yaqin Pan <akingchen@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel@vivo.com>
References: <20211220141629.14282-1-akingchen@vivo.com>
 <20211220141629.14282-3-akingchen@vivo.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cb1c928c-07fa-e6f0-8166-d68596224105@omp.ru>
Date:   Mon, 20 Dec 2021 21:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211220141629.14282-3-akingchen@vivo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/20/21 5:16 PM, Yaqin Pan wrote:

> Add snps,dis_split_quirk property for dwc3 controller

   The name doesn't match the prop itself anymore...

> 
> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 41416fbd92aa..e9615ca8f447 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -226,6 +226,12 @@ properties:
>        avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>      type: boolean
>  
> +  snps,dis-split-quirk:
> +    description:
> +      When set, change the way host controller schedules transations for a Control transfer.
> +      Avoid failing to enumerate some devices due to usb compatibility issues.
> +    type: boolean
> +
>    snps,is-utmi-l1-suspend:
>      description:
>        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> 

MBR, Sergey
