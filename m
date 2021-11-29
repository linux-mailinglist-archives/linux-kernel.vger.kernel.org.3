Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA958462568
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhK2Wim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:38:42 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40415 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhK2WiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:38:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E9A495C019E;
        Mon, 29 Nov 2021 17:34:45 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Mon, 29 Nov 2021 17:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=nak5LLj7hhbHiQ3bZxbtQxMEyoqm
        oK2+u/U9XmUMMoc=; b=THtCY7wkN/LcNfZsiY6qA3Z5wl8SrUNoDQdhre1m32or
        xXwFlPbIeq4T7sCxkvXWWqLU0wIndzQRo1e3w7X6TPxHrcmbdlN4s9+JP9D+uT+v
        u5x/ef/5I2XDXd+kkfqh1c8KgGlq/gbEbOCtRFctyliNdfHGxr3kUcgbeGnrx914
        BzWbLeVdSNNVcE5iAZsZGDCEC0nCMIeVNcctl0Dllk9l36YowjHlHgN5TUqqF1ta
        ResCWamcVlEQ4k8HTJZLa3MIE3iJlwnmJoiXh8dNKkuMDVq/xW1m+/vhXEhUvJSH
        jVmeMDwVM/P3a8Tb/2hcaiblzfVnK2V3wcQzW8mpGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nak5LL
        j7hhbHiQ3bZxbtQxMEyoqmoK2+u/U9XmUMMoc=; b=ea2pzyNyhML2wK/z0O8odQ
        6ude99ahq4hO3z6Kspo4G0O8LWGST+J62JO11HmqUp7CjYjmNFCUjn4Y+sTNJdLn
        3UjWrq4krZjwSj2Lw1VBrMRloGxNyH3nDYybdfccJ/uYWObptf/OlrTQNimE1JZT
        EkP1Bru+1a3cGKwBrjVRvIXkVQM4Hzahp651L0hUPTHXrERbGC9zcWjczgMo4T8h
        nl6Ii051ICABSNgG3jQpj7YLcu71L38xr0Ky7e+LvxmpXbVWZsW79t3am3umfrUF
        43FhB5ZyBaO0OK3T42FI/blnp8Q+5hdByyiaFBfo9e8OyUzfMnOoaxhGgyvPk4PA
        ==
X-ME-Sender: <xms:hVWlYYVr53cB3hUsRMEnoYkT3mph035pFKO1ZloTpfqIZzJTjJjkOQ>
    <xme:hVWlYclhtLS9EXXK1DDxNQPtCVGB3ytwPjypfL9N_vdIpNlQWuRu6uQ2EaMce2_VK
    F_THxC0rEAtiG2G77A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheelgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehtdffledvffegveejgeegvdeujedtteefgfelffehtdetudekteethfet
    keeuudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvght
    vghrrdguvghv
X-ME-Proxy: <xmx:hVWlYcaQVGukXnjV1thivnYKbqj2kj_VF9BQWNV4mUBNeBEmi4jgug>
    <xmx:hVWlYXX0fhxwE5auQvj3nId5W7diEzvBj4LmtcbR1vSb3z9gYdLONw>
    <xmx:hVWlYSn4zj8upU9tYUZ4DZ1CBy_zfTBJWiy33GC_aZWeByA77_ZIkQ>
    <xmx:hVWlYQa8SoRKcrKDWlE9VIg3rxbbH8S1CISuiDkLp00MAf7QoVIltQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 407A427407A2; Mon, 29 Nov 2021 17:34:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4409-g12559b250c-fm-20211129.001-g12559b25
Mime-Version: 1.0
Message-Id: <78db7a00-93a4-46de-8071-2801c84bc171@www.fastmail.com>
In-Reply-To: <YaQseO5kF71vABji@robh.at.kernel.org>
References: <20211108170946.49689-1-sven@svenpeter.dev>
 <YaQseO5kF71vABji@robh.at.kernel.org>
Date:   Mon, 29 Nov 2021 23:34:24 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add Apple dwc3 bindings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review!

On Mon, Nov 29, 2021, at 02:27, Rob Herring wrote:
> On Mon, Nov 08, 2021 at 06:09:45PM +0100, Sven Peter wrote:
>> Apple Silicon SoCs such as the M1 have multiple USB controllers based on
>> the Synopsys DesignWare USB3 controller.
>> References to the ATC PHY required for SuperSpeed are left out for now
>> until support has been upstreamed as well.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>> v1 -> v2:
>>  - added apple,dwc3 bindings instead of a property for the reset quirk
>>    as requested by robh
>> 
>> I think I have to use GPL-2.0 for this binding since it's based
>> on and references snps,dwc3.yaml which is also only GPL-2.0.
>> Otherwise I'd be fine with the usual GPL/BSD dual license as well.
>> 
>>  .../devicetree/bindings/usb/apple,dwc3.yaml   | 64 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/apple,dwc3.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
>> new file mode 100644
>> index 000000000000..fb3b3489e6b2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: GPL-2.0
>
> Dual license please.

I'd like to but I'm not sure if I can do that. This binding is based on
snps,dwc3.yaml and rockchip,dwc3.yaml which are both only GPL-2.0.

>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple Silicon DWC3 USB controller
>> +
>> +maintainers:
>> +  - Sven Peter <sven@svenpeter.dev>
>> +
>> +description:
>> +  On Apple Silicon SoCs such as the M1 each Type-C port has a corresponding
>> +  USB controller based on the Synopsys DesignWare USB3 controller.
>> +
>> +  The common content of this binding is defined in snps,dwc3.yaml.
>> +
>> +allOf:
>> +  - $ref: snps,dwc3.yaml#
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: apple,dwc3
>
> This needs to list all possible compatibles except snps,dwc3 so the 
> schema is applied for any incorrect mixture of compatibles.

Makes sense, will do that for the next version.



Thanks,

Sven
