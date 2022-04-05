Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC794F2220
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiDEETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiDEETQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108C7665E;
        Mon,  4 Apr 2022 21:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D386136F;
        Tue,  5 Apr 2022 04:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA07C340F0;
        Tue,  5 Apr 2022 04:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649132179;
        bh=WTPtM2b2ZKDKexhibsDpSmeAHFn61p8jAZEY8Se0LHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsaCAE7ioMMRJAtVrCYEXXg9XLk1bT7czgRscGZ0P9wH3xsyMBnVmzOeMz49Khzh3
         cBsaNVSJ1w5crxDdMY9000khoqP/fhJVZ2oeOFQkCMH1comYraDYXJDlslDPzqmPnl
         0QNWKs8fCKM/XV1VRpPKSy9/Hibz2DBR/AkXh+DAMn73myhC2R9kDD4iDfcNkmqKJh
         vA4sjricMGXWi28oIOQ+BQk1jsVAkwTn8zvY8ct357InwSV38tdRUYHmeSw3I9B2ge
         NZ8kIGuPWPjsKQr2xcqnvoNLc5XFkerUlQ8vl9Hi8tUYe77/cgSb7L9dYDcTyWj9Ev
         4ofOfLe45g2Pw==
Date:   Tue, 5 Apr 2022 09:46:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
Subject: Re: [RESEND v7 0/2] Add support for SoundWire1.6 audio cgcr register
 control
Message-ID: <YkvCj7LCZfhd92wB@matsya>
References: <1646317851-14414-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646317851-14414-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-22, 20:00, Srinivasa Rao Mandadapu wrote:
> This patch series is to add v1.6.0 compatible name for qcom soundwire
> driver and corresponding dt bindings.

Applied, thanks

-- 
~Vinod
