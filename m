Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81D4D7FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiCNKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCNKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:32:08 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3D612747;
        Mon, 14 Mar 2022 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647253859; x=1678789859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AE49BjDKIr7fQ1ylcAJCvf/EmIu4MWN573wR5DDTssM=;
  b=KazAqrg8+IE6VL7pP5aVklnM3Rhu+y4Nt+eXcUvtwYMjo1pTd6aMnOI2
   xtDMRvUXJUq7Zbu8JTFk9uWYtPrAKdZRN3wf/KbsxVqG352Yika80tYCB
   hXFPiBzcnopxL8gyzfANN+ysbv/bu95nAYUhVUhMsOy2lh4pixdhT5r+B
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Mar 2022 03:30:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:30:56 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:30:55 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:30:49 -0700
Date:   Mon, 14 Mar 2022 16:00:45 +0530
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
Message-ID: <20220314103045.GA31533@hu-pkondeti-hyd.qualcomm.com>
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
 <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
 <20220314032952.GA27561@hu-pkondeti-hyd.qualcomm.com>
 <f1621a67-a0ff-f111-c4da-9401924e7f4a@canonical.com>
 <20220314081613.GA28402@hu-pkondeti-hyd.qualcomm.com>
 <c88396f4-4cfe-d375-1dcd-b34a6496cb06@canonical.com>
 <20220314094054.GB28402@hu-pkondeti-hyd.qualcomm.com>
 <b45b3b7e-e1c0-79b6-81c0-53c70427dd10@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b45b3b7e-e1c0-79b6-81c0-53c70427dd10@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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

On Mon, Mar 14, 2022 at 11:08:05AM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2022 10:40, Pavan Kondeti wrote:
> > Hi Krzysztof,
> > 
> > Thanks for your suggestions and guidance on this.
> > 
> > On Mon, Mar 14, 2022 at 09:36:02AM +0100, Krzysztof Kozlowski wrote:
> >> On 14/03/2022 09:16, Pavan Kondeti wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Mon, Mar 14, 2022 at 08:39:57AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 14/03/2022 04:29, Pavan Kondeti wrote:
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> On Thu, Mar 03, 2022 at 04:59:22PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 03/03/2022 07:13, Sandeep Maheswaram wrote:
> >>>>>>> Add device tree bindings for SNPS phy tuning parameters.
> >>>>>>>
> >>>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>>>>>> ---
> >>>>>>>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
> >>>>>>>  1 file changed, 125 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> >>>>>>> index 0dfe691..227c097 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> >>>>>>> @@ -50,6 +50,131 @@ properties:
> >>>>>>>    vdda33-supply:
> >>>>>>>      description: phandle to the regulator 3.3V supply node.
> >>>>>>>  
> >>>>>>> +  qcom,hs-disconnect:
> >>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>>>> +    description:
> >>>>>>> +      This adjusts the voltage level for the threshold used to
> >>>>>>> +      detect a disconnect event at the host. Possible values are.
> >>>>>>
> >>>>>> ':', instead of full stop.
> >>>>>>
> >>>>>>> +      7 -> +21.56%
> >>>>>>> +      6 -> +17.43%
> >>>>>>> +      5 -> +13.32%
> >>>>>>> +      4 -> +9.73%
> >>>>>>> +      3 -> +6.3
> >>>>>>> +      2 -> +3.17%
> >>>>>>> +      1 -> 0, Design default%
> >>>>>>
> >>>>>> Use "default:" instead. Here and in other places.
> >>>>>>
> >>>>>>> +      0 -> -2.72%
> >>>>>>
> >>>>>> In current form this should be an enum... but actually current form is
> >>>>>> wrong. You should not store register values in DT. What if next version
> >>>>>> of hardware has a different meaning of these values?
> >>>>>>
> >>>>>> Instead, you should store here meaningful values, not register values.
> >>>>>>
> >>>>>
> >>>>> Thanks for the feedback.
> >>>>>
> >>>>> The values in % really makes the tuning easy. People look at the eye diagram
> >>>>> and decided whether to increase/decrease the margin. The absolute values
> >>>>> may not be that useful. All we need is an "adjustment" here. The databook
> >>>>> it self does not give any absolute values.
> >>>>>
> >>>>> I agree to the "enum" suggestion which we have been following for the
> >>>>> qusb2 driver already. 
> >>>>>
> >>>>> The values have not changed in the last 5 years for this hardware block, so
> >>>>> defining enums for the % values would be really helpful. 
> >>>>
> >>>> I did not say you cannot store here percentages. Quite opposite - store
> >>>> here the percentages. Just do not store register value. No. Please read
> >>>> my comment again - meaningful values are needed.
> >>>>
> >>>
> >>> IIUC, you are asking us to come up with a meaningful values to encode the
> >>> percentage values. However, all the % increments are not linear, so we can't
> >>> come up with {min, max} scheme. Lets take an example of hostdisconnect
> >>> threshold.
> >>>
> >>> As per the data book,
> >>>
> >>> +      7 -> +21.56%
> >>> +      6 -> +17.43%
> >>> +      5 -> +13.32%
> >>> +      4 -> +9.73%
> >>> +      3 -> +6.3
> >>> +      2 -> +3.17%
> >>> +      1 -> 0, Design default%
> >>> +      0 -> -2.72%
> >>>
> >>> so how do we give meaningful values here? Does the below scheme make sense
> >>> to you?
> >>
> >> By "meaningful value" I mean something which has a understandable
> >> meaning to reader of this code or to hardware designer. For example
> >> percentage values or some units (ms, ns, Hz, mA, mV). The value used in
> >> register is not meaningful in that way to us because it has a meaning
> >> only to the hardware block. Storing register values is more difficult to
> >> read later, non-portable and non-scalable.
> >>
> >>>
> >>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_NEG_2P72	(-272)
> >>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_DEFAULT	0
> >>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_3P17	317
> >>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_6P3	63
> >>
> >> This is some define in driver, does not look related to bindings.
> >>
> >>> In the driver, we have a mapping (which can be per SoC if required in future)
> >>> that takes these values and convert to the correct values for a given
> >>> register.
> >>
> >> You focus on driver but I am talking here only about bindings.
> > 
> > I was saying we define those defines in include/dt-bindings/phy/... header and
> > use it in the device tree and as well in the driver.
> 
> Ah, I did not get it. That's not the solution for this case. defines in
> dt-bindings are for constants which already can be in DT, e.g. IDs. Your
> register values should not be stored in DT.
> 
These are again not register definitions. These are encodings that dT and
driver can use. These would be constants only, no?

