Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947A4C0138
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiBVS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiBVS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:26:21 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5DAEB159;
        Tue, 22 Feb 2022 10:25:55 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so10212588otl.12;
        Tue, 22 Feb 2022 10:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnlhZOUsuCTZiCLLFfPFXU7KusFpj+npdpqQIuQ4k3g=;
        b=8DAaIWGfcCsXiudZW1/oCE4e0BWc6/ZNGj9WrMMrBw1fe6hfXiGN+YxQwbxJJC0GI4
         xDciu102+P00QS+Gq2vKJGxWNCRKJFa7WY2WWs3ip9nwpzAV5UOryxczP768fT068C4M
         GgCSUa6ymQ5StqQ2Xz4ObMELDiliTY9I2zWD86MlUlDwRq+FsUgARKWWTwnea0xS4isG
         S0V1fvrZkAcL/ed90xNYGhZsIaIVte7J8naMHRoyn9hdtxFeACeIOOMSBvUx/a4h3coE
         a4wv4fj5a13qlNBtgwamrQK74U5NlStBHI4WbJZmGOoSbbkktUBzFfW8t2Sb5Y1DktQ6
         a0mQ==
X-Gm-Message-State: AOAM530HyWbl9/OFbCYN0GSdrBwlGx+9f1onXE9mCHcx5hk/ofKq9NM1
        3UGhZ0jBXLqkA5nyflYYAz2mGQqXVw==
X-Google-Smtp-Source: ABdhPJxvH797INbh52DiaCXhOaAp7w6upp9EG0yIg8XsfUWjjE4v7chcy22T1xv/nwCVP7pshlNA6A==
X-Received: by 2002:a05:6830:44e:b0:5af:3b50:8a2a with SMTP id d14-20020a056830044e00b005af3b508a2amr3533718otc.129.1645554354421;
        Tue, 22 Feb 2022 10:25:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i14sm3500075oig.24.2022.02.22.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:25:54 -0800 (PST)
Received: (nullmailer pid 3351185 invoked by uid 1000);
        Tue, 22 Feb 2022 18:25:53 -0000
Date:   Tue, 22 Feb 2022 12:25:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property
 description for SCMI
Message-ID: <YhUqsWRldHcVVmre@robh.at.kernel.org>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <c751add9b54e9661e463ae265d8d5f0314eac33e.1645460043.git.oleksii_moisieiev@epam.com>
 <1645539763.068794.3016153.nullmailer@robh.at.kernel.org>
 <20220222145116.GA2024457@EPUAKYIW015D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145116.GA2024457@EPUAKYIW015D>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:51:16PM +0000, Oleksii Moisieiev wrote:
> On Tue, Feb 22, 2022 at 08:22:43AM -0600, Rob Herring wrote:
> > On Mon, 21 Feb 2022 17:26:47 +0000, Oleksii Moisieiev wrote:
> > > Document scmi_devid property for the devices, using SCMI protocol
> > > to work with clocks/resets/power-domains etc. This property is intended
> > > to set the device id, which should be used to manage device permissions
> > > in the firmware. Device permissions management is descibed in DEN 0056,
> > > Section 4.2.2.10 [0].
> > > 
> > > This property is useful for the virtualized systems, when several agents
> > > are running on the same platform. Agent term is descibed in Section
> > > 4.1.1 [0].
> > > 
> > > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!m_dudHGSVg6mys2GtScvkfHNbQ1mv2kCGeU2GEdcV_C0cqHoWuknIkJPdLTaKiq6Ed9f$ [developer[.]arm[.]com]
> > > 
> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > ---
> > >  .../bindings/firmware/arm,scmi-devid.yaml     | 41 +++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi-devid.example.dt.yaml: example-0: usb@ee0a0000:reg:0: [0, 3993632768, 0, 256] is too long
> > 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1595720__;!!GF_29dbcQIUBPA!m_dudHGSVg6mys2GtScvkfHNbQ1mv2kCGeU2GEdcV_C0cqHoWuknIkJPdLTaKsRHUfCS$ [patchwork[.]ozlabs[.]org]
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> Hi Rob,
> 
> Thank you. I will recheck on my side.

The default address and size cell size for examples are 1 cell.

Rob
