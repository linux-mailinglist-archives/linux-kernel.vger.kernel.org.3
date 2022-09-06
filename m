Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFA5AF133
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiIFQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIFQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E1248C0;
        Tue,  6 Sep 2022 09:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E776159A;
        Tue,  6 Sep 2022 16:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE53C433C1;
        Tue,  6 Sep 2022 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482314;
        bh=6/CdKGlfq3OAOR+FjUbyLJY/bKq92frvKJFpNWVPDUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1IdA04C8DoptpVhrSG6i09TJyEdvM0WUY0WeRxWOBNajKmwSMje8LSqigxXU+rZY
         IipbqEueTxsw7EpeQrEjhN4C7H0+Df7Jq/rkgULQqEWctRJYafnZ90wM5QJQvzUhg2
         /01Q5zIv0/0l3W9GY1hviqLuqnhgYK/CKvN5ZR1M1PQDDxciEpNYPPTLBLTOVIvnya
         rLVEbMkBA364aEWAaAeAri4QcxqD9S3K4cH9vy5vfTzDgtw1ocoLB2r2VIApVLlnx4
         nxs7Zvadx2P70rWvf6pE8xfJxu9zcTozGyLfqrSWO7yJ4p97ssOpFagCAmTIDwo5sF
         fKp39oKBDGAug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org
Cc:     bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, agross@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry & use correct node name for pmc8280c_lpg node
Date:   Tue,  6 Sep 2022 11:38:26 -0500
Message-Id: <166248229990.53237.4180188464536295468.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905070240.1634997-1-bhupesh.sharma@linaro.org>
References: <20220905070240.1634997-1-bhupesh.sharma@linaro.org>
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

On Mon, 5 Sep 2022 12:32:40 +0530, Bhupesh Sharma wrote:
> Commit eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
> dropped PWM reg declaration for pm8350c pwm(s), but there is a leftover
> 'reg' entry inside the lpg/pwm node in sc8280xp dts file. Remove the same.
> 
> While at it, also remove the unused unit address in the node
> label.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry & use correct node name for pmc8280c_lpg node
      commit: 7dac7991408f77b0b33ee5e6b729baa683889277

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
