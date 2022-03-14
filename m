Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB94D8074
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiCNLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiCNLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:14:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EC61DA76;
        Mon, 14 Mar 2022 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647256406; x=1678792406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfBrAu+qBaUATnWxIS1MDajha/eQ14Gcbh4gLGvfVKs=;
  b=ygRPhWKW2zdGa7NWBBZLqwXMJkWlB4dlfuqXPYgQfkQfy03ApqreiRC5
   ZSvTRcJ/efRXK0yI/W1ixkALcnxCTCQsWLIdynZSy3LItSvdx+VwdL2Pg
   yVIosPULl8kvvOtHdd5JmK8TaZxbktDP2QPl9wV4ZLuH9lg2GhVeZ0HYq
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Mar 2022 04:13:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 04:13:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 04:13:24 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 14 Mar 2022 04:13:18 -0700
Date:   Mon, 14 Mar 2022 16:43:13 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Message-ID: <20220314111313.GA6889@hu-pkondeti-hyd.qualcomm.com>
References: <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
 <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
 <20220314032952.GA27561@hu-pkondeti-hyd.qualcomm.com>
 <f1621a67-a0ff-f111-c4da-9401924e7f4a@canonical.com>
 <20220314081613.GA28402@hu-pkondeti-hyd.qualcomm.com>
 <c88396f4-4cfe-d375-1dcd-b34a6496cb06@canonical.com>
 <20220314094054.GB28402@hu-pkondeti-hyd.qualcomm.com>
 <b45b3b7e-e1c0-79b6-81c0-53c70427dd10@canonical.com>
 <20220314103045.GA31533@hu-pkondeti-hyd.qualcomm.com>
 <fadbc93f-8741-58c6-d0e5-dc740e0f0724@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fadbc93f-8741-58c6-d0e5-dc740e0f0724@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On Mon, Mar 14, 2022 at 11:41:27AM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2022 11:30, Pavan Kondeti wrote:
> > Hi Krzysztof,
> > 
> >>
> >> Ah, I did not get it. That's not the solution for this case. defines in
> >> dt-bindings are for constants which already can be in DT, e.g. IDs. Your
> >> register values should not be stored in DT.
> >>
> > These are again not register definitions. These are encodings that dT and
> > driver can use. These would be constants only, no?
> 
> What do you mean it is not a register value? I don't have access to
> datasheet/manual but I can clearly see code:
> 
> +	if (or->hs_disconnect.override)
> +		qcom_snps_hsphy_write_mask(hsphy->base,
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> +			HS_DISCONNECT_MASK,
> +			or->hs_disconnect.value << HS_DISCONNECT_SHIFT);
> 
> You read the value from DT (e.g. "3" which means 6.3% for hs-disconnect)
> and you write it to a register. Directly. 3 is a value for the hardware,
> meaningless outside of it. It has meaning only in this one hardware
> programming model. For humans it means nothing. For humans 6.3% means
> something.
> 

Right, This is what I have been saying will change. we don't pass the direct
register values anymore. Instead I am saying, we pass the percentage
multiplied by 100. For 6.3%, user will be passing 630 in device tree. for
-2.75% user will pass (-275).

Are we on the same page now?

Thanks,
Pavan