> > 
> >>
> >> What could be the meaningful value? Percentage could work. You have
> >> there a negative value, so I wonder what type of percentage is it? What
> >> is the formula?
> > 
> > I just multiplied by 100 since device tree has no support for floating (as per
> > my knowledge). The negative value represents it lowers the disconnect
> > threshold by 2.72% of the default value. if it makes sense, we could also
> > start from 0 like below.
> 
> ok
> 
> > 
> > #define QCOM_SNPS_FEMTO_HS_DISCONNECT_NEG_2P72_PCT 0
> > #define QCOM_SNPS_FEMTO_HS_DISCONNECT_DEFAULT	1
> > #define QCOM_SNPS_FEMTO_HS_DISCONNECT_3P17_PCT	2
> > #define QCOM_SNPS_FEMTO_HS_DISCONNECT_6P3_PCT	3
> > 
> > The driver can have a table to map these bindings. This looks much better
> > than those x100 formula values.
> 
> Again mention driver how he can map it. I mostly don't care about the
> driver. :)
> 
> I think we are getting around the problem, so to emphasize again: do not
> store register values in the bindings/DT but its meaning, so in your
> case most likely percentages (or permille or ratio or some other value).
> 

I am really confused on what is that you mean by not storing the registers
here. We are only giving enum values for specific percentages supported by
the PHY. if you see -2.72 corresponds to 0 value on 0:2 bits of a register.
I did not mention that in the device tree. we are giving constant values
(enums) for all the possible percentage values. The user can see the
dt-bindings file and pass the approriate value based on the compliance
results. What is the objection?

can you please give an example if you have something in mind? 

Thanks,
Pavan
