Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65F48A840
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiAKHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:18:17 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:55231 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiAKHSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:18:16 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 11 Jan
 2022 15:18:14 +0800
Message-ID: <fbca8027-f7f0-7822-5252-0be586a66496@amlogic.com>
Date:   Tue, 11 Jan 2022 15:18:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 1/5] dt-bindings: serial: meson: Drop legacy
 compatible.
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
 <20220110104214.25321-2-yu.tu@amlogic.com>
 <CAL_JsqKFLnfc5eaUHeo6EkbS0kkpA94rh=Zuda9V9aCragdVxw@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAL_JsqKFLnfc5eaUHeo6EkbS0kkpA94rh=Zuda9V9aCragdVxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
	Thank you very much for your reply.

On 2022/1/11 0:18, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Jan 10, 2022 at 4:42 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>
>> Deprecated, don't use anymore because legacy amlogic,meson-gx-uart
>> compatible. Don't differentiate between GXBB, GXL and G12A which
>> have different revisions of the UART IP. So it's split into
>> GXBB,GXL and G12A.
> 
> You are breaking compatibility. If your dts is updated to use the new
> compatible, then a kernel without the change will not work anymore. It
> worked before without understanding the changes you are making. It
> should continue to. A compatible value like this would accomplish what
> you want:
> 
> "amlogic,meson-gxbb-uart", "amlogic,meson-gx-uart", "amlogic,meson-ao-uart"
> 
> A new kernel will match on "amlogic,meson-gxbb-uart" or
> "amlogic,meson-gx-uart" depending if the dtb is updated or not. An old
> kernel will continue to match on "amlogic,meson-gx-uart".
> 
> If you are going to go breaking things, the power domain distinction
> in the compatible is odd...
> 
I will not blindly delete this "amlogic, meson-gx-uart" compatible as 
you suggest, just make a comment until all DTS changes are finished.
> 
> Rob
> 
