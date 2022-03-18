Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C404DE397
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 22:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiCRVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCRVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 17:35:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AC1DA8FB;
        Fri, 18 Mar 2022 14:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29CC1B825BC;
        Fri, 18 Mar 2022 21:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844B9C340E8;
        Fri, 18 Mar 2022 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647639253;
        bh=/Z1/M59ERRvXYmQlgycDFVEYINXXv8fogwEEU16Qt4M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZiR4AmRfKV8EXsbSsSYThjhv5snfOKECbUvrz/85NVtCPg6RpN8wdZgFA7tULHxL8
         QQVcQyzjIEav97Ihf8ZNXPBARhz5OXmTQLGXZNtYQWds/uS05G+EzB2ryVZJ5s3Zzg
         v1+/e9faKKmJOOTu1ezLrx6mY6h4XWiDiFzI3j/gFTq/AxtaBcXgmg1zdf4+lbTcOi
         6lrV3ULA1mNwkID7upto1Gif4VR71Mc6VIt5KgJR4TLKoUdv81uZqS2KkQ0TkBjRER
         zzpoqiKeFVUXSzaS49Oywk1xAsGpGcVGH5e1cZfpgSuiP9WX1gzt6hSBebkrHFLDKR
         eCecZIx2ciQFA==
Date:   Fri, 18 Mar 2022 14:34:13 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Luca Fancellu <Luca.Fancellu@arm.com>
cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/arm: fix typos in comments
In-Reply-To: <50B35A3D-9848-4B89-8935-AD3A1330D7CF@arm.com>
Message-ID: <alpine.DEB.2.22.394.2203181430300.2910984@ubuntu-linux-20-04-desktop>
References: <20220318103729.157574-15-Julia.Lawall@inria.fr> <50B35A3D-9848-4B89-8935-AD3A1330D7CF@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022, Luca Fancellu wrote:
> > On 18 Mar 2022, at 10:37, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> > 
> > Various spelling mistakes in comments.
> > Detected with the help of Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> Reviewed-by: Luca Fancellu <luca.fancellu@arm.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

I assume this patch will go via the trivial tree? If not and you want
this patch to be picked up in the Xen tree let me know.
