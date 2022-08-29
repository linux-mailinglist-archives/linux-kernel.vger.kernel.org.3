Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEB5A582B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiH2XtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiH2XsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77EA4B2D;
        Mon, 29 Aug 2022 16:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5B5F6139D;
        Mon, 29 Aug 2022 23:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91A3C43142;
        Mon, 29 Aug 2022 23:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816810;
        bh=mAZQAuX5IgZWvMvOMkmcYomCsRbRNXLz0UWREs9NcwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCgG6mcYfEbUiMwkOafhqQv8UHNFy1XiQdFSpFz/a3KjIfyHUskod/TkQbBBscVcH
         bc86OnF2Akeu/AFCWLT2IxA2jn4i35/LLRlWsQanhzevZeBi8pQAYismgOZ9ru13sl
         V30cF6mObhI6ZbOuZMij/WDHMLo3BPJefObzI6i8VNnNNLyFcUnSwD1LkSb7+xHCuN
         LBrSiqaljhbG6DtbwA2UKqTqOJt763YinAE7B/oTOhCUlPZCGlGnhJQ6pXWt4qNfY9
         DwPlIqPB8oi0GieKNgQfYgdL65XXS+f48GHWIkWq6MNSXrCBdiRNBWwDhl1Hf+SQFT
         CnZtFWW3aE9Xg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     yuehaibing@huawei.com, Bjorn Andersson <andersson@kernel.org>,
        agross@kernel.org, konrad.dybcio@somainline.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next] soc: qcom: Make QCOM_RPMPD depend on OF
Date:   Mon, 29 Aug 2022 18:46:13 -0500
Message-Id: <166181675968.322065.9716517624418535521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820113202.23940-1-yuehaibing@huawei.com>
References: <20220820113202.23940-1-yuehaibing@huawei.com>
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

On Sat, 20 Aug 2022 19:32:02 +0800, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
>   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
>   Selected by [m]:
>   - QCOM_RPMPD [=m] && PM [=y] && QCOM_SMD_RPM [=m]
> 
> PM_GENERIC_DOMAINS_OF depends on OF, so QCOM_RPMPD also depends on it.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Make QCOM_RPMPD depend on OF
      commit: 0e5732e4d58437feded42fb459384904eb317e91

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
