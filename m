Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB76465B06
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhLBAiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:38:23 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27398 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhLBAiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638405300; x=1669941300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tigB941sFJ2JS9XqW/Csq5Ad1Iz966W6LuwZoun7X4c=;
  b=mEXkHIZ7bWojYKP56KlBO3VhAS+gfFjlUAo9AzLFmH4pIvrYZklTVTfL
   uZV56ypgXts1x/kRZsGWdhwuYEgNx1Ne8EwXIgfBj7HEor3UQQfXOViil
   v2YHf/xKCjOGcEsZIn8knNL5tCjpEZygE/IkG6h3bT7V82QIt8uEPTo6l
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 16:35:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:35:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:35:00 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 16:34:59 -0800
Date:   Wed, 1 Dec 2021 16:34:58 -0800
From:   Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <olof@lixom.net>, <soc@kernel.org>, <linus.walleij@linaro.org>,
        <sboyd@codeaurora.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 0/3] Add devicetree support for SDX65 Modem and MTP
Message-ID: <20211202003458.GA25288@quicinc.com>
References: <1635552125-16407-1-git-send-email-quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1635552125-16407-1-git-send-email-quic_vamslank@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:02:02PM -0700, quic_vamslank@quicinc.com wrote:
> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Hello,
> 
> Changes from v2:
>  - Added cmd-db node to the sdx65 dtsi file
> 
> Changes from v1:
>  - Addressed Bjorn's comments
> 
> This series adds devicetree support for Qualcomm SDX65 platform and MTP
> board. This series functionally depends on Add Pdc, GCC and RPMh Clock support
> series [1] and Add pinctrl support for SDX65 [2] which are under review.
> 
> With this current devicetree support, the MTP can boot into initramfs
> shell.
> 
> Thanks,
> Vamsi

Can you please review this patch series. It's been pending since longtime now.

Thanks,
Vamsi
> 
> Vamsi krishna Lanka (3):
>   dt-bindings: arm: qcom: Document SDX65 platform and boards
>   ARM: dts: qcom: Add SDX65 platform and MTP board support
>   ARM: dts: qcom: sdx65: Add pincontrol node
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml |   6 +
>  arch/arm/boot/dts/Makefile                      |   3 +-
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts            |  25 +++
>  arch/arm/boot/dts/qcom-sdx65.dtsi               | 222 ++++++++++++++++++++++++
>  4 files changed, 255 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/qcom-sdx65-mtp.dts
>  create mode 100644 arch/arm/boot/dts/qcom-sdx65.dtsi
> 
> -- 
> 2.7.4
> 
