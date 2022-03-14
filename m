Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B134D79A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiCNDbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiCNDbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:31:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD601245BE;
        Sun, 13 Mar 2022 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647228604; x=1678764604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTigVYPVCkuHRdanPQILHhd3eQaHPFWGn2HDxmows44=;
  b=KODfWs9QFlw8I5ttSp85pdWFiJ/J9vIhAiZ/xBQeLvdqMTrk8VyjyxNL
   CHI6TkZMpZ10mMq+iq2Z/6QQKSmEMpsTlgmIcWpzIAKu2yKlbpuYMNdAB
   paVjJ93Q+SGLXfxYb/dHmoHDlw9yJRJUvN0shh5+9RKCiyIbqr4rLZTWv
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Mar 2022 20:30:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 20:30:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Mar 2022 20:30:02 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Mar 2022 20:29:56 -0700
Date:   Mon, 14 Mar 2022 08:59:52 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Message-ID: <20220314032952.GA27561@hu-pkondeti-hyd.qualcomm.com>
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
 <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Mar 03, 2022 at 04:59:22PM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2022 07:13, Sandeep Maheswaram wrote:
> > Add device tree bindings for SNPS phy tuning parameters.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > index 0dfe691..227c097 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > @@ -50,6 +50,131 @@ properties:
> >    vdda33-supply:
> >      description: phandle to the regulator 3.3V supply node.
> >  
> > +  qcom,hs-disconnect:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This adjusts the voltage level for the threshold used to
> > +      detect a disconnect event at the host. Possible values are.
> 
> ':', instead of full stop.
> 
> > +      7 -> +21.56%
> > +      6 -> +17.43%
> > +      5 -> +13.32%
> > +      4 -> +9.73%
> > +      3 -> +6.3
> > +      2 -> +3.17%
> > +      1 -> 0, Design default%
> 
> Use "default:" instead. Here and in other places.
> 
> > +      0 -> -2.72%
> 
> In current form this should be an enum... but actually current form is
> wrong. You should not store register values in DT. What if next version
> of hardware has a different meaning of these values?
> 
> Instead, you should store here meaningful values, not register values.
> 

Thanks for the feedback.

The values in % really makes the tuning easy. People look at the eye diagram
and decided whether to increase/decrease the margin. The absolute values
may not be that useful. All we need is an "adjustment" here. The databook
it self does not give any absolute values.

I agree to the "enum" suggestion which we have been following for the
qusb2 driver already. 

The values have not changed in the last 5 years for this hardware block, so
defining enums for the % values would be really helpful. 

> 
> > +
> > +  qcom,squelch-detector:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This adjusts the voltage level for the threshold used to
> > +      detect valid high-speed data. Possible values are
> > +      7-> -20.90%
> > +      6-> -15.60%
> > +      5-> -10.30%
> > +      4-> -5.30%
> > +      3-> 0, Design default%
> > +      2-> +5.30%
> > +      1-> +10.60%
> > +      0-> +15.90%
> > +
> > +  qcom,hs-amplitude:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This adjusts the high-speed DC level voltage.
> > +      Possible values are
> > +      15-> +26.70%
> > +      14-> +24.30%
> > +      13-> +22.20%
> > +      12-> +20.00%
> > +      11-> +17.80%
> > +      10-> +15.60%
> > +      9-> +13.30%
> > +      8-> +11.10%
> > +      7-> +8.90%
> > +      6-> +6.50%
> > +      5-> +4.40%
> > +      4-> +2.30%
> > +      3-> 0, Design default%
> > +      2-> -2.20%
> > +      1-> -4.40%
> > +      0-> -6.60%
> > +
> > +  qcom,pre-emphasis-duration:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This signal controls the duration for which the
> > +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
> > +      The HS Transmitter pre-emphasis duration is defined in terms of
> > +      unit amounts. One unit of pre-emphasis duration is approximately
> > +      650 ps and is defined as 1X pre-emphasis duration.
> > +      Possible values are
> > +      1-> 1x, short pre-emphasis current duration
> > +      0-> 2x, long pre-emphasis current duration
> 
> I could understand encoding of percentages in way of register value, but
> a boolean flag is too much.
> 

Agreed. This needs to be encoded in % as well (100% or 200%).

Thanks,
Pavan
