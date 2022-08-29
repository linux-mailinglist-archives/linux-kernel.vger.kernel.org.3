Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3655A5A5803
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH2Xrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Xq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507A99275;
        Mon, 29 Aug 2022 16:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 948A4B815DF;
        Mon, 29 Aug 2022 23:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F11EC43143;
        Mon, 29 Aug 2022 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816793;
        bh=nbIJOCT12GlOluQhZDKLFdZySetlRkSLo5au+V/yapE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aolZMjhttp7L5MrDhhEi54T7aYUVg3PSG0V77dMsL5CbCRDldDs+5Y5e+6ECol3yr
         0/gWmllgusVs255uCGLLSeu9v969xNvnuxhIGVi/x8NUBMWLHE3a7tA96tKgR9gITx
         G2wPHJdTNDLH5UBDi+ft5I+QfPEIN5nTBj72b2lqVCd0CJmhePCqYW3SpbgNPqD0IX
         4XgYa+Q+66R3yaGU7/yecoLwjfy+20JJvn9dNBW8giYdw9WmtLTsuQ22RJc1HlkapN
         nnkHhKb+6r3knJ5UGx6Z0cOSjQcMrNWDeQ+W9yNI+xgkautVx6TZ02rqOxNhpClhl8
         BIkOsi+6tuRgg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH 1/4] ARM: dts: qcom: msm8960: override nodes by label
Date:   Mon, 29 Aug 2022 18:45:55 -0500
Message-Id: <166181675978.322065.8113362437480273235.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
References: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 10 Aug 2022 11:05:13 +0300, Krzysztof Kozlowski wrote:
> Using node paths to extend or override a device tree node is error
> prone.  If there was a typo error, a new node will be created instead of
> extending the existing node.  This will lead to run-time errors that
> could be hard to detect.
> 
> A mistyped label on the other hand, will cause a dtc compile error
> (during build time).  This also reduces the indentation making the code
> easier to read.
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: qcom: msm8960: override nodes by label
      commit: cb9d7639491466d7296d30ec43045391c3a34651
[2/4] ARM: dts: qcom: msm8226: override nodes by label
      commit: c77ad7f3ba7ffa05f49516732886f5feed95793b
[3/4] ARM: dts: qcom: msm8660: override nodes by label
      commit: 5bd858a82ab77333b41bda9049fbaf6f878c11ab
[4/4] ARM: dts: qcom: msm8660-surf: move fixed regulator out of soc
      commit: 7c7a05390b5e4f44787b6703e5a3b836c3327b0f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
