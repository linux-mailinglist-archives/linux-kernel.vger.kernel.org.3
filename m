Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D685576098
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGOLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiGOLet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:34:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955DC201A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB8CB82B88
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282FC34115;
        Fri, 15 Jul 2022 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657884876;
        bh=Gg9+rPfHnCv/g2fost5hnrWOOpgML/L64l2+FxYBMRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THwnBxzRcyhE5VjGQQ7K+awANTYSKYvRRM9ifEdfOuZodd71H0lp3za4HTl+knLYw
         6d8NT/IiX2NordgRXumj9xX+l0Epp/IMzjXKEoD7P0eEQkxdLKOCiyTvSGdPyZoojh
         I3AzD6EgHENSsnCbDILyDaNVSYaSN18ushW0aDFbQB5wosG7T4VjtJ+5ldv5dL5Dr2
         K0HRRpLGohWxC0sBwjLUIHQ8ttw5DopSeCdIBEy8yBnQxhQq+iYx42j3dIJCG0mC/u
         8FU3inju9RKI39rRUGH1dbZE9aEhyCGj5jiq+DVQqU4lEgIiKS/yN06aUf7Miywe+3
         XLXJ6rOoG5MZQ==
Date:   Fri, 15 Jul 2022 17:04:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     kishon@ti.com, amelie.delaunay@foss.st.com,
        alexandre.torgue@foss.st.com, linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: stm32: fix error return in stm32_usbphyc_phy_init
Message-ID: <YtFQyBCc2IRXOptK@matsya>
References: <20220713133953.595134-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713133953.595134-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-22, 15:39, Fabrice Gasnier wrote:
> Error code is overridden, in case the PLL doesn't lock. So, the USB
> initialization can continue. This leads to a platform freeze.
> This can be avoided by returning proper error code to avoid USB probe
> freezing the platform. It also displays proper errors in log.

Applied, thanks

-- 
~Vinod
