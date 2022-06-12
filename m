Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B46547843
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiFLC2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiFLC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 22:27:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18A69CEC;
        Sat, 11 Jun 2022 19:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F1DB80B4C;
        Sun, 12 Jun 2022 02:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B787C34116;
        Sun, 12 Jun 2022 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655000876;
        bh=K7ezTnzPO+4XQNX3x8S29NvyUEPPvYUDUxrNHyOeOVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLwipXQ2L0CeqRd2M19FRb4lWY1ZzsHmdAyB8xBK1JGvBi+FguVTAUnlIVvQstOam
         8j546bp8fhwb6zTbmgH+hNMqIn1Nzc4WB4zaKpGLxlwPjOSNmmLaAlBF7OSHHmoV01
         CSZ3oVCQMqVOl/ythHR2J9Vi869oiQvJ7NXUV6vXO2pGLbEMgE6Bxz0KAYYRKFIy0E
         Ow8BYee6D6RNJ5hmb5x1OttaK4j6UDDa/yD943iuc12kPB14ElNIHqVkKpuQFgmal3
         iHZHpSUPsm1E+TFBKpsZkqhgsv40h8oxoyzAbsHf5OUVhlw+husahDBcJkGr69SGok
         VVcMRYE1X1L+w==
Date:   Sun, 12 Jun 2022 10:27:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls-10xx: use generic dma node name
Message-ID: <20220612022750.GR254723@dragon>
References: <20220526035449.4062846-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526035449.4062846-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:54:49AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> dma-controller is preferred for dma node.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
