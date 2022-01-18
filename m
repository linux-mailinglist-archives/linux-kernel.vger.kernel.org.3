Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7612749207D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiARHsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiARHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:48:11 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89924C061574;
        Mon, 17 Jan 2022 23:48:11 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JdLVK1jB8zQkJY;
        Tue, 18 Jan 2022 08:48:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642492085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdrh7JMMskk1D7DPn1o6UnDg1e908QjhDspXyheNBpE=;
        b=HA8K9SBBTtJi3LI6KacVw+7w9v3AOesGgibSpBq0fIJzulWfySF8gJuDInz0l1yX5rxKZy
        Rfqr+B8aHhh6KHFvWdvbmG1p36GN7ok1jOIZY2G5EVpadzykUHv9XZxQyKdZk/lQqJ6Yzi
        mK3s4/xZMIjWAGKaog+erOJvUxL0Rj6vXecvcnIGphejWhnb66E/dsshDyb6FB8VTGRrDh
        ACvBJ7iIuqIZtMc/zF2XIZaRlRmaXcL2XCeTAAzjgVQbxyUf4XlM7IsDr3K1yRnWEsPpev
        XfotI29fe31IUp6xna43PtMRFFMf4f/zNSYZJzyhF7sDclwk8h2tcGsNTI/y3w==
Message-ID: <b486698dd93e5056db397d5ae0da31b0e82bec88.camel@sylv.io>
Subject: Re: [PATCH v1 2/4] dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus
 Converter
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jan 2022 08:48:01 +0100
In-Reply-To: <e5ddd3f1-61c9-862d-8973-484c91b7718e@roeck-us.net>
References: <cover.1642434222.git.sylv@sylv.io>
         <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
         <e5ddd3f1-61c9-862d-8973-484c91b7718e@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 09:06 -0800, Guenter Roeck wrote:
> On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
> > Add bindings for BCM6123 Bus Converter from Vicor Corporation.
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Can this be added to trivial devices instead ?
> 
> Guenter

Indeed. Thanks.

Marcello

> 
> > ---
> >   .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++++++++++++
> >   1 file changed, 41 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> > new file mode 100644
> > index 000000000000..5559d22e00f1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/pmbus/vicor,bcm6123.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Vicor Corporation BCM6123 Bus Converter
> > +
> > +description: |
> > +  The BCM6123 is an isolated Fixed-Ratio DC-DC Converter,
> > +  operating from a 260V to 410V primary bus to deliver an unregulated
> > +  ratiometric secondary voltage.
> > +
> > +  Datasheet: https://www.vicorpower.com/documents/datasheets/ds_BCM6123xD1E5135yzz.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - vicor,bcm6123
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        bcm6123@5f {
> > +            compatible = "vicor,bcm6123";
> > +            reg = <0x5f>;
> > +        };
> > +    };
> > 
> 

