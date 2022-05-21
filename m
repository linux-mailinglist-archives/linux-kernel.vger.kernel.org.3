Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A252F809
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiEUD2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiEUD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:28:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ABF17856B;
        Fri, 20 May 2022 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653103728; x=1684639728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0LDXVKVdyKs0GAHKkPbR5zauQdlYZvFTlw+hJZ4BOLc=;
  b=PVahPzGcmj2rvYjndNmPbHYpETu2GMMHzIcM1fryh1vZ1vT3SInKsOfQ
   F5OcxuED1VKd6Y4uPHGCBKyTy6r7f8a9coszg1zD38Uao8yn/6jmp/ZtC
   wKrX3V7e+KOIEGSpUoDzLF/Z87mDofpZmi4TFHUgYza693nUM39nlXP+0
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 May 2022 20:28:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 20:28:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 20:28:47 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 20:28:43 -0700
Date:   Sat, 21 May 2022 08:58:39 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
Subject: Re: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220521032839.GA15121@hu-pkondeti-hyd.qualcomm.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsh,

On Thu, May 19, 2022 at 06:04:54PM +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num-ssphy and num-hsphy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index f4471f8..39c61483 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -341,6 +341,35 @@ properties:
>        This port is used with the 'usb-role-switch' property  to connect the
>        dwc3 to type C connector.
>  
> +  multiport:
> +    description:
> +      If a single USB controller supports multiple ports, then it's referred to as
> +      a multiport controller. Each port of the multiport controller can support
> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
> +      port is represented by "mport" node and all the "mport" nodes are grouped
> +      together inside the "multiport" node where individual "mport" node defines the
> +      PHYs supported by that port.
> +    required:
> +      - mport
> +
> +  num-hsphy:
> +    description: Total number of HS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num-ssphy:
> +    description: Total number of SS-PHYs defined by the multiport controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
Do we need this properties at all? Atleast your next patch in this series is
not parsing those properties. The idea I believe is to maintain the same
usb-phy / phys semantics as of today. i.e we expect first PHY to be USB2 PHY
and 2nd PHY to be USB3 PHY. Obviously, we need to make sure that all ports
defined under multiport node are passing PHYs without any holes. For example,
if the controller has 3 ports and passing phys for 1st and 3rd port is not
acceptible. In any case we need to know the number of HS and SS PHYs so that 
the GUSB2PHYCFG/GUSB3PIPECTL are configured correctly, irrespective of how we
handle phy(s) in this node.

Can you please clarify on the need for num-hsphy and num-ssphy and what
happens for USB2 only ports?

> +  mport:
> +    description: Each mport node represents one port of the multiport controller.
> +    patternProperties: "^mport@[0-9a-f]+$"
> +    oneOf:
> +       - required:
> +         - usb-phy
> +       - required:
> +          - phys
> +          - phy-names
> +

Thanks,
Pavan
