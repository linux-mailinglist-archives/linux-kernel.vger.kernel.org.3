Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8761A5A57D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2Xq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiH2Xqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542109FABD;
        Mon, 29 Aug 2022 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F56613F1;
        Mon, 29 Aug 2022 23:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCEDC43143;
        Mon, 29 Aug 2022 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816788;
        bh=q+cY4ooh9TzxnIMeF0wlcIIumMqQCSiNcaOjlSaxeYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+Ra3u/nY1ZnnR9EwGPBmfAcqNTfzQ2UjGID+7Q6NOMFRK6hT+cieb4JhIth0gCWB
         h8/eRsWdMEvTZyLzQ7sGkcAY4mV9uxhl2j4Q+2D3NQ0K4WRDKFAv0cu6d5WnWMlzeJ
         1bRBVW6ytGiclIJCPtIY1ASM/JS7MycU/J4Mv74xmX7WjuFahp5L2PArgnKQ1Ny7HK
         D6frEDcoTcHRq1gXgOPYAFdTa58GxFvtWV9FsOsA1RPZ6DzESHR4iVGcpB7o+weJII
         9BKUEHh+xuHpbr7Lu9+KQqaIQUrrKNAsUqZeQAWEkCLjZK+5JxuhraEjAf6ehxHOTg
         gwl+Ub6b79o0Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, johan+linaro@kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sc8280xp: disallow regulator mode switches
Date:   Mon, 29 Aug 2022 18:45:51 -0500
Message-Id: <166181675980.322065.3918715363441736917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803121942.30236-1-johan+linaro@kernel.org>
References: <20220803121942.30236-1-johan+linaro@kernel.org>
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

On Wed, 3 Aug 2022 14:19:39 +0200, Johan Hovold wrote:
> A recent change in a USB/DP PHY driver that started specifying regulator
> loads caused the regulators that were also shared with the PCIe and USB
> PHYs to be put in low-power mode, something which broke PCIe and USB on
> sa8295p-adp.
> 
> As was discussed in the following thread:
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc8280xp-crd: disallow regulator mode switches
      commit: 412737a60c846a6adb7f7571905c200da036815e
[2/3] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disallow regulator mode switches
      commit: 648ec2f2ddc05346287e308fbc31a6b8117a1edd
[3/3] arm64: dts: qcom: sa8295p-adp: disallow regulator mode switches
      commit: 2a6164cef63cae77edbd9deef844b1774886fcb7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
