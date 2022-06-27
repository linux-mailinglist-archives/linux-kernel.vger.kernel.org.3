Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4153455D1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbiF0UEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbiF0UDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:55 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C21CB23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so14262952fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zr/71miOpGKhog20TP0jCDwC/vOlvLa7msJCs05sI18=;
        b=IwisUBbN+ASrCJgfo69Rxxo0VEEFNMfOCTz8jToryKFzQyoMziiy1k66cS5vxubdRx
         hQvofkfcB28kcQanwUfEs14pPPBb3rX+wWa9i29LGy4Fd1Rb+0WHz0MqH5vmcaKxhOSb
         W+hl7YwdIDkoC7fnOwbNU/ez2TmFbMlQuOcrLraqMi8fDRadNFHC17s3yWC/zMvQ+O2/
         +vtZMteEid14WD1ORXMtjNDj5AYj60JrrdqAG95XDD7UL7tRb2aJqzw+bS4hIxGBu0li
         E7bQU9gVDccu4LCgtfb6KEqLIneqnJAhM8ALJOt5Fqd208NR38LflA2KhIUNYgQi2bUN
         minQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zr/71miOpGKhog20TP0jCDwC/vOlvLa7msJCs05sI18=;
        b=EOfeBK0LqEQ2HTkSxSKXmQEv5S+clP150n61uQtBdatD5P+mqUq3Jo89AThmNbeh93
         UuFNFRQpKj9SRICYAGMYZZn3UOzpjImLRMpfGB53LJdwdEJKnzWXC13YB8MfGojCd0Dr
         e7QQc2LwhmOgSnPTIoypJjwXVwUai2il9k0wDG8hyJhPm4TO8d2J2VRHk+hSg9XVAZfs
         DekO9iIQyndyNUjmtFvjh0a8uIlx51EvPkvxgcFfiR7yqQR5oTk80XIWQoaIxk5Cmi7v
         fsvOdWdDE90XVQCGQtw0e+T81InYdJ8qtOfsCANjVzPW2K7gJpnD51Nd/NBzJ0ZBI9uM
         WhzA==
X-Gm-Message-State: AJIora8v9o9hJxJJcrP9TD2/W25PIRKFCY5UOR4+8lNCmFuHDeQfbykl
        Tm1kI7HbhRZ+6g4hwnLBKEqu5Q==
X-Google-Smtp-Source: AGRyM1vD/kgEZjgwPs0to4i2WZxKRjbJaz78WOZQQYkjuwx8IzcI8TCTSCVhuNq4mGb9SKkNPpWWDg==
X-Received: by 2002:a05:6870:8e1b:b0:108:561a:79be with SMTP id lw27-20020a0568708e1b00b00108561a79bemr10195365oab.243.1656360232259;
        Mon, 27 Jun 2022 13:03:52 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, patches@lists.linux.dev,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
Date:   Mon, 27 Jun 2022 15:03:05 -0500
Message-Id: <165636016348.3080661.5219140331391727062.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517193307.3034602-1-swboyd@chromium.org>
References: <20220517193307.3034602-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 12:33:07 -0700, Stephen Boyd wrote:
> We don't use this carveout on trogdor boards, and having it defined in
> the sc7180 SoC file causes an overlap message to be printed at boot.
> 
>  OF: reserved mem: OVERLAP DETECTED!
>  memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)
> 
> Delete the node in the trogdor dtsi file to fix the overlap problem and
> remove the error message.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
      commit: e60414644cf3a703e10ed4429c15263095945ffe

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
