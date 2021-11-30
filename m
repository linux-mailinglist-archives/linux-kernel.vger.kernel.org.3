Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0B4628F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhK3ASr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:18:47 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43914 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhK3ASr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:18:47 -0500
Received: by mail-oi1-f178.google.com with SMTP id o4so37812908oia.10;
        Mon, 29 Nov 2021 16:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTXlF6Gnm/rT0qldVGXfz0tI0LWvoagfDepzULfghYw=;
        b=jpnIWVJE7+Vl6MZxhVUcuE7ZyqyLEDeJVyeX9k90TgdOhl1+lqn8BN6jmokd1w4A51
         KeLGGI1R9WNZovBrASPN2gKTAir3U7MX5rc7lH1VRTRs43Xe/SHD+16+OUjsrFsqB13f
         wjU5SsqgjjpKJsXEx+HkV5P3OQZ02tgu/SrpGArvwCEz6pnqvtrbetwklTJB79rcN+cw
         ZjL7HjtAcMoC40Tv8SHmtlPwnuIj+oIVpElRdzE3ijyRWh1vnqDFEOMUyGPC8u7p5sXB
         hSmGsQWA+O21je4oudcuthF7Z6vR6I2IG2Gty0hk73fb/l8+sokwYxAb7tOdjr2gnXh6
         5eiA==
X-Gm-Message-State: AOAM533Vjt4GtkjWSWgBKFnsqPKH1UY1lPqkB93dMNe8Sfc8uYyQ3v9T
        5y64toZEzA1LYVy+CqpZRw==
X-Google-Smtp-Source: ABdhPJzWvVLBFUM1w9MIGxp1dvanjID+SCvk9UvCvwk3mkyhqzj1CD5wwDV8UPTwhuCcK/jo7SmJvA==
X-Received: by 2002:a05:6808:1381:: with SMTP id c1mr1161897oiw.129.1638231328337;
        Mon, 29 Nov 2021 16:15:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg38sm3563993oib.40.2021.11.29.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:15:27 -0800 (PST)
Received: (nullmailer pid 875053 invoked by uid 1000);
        Tue, 30 Nov 2021 00:15:26 -0000
Date:   Mon, 29 Nov 2021 18:15:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     git@xilinx.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3-xilinx: Convert USB DWC3 bindings
Message-ID: <YaVtHpb5kQk9xduz@robh.at.kernel.org>
References: <1637329568-31756-1-git-send-email-manish.narani@xilinx.com>
 <1637341102.285159.4078689.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637341102.285159.4078689.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:58:22AM -0600, Rob Herring wrote:
> On Fri, 19 Nov 2021 19:16:08 +0530, Manish Narani wrote:
> > Convert USB DWC3 bindings to DT schema format using json-schema.
> > 
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/usb/dwc3-xilinx.txt        |  56 ----------
> >  .../devicetree/bindings/usb/dwc3-xilinx.yaml       | 119 +++++++++++++++++++++
> >  2 files changed, 119 insertions(+), 56 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1557119
> 
> 
> usb@ff9d0000: 'phy-names', 'phys' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml

Looks like the schema is missing some properties.

> 
> usb@ff9d0000: usb@fe200000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml
> 
> usb@ff9e0000: 'phy-names', 'phys' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
> 
> usb@ff9e0000: usb@fe300000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml
> 
> 
