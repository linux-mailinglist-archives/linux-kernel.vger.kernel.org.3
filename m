Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF55952CE81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiESIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiESIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:41:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5015EBE2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso4596714pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9F4LJppyqE41q1h43fo/X8VtHTZjJ9e8kf5fIIkbl00=;
        b=WJFhyIJFYS9f3bR81kq8k7S1IT6b4ctmIlFV09o1nN6goqGhtWhRtp729/39pPXNCP
         eOWyRZfzQgZUADV66in2saYgYZg2XqVqOtr9kpUVn+f184+8c4eNOMBtIbyO/s/e2bzx
         TMynds0f5ujgx7YWNE9URnPppPuj+8cw8OkAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9F4LJppyqE41q1h43fo/X8VtHTZjJ9e8kf5fIIkbl00=;
        b=u3vhg9z9R4ECRFMqwmLFWKr5RG8YRGuAwhimOXjyplPxF/cYwCFgKHA8eTK41/DJEB
         Eq3bojNeNxTr+8ZlLdhXtvshblRrNIIRssQdYYu1B5L1lWHWoTbqhIX3sDuWLgbaXVFv
         ZzcVYwRSKdChXC/6IkW0o0hLGN8CGdH8Sn2X8S4a3dmpIeWsa49zQhxzuO0tc1jbF46o
         5Xu66xfhoA10FTAf2/mHrvzN5k+Tcv1XbZ4PbUm8cpkxOFZJ1URUa1y/MHNXXPTBSPI7
         145p3EvSqt4NppJTLXPNrhdWV0tybErX+jgL7cXidT5uzYt12xhAfOmIRsSXE1sF+J7Z
         tROw==
X-Gm-Message-State: AOAM531/6Sgfk9kwJKDfbosOAim6DkXmObcC7mRfkN8HPPHwV9jKu7FD
        rP4rDa2W9KADvdLyg+BhkEiTOIppLtJSwA==
X-Google-Smtp-Source: ABdhPJw+iNDACAe/dSBqzUI0O4XQGEgN1hO5zC0/gT+10HZzsJJK95BJlERBpDdb3hhiVNO/UA37vg==
X-Received: by 2002:a17:902:b495:b0:15f:2a7b:b9d2 with SMTP id y21-20020a170902b49500b0015f2a7bb9d2mr3889302plr.20.1652949695018;
        Thu, 19 May 2022 01:41:35 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f20a00b0015f33717794sm3066185plc.42.2022.05.19.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:41:34 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [v1 0/3] Add dtsi for sc7280 boards that using rt5682 codec
Date:   Thu, 19 May 2022 08:41:16 +0000
Message-Id: <20220519084119.675990-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put sound node and lpass_cpu node settings for boards that use rt5682
codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
choices of headset codec for herobrine projects. Common audio setting
for the internal speaker is in sc7280-herobrine.dtsi.

Judy Hsiao (3):
  arm64: dts: qcom: sc7280: Add drive strength property for secondary
    MI2S
  arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
  arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
    in villager and herobrine-r1

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 121 ++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  14 ++
 4 files changed, 137 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

-- 
2.36.1.124.g0e6072fb45-goog

