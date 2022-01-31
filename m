Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2A4A4E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbiAaSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348956AbiAaSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:33 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733EC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:33 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso5694167otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/uEQDiPvyVpaW3bH2ylqgdN3GSKb6mGtIDulo2igF4A=;
        b=Dj4Ze4AyS49RZQCHcV7EVYf3hJluedHM2cMEXbuCHBtf8CPRtUSONXankqPdPPbGg+
         kVh8mrcPUn4v1+u6txNnRyQKAN70VohEMitBldwoJ6c/AoYAilMgI26DXnO9F55yAyL0
         z4Z/avh/s/F9K1lXs4japf33mYiGxt5IZBCkaGh7KVhAk7NLXmXv6p0dL8nWqn0nqSbB
         R88H4gOMjV1+cOEE+ALXTChil4s1IqG5xuUD2Q+E07Fnm3B/06TSCDkw/mziAjxejpTd
         aE9CJ4dpPFq/aMty/FEd3kaRGWuAOAr3vqoS4UBh9MSjAuJ/sLmIc0nQnqS+IuMgl4aW
         EfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/uEQDiPvyVpaW3bH2ylqgdN3GSKb6mGtIDulo2igF4A=;
        b=ctB+dcW+vKWxOmZpdnyByB90Y9wJIzZuhIq7YR9FRbm2TFhTvBWw9oFXlyZwLZUDs+
         nPIx9UiLAnFbcu3j7fJPIJcFHgE/88a6NLLfj+bxhBQlKCRQvv3ZSPnO8bDVzoOkaa6e
         eNrDZFSAfWnlSPmWjvNpdfUACJvfVAN+vyiCEQUQdi8B/v3Xpdb+GVYIiMZ2d/BtLQMD
         AbfvTyuGxD4wXatkXUvuPoG71MIaZSaLCVHIc1e8+2n3c1BA0Q2vKwgkNEA7lXSffIzI
         TehdvSuc7HXPl9HQY1Yku+SxBVGsJNu6w5qMMozQuRqHgB1gil35bjdwzdH6eIRibc6h
         kqNA==
X-Gm-Message-State: AOAM531/4/NPSld1vfT7bWjZD/sh+dUyfGiZr2aqCA3bDRMKwpuP+0Ms
        FOU0dJD5TXp4HP28bT2wvSUxLQ==
X-Google-Smtp-Source: ABdhPJxYX/Skwea3U6mnS3RjwgXRsnB8XXUHMcSLu/8d72fFJvoUTX2f9Iov6ifpLhXWnw5fbHDUUQ==
X-Received: by 2002:a9d:5388:: with SMTP id w8mr12079357otg.296.1643653472814;
        Mon, 31 Jan 2022 10:24:32 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/7] dt-bindings: power: supply: pm8941-charger: add pm8226
Date:   Mon, 31 Jan 2022 12:24:21 -0600
Message-Id: <164365345128.3009281.14091610271244037976.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118210210.160895-1-luca@z3ntu.xyz>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 22:02:04 +0100, Luca Weiss wrote:
> The charger in PM8226 (used in MSM8226) is similar to the charger in
> PM8941.
> 
> 

Applied, thanks!

[3/7] ARM: dts: qcom: pm8226: add smbb charger node
      commit: b64192272cb65b0fddb97dba7c4f244452954a85
[4/7] ARM: dts: qcom: apq8026-lg-lenok: configure SMBB charger
      commit: 0bbcddc5f0365937ed53ebf7daa98134a6ebce8d
[5/7] dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 compatible
      commit: c04421c68fd40ee33df87eea69c1a447b7985d0d
[6/7] ARM: dts: qcom: msm8226: add USB node
      commit: 1a34117f2e145f158c339ad9d296c0c1c42bc504
[7/7] ARM: dts: qcom: apq8026-lg-lenok: enable USB
      commit: f8565bd5404fcd6f87ee1e2d585541fbb457612d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
