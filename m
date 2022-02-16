Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C54B7EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbiBPDr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:47:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBPDrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:47:25 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34692645;
        Tue, 15 Feb 2022 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644983233; x=1676519233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rpw3z4mr4YAi4etcbDDl1YczzPt53WRqNLudJjmBmrA=;
  b=qg9NbMBPXHVnYrypqMf4C84dfhWDsa04EtoskBS3uucZsIDv4Y1xfzOz
   zFv4nkagwIX3g2sbFdnNgXVgWQSSJHLmRGucofgz91oop1QKjbM3uxr+L
   blytDPBwbSXbj0g8tj0/KQgB8R/x4LAtXDr/CccfY+wg1QB9xlDeK9fPZ
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 19:47:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 19:47:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 19:47:12 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 19:47:06 -0800
Date:   Wed, 16 Feb 2022 09:17:02 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        <evicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Message-ID: <20220216034702.GA8486@hu-pkondeti-hyd.qualcomm.com>
References: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
 <f1b4b389-12f9-7c21-b117-f2fe6df58a89@linaro.org>
 <CAE-0n52G6Cu8douv_KuQEeVM-3vnwGT4dhai8kmiLJ4Fd9Qz8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE-0n52G6Cu8douv_KuQEeVM-3vnwGT4dhai8kmiLJ4Fd9Qz8A@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 06:10:45PM -0800, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-02-15 11:55:18)
> > On 15/02/2022 22:19, Sandeep Maheswaram wrote:
> > > Add support for overriding SNPS phy tuning parameters in device tree
> > > bindings.
> >
> > This does not really benefit the users and does not help developers.
> > Could you please change the dt bindings to specify values for
> > thresholds, durations, impedance, etc. The values should be represented
> > in the human units (e.g. us, Ohms, mV), not in the internal register
> > 'bits' representation.
> 
> +1

Agreed to this proposal.

Sandeep,

We have a similar implemention in QUSB phy driver. can we have something like
that for SNPSHS PHY too?

Thanks,
Pavan
