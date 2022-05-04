Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9051AC34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359842AbiEDSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359599AbiEDSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:11 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3536D6D3A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:29 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-edf9ddb312so905399fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKpqt3Zv71OFS+RtPhQCpWEmVvpBGhpyU8YWWfhiy8Y=;
        b=X3sXe04ZkZYP37hU1qpG6mMuBg9Z7LxX/EgWjSm7om6CYeHY5AX+WVfwlUtuR6s3DS
         JQ2MOTy6wndnhdDNyARx/uI7yIWF3JnnEeFhoLU84NGkC7kVeQnfhEDswdgZ4jan6QYu
         3hTtJim8bqdzAukunw3K/36WIdd2UoiOxiQrv3q+/ev+3xR0zYXB0I11VJOqLo5kKQnW
         K8l43rAqc7C0qGOsLeYw4q/AJnZ9vbzRtD1wlNGiwI2fdtmhiSEbYdofofwBTXjQ69Az
         Hybm0bC8HnDgoRCgNwt+lF5yHIvOhE7sQNuwi7gl5lUXcijwN+TQBY07gD+TPjFlCiva
         fTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKpqt3Zv71OFS+RtPhQCpWEmVvpBGhpyU8YWWfhiy8Y=;
        b=b2KY6k5TxraY+mkLz4tVCj698Bhq+3OIfKDqu6aA2W3R63HDxkBkuw6qaYHXLiIknm
         HqVJ0bUgj3m08omPc/EvSOiBJC1yWGGhbyno6l3KOqGo+NVX1ocD71IF3poUugOJfP37
         osMGr4/D8ZyObGT9Z/K4Rs7YN4tA6sfstwsh57gg/pCQ62YFIlHjTEiBZnDPUSAJ9qDQ
         FyIXrPQU1frs0S+tChLNoewkcksQOGw2Nn+hbOgSjVSoTSUru9ZNJQYKkcpSKsl7OziZ
         mO1UXw/Ss6zbWWq7S1nCZ3CFmeucTdKP4+vz2emFj9ep+tbuqofkh7RULfaK/ywefFv0
         96cA==
X-Gm-Message-State: AOAM533VYoChFd4wJIwS0935owTDdu5N0lpKlhPL2tTUQt7fLEsNn9Ly
        KY2FGhtOleAmDX/gU2K15JWnDA==
X-Google-Smtp-Source: ABdhPJyU0Q/uoTIwMxovxMdIKX+ny8p88N5ogcC+0vganajhvhHMka5oEPfrKlUo8lGlzi/th+7yvw==
X-Received: by 2002:a05:6870:6301:b0:e9:17b2:2e12 with SMTP id s1-20020a056870630100b000e917b22e12mr276826oao.96.1651684888962;
        Wed, 04 May 2022 10:21:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     devicetree@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     dianders@chromium.org, quic_msavaliy@quicinc.com
Subject: Re: [V6 0/2] arm64: dts: qcom: Configure CTS pin to bias-bus-hold for bluetooth
Date:   Wed,  4 May 2022 12:21:13 -0500
Message-Id: <165168485227.3730817.12193941137410849095.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1650556567-4995-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1650556567-4995-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 21:26:05 +0530, Vijaya Krishna Nivarthi wrote:
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change pinctrl configuration to handle same.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280-idp: Configure CTS pin to bias-bus-hold for bluetooth
      commit: 497b272759986af1aa5a25b5e903d082c67bd8f6
[2/2] arm64: dts: qcom: sc7280-qcard: Configure CTS pin to bias-bus-hold for bluetooth
      commit: 3d0e375bae55c2dfa6dd0762f45ad71f0b192f71

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
