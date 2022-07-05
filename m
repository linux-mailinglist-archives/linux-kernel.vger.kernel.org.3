Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA232566047
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGEAmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC492BEA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F7F616ED
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA609C3411E;
        Tue,  5 Jul 2022 00:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656981763;
        bh=NH5c7njVSOspj3x3CMKvmR0zmbbUmwx4E9ZZYbEUmyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cML8F2/rNnHbks8e7CnqUhOmIdkzwwsccL1VmbQy1N2i896KnOAyzzcV3IQUw1bun
         j4wTeQLNJ9g/xMhFZUcxNQ+dywd34+nYX2acDwVvOMgiInFIKtXsefmpSyizqVknnM
         b7hftZlzd3RUANdcMcdUiaB/qXh3GqfM5UdNLZnt3l1astEM0M8K5ny93L1nZHmdtH
         WeRFtSh7WOBl/Hl/Vfpay2u18ChiFwaXNlOg9VgXlLpXvH1+HuHeiIaDWTUrspVb7m
         p2gnRyMtBxZuJJGAX3yv9ZbePsBuE8dM/atdGFhOYKu0YROHQovEZ1YP5l+yyLiPih
         WoRW00tur0vZA==
Date:   Tue, 5 Jul 2022 08:42:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, michael@walle.cc, arnd@arndb.de
Subject: Re: [PATCH -next 1/2] soc: fsl: guts: fix return value check in
 fsl_guts_init()
Message-ID: <20220705004237.GP819983@dragon>
References: <20220628140249.1073809-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628140249.1073809-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:02:48PM +0800, Yang Yingliang wrote:
> In case of error, of_iomap() returns NULL pointer not ERR_PTR().
> The IS_ERR() test in the return value check should be replaced
> with NULL test and return -ENOMEM as error value.
> 
> Fixes: ab4988d6a393 ("soc: fsl: guts: embed fsl_guts_get_svr() in probe()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied both, thanks!
