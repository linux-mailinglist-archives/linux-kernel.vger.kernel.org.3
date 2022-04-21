Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2A50A271
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389249AbiDUOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389237AbiDUOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3123F323
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r85so5774479oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0w23URXeycXFwHQWgdXQr4pbeMphaV2jmFrrqqfSE3s=;
        b=Kebsc3zy2R6yFz94yzcf5L02awCw06FtzoKktwaU4iZ/+LNtOXn4l4wjwnFA8Xih3N
         VPPlS4BHiIxYilcUMU2sRgVAvEJxkOxD1J8/HnmpZ8Dh/hNWGzH1/Kd2Jgm4Bx5ugpM7
         3BVW5CbZ9hV+f9TvQuGyzrFZZU9DimKCStk4OmEOdq1MzjP0Sw7WKH1fTQe0BZXj/NZD
         t7O4lcWpctPZEB+jxdXNPnwMpmAJoKSOMFXWFss8V9bg7/RXtzsAdaEAR/MLDEL6RGZ4
         6zKGlSwaAFZ5kUBI1dHspvlo3sqi37zqx2jNTTZfqMmED0PR8UnWCBcpEq3H4b9ykIB5
         aLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w23URXeycXFwHQWgdXQr4pbeMphaV2jmFrrqqfSE3s=;
        b=XhhuuRaKhJ76415k9Kw+gWKMBdzbAUfiX5KBXnuHhTSMJerGnojA3aULiNjkHT4JTm
         ghfQZhnElVe1SPNhfuh6iw/ezRCWO4yQCAo/yx4KITUs5lgUc0Td7QKzgqWIfDkzCpy2
         eoznOVUqSfkcgmTUqKM3gTMF4HErMzqm6Nyk5f/8n9CZEulvs0TAVOK+k2682JC4AItI
         BKhlVSMDqzg8MABqvvVF43ss4Cxu2gMDi5W2HvRaa8OuQVmoTmFM/FcYr3REeiUVisRG
         SDiXb08+bk6BfQsyIQ3IF1zk3G+6KGU5EcJ3/BlM4R61NFkKYTaEwamG114z8TUeoPFu
         GKAQ==
X-Gm-Message-State: AOAM531BXtiqyCYE75Ojws0ETwnZrWuRrIJRSE+OeUbSP3XivpGp4Ub9
        zdkrVvBZ2/9+OjTfP82crnpqP+ZQYAetdcTS
X-Google-Smtp-Source: ABdhPJxCL7XWF6jtZFt9pOGaDmdX7DhZt/kmdmrCbgrDyE4fGGQ4vEqB3z2nqbkDX62yOn6G/+njBg==
X-Received: by 2002:aca:bed6:0:b0:322:bd33:7efc with SMTP id o205-20020acabed6000000b00322bd337efcmr4424116oif.95.1650551248383;
        Thu, 21 Apr 2022 07:27:28 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc7280: Add SAR sensors to herobrine crd
Date:   Thu, 21 Apr 2022 09:27:04 -0500
Message-Id: <165055095991.2574292.1674742785100690480.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220415172238.1.I671bdf40fdfce7a35f6349fca0dc56145d4210ee@changeid>
References: <20220415172238.1.I671bdf40fdfce7a35f6349fca0dc56145d4210ee@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 17:22:41 -0700, Matthias Kaehlcke wrote:
> Enable the two SAR sensors of the CRD based on herobrine.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add SAR sensors to herobrine crd
      commit: 5d04419045e7ad28155e2f7403599b2fdbd1548f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
