Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109875A57CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH2XqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2XqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155B9858D;
        Mon, 29 Aug 2022 16:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E638B815CE;
        Mon, 29 Aug 2022 23:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E16DC43141;
        Mon, 29 Aug 2022 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816778;
        bh=6or2s+dA/8Q1RzW4e/ykDjpQoz2SuAMa/l45LoY/gBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XY2EbDgtwZyjq1cIr65d+PTx5hzYJwcLhQMq3yb4d9LL/vbQH7WlzS2I05Vkuxvik
         Rr9BnNuJXuNxA2Eds7EJPnEKM7x6QUdXYXi8Spt2Wmn2mHCEdKOGlou7YWii8CXo6M
         7S+91hhxylVIoHBsQXDPBSO9sQAS0PDVzSCPheDwBki2xpJeOXwrd+0gRU4LNoXgaQ
         gH0q8ymG3IAklUH0LLrWGN1yHVOsWxA30VXYkxrj76mrYZ4WXRuhMmGilmB0xmvS7I
         BNmisbrl4Qq20jjXBup4Mp9y3mtzMXhFcYEPMbRL2tMKWYoqjIGFFJncHvAV0+vawq
         ehmo5XveeF6Ig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, quic_mkshah@quicinc.com,
        konrad.dybcio@somainline.org, abel.vesa@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] arm64: dts: qcom: sdm845: Reduce reg size for aoss_qmp
Date:   Mon, 29 Aug 2022 18:45:39 -0500
Message-Id: <166181675978.322065.7678166957797997840.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812101240.1869605-1-abel.vesa@linaro.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
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

On Fri, 12 Aug 2022 13:12:37 +0300, Abel Vesa wrote:
> Like on the other platforms that provide RPMh stats, on SDM845, the
> aoss_qmp reg size needs to be reduced to its actual size of 0x400,
> otherwise it will overlap with the RPMh stats reg base, node that will
> be added later on.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sdm845: Reduce reg size for aoss_qmp
      commit: b0f8e8a38a010999f7b07617d874e3eb594a0a3e
[3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
      commit: 528dc60f9e5eadcfde651b1458da2b8d008a2cf0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
