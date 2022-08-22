Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F759B805
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiHVDfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHVDfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:35:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E7201AD;
        Sun, 21 Aug 2022 20:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9DF3B80E62;
        Mon, 22 Aug 2022 03:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54031C433D6;
        Mon, 22 Aug 2022 03:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661139347;
        bh=NLLdBI3ErvUa4uYt6JLzq2qOjMRMd3yt3lW6sZpK5r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krMsVvzGtJcxVW2QfVVBJx6lgrGa0MlVEj1RYiMDD833KlTshbNfxfgp/0+VFIAOH
         SPGSCXO3m5BwSRqn58flBW5H4GyKq0ya8I/AIlolBzlFObjIrFrjZWoAJ2XREpNURK
         3+K9tHs/8y5SejdNBVITiHFd/YPS5aBrGAM9kY2JD+wsifB26cP5HimF3YvkuK4se6
         eE/bv3rAjRCGqhDNR2nj+pjpk/eumOdiIbAzncTmJaZQV2/gZYYhPw4tqGXhF/Enur
         SoC7O4HzgpFDynLYkWetKQUlv+ooLWIwPIrRL8DE9adoJwe4jOWAg831XxkPFh1nZN
         d2gfz6uj4Axrw==
Date:   Mon, 22 Aug 2022 11:35:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] lx216x DTS updates
Message-ID: <20220822033542.GQ149610@dragon>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817202538.21493-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:25:36PM -0500, Li Yang wrote:
> Some accumulated updates for lx2160/lx2162 SoC and boards.
> 
> v2 updates:
> - Dropped duplicated "arm64: dts: lx2160a-qds: enable sata nodes"
> - Removed binding patches which are applied in fsl-soc tree
> - Enables optee-tz in the missing lx2162a-qds board
> - added new patches "arm64: dts: lx2162a-qds: add interrupt line for RTC node"
> - added new patches "arm64: dts: lx2162a-qds: enable CAN nodes"
> 
> v3 updates:
> - Dropped "arm64: dts: lx2162a-qds: enable CAN nodes" merged
> - Added new "fsl,lx2160ar2-pcie" compatible and use it dts update
> - Changed pcie_ep node name to pcie-ep
> - Added Fixes tag for "arm64: dts: lx2160a: fix scl-gpios property name"
> 
> v4 updates:
> - Dropped patches from v3 that have been merged
> 
> Li Yang (1):
>   arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon
> 
> Xiaowei Bao (1):
>   arm64: dts: lx2160a: add pcie EP mode nodes

Applied both, thanks!
