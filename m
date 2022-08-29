Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11585A582A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiH2Xrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiH2Xq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F071A5C59;
        Mon, 29 Aug 2022 16:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94437B815CE;
        Mon, 29 Aug 2022 23:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5AAC433B5;
        Mon, 29 Aug 2022 23:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816801;
        bh=dv17Y2mhXBQx2sTKnqhChtP+LSnUSVZsPo/u12Xln0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zg6WtVBQcH39ZzpTXC3/Z2VBryinOvvkUV1c1EBSuzxAsD3+M4meTBGkOviD5hYWk
         3LEZoWroNVEypAHPspCx/aSBbTeuhcEwmhYudhpqSIgl6LCL3Vkb0WqaJ6ZoWQ3lJ+
         9qaH1hM+baKKks9H24Fr8/epRL8d23aiATOSyRImXAsWg+sz8mfQ5c4+Ik9FL+nxjH
         x4DSslerZsIUS3Zj9CVaOle+ubLq8oocp8dX7n7Tw12s5TvA+6L0rbIc5qaPHzIWq8
         VW0BoTet6E8nRBBwMS+K3FSoo90hdNhxaFRwQZ1p9Ch6l+4KUWi/O0n3P2VGbNd/gv
         U/MlJuZ0qr6tA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     linux-pm@vger.kernel.org, okukatla@codeaurora.org,
        georgi.djakov@linaro.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] Add interconnect support for SM6350
Date:   Mon, 29 Aug 2022 18:46:03 -0500
Message-Id: <166181675955.322065.18365644806860060536.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
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

On Wed, 25 May 2022 16:43:56 +0200, Luca Weiss wrote:
> This series adds interconnect support for the various NoCs found on
> sm6350.
> 
> A more special modification is allowing child NoC devices, like done for
> rpm-based qcm2290 which was already merged, but now for rpmh-based
> interconnect.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: sm6350: Add interconnect support
      commit: 38c5c4fe17014130dee4f85e663c5d919655801e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
