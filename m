Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022EF4F63BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiDFPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiDFPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:41:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85A1CD7E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D178CB82271
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32C9C385A3;
        Wed,  6 Apr 2022 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649249287;
        bh=fLrN5u7BGbrpEcBI19emJ6LhV/+40Wj/PPZ1PABZiRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANlHs3LKNmHJ6cZM+ZBVLbtXEn0LIj/uHiU6FoiGWBW3d4x5NRJbLe2PLaQx1Vz+i
         iQkNZYwVEQDJgvlHntwPnB20nYjAFCf7m/Y+/tF0jeNUa5c69IDvL3eP7ccnfb6Ck/
         CEgVhOgmZ8TE4PiAOWn/x2iNBSUhXL4JXhaEboI5iwe1CYnCxp0kCodvKuEiRVSuSz
         wuC5ulQuKgF9zmSoiMjr01nw8CXpcFOQfRRyyxiWl2j2MhpMPU3uXwQR/srIEndXBM
         JaVX9qkxWfWx0ix4IuqU6/ixnA5Xc8yaT9ru8/Dq9ZK4oceATVmssm2kz2u3jVe86X
         Y6R0V2q+e0Whg==
Date:   Wed, 6 Apr 2022 20:48:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com
Subject: Re: [PATCH] bus: imx-weim: fix NULL but dereferenced coccicheck error
Message-ID: <20220406124800.GN129381@dragon>
References: <20220223035146.412499-1-wanjiabing@vivo.com>
 <20220223065815.i7qbyz2gtkgjzcwv@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223065815.i7qbyz2gtkgjzcwv@x260>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:58:15AM +0300, Ivan Bornyakov wrote:
> On Wed, Feb 23, 2022 at 11:51:45AM +0800, Wan Jiabing wrote:
> > Fix following coccicheck warning:
> > ./drivers/bus/imx-weim.c:355:18-21: ERROR: pdev is NULL but dereferenced.
> > 
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied, thanks.
