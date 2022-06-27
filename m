Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448E55C857
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiF0UEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiF0UD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E3A1CB24
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101b4f9e825so14319019fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oqCMEdZOFPWtNjZHK0DpD/hkul9N6jiiMvxLAkZPi8=;
        b=c+TaVHeiDxOdRSm0ioO42BbHne9So3WLc5XJeNOZJ0rlSBJX8kDh46TLhftBwFlbWn
         HK7QBu4r6BG9KjAVqWRp5xRRFadAYmtOFHuy0jkt9R6fxCbOzRDCaZmwE5lLBVllCWSB
         hmYTENrkqHis3PiqY8HssRMdCTttNd7AF/LpEcEL2GZL6t71+Rgyt+lXyUCXZVunfKCP
         UO41Kf+TKuX0racjRt7Tfy9WM2qg13jKk7BS5L3zszXk/YC10PfxRAEPcgFg8aIT2v3R
         1uJ+4yBWHLu72quE2OmQT+3JmN1rD0mHTn9I/xgHAs//j/ZeP8lnN9guMrGCo5lxCPA9
         W2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oqCMEdZOFPWtNjZHK0DpD/hkul9N6jiiMvxLAkZPi8=;
        b=B6PNpyYqCvqJDi5XExvAXXvWwlqXl3jcLJTvioaRhsygrh7/jTItgWdHEGKgGYUdqi
         KhzEz8kjyhEEKfVXY83N19RBhib3HTCwvKqizdBZexNYgrf3eq65nGOZPDHQxpxjHiUw
         0APRBdJV5qn5ylbPlJark8czinPd2PYHLS5o05K1TYxe4u/34RfHYbezKApumuwophn+
         S7FiiwILjCJUciqqQhmDuGS11Ivvtgsde5oU1m94deX28mJetdV1jQjOu8eoFgGXr3J9
         hJ1Ktc2VxdoOAcTRKkIZ6YHr4o5c7YN3e3JzpdyHfY+vmO2l+xlsaByS6P05CQj8EJ5P
         tEeQ==
X-Gm-Message-State: AJIora8+qak/j3mxaPRJWDxMIYhfs4qmJOCqPrG5/8GeOYq/PPhU+FUx
        bIjHRPo6VVgfzgxFMRxmwYAO+dNPNIKmYg==
X-Google-Smtp-Source: AGRyM1sdW18nt1XKn8B2l/2cRF49xuAu2AWS1n2ZrV4v5duSEyRQaafDGupWeaB+wveruRsG7nA6Hg==
X-Received: by 2002:a05:6870:5ba6:b0:f1:5840:f38e with SMTP id em38-20020a0568705ba600b000f15840f38emr11148453oab.210.1656360235978;
        Mon, 27 Jun 2022 13:03:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        patches@lists.linux.dev, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar
Date:   Mon, 27 Jun 2022 15:03:07 -0500
Message-Id: <165636016347.3080661.3020909807591656315.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602190621.1646679-1-swboyd@chromium.org>
References: <20220602190621.1646679-1-swboyd@chromium.org>
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

On Thu, 2 Jun 2022 12:06:21 -0700, Stephen Boyd wrote:
> The sc7180-trogdor-{lazor,homestar}-*.dtsi files all include
> sc7180-trogdor.dtsi and sc7180-trogdor-lazor.dtsi or
> sc7180-trogdor-homestar.dtsi, so including it here in the
> sc7180-trogdor-{lazor,homestar}.dtsi file means we have a duplicate
> include after commit 19794489fa24 ("arm64: dts: qcom: Only include
> sc7180.dtsi in sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi
> file in a board like sc7180-trogdor-lazor-r1.dts so that we can include
> the display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi)
> instead of making ever increasing variants like
> sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar
      commit: 372b2aee97028c75a6e12d205a2e5f0c8626efc6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
