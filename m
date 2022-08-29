Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71E5A5825
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiH2XtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH2XsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D0A894C;
        Mon, 29 Aug 2022 16:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECFCFB815DD;
        Mon, 29 Aug 2022 23:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C32C43140;
        Mon, 29 Aug 2022 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816809;
        bh=OW81wvyMt27kPdb6wCMng77CaUWg/2WZUezvbrn0ghM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksnQjk4vSgPF31ExZixgMAe8d5Ft8sRdRSeZYIIFzYgrUceJPyDXrTQ27RueMjL/A
         SzmY3UmHZqUcapCG/xdDiNhSFDmgrsr+XGOtgCemiEKg7nar+ub89FKuxb1sFusQCN
         rNRRnGfDF8obFEarLtIYIHSRHxBiKUAFh0P9I9FDpeNisbjO+TTH/0+6REGyvSeUEc
         Nrdp1ZL4jjB2+rDDBZ0EVbem+1E1UbHINjvASHFFHLVNs/+uxKhjMons7N/MZ/foAE
         UBKXvWeSQbbqI7iHnZHDmXAtPFz/HD252pxx9jQ2BdIcK4tJncKIezkgyuBU7pBrNj
         9h9rEsqEgFvvg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        yassine.oudjana@gmail.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, y.oudjana@protonmail.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-xiaomi-*: Add LEDs
Date:   Mon, 29 Aug 2022 18:46:12 -0500
Message-Id: <166181675986.322065.8253509414799485162.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728180120.97968-1-y.oudjana@protonmail.com>
References: <20220728180120.97968-1-y.oudjana@protonmail.com>
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

On Thu, 28 Jul 2022 19:01:20 +0100, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add LEDs found on the Xiaomi MSM8996 devices. The devices share
> a status RGB LED mounted on the front, as well as a PWM-driven
> IR LED for remote control (sometimes known as an IR blaster).
> The Mi Note 2 has an additional pair of white LEDs used as backlights
> for the touchkeys driven by the PM8994 LPG block.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-xiaomi-*: Add LEDs
      commit: d710fdfe484491679209ae0e11ac118da02f5d82

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
