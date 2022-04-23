Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062750CC29
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiDWQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiDWQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:06:50 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2E69CE9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:03:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e67799d278so7939683fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qx0GiGQM5WEgM2VJQDK+H8A1gODJVIAo9YHWFymnTB8=;
        b=et187E8ifN3AohBjFB5tK4v44TS+m89fTH9xXyZ6DTUEBvAa8vssfbHcWMX6wieG4W
         m88y0+Ph9AAfIpminIvkWeKvKCBYd2U9NsGC7inU/znyAdyf7oFFu+k9YT+7H2u0tG8X
         6p/5MTcMm6XXm51bq82NNbJ6gWd3tauVAuAZoA0WfDx+GqKZbMtcd8EdGQJSYOWdI2Y5
         7CeeZBOAWP0yjPdzwoZJdhgiARE3x7CsET9W46/bT+OoLlGqiZ7l/uM0pQwxhwrD63Kq
         rrcmP82qx4I0UBELIvBiifPErBWcdaEx1tkldc5dKe9PavjjASI0PJezJsxl1lXW74Dp
         PJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qx0GiGQM5WEgM2VJQDK+H8A1gODJVIAo9YHWFymnTB8=;
        b=ncFYTYS1YQ0gFVb5z8C9ojpDtHxW98514q4+pRj9wn5l7XAGfD+dOJdHlODfUyigLS
         TDQwtEjU125AgR3y62mDh9AIQLomCS3bX+CiCKXMMgAhqdKe3y8ZgNQE84V40Y+wvphx
         WQr+1ISY21cREunWMOX1x36Lbb0lWCEeCgyg3HJflIrMSvB3xO38jsEsnk6mVPG9zIRH
         4jGKIuvqM33TRjrJW3H+DYe1HN8BaF6qQ5lc86c9BAUt32AzmPFTsjTBeI4AWSMFy/Ez
         4UTPkn/My9xgJRXgDLNNPLe2zyVBuqlOyJqOCDgwyglfVbxH4PpxhuIFYVR3NL4vNgLs
         W3cw==
X-Gm-Message-State: AOAM533ufw0J5jDTbrSEqiaCmGwk+c9KT+Yxyo+x2pMEo3kLRAHong/x
        vODXDOPPJ8eygEd4Mo4cC3vpxQ==
X-Google-Smtp-Source: ABdhPJxTvB6kmpQgJ1AR6kxPeH5crT1K7/Pq6ptpCC6EPQ1XjSbCOKWzRD261uTJyKw87Xd0Ors0Dw==
X-Received: by 2002:a05:6870:ec8c:b0:e9:365:7a53 with SMTP id eo12-20020a056870ec8c00b000e903657a53mr3224738oab.269.1650729829745;
        Sat, 23 Apr 2022 09:03:49 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c9-20020a4a8ec9000000b0032438ba79b0sm2123856ool.0.2022.04.23.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 09:03:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: qrb5165-rb5: Fix can-clock node name
Date:   Sat, 23 Apr 2022 11:03:45 -0500
Message-Id: <165072980563.2810336.11568636837670470750.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421073502.1824089-1-vkoul@kernel.org>
References: <20220421073502.1824089-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 13:05:02 +0530, Vinod Koul wrote:
> Per DT spec node names should not have underscores (_) in them, so
> change can_clock to can-clock.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qrb5165-rb5: Fix can-clock node name
      commit: 1eae95fb1d696968ca72be3ac8e0d62bb4d8da42

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
