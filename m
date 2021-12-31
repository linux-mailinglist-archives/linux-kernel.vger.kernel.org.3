Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4163148237B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhLaKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:35:31 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:49568 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLaKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:35:30 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 18:35:28 +0800
Message-ID: <93da58f8-aca1-2fcf-e45c-e341e1be593b@amlogic.com>
Date:   Fri, 31 Dec 2021 18:35:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 3/6] dt-bindings: serial: meson: Support S4 SoC uart.
 Also Drop compatible = amlogic,meson-gx-uart.
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-4-yu.tu@amlogic.com>
 <CAFBinCB0RTfOLbV3ZC+9dJEiw2_y41V+JvNP9GOPaQcCLB7UdA@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCB0RTfOLbV3ZC+9dJEiw2_y41V+JvNP9GOPaQcCLB7UdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/31 6:34, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> as Greg already mentioned the $subject line is very long.
> 
> On Thu, Dec 30, 2021 at 11:21 AM Yu Tu <yu.tu@amlogic.com> wrote:
>> Deprecated, don't use anymore because compatible = amlogic,meson-gx-uart
>> don't differentiate between GXBB and GXL which have different
>> revisions of the UART IP. So it's split into GXBB and GXL.
> actually it's split into GXBB, GXL and G12A
> 
> [...]
>> -              - amlogic,meson-gx-uart
>> +              - amlogic,meson-gxbb-uart
>> +              - amlogic,meson-gxl-uart
>> +              - amlogic,meson-g12a-uart
>> +              - amlogic,meson-s4-uart
> In addition to Greg's comment I suggest splitting this into two patches:
> - one where the "amlogic,meson-gx-uart" compatible is marked as
> deprecated (Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> has an example for deprecated entries) and GXBB, GXL and G12A
> compatible strings are added instead
> - another one where the new S4 compatible string is added
> 
> The idea here is to have "one logical change per patch".
> Deprecating and replacing "amlogic,meson-gx-uart" is one logical change.
> Adding a new compatible string is another logical change.
> I am hoping that this will also make it easier to find a shorter
> $subject line (which according to the patch submission guide [0]
> should be 70-75 characters: "the summary must be no more than 70-75
> characters")
> 
I will split the two patches in the next version.One was deprecating and 
replacing "AmLogic, Meson-GX-Uart" and the other added S4 compatible.
> 
> Best regards,
> Martin
> 
> 
> [0] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#the-canonical-patch-format
> 
