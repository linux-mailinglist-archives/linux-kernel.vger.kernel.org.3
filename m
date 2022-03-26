Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDB4E813B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiCZN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiCZN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDDCDF4BC;
        Sat, 26 Mar 2022 06:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0998A60ECC;
        Sat, 26 Mar 2022 13:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38069C340EE;
        Sat, 26 Mar 2022 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648303046;
        bh=HOkf7BpuW7qajUziuSzll9yU+W0M8a5zkgH+oxR3DWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U6Wj317tVd3AyMzFoTmf+nKzV4OKlWThsgcIwY5E0UM/pDcJzNS9yCA5JS7otIYw7
         frT1XFE+94ZF087u+xjRV9nG4/fMhI7iSwToRH8QOq3sGffKU7LwDtT+BjqVQGbGus
         8pkkFKc5yIqmJ4EC+PWPHdqwJ4cyPpb1NklemlrNahuj5Sv1yBOH3rB4KtRWWXFQV8
         qmK3kAClKQXQncYsi1mRHJB8szWmgHqFWV39sPENg7JCFcE6erM9pr71OGeHMxMOIW
         auDzVWxZqMAKTyOGbZGjzPIBoSji8SaVWgNViIejLpzLAp4e9SnEUU2wlhSS7sjrzx
         Eb+MsaFjaOvIA==
Date:   Sat, 26 Mar 2022 14:57:21 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Documentation: sphinx: replace "Introduction"
 chapter heading with page title
Message-ID: <20220326145708.7926b29d@coco.lan>
In-Reply-To: <20220326123337.642536-3-bagasdotme@gmail.com>
References: <20220326123337.642536-1-bagasdotme@gmail.com>
        <20220326123337.642536-3-bagasdotme@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 26 Mar 2022 19:33:38 +0700
Bagas Sanjaya <bagasdotme@gmail.com> escreveu:

> Replace first chapter heading ("Introduction") with page title named
> "Using Sphinx for kernel documentation". This way, the first-level TOC
> for doc-guide contains title instead of chapter headings for this page.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  Documentation/doc-guide/sphinx.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index bb36f18ae9ac3e..2ff1ab4158d48e 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -1,7 +1,8 @@
>  .. _sphinxdoc:
>  
> -Introduction
> -============
> +=====================================
> +Using Sphinx for kernel documentation
> +=====================================
>  
>  The Linux kernel uses `Sphinx`_ to generate pretty documentation from
>  `reStructuredText`_ files under ``Documentation``. To build the documentation in



Thanks,
Mauro
