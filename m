Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBE4B3362
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiBLGJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 01:09:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 01:09:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45828E3E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 22:09:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A66C60A67
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 06:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC661C340EF;
        Sat, 12 Feb 2022 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644646152;
        bh=XlkjUTLUbDkHcOOfar01boHmpapUmprsFVkSyJ5UNr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnXScDfd6cgqj09Ui/Ds9+ifGSvCeurCDf3zkFNv3LRmahaRlzQZRo+OkRBP9sKum
         6QxkMcdxOF8ppDat9+PUEi7QNTVMwjjbBOtIzloaq12VzXm8OCcd/738Qwi94xlhzy
         dxkZq9+BNOAgjUEZO6NgrWkbOYWWE2wD+D7DypCikZ+ZLcH8nuaZ6FYowc2DV+vdeT
         wNk3vyomZnZ3qE+YpG7QEoHLxjgxJ3LegdHl9d9ANwIbzU2dpdrCzUTsS2LioofU7s
         LMLVPgfTu15ebx4adzJHT3+yi1SN1817ilhZHz2egB5rykkztQD8VS5i+MjQSt8tCw
         dZrCqgMsMO21Q==
Date:   Sat, 12 Feb 2022 14:09:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: imx: add get resource owner api
Message-ID: <20220212060906.GC4909@dragon>
References: <20220207020540.466670-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207020540.466670-1-peng.fan@oss.nxp.com>
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

On Mon, Feb 07, 2022 at 10:05:40AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add resource owner management API, this API could be used to check
> whether M4 is under control of Linux.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
