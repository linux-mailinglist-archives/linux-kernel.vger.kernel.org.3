Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED595AF12B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiIFQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiIFQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF10B659D1;
        Tue,  6 Sep 2022 09:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C5AB81929;
        Tue,  6 Sep 2022 16:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5423CC43144;
        Tue,  6 Sep 2022 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482319;
        bh=nBPM1tCLxY0jhS6wAb2MiW4IDlxkdDf8COBh86zjN1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPUCZtwx8e246b+Je10oZSY22qmxcp97wAZFDZngSRPx76c3iweobj+CElEOCKtHK
         WSCY9Vgm1/2JRxbQ3GEGPufw6Fz2+TnD9mfLGQK1jbbVKj9BWOOUeGg1KExZmJVFmM
         rjWr76o/b9ndBbjB+Tvlu08KPLT1JsYfsLeH/PBl8A/lwWVW4+Ep8KMZ/3MRzr9jFp
         Ay41G4lZ0zzbRlyEJOfLU2aQoW7+Wne4GrCD4D7RE7sA9kw8prKbCLG4m3JjAaMGXI
         3hlaKxD2qBJE1ffkyjhjFGKbZBY1eiXA21D8G9nchsXtCN8dPTqxa9Ln+TQAVSwQIk
         R4M8acC6bkMEw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, quic_rjendra@quicinc.com,
        agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] soc: qcom: icc-bwmon: Add support for llcc and cpu bwmon on sc7280
Date:   Tue,  6 Sep 2022 11:38:31 -0500
Message-Id: <166248229984.53237.1481254056227703435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902043511.17130-1-quic_rjendra@quicinc.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
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

On Fri, 2 Sep 2022 10:05:07 +0530, Rajendra Nayak wrote:
> Changes in v2:
> Patch 1/1: rearranged compatibles in alphabetical order, no changes in rest of the patches
> 
> This patchset adds support for cpu bwmon (bwmon4) and llcc bwmon (bwmon5) found
> on sc7280 SoC.
> 
> Patchset is based on top of series [1] that adds support for llcc bwmon on sdm845
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
      commit: b2f3eac1b77c6feba4daff83de9436fcf728a5e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
