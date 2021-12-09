Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8C46E454
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhLIIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:39:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58648 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhLIIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:39:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24744CE241B;
        Thu,  9 Dec 2021 08:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624DFC004DD;
        Thu,  9 Dec 2021 08:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038980;
        bh=clIsXRKT2fHFWGkYWamNyTRV+mWRk4qf67lnV8HVxo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMjw0hIo0Fp05eonFBLeqUA2vHen3V9ZK7yzzqqfK8YZdEmAY+Cod3GnabM5U1TzU
         ynmporZRTUiRmd8ZlAra/cZgRmNtVlsdQQDY3mhhbmH3MyhhCz3+tcjy4scZWCEosY
         9s/rtIlYlC+VLNhNk4BUtPlVz1MHZDyXI5fHjVBqSJHZN7bkQePuj1CaJyDt2dsw6r
         hBuiNqaStrppL1lpIdHlCzyPmXPOVsjWqxIJLTpUxqwBlfvjxCK9k2BKCt4+h/ixJg
         HwVwa0nXvq/W6+zGs8UtK3MKbSQPJezJ7xiH4BJ2n+/aj62yQOSLD7zSkQB9vSXY88
         DV00+GP0tjMNw==
Date:   Thu, 9 Dec 2021 14:06:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, viveka@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add interconnect support for SM8450
Message-ID: <YbHAALDqcFBtRZlS@matsya>
References: <20211209072251.185634-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209072251.185634-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 12:52, Vinod Koul wrote:
> This add device tree binding and driver for interconnect providers found in
> SM8450 SoC.
> 
> Changes in v2:
>  - remove sync state call
>  - Make dt binding dual license
>  - Fix the indexes to start from 0

I have sent the wrong version, pls ignore, will resend the corrected one

> 
> Vinod Koul (2):
>   dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
>   interconnect: qcom: Add SM8450 interconnect provider driver
> 
>  .../bindings/interconnect/qcom,rpmh.yaml      |   11 +
>  drivers/interconnect/qcom/Kconfig             |    9 +
>  drivers/interconnect/qcom/Makefile            |    2 +
>  drivers/interconnect/qcom/sm8450.c            | 1987 +++++++++++++++++
>  drivers/interconnect/qcom/sm8450.h            |  169 ++
>  .../dt-bindings/interconnect/qcom,sm8450.h    |  171 ++
>  6 files changed, 2349 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8450.c
>  create mode 100644 drivers/interconnect/qcom/sm8450.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
> 
> -- 
> 2.31.1

-- 
~Vinod
