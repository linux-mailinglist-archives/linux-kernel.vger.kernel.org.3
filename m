Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888E44A53D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiBAALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiBAALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:11:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70CC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso736102pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9iNYsNAkRE6Fn8NnMN+F7D5IXYdpWh0Ey6zeXLTYfU=;
        b=VFmJ2Z1no+UGdQrAqtdXgAfEVeZXTH1/0PSZANeVHs2BRl0+pTQlLOId7FBk/iuvxj
         VfCQXI+beKnvEsmPJsIx2l2UWGCbfLyy9wU+5DBAonovJS40keANF9w08hLdBd3qvcnz
         gv9FJNIoGVGB+33pH9F2vgGeu+aLW5/x5kG58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9iNYsNAkRE6Fn8NnMN+F7D5IXYdpWh0Ey6zeXLTYfU=;
        b=kTDtQFQtWzeuqxv9/zltptOTPQRVPuhBTJVwUqZ5vNa+SdUu/mM6VNHMY82KEktrk1
         /S3A9ephS4vbJrq3JRV6yDIq0Tiulh2cZdsDcoJh0PlA3ZCdCVhtpov9/QjWDTk3ikNg
         q1e+WRE7YAlLDC0S31VyaUZf5FrUBaY9oiMHKVMPKYk9PldPj81igc1ubRxT0traPJ0J
         9SSfMU+kFtNIb3NZmJCw/axhEJHrZPJNvRwTvKSaGe6f3HxbRq+CRIxhzljpvHvFFRYA
         pk36kYPw8D2gkwqfcNcCITGszJ400w0oMDTqfsWyBQEyvkD9s6cs5v022VORyzX8taA6
         715g==
X-Gm-Message-State: AOAM5316aMXM171iDlxLNio9G3Mf13UdZNxZiMnP5gdvKCCAPIVYWs+9
        HMdBvOo2UUOiBkgu83u8HIT21w==
X-Google-Smtp-Source: ABdhPJxwWE9R3CL3nsJvcmpDOAAitJCrhjm+fvn9NAXiO2E+iIntaSPr1fxhvXHMu/09FwSIrzHaug==
X-Received: by 2002:a17:90a:ed03:: with SMTP id kq3mr26929199pjb.136.1643674265409;
        Mon, 31 Jan 2022 16:11:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c47e:986d:769b:ead2])
        by smtp.gmail.com with ESMTPSA id oj5sm424024pjb.53.2022.01.31.16.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:11:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: qcom: sc7x80: A smattering of misc dts cleanups
Date:   Mon, 31 Jan 2022 16:10:37 -0800
Message-Id: <20220201001042.3724523-1-dianders@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing really holding this series together except that it
fixes a smattering of random dts stuff that I noticed recently. There
are no real dependencies other than the second "sdc" change depends on
the first.

Hopefully these look OK and can be applied quickly to avoid conflicts
with other work going on.

NOTE: if these changes land then my "herobrine-rev1" change definitely
needs to be re-posted. I've got that ready to go once we resolve the
cpufreq stuff.


Douglas Anderson (5):
  arm64: dts: qcom: sc7180-trogdor: Add "-regulator" suffix to
    pp3300_hub
  arm64: dts: qcom: sc7280-herobrine: Consistently add "-regulator"
    suffix
  arm64: dts: qcom: sc7280: Properly sort sdc pinctrl lines
  arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
  arm64: dts: qcom: sc7280-idp: No need for "input-enable" on sw_ctrl

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   2 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  85 +++++-----
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  90 +++++-----
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 155 +++++++++---------
 4 files changed, 159 insertions(+), 173 deletions(-)

-- 
2.35.0.rc2.247.g8bbb082509-goog

