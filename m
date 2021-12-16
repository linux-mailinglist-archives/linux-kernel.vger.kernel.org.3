Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDE476BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhLPI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:26:49 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:35856 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhLPI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:26:44 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 6104220D2F75
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <abede066-43a2-b61b-d152-c95ef3785934@omp.ru>
Date:   Thu, 16 Dec 2021 11:26:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk
 property in dwc3
Content-Language: en-US
To:     Yaqin Pan <akingchen@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel@vivo.com>
References: <20211215130325.19017-1-akingchen@vivo.com>
 <20211215130325.19017-3-akingchen@vivo.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211215130325.19017-3-akingchen@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.2021 16:03, Yaqin Pan wrote:

> Add snps,dis_split_quirk property for dwc3 controller
> 
> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
> ---
>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 41416fbd92aa..e9615ca8f447 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -226,6 +226,12 @@ properties:
>         avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>       type: boolean
>   
> +  snps,dis_split_quirk:
> +    description:
> +      When set, change the way host controller schedules transations for a Control transfer.

    Transactions.

> +      Needed to avoid emurate some devices fail.

    Avoid failing to enumerating some devices?

[...]

MBR, Sergey
