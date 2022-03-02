Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1923D4CA951
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiCBPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiCBPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:43:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7794C2B;
        Wed,  2 Mar 2022 07:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B2A2B81F2D;
        Wed,  2 Mar 2022 15:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DD4C004E1;
        Wed,  2 Mar 2022 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646235773;
        bh=7IYRL+GavLmgyLRpxHba+gbdrurgtbY4Z97aGoux0xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9bcaRPydA5rE7UiWO+AwDn8Dw2XEyrI7axyNYrCDDuYn6BTHy8G+NOeJWrOCyxOc
         pEeY7E2sPPS2gL2hbFbKbhuW4S2l50kkI5DhQAVX2nfFqpsQ4Kq3KEevr2/GLPUiw0
         mxlPRuHI569S7IQdon+YbCxs7++L6f1RrW4qLjxKtXoC+uFyxCITuANeGP0VeJrsy6
         VsJnrzwlcSOlS6Q4VLw6HnrXJesLUbGHkDQBr1vY6T9pr19KulOfAFch1z/G84TXtj
         NOegoTsBZrLhMNRMWK30XpekBE7sYDJh3VXwzTw81fO2yUUCayvYQArluvl3VAFBIa
         VreWrZefN5Lbw==
Date:   Wed, 2 Mar 2022 21:12:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com
Subject: Re: [PATCH v3 0/3] soundwire: qcom: add pm runtime support
Message-ID: <Yh+QeWEufbp2JLo+@matsya>
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-02-22, 17:25, Srinivas Kandagatla wrote:
> This patchset adds pm runtime support to Qualcomm SounWire Controller using
> SoundWire Clock Stop and Wake up using Headset events on supported instances and
> instances like WSA which do not support clock stop a soft reset of controller
> along with full rest of slaves is done to resume from a low power state.
> 
> Tested it on SM8250 MTP and Dragon Board DB845c

Applied, thanks

-- 
~Vinod
