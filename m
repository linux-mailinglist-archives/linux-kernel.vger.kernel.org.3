Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5068D465137
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350986AbhLAPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350711AbhLAPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:16:34 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B1C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:13:13 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bk14so49136992oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Z7nUlUav8oWY3QAXrOICDbgMZCfO+xHnIpWNXf6X0o=;
        b=omxzqvsF/fUrXUHL01i6E92FAncbSn0XRdWoqTP8pnkSkPMYMKsVOos492jJLkA014
         N45endSs2yhAOfKdN4ZayXBV1I+7leX4WtYkAEVcQxtMrKNeXKO1/lt8RGazADCbhkwd
         XtRYgipxKc/jzNPF7qI5SmGtlzD1U3Lwx77xQ+cKy9nPsGktI7B+OCtLTmqZpvZoYW6m
         8cZ4cRl1pwsHaa671FHXocA8jX64zR138A13Ew3sLqbJ8M0dCmt7CUmlvb6L+GfpuMyA
         gp5ASWd+Nmebo90N0uYfYXug/+IBWM5u9sePdzqXeI3MxA3grE3As1YWE8Qr7xpU3IRU
         L3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Z7nUlUav8oWY3QAXrOICDbgMZCfO+xHnIpWNXf6X0o=;
        b=i2ETQ8QUcczXpRILG26oKye7DIC70Dr3ZD3zBiLfX9KO7tP6ZFGN4NWXuUDa/wjkvR
         ImgXFBTeA1WWX1avkPqddD3bGuvBfpp2D/chYBu4IG9xIgwhXbe76rfb4p8u3wHY+ZMj
         EmHYWcmvf91jJMlktgh2nSwqGM4Dndx5f9WEX0JgBO73m0Da6wXBLGECeiHw4lDfgQpK
         MH/0Nhje1ORmHYTE5+nTg3iTXPt58VX4FGJrRlV0uBnP6nx5dhtakWiqveSCZ5cvMu/1
         FCTUXpaio7Fo3qTEk7difIaMUunu3sSKXIxGExIuxpJUCd09k9phsnfLzt1bYFBhshj1
         ZBgg==
X-Gm-Message-State: AOAM533HqgxUhKEMrnzV7cSjJvVi3FLWIR2A/Jbc+FASsSmQV+ORSa7o
        xVOr8KggOX4LCoxKODo35baJEX/hFwb8CA==
X-Google-Smtp-Source: ABdhPJx0cwnUfAcwJxnHSFUMpyLNcKOmI5RbalFzjUQDqR5PuueX1JCkE+S5Zh16PmkKHg2qzIlM1A==
X-Received: by 2002:a05:6808:2186:: with SMTP id be6mr6798534oib.115.1638371592612;
        Wed, 01 Dec 2021 07:13:12 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id be12sm33933oib.50.2021.12.01.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:13:11 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add PCIe EP and IPA support for SDX55
Date:   Wed,  1 Dec 2021 09:12:59 -0600
Message-Id: <163837153033.1905338.11447851101317565471.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 12:35:14 +0530, Manivannan Sadhasivam wrote:
> This series adds the devicetree support for PCIe PHY, PCIe EP and IPA on SDX55.
> The PCIe EP is enabled only on FN980 as there is no endpoint support on T55.
> 
> For IPA, the support is enabled on both FN980 and T55 boards. With this, IPA
> seems to be functional as the modem ready interrupt has been received. But there
> is an issue with some QMI command failing with the mode, so can't do the
> data call atm.
> 
> [...]

Applied, thanks!

[1/6] ARM: dts: qcom: sdx55: Add support for PCIe PHY
      commit: 254a27585eb135f35887579ebc7d0e02b9788b92
[2/6] ARM: dts: qcom: sdx55-fn980: Enable PCIE0 PHY
      commit: a5a2661287b450f2b1f751ae7b4da4f39976571b
[3/6] ARM: dts: qcom: sdx55: Add support for PCIe EP
      commit: e6b69813283f9babc6892c1324d2c3bd2a577d9c
[4/6] ARM: dts: qcom: sdx55-fn980: Enable PCIe EP
      commit: 7cecfb53cad8e9f564fdf11e56502c7d8607b3a3
[5/6] ARM: dts: qcom: sdx55-fn980: Enable IPA
      commit: e1fb17ee85bc85808eeb103afa63581d065c7328
[6/6] ARM: dts: qcom: sdx55-t55: Enable IPA
      commit: 1f7fe79d03b2ac0991c8a229ca50a9f45b71df80

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
