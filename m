Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096F95A5814
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiH2Xsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiH2XrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A989F750;
        Mon, 29 Aug 2022 16:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B42B815BE;
        Mon, 29 Aug 2022 23:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91874C43146;
        Mon, 29 Aug 2022 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816805;
        bh=giPzr9lSveuKVrux85VJpyx1SSHGTjr0bY0dxYC++DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cex8IpbiQh+LRK/Prp3e0NVf2zbqveH0XwFgH4PUSHUnbgMvZt8Hv4RGxjD3oZs4h
         edusJCnQWYn+iJiJT4f/FGZ/VVvqaIa9W591qDgm3gq/++4FviO8VUn7j+P+Ly5zKx
         4EBCQbuK0CkBdSu1G3MRDnJHYBjac7rszFgI0CxH1YZ7avJTfdmKPwKPjdQ7LsZxCY
         ySnODz79hBpOeNANgXzN/BvB289FwBVffGuI4e+hwPpWIe4Nqu1B9zhAS8A9kTifSv
         2jCWBfDnBjroZp1MGgow6mmWEoLGmNJt0p05JyRVbAMKRVe30j63UJQWdkyKcJWk/N
         1CYl7BX2m06Xg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, moragues@chromium.org
Cc:     mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        swboyd@chromium.org, robh@kernel.org, devicetree@vger.kernel.org,
        sboyd@codeaurora.org, agross@kernel.org
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: arm: qcom: document zoglin board
Date:   Mon, 29 Aug 2022 18:46:07 -0500
Message-Id: <166181675987.322065.2769529271938037063.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
References: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
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

On Thu, 28 Jul 2022 14:33:20 -0700, Bob Moragues wrote:
> Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> Zoglin is identical to Hoglin except for the SPI Flash.
> The actual SPI Flash is dynamically probed at and not specified in DTS.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document zoglin board
      commit: f72a9f525b98aca1ad134e163e070d614ff60a24
[2/2] arm64: dts: qcom: sc7280: Add support for zoglin
      commit: 2cb88ebe44531ba18c908e627811698c9461b4cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
