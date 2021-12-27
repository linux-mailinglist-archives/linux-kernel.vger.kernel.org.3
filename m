Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8222548012E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhL0PyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhL0PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:51:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D69C08EB28;
        Mon, 27 Dec 2021 07:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF34B810CC;
        Mon, 27 Dec 2021 15:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B53C36AF9;
        Mon, 27 Dec 2021 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640619966;
        bh=QwJfSm+dlg50xDEsydpdzN4VFxUQiYUIsoIRz08YMpg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UpNtBCf/OSSo+OjXWy5CHI0rUBlJiHe9NYOvMIYd+2s3K8a8aiZnK/5e6E/1btRE7
         K2tOD668hW2a61Ji8ieOavw2g5+KEbNOkyd4m5amAMN4RnkyW7oVEiaT1gWPuPLUM7
         gm8hqWqxUmeRNAXHYOfQ7HHphkcJ/IZrYdy12C9ETB2K2r81F1A9hCC5xZwruhIK1q
         TtgnxcEROb3vn4onjDE9iFof2sX/CkaQqneni5PdXBOFLQ4TEWXievaRFkCKqu0mUp
         bt0D8ddTYSeAXLoxxKfDfyBAZ4wfiLk4jM3vdlCRf9TuqUU3hhnw9m6LZxEeI0PjHO
         zqa+1d8/B0OfQ==
Received: by mail-ed1-f49.google.com with SMTP id q14so55430983edi.3;
        Mon, 27 Dec 2021 07:46:05 -0800 (PST)
X-Gm-Message-State: AOAM532tHl5UtikWtiLWoY8T0WZL2I69ahmM8oxAxE/le01VV3OqAbV5
        7V2ki0sYBvCcRTjX/RcqzPkHezZBUvi6XxlHtw==
X-Google-Smtp-Source: ABdhPJwMStdwgjE2OH4uiH+Ziep31Wwjs0Ml2x3toG+q5+RE5DPVmHHn5GkiKuZKENGJU9ACKddmGxQdY+Y8EOr4ubk=
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr17057660edv.109.1640619964379;
 Mon, 27 Dec 2021 07:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com> <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13230483733ECB77304EC416A5429@DM6PR21MB1323.namprd21.prod.outlook.com>
In-Reply-To: <DM6PR21MB13230483733ECB77304EC416A5429@DM6PR21MB1323.namprd21.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Dec 2021 11:45:51 -0400
X-Gmail-Original-Message-ID: <CAL_JsqLuwvxkxeOmZQVOpMX_aA83LzEc4Tg+bkcFp3mUZYiTKw@mail.gmail.com>
Message-ID: <CAL_JsqLuwvxkxeOmZQVOpMX_aA83LzEc4Tg+bkcFp3mUZYiTKw@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 10:54 AM Jarrett Schultz
<jaschultz@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, December 21, 2021 5:24 PM
> > To: Jarrett Schultz <jaschultzms@gmail.com>
> > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Hans de
> > Goede <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>;
> > Maximilian Luz <luzmaximilian@gmail.com>; Felipe Balbi
> > <balbi@kernel.org>; linux-arm-msm@vger.kernel.org; platform-driver-
> > x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; Jarrett Schultz <jaschultz@microsoft.com>
> > Subject: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> > microsoft: Document surface xbl
> >
> > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > >
> > > Introduce yaml for surface xbl driver.
> > >
> > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > >
> > > ---
> > >
> > > Changes in v4:
> > >  - Addressed small formatting changes
> > >  - Removed unnecessary lines
> > >
> > > ---
> > >
> > > Changes in v3:
> > >  - Updated description to only pertain to the hardware
> > >  - Updated the required field to properly reflect the binding
> > >  - Removed the first example
> > >  - Fixed the size of the reg field in the second example
> > >
> > > ---
> > >
> > > Changes in v2:
> > >  - Removed json-schema dependence
> > >  - Elaborated on description of driver
> > >  - Updated example
> > > ---
> > >  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
> > >  MAINTAINERS                                   |  7 ++
> > >  2 files changed, 71 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/platform/microsoft/surface-
> > xbl.yam
> > > l
> > > b/Documentation/devicetree/bindings/platform/microsoft/surface-
> > xbl.yam
> > > l
> > > new file mode 100644
> > > index 000000000000..df5a87a016f4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl
> > > +++ .yaml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > >
> > +https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > > +cetree.org%2Fschemas%2Fplatform%2Fmicrosoft%2Fsurface-
> > xbl.yaml%23&amp
> > >
> > +;data=04%7C01%7Cjaschultz%40microsoft.com%7C77abe729b69a40624472
> > 08d9c
> > >
> > +4d8f44e%7C72f988bf86f141af91ab2d7cd011db47%7C0%7C0%7C637757258
> > 3887312
> > >
> > +05%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > zIiLCJBTi
> > >
> > +I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jG0qubz122GG2s8%2B
> > 1ZuMCcPIa
> > > +33KWwPoO2VNlDySmvs%3D&amp;reserved=0
> > > +$schema:
> > >
> > +https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cjaschultz
> > >
> > +%40microsoft.com%7C77abe729b69a4062447208d9c4d8f44e%7C72f988bf8
> > 6f141a
> > >
> > +f91ab2d7cd011db47%7C0%7C0%7C637757258388731205%7CUnknown%7C
> > TWFpbGZsb3
> > >
> > +d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%
> > >
> > +7C3000&amp;sdata=FxKNLPok9eW%2FBPmuGzU6x7dPwpnev0Ngr8epO4NA
> > UzA%3D&amp
> > > +;reserved=0
> > > +
> > > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > > +
> > > +maintainers:
> > > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > > +
> > > +description: |
> > > +  Defined to expose information that is used during production when
> > > +  device is in manufacturing mode. Some of the information included
> > > +  in this imem section is -
> >
> > If this is onchip sram, we have a binding for that. That's not an MFD.
> >
> > > +    * board_id
> > > +    * battery_present
> > > +    * hw_init_retries
> > > +    * is_customer_mode
> > > +    * is_act_mode
> > > +    * pmic_reset_reason
> > > +    * touch_fw_version
> > > +    * ocp_error_location
> >
> > nvmem binding doesn't work for describing these fields?
> >
> > > +  See sysfs documentation for more information.
> >
> > sysfs? Not relevant to the binding.
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ranges
> > > +  - address-cells
> > > +  - size-cells
> > > +
> > > +examples:
> > > +  - |
> > > +    / {
> > > +        compatible = "foo";
> > > +        model = "foo";
> >
> > No need to make this the root node with a fake compatible.
>
> I included this root node in order to make #address-cells = #size-cells = 2,
> since this example raises errors otherwise.

Why does your example require 2 cells? You only have 4KB of address space.

Though you can do:

bus {
  #address-cells = <2>;
  #size-cells = <2>;
  ...
};

Rob
