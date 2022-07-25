Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA957FC95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiGYJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGYJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:38:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FBB7C9;
        Mon, 25 Jul 2022 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658741889; x=1690277889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TthBya58gH7epvLwOH5Jw8gF6/uSQB1tBx4AWRwJht8=;
  b=b0LnYgOC3A8u2n/thxdOwXnrety+oNchpSiHnjzoUKd9pVu0CqwSRSDH
   xsuh3sz052aJeInVVgI9I1lHrGGkGl1zz05q3586yuxS80lyEVlgFkApV
   sXhuLKswtKEeyCrsH2JSKMthZlitXS0QXZKb4jnjQBVbp12OqANF3xD0/
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Jul 2022 02:38:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:38:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 02:37:36 -0700
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 02:37:33 -0700
Date:   Mon, 25 Jul 2022 15:07:29 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Document additional
 sa8540p device
Message-ID: <20220725093729.GA19730@hu-ppareek-blr.qualcomm.com>
References: <20220722142515.18592-1-quic_ppareek@quicinc.com>
 <de7fc091-ed12-c585-d39d-2bcf2bda37fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de7fc091-ed12-c585-d39d-2bcf2bda37fe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:27:39PM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2022 16:25, Parikshit Pareek wrote:
> > Add the ADP ride device to the valid device compatibles found on the
> > sa8540p platform.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
My mistake, I missed the tags.
> 
> 
> Additionally - please thread your patchset. Git send-email does it by
> default. If you use other tools - be sure the effect is threaded.
Used git send-email. May be happened due to the change in one of the commit headers in one of the patches.
> Otherwise it is not possible to find the patches from you.
> 
> 
> Best regards,
> Krzysztof
Regards,
Parikshit Pareek
