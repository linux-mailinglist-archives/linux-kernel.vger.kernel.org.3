Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FD47356E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhLMT7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:59:22 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45713 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242644AbhLMT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:59:04 -0500
Received: by mail-ot1-f43.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso18590903otf.12;
        Mon, 13 Dec 2021 11:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwkx6tCxLlutVfvteMK8M9m+ba49o8n1PLMUF/zhTEw=;
        b=IkdQ0oR2dbGBecRGATMbR/SsNkENKdywRL0FHChcDVr0YF+E5bXOL+v+4G8vL8s83r
         g0NMAO5qLguo7g635jlDT/oFt6KCfjN2egSuarOB3uNUaPsxddkArU2dVmJUnTvDNU73
         HUF1JHBlFhguVB4dTNrd7ZhIKRxj7jPJSVet2l8r+JnDL4aCqHwL4R4qI8asWBkvwKuY
         nFjsNM5nOFmt5Hutea1IEcbVwdYCJvQzfaIUZP7TogXd9BAFSY73NYTFnDuLOPyYlvoo
         vrYl3U9ix1dhJBvfD5H/zZX1YdCxenA9vdaGSbTJQt189JxI+mpcH96B7dQ5qg11Y+4Y
         S0qw==
X-Gm-Message-State: AOAM530PZhT6Ws4gzP2YhBeWzQrVq43MMkz7DuLDjDBbhKBtzF4EV1E1
        BcOguxsIm+8HOb8J+ODnYg==
X-Google-Smtp-Source: ABdhPJxguPby78NVB+SdqQBtegCOiixjO379DtMQqeU+zZsKKLz3+6s9Gv3VEbsyeLRUEEdGoUsGlg==
X-Received: by 2002:a05:6830:44a4:: with SMTP id r36mr514976otv.365.1639425543186;
        Mon, 13 Dec 2021 11:59:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm2730488oij.16.2021.12.13.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:59:02 -0800 (PST)
Received: (nullmailer pid 1470791 invoked by uid 1000);
        Mon, 13 Dec 2021 19:59:01 -0000
Date:   Mon, 13 Dec 2021 13:59:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, greg@kroah.com,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V2 6/8] arm64: dts: qcom: sc7280: Add EUD dt node and
 dwc3 connector
Message-ID: <YbemBSexMQRCVGYl@robh.at.kernel.org>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <d035e37829c6f9ec8f01d1137020af635e34966f.1638430506.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d035e37829c6f9ec8f01d1137020af635e34966f.1638430506.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:21:25PM +0530, Souradeep Chowdhury wrote:
> Add the Embedded USB Debugger(EUD) device tree node. The
> node contains EUD base register region and EUD mode
> manager register regions along with the interrupt entry.
> Also add the connector to EUD which is mapped as the child
> of dwc3. The connector is attached to EUD via port. Also add
> the role-switch property to dwc3 node.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..2d14e5c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1315,6 +1315,18 @@
>  				phys = <&usb_2_hsphy>;
>  				phy-names = "usb2-phy";
>  				maximum-speed = "high-speed";
> +				usb-role-switch;
> +				usb_con: eud_usb_connector {
> +					compatible = "qcom,usb-connector-eud",
> +						     "usb-c-connector";
> +					ports {
> +						port@0 {

It is already defined that port@0 of the connector is USB HS data. Is 
that the case here? What about the SS lines?

From the description, it sounds like the data path is DWC3 -> EUD -> 
connector. The DT structure doesn't match that.

> +							usb2_role_switch: endpoint {
> +								remote-endpoint = <&eud_ep>;
> +							};
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> @@ -1339,6 +1351,19 @@
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		eud:  eud@88e0000 {
> +			compatible = "qcom,sc7280-eud","qcom,eud";
> +			reg = <0 0x88e0000 0 0x2000>,
> +			      <0 0x88e2000 0 0x1000>;
> +			interrupt-parent = <&pdc>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +			port {
> +				eud_ep: endpoint {
> +					remote-endpoint = <&usb2_role_switch>;
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
> 
