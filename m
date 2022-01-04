Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA2484A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiADWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:00:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57120 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiADWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:00:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7477E615C8;
        Tue,  4 Jan 2022 22:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C4AC36AF4;
        Tue,  4 Jan 2022 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641333618;
        bh=0bNxva3vPLAvYpaAdpSuepoaCoKQQipx/GhAyegGbVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t+rXhHoLcOHJduijqYNRY8tlpXzVWh0KpYwk+rx6CkDbHFw6BWoQfc3dXLlcl/QFx
         +kV+Z7BT64/xARfJOKkWifeu1AMyYJQFKfDHff+o/mgKAweYD+zH9+BhF7dptkNUTO
         nI16YYjiCtACLrBZm7/ov98Ng3uHL5BBAyLMShiwuB5RxbHeTHQRyQpmOmLVPUEovT
         DN+JF6bvRZwQCMyf2cNGPiOAUpMrNS6xvU/Nd+aaukmpYWRd3n481vuST5NmH43RyZ
         DS3j1/aSAmWDAE4RVWLmiplHP5EnM9TQhn3QRQY/7v6RYL2suv8cYkTnjMw+oBjjrm
         yNlw7OhM0TWbw==
Received: by mail-ed1-f45.google.com with SMTP id f5so153927066edq.6;
        Tue, 04 Jan 2022 14:00:18 -0800 (PST)
X-Gm-Message-State: AOAM532lvLx0HMzogq+aAIA0KxyW70vfzP2Lxmqn/PvFTAwsSUfHb88c
        ow41PJCBhXJbuLN0KAimiYnL/P1N4rXQ0jbo7g==
X-Google-Smtp-Source: ABdhPJw1uhAiPnnIERGD8hUffX/5WwGrUbcSjfKqItL4XiR/0tBUqdIOj8MPuwRwRufmD5fbyNpWQWkXeqIby6m9mbY=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr41415818ejc.325.1641333617085;
 Tue, 04 Jan 2022 14:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com> <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13230483733ECB77304EC416A5429@DM6PR21MB1323.namprd21.prod.outlook.com>
 <CAL_JsqLuwvxkxeOmZQVOpMX_aA83LzEc4Tg+bkcFp3mUZYiTKw@mail.gmail.com> <DM6PR21MB1323319815EFD885339C8F9BA5429@DM6PR21MB1323.namprd21.prod.outlook.com>
In-Reply-To: <DM6PR21MB1323319815EFD885339C8F9BA5429@DM6PR21MB1323.namprd21.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Jan 2022 16:00:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPq=B+DEGFvg_JNvDiZiig-wGetNJ4u8ssnJV_ADp4QQ@mail.gmail.com>
Message-ID: <CAL_JsqJPq=B+DEGFvg_JNvDiZiig-wGetNJ4u8ssnJV_ADp4QQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
To:     Jarrett Schultz <jaschultz@microsoft.com>
Cc:     Jarrett Schultz <jaschultzms@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:17 AM Jarrett Schultz
<jaschultz@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, December 27, 2021 9:46 AM
> > To: Jarrett Schultz <jaschultz@microsoft.com>
> > Cc: Jarrett Schultz <jaschultzms@gmail.com>; Andy Gross
> > <agross@kernel.org>; bjorn.andersson@linaro.org; Hans de Goede
> > <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Maximilian
> > Luz <luzmaximilian@gmail.com>; Felipe Balbi <balbi@kernel.org>; linux-arm-
> > msm@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> > microsoft: Document surface xbl

Please fix your mail client reply style.

> >
> > On Mon, Dec 27, 2021 at 10:54 AM Jarrett Schultz
> > <jaschultz@microsoft.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rob Herring <robh@kernel.org>
> > > > Sent: Tuesday, December 21, 2021 5:24 PM
> > > > To: Jarrett Schultz <jaschultzms@gmail.com>
> > > > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Hans
> > > > de Goede <hdegoede@redhat.com>; Mark Gross
> > <markgross@kernel.org>;
> > > > Maximilian Luz <luzmaximilian@gmail.com>; Felipe Balbi
> > > > <balbi@kernel.org>; linux-arm-msm@vger.kernel.org; platform-driver-
> > > > x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; Jarrett Schultz
> > > > <jaschultz@microsoft.com>
> > > > Subject: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> > > > microsoft: Document surface xbl
> > > >
> > > > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > > > >
> > > > > Introduce yaml for surface xbl driver.
> > > > >
> > > > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v4:
> > > > >  - Addressed small formatting changes
> > > > >  - Removed unnecessary lines
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > >  - Updated description to only pertain to the hardware
> > > > >  - Updated the required field to properly reflect the binding
> > > > >  - Removed the first example
> > > > >  - Fixed the size of the reg field in the second example
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >  - Removed json-schema dependence
> > > > >  - Elaborated on description of driver
> > > > >  - Updated example
> > > > > ---
> > > > >  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
> > > > >  MAINTAINERS                                   |  7 ++
> > > > >  2 files changed, 71 insertions(+)  create mode 100644
> > > > > Documentation/devicetree/bindings/platform/microsoft/surface-xbl.y
> > > > > aml
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/platform/microsoft/surface-
> > > > xbl.yam
> > > > > l
> > > > > b/Documentation/devicetree/bindings/platform/microsoft/surface-
> > > > xbl.yam
> > > > > l
> > > > > new file mode 100644
> > > > > index 000000000000..df5a87a016f4
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/platform/microsoft/surface
> > > > > +++ -xbl
> > > > > +++ .yaml
> > > > > @@ -0,0 +1,64 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > > +1.2
> > > > > +---
> > > > > +$id:
> > > > >
> > > >
> > +https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fde
> > > > +vi
> > > > > +cetree.org%2Fschemas%2Fplatform%2Fmicrosoft%2Fsurface-
> > > > xbl.yaml%23&amp

And this...

Or trim the context if not relevant to the discussion.

[...]

> > > > > +examples:
> > > > > +  - |
> > > > > +    / {
> > > > > +        compatible = "foo";
> > > > > +        model = "foo";
> > > >
> > > > No need to make this the root node with a fake compatible.
> > >
> > > I included this root node in order to make #address-cells =
> > > #size-cells = 2, since this example raises errors otherwise.
> >
> > Why does your example require 2 cells? You only have 4KB of address space.
>
> The soc node that imem sits under in sm8150.dtsi defines it that way so for
> continuity I figured that it would make sense for the example to mirror that.

It's just an example. If you are just duplicating dts files, why have examples?

>
> Also, should imem and xbl be documented in separate files?

No. That depends more on the size of the schema. So it's a judgment
call typically.

Rob
