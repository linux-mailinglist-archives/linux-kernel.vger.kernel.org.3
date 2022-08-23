Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBD59EB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiHWSdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHWScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172010BE3D;
        Tue, 23 Aug 2022 09:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AA32B81E97;
        Tue, 23 Aug 2022 16:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769E3C433D6;
        Tue, 23 Aug 2022 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661273673;
        bh=p88vJDhjNhP/UYOBR252hX3zvo246PNcPZEo6vSfkQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gydzuzv2SgN9i5w0v/C1Irov18C7R5zy2J67Oa4qbnQtUDhgXPWFYfRS5vXr9tD6I
         SHFsJKJODBTncZsOApYE3ILI2kDQZz06ky+ivm5qe/kLbNZgZHldBuHtGuSci209gZ
         DBQhlPFlNP6TBCQL1jlGQhcBK7yPbfck9YHg31LvyXY8choe/7kLqS4hzWP4E9QQVZ
         QdU/Og8fB4Th+6Ra1f3Rt+n+Y6lgsRCLdxNFya01U//GQH5BNpNPE/4pIGrywDfdMO
         syfmLGPSUIoIonGdTdzZqkfI0CR53NqQFRjzYGrN8MWvjtjy8ewbqvT30FpVs4Kavp
         DRKJyB5PjBHEQ==
Date:   Tue, 23 Aug 2022 22:24:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [PATCH v2] soundwire: qcom: Update error prints to debug prints
Message-ID: <YwUGRGhDCXbhrHVn@matsya>
References: <1657724067-19004-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657724067-19004-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-22, 20:24, Srinivasa Rao Mandadapu wrote:
> Update error prints to debug prints to avoid redundant logging in kernel
> boot time, as these prints are informative prints in irq handler.

Applied, thanks

-- 
~Vinod
