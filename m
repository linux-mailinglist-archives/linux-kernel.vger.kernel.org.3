Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE14A4E06
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbiAaSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiAaSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:32 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769AEC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:32 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q8so13841958oiw.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6VOFFGj1qnMeMl99dR3lQJNjcE4yvoIF4l+t5DT8R0=;
        b=OeXIRCNrV9do1eoAS1AxMDagZMthxM01KmjRm6bMJeqytC2sbzD3OxvRBfarGecpB/
         uUrkaTK4DKTCwKxNfegcNWi9/XCHnVOj47BONhCqmRwVDiWRPPJdxcQB6a9v7b2DFyLJ
         cbP4iDRi2b3HfoPk5IqfXKPFrEjFMjr8q8E3LfMPk127i1yVmeBbSGYX0PjBHNZxFBaS
         77R/pFFWHehWAxoYl6CCFhUtn93MXwYQQJK+eLP8vffcp5CNBjSBVXXi1Fd7C8FgnOD/
         HAPyXh07TVQUATsnB8g+DzUzrv4npsNhqHDslcfIQd8aHTL9lbmPdL9dEV92X8O42s0p
         INbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6VOFFGj1qnMeMl99dR3lQJNjcE4yvoIF4l+t5DT8R0=;
        b=NX3RAfq5YWhvUy+9uvx/geVhYMr5pT1/KbbS9sbxa+QGsIh60TV2qYiHrS5ZfA3eZd
         pmb6P6iL640lR2xoBKSlEngdeeOCDv/wAvKA4zXu+SzNcvjRDvl/yxVM15wm3Z1X5QhB
         ew3dqvSClWgTC4RFcq3gR+LSJSgoySPknTVjh5ubnb6LXdqdJtjY1sT0zXUyiu2+SOGj
         39YMm7VL5uGTK0pP8aFe9h8zpm9An/+ISp2ncrHl/1wA5wj23hkG6FqUZqF1i6j9xgKn
         0+NHKq5wXkVKsrDV72ZaEymKjvB5qslVhCsLpv5BpnTvgp7S1tEujFey3IX4aoil9Hl6
         ukNw==
X-Gm-Message-State: AOAM533sIIcXHkTKMJMWY8tQrDv5g68vXcSalV9eYAeBN7X/pAa2TIj+
        nGnFtS38b6/6ek8g+Ab/xLM7dw==
X-Google-Smtp-Source: ABdhPJzk4Xf1Oqvbt7FyrQDJ8LZD5T6yYg72uBGLLyXtBwGsAGDJrK9Hp+VEdMHZ/VF0M0PF4bTjLw==
X-Received: by 2002:a05:6808:3022:: with SMTP id ay34mr98682oib.240.1643653471816;
        Mon, 31 Jan 2022 10:24:31 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, sibis@codeaurora.org,
        quic_rjendra@quicinc.com, pmaliset@codeaurora.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        konrad.dybcio@somainline.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>, kgodara@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] arm64: dts: qcom: sc7280: Introduce herobrine-rev1
Date:   Mon, 31 Jan 2022 12:24:20 -0600
Message-Id: <164365345129.3009281.3222256950941436555.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125224422.544381-1-dianders@chromium.org>
References: <20220125224422.544381-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 14:44:17 -0800, Douglas Anderson wrote:
> This series adds support for herobrine-rev1. Note that it's likely
> that with the introduction of -rev1 we can drop -rev0 support, but
> we'll keep it for now (though we won't try to "fit it in" and share
> code with it).
> 
> This series is confirmed to boot herobrine-rev1 atop mainline, commit
> 0280e3c58f92 ("Merge tag 'nfs-for-5.17-1' of
> git://git.linux-nfs.org/projects/anna/linux-nfs"), though it requires
> a hack to work around a misconfigured DMA for i2c14
> (https://crrev.com/c/3378660)
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sc7280: Fix gmu unit address
      commit: 142a4d995c6adb6bf5b22166f51b525e83c96661
[2/5] arm64: dts: qcom: sc7280: Move herobrine-r0 to its own dts
      commit: 61a6262f95e0c400baee59ced0721f49ffca604c
[3/5] arm64: dts: qcom: sc7280: Factor out Chrome common fragment
      commit: 56eead37681511d3bd5c5869cf2878865942ba75
[4/5] arm64: dts: qcom: sc7280: Factor gpio.h include to sc7280.dtsi
      commit: 40ab97eb383dfd9de37d049883a8707397a478b1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
