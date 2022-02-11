Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAD4B1D67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbiBKEnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:43:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBKEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:43:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F21105;
        Thu, 10 Feb 2022 20:43:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4666135B;
        Fri, 11 Feb 2022 04:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F039BC340E9;
        Fri, 11 Feb 2022 04:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644554599;
        bh=h8ABG3QF55r6VXzp/MBfC9UCfXS/GjvEfNNw0R9W/zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPYm1MLqvwslkzLWGI83UttcSiZW/32jE2yjmj1AzOKRBv3nfHCfvPUKE9UUZBWt6
         sOdFQC40jBjtY/F4Chf3Y9O+VqKluQG57fzngjtZc+E5re73EILP9lVvrw8pg7vwnY
         Dgf6OPLhD90BGYHU8HF0BEHO25jYwZ/K1S8qRl/llpG5xa90h59Rr+ZDMR7XTF9zZ9
         8tr7dk4xYNsA6Pk2FSgEapvUrGIh3LRfR6JhaOigJCLhc40c7v3L8NTAk1eeRI+J3a
         t45bwwhq/yC5zkvKbqg8TPnFrKRv4eIpCv10B9igNLEDXcwT5HeblvbeyVCXAMgneV
         UFKZPEsVfkgzw==
Date:   Fri, 11 Feb 2022 12:43:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qdl-phytec: add missing pmic MFD
 subdevices
Message-ID: <20220211044312.GO4909@dragon>
References: <20220128072738.157247-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128072738.157247-1-andrej.picej@norik.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:27:37AM +0100, Andrej Picej wrote:
> phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
> MFD subdevices so they can be used.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Applied both, thanks!
