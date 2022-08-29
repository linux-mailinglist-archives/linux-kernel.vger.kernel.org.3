Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F05A57EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2Xqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2XqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532D98C87;
        Mon, 29 Aug 2022 16:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00764B815A1;
        Mon, 29 Aug 2022 23:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4D4C43145;
        Mon, 29 Aug 2022 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816779;
        bh=RUHEt5YT7FjYNW4ePBgCkIbAEcvz5B3ZIpaluI5m+jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoigymEwoFCiIkb43QDZ3eV4njZsxTiFn3JQ+kv5zcsCv3mvJ/oUVw1bk1wPMrQQZ
         l4EWjIzXNf9zNSRk2dTLLVn/9N8fDQIXTJLaoL/aPC0rVIOPgOlL6FVD5n8dBH979/
         MzOxE6PINqJhUqAK9db0MU+m0fITIYglBv5Ia75xT7bs/pGVv38aWJjM+Y4wFOYr3O
         F05uY8GQeqtu3a0aDPf+NsyFWapipYaPrN3ONGGYEsUlhe92nJV42J1avdLnpx/KU0
         PePFcsQjDur2NerARNMe7HL2pjOgsGkpC3SVrFQxUZOX+elpcZzRb4EUjHqIXPZZF3
         oKdzEo/3ccd0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org
Cc:     bhupesh.linux@gmail.com, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Fix sm8150 fastrpc node - use correct iommu values
Date:   Mon, 29 Aug 2022 18:45:41 -0500
Message-Id: <166181675971.322065.7839457488348233824.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819053945.4114430-1-bhupesh.sharma@linaro.org>
References: <20220819053945.4114430-1-bhupesh.sharma@linaro.org>
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

On Fri, 19 Aug 2022 11:09:45 +0530, Bhupesh Sharma wrote:
> Fix the 'memory access' relaetd crash seen while running Hexagon
> SDK example applications on the cdsp dsp available on sm8150 SoC
> based boards:
> 
>   qcom_q6v5_pas 8300000.remoteproc: fatal error received:
>     EX:kernel:0x0:frpck_0_0:0xf5:PC=0xc020ceb0
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Fix sm8150 fastrpc node - use correct iommu values
      commit: 1d330a6783c66ac6c569f14ecf8dd196d50c15e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
