Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CC5A581C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiH2Xsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiH2Xro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEEFA5986;
        Mon, 29 Aug 2022 16:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF3BE61405;
        Mon, 29 Aug 2022 23:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94363C4347C;
        Mon, 29 Aug 2022 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816806;
        bh=Qd3AMfyY4tk6Q+pRvCfhQZF3G+wUidbn6BTwGgEO0uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd+4xUqNIb31qpwyr3HEZqWaWRrdrMK1mwCfbuVKDRSrWHqiJdfB+naHLU3EqofoD
         QmeiVcSRYdbMqN4g2eCazDzoa+UG91hE6rUVgPZXmMoYkDTwiCxRCBge2oVR/WxPQP
         SBrVANT7MzErL+D7ZAiLJYMUSffZ8FpPH1t4AUTiVOwWqDXZ/2+7K2NSzIP1oPn4+c
         8XYRiVr8Vyvel+Q5jsQX8hwAEz/Han0sEsLM0TmZSHTg0GQFkVoAq08ZrKGWQka80c
         /8RgFgaexgM91PRfuVZ2PMYXT0SlQ3CaDMdTzKkoDNHQRmNl6+QvRLfJwzhGHiE7EQ
         Dxx6ba6iEd23A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_c_skakit@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        robh@kernel.org
Cc:     dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: [RESEND PATCH V4 0/3] Add DT support for audio clock gating resets for SC7280
Date:   Mon, 29 Aug 2022 18:46:08 -0500
Message-Id: <166181675979.322065.8110343540812445012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1660107909-27947-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1660107909-27947-1-git-send-email-quic_c_skakit@quicinc.com>
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

On Wed, 10 Aug 2022 10:35:06 +0530, Satya Priya wrote:
> This series depends on [1], which adds the dt-binding changes.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=663372
> 
> Satya Priya (2):
>   arm64: dts: qcom: sc7280: Cleanup the lpasscc node
>   arm64: dts: qcom: sc7280: Update lpasscore node
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
      commit: 8c7ebabd2e3f33ef24378d3cac00d3e59886cecb
[2/3] arm64: dts: qcom: sc7280: Update lpassaudio clock controller for resets
      commit: e02a16c23410a118e5497601871a2f8c3ea9bfd0
[3/3] arm64: dts: qcom: sc7280: Update lpasscore node
      commit: d9a1e922730389afc425f2250de361b7f07acdbc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
