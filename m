Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512874FAB64
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiDJBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiDJBgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:36:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE531513;
        Sat,  9 Apr 2022 18:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE771B80A39;
        Sun, 10 Apr 2022 01:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBAC385A4;
        Sun, 10 Apr 2022 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649554475;
        bh=KfRlfSwdB8hKBO6z1BzNiK0UV2Dwf/89V217roDiQTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agtXDePfFNjJm5uSBIsCFmuKaejb4tsU2zSZhCoQgX33WWQRWWrL4M3b/HFD5LM/9
         SG9hfwKLkLpJhmO5cXABQ7sV1FiXwEdp7jO98ng1bVumJF0xetZuQJfj3v3xN9yRAd
         kTiq32R/bdRTY0pl40dO1QVS4XdBjKuIwmLOxexIJC8vt11K3yRzJRLFPZOka11+sJ
         Gvx7I4+7ewBtImvfPJRxy0UCTzbep+BZZ2BXh2qOwnvOBf4bPIzZsAJ2tST06ip9wE
         eNfAxLkgJPOS0pjzkMSjmtdd75rdAVFRpHgvd8RcEhFZl2MPgIa29ByLUFhvlkISKR
         xkvcZyrM4Fvzw==
Date:   Sun, 10 Apr 2022 09:34:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, s.hauer@pengutronix.de,
        manish.narani@xilinx.com, michal.simek@xilinx.com,
        dinguyen@kernel.org, bp@suse.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] arm64: dts: imx8mp: add ddr controller node to
 support EDAC on imx8mp
Message-ID: <20220410013428.GM129381@dragon>
References: <20220321075131.17811-1-sherry.sun@nxp.com>
 <20220321075131.17811-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321075131.17811-3-sherry.sun@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:51:31PM +0800, Sherry Sun wrote:
> i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
> for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Applied, thanks!
