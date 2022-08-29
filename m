Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63065A5816
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiH2Xsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiH2Xrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB06A74D8;
        Mon, 29 Aug 2022 16:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E2C9B815E0;
        Mon, 29 Aug 2022 23:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB81C43143;
        Mon, 29 Aug 2022 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816811;
        bh=KahG2xDxCoetzNW8Gajuh3YY+vG3D5HNu1BmVl41zG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuYMnycXgxXjN/B7vb8RZh4qYzhBtESW6p3EtevAvLNO8SptT0UziIMPdKROgT7KQ
         JQ1Lff/iLFlqwd+Bz/UG6z/e1cokexrPWtb2hVTZkHl4oSSaX7SZ2zg5b+Vix3ENLM
         WJSOAEWQ1wsyt8UI1cevBBlSDhFp2T2/8Bw0LTdb67Cb+TzB2H30bn/COMKWWRdOUt
         frLUI+gFRZaLy9FGEhwv077pvEl5abanHKw0C8d6glaiZ2USb2n+ZvNMqzNdyB4d/K
         UN9c0RekjpDTnxZvHhDm6tU3/ZThNlV8oBxNcwMlslqefv7cDDX0HFKjL1tAe9YTk5
         C11RZeIEgWdTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        yunlong.jia@ecs.corp-partner.google.com
Cc:     dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        moragues@chromium.org, henrysun@google.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH v3 1/2] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
Date:   Mon, 29 Aug 2022 18:46:14 -0500
Message-Id: <166181675965.322065.1296946255841771215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 03:58:42 +0000, Yunlong Jia wrote:
> SKU6 is LTE(w/o eSIM)+WIFI+Parade
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
      commit: 030a7bfb365fd19714e25e9547764bff690cb227
[2/2] dt-bindings: arm: qcom: Document additional sku6 for sc7180 pazquel
      commit: 07603a1c17cf9eec5c963b470daba780cd7b9981

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
