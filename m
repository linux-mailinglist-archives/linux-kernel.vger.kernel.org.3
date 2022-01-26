Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB949C2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiAZE3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiAZE25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:28:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E5C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:28:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q186so35322194oih.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bzD015SK842VFv5zijZ4K4/KS4tSbmpuXyJm0B+Y8T8=;
        b=QXzEiw7J7mU7JuGXHrCH+HFIPcLVZPbwBE9WxzaOQlbdSLHgLfmn7aKJjq6rgA8NOV
         WsS6Q0lrgqDd3P9epYwpP73IZStPuWb93R8eZ+b/UTOy7khMMTC7iao/BM0N7luU1/xK
         fAwMC9tDKVgeR7+AjvJsn2DeFpL4qUXNF+z8IBV+0Jd4iEBYlgYcUH8yFYA+GzkL2AQl
         Z+l1om8Ufe31vTgdmTqVSg3O/SyHoJpQG8CGidhF7Ev0RijJdMFpvYS+lJMnNZx+uKzn
         xUP6+kwExJg0mqUsu+R3LxA2gEZbN45MKjCWMddBartB3w+s95GCNXN21NSUCko8s4NT
         jSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bzD015SK842VFv5zijZ4K4/KS4tSbmpuXyJm0B+Y8T8=;
        b=E6ogLKCUb60Mu1S4/YFMnlEwQWyMMTDhbT1ats/Z8hdhfDzthyxtRbk9BuLXFld6yH
         ml4RpVFXH5ZTnzXLrNg9mSmWv4EU3Po8DuuiesChohtH5BYd1EVS65UVfvtd9FkE7gyc
         nNfG9FZ8OY1BYhclyItzSQr+n1S5O493Hnkz67TaB9sTau6anJsuxaQgxoXMnzDz/d46
         XcLVhUOJC9irOSaD9DDxxVOEx9V5UF6MS0GtTPqcMFfnyb3R5lGWdIGpTyiu/9DGWlrS
         H+Mpalr7HQuPTswLpZufKu9QAA0+uOhtG6JUXAzlI0GfGsqA2vMIvGa/iC6u2wkkF1UP
         hhrg==
X-Gm-Message-State: AOAM532f1MCro/RON8t5DI+FGeyNcR1Wm8qYrGExu4U012sin6Fx5Oiu
        emABenvWtTa7MIYbHCsqpKk36w==
X-Google-Smtp-Source: ABdhPJwtjms72VHZkyl/fIywSWUWB72NU+oT59nSW9dXTHEA2zSK+gAh48hdlP8/z5dNcc3SZRhXIA==
X-Received: by 2002:a05:6808:130b:: with SMTP id y11mr2838114oiv.51.1643171336440;
        Tue, 25 Jan 2022 20:28:56 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c21sm1316166oto.55.2022.01.25.20.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:28:55 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:28:54 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_satyap@quicinc.com, quic_pheragu@quicinc.com,
        quic_rjendra@quicinc.com, quic_sibis@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V4 4/6] arm64: dts: qcom: sc7280: Add EUD dt node and
 dwc3 connector
Message-ID: <YfDOBuT/9dEEDG6/@builder.lan>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <3ca56ffa9e4aa73f3c3f36d0edad0827ee11d953.1642768837.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca56ffa9e4aa73f3c3f36d0edad0827ee11d953.1642768837.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:

> Add the Embedded USB Debugger(EUD) device tree node. The
> node contains EUD base register region and EUD mode
> manager register regions along with the interrupt entry.
> Also add the typec connector node for EUD which is attached to
> EUD node via port. EUD is also attached to DWC3 node via port.
> Also add the role-switch property to dwc3 node.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 39 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 937c2e0..daac831 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2583,6 +2583,14 @@
>  				phys = <&usb_2_hsphy>;
>  				phy-names = "usb2-phy";
>  				maximum-speed = "high-speed";
> +				usb-role-switch;
> +				ports {
> +					port@0 {
> +						usb2_role_switch: endpoint {
> +							remote-endpoint = <&eud_ep>;
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> @@ -2624,6 +2632,37 @@
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		eud: eud@88e0000 {
> +			compatible = "qcom,sc7280-eud","qcom,eud";
> +			reg = <0 0x88e0000 0 0x2000>,
> +			      <0 0x88e2000 0 0x1000>;
> +			interrupt-parent = <&pdc>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;

I find "interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;" cleaner
than having to specify both parent and interrupts.

> +			ports {
> +				port@0 {
> +					eud_ep: endpoint {
> +						remote-endpoint = <&usb2_role_switch>;
> +					};
> +				};
> +				port@1 {
> +					eud_con: endpoint {
> +						remote-endpoint = <&con_eud>;
> +					};
> +				};
> +			};
> +		};
> +
> +		eud_typec: connector {

The connector should be a child of the Type-C controller, which I know
differs between the various devices on this platform. So you should
leave &eud_con without a remote-endpoint and then fill that in for each
device, based on respective Type-C controller.


But beyond that, I think this design looks good now!

Regards,
Bjorn

> +			compatible = "usb-c-connector";
> +			ports {
> +				port@0 {
> +					con_eud: endpoint {
> +						remote-endpoint = <&eud_con>;
> +					};
> +				};
> +			};
> +		};
> +
>  		nsp_noc: interconnect@a0c0000 {
>  			reg = <0 0x0a0c0000 0 0x10000>;
>  			compatible = "qcom,sc7280-nsp-noc";
> -- 
> 2.7.4
> 
