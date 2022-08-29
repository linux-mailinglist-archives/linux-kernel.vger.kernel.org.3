Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D35A57E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2Xqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiH2Xqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186459F8FE;
        Mon, 29 Aug 2022 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 221BAB815C6;
        Mon, 29 Aug 2022 23:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46637C43142;
        Mon, 29 Aug 2022 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816787;
        bh=UfPtaupXTtCfFxCnApqirwVWwfvDHvDQIJVpMrNPK4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pc+T76YvNmqKVs70qvtm3ICPZ8c8k4Mqwx5//22OcKqDk4I+lGwDwfJEordSSZq7B
         q7ocdvLkP+NU8filQX7JP8L8JIEJv3ADHDh5DYvtl7NGYqzZYT2+Iwe94r54yB1zSp
         9fouiAAE4ARkKSzg+wfpj8mL4Na9TBu89tw7OCT3rlSzfZxgD/fZQz0vBoDme010Lx
         nmPHsPTYbkR+ksG3xmYl0Yh7qsidDez7/LwXTPOw1Yh4vhvS0QYZJnLQROZKLmh0Em
         QElnbPSwDu6lGF3P6j7phsVPEYaZU8I1tR4TIquqB6XXOu85Oy4Ap3eZ/vNYYhRWiN
         yF+8VXPn6IpFA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     geert+renesas@glider.be, Bjorn Andersson <andersson@kernel.org>,
        mollysophia379@gmail.com, konrad.dybcio@somainline.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] [RFC] arm64: dts: qcom: sdm845-xiaomi-polaris: Fix sde_dsi_active pinctrl
Date:   Mon, 29 Aug 2022 18:45:50 -0500
Message-Id: <166181675969.322065.3037250302994676765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <629afd26008c2b1ba5822799ea7ea5b5271895e8.1660903997.git.geert+renesas@glider.be>
References: <629afd26008c2b1ba5822799ea7ea5b5271895e8.1660903997.git.geert+renesas@glider.be>
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

On Fri, 19 Aug 2022 12:14:23 +0200, Geert Uytterhoeven wrote:
> "make dtbs_check" says:
> 
>     bias-disable: boolean property with value b'\x00\x00\x00\x00'
> 
> Fix this by dropping the offending value.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-xiaomi-polaris: Fix sde_dsi_active pinctrl
      commit: 5a0504945878b4af7534c1ce668a5678dc0201cf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
