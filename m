Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A574C70FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiB1Pwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1Pws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:52:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199D7EB21;
        Mon, 28 Feb 2022 07:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7E36112B;
        Mon, 28 Feb 2022 15:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E25C340E7;
        Mon, 28 Feb 2022 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646063528;
        bh=FuAUJa0N5Z3zphhfMynlqEJerBpQRZ5NCVKZkXGEJGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VprTpx0jqlg28TEPAjgnsQnPwdyANZxyYqLPyfs6nhvUP4tDdDNCxCLaecPFnDKOe
         K3mOuzruH85GTx1YVXCqi3FryOM5FbBpO1Rp1ZHDskHC6ScefuS351oY/N6DnPZSp3
         f8jv4N9xjmGlo41NVxvTGal0VLCobj/hEydYuSgNTt9wAWMz2jfUucAkBh2ZO9sFCo
         kewqC6q6ns3J7faSVGHVArFRo4gJzRnxq3zeEOvT4a1pGK5XnfDVwg/kPFvisH+vP9
         CWvjMcwj0vCCoWOJGXqaes5OemaWWxcXYj+MvBw4dkf0m2L6hCVSi116pE7dG3MiEp
         TDGbS+qUtokWw==
Date:   Mon, 28 Feb 2022 09:52:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] docs: fix 'make htmldocs' error in vgaarbiter.rst
Message-ID: <20220228155206.GA501015@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228023003.1653402-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:30:02AM +0800, Wan Jiabing wrote:
> Fix following 'make htmldocs' error:
> Error: Cannot open file ./drivers/gpu/vga/vgaarb.c
> Error: Cannot open file ./drivers/gpu/vga/vgaarb.c
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version
> 2.4.4 -export ./drivers/gpu/vga/vgaarb.c' failed with return code 2
> 
> Fixes: d6e1898bfa5b ("PCI/VGA: Move vgaarb to drivers/pci")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks, I squashed this into d6e1898bfa5b.

> ---
>  Documentation/gpu/vgaarbiter.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbiter.rst
> index 339ed5fecd2e..bde3c0afb059 100644
> --- a/Documentation/gpu/vgaarbiter.rst
> +++ b/Documentation/gpu/vgaarbiter.rst
> @@ -100,7 +100,7 @@ In-kernel interface
>  .. kernel-doc:: include/linux/vgaarb.h
>     :internal:
>  
> -.. kernel-doc:: drivers/gpu/vga/vgaarb.c
> +.. kernel-doc:: drivers/pci/vgaarb.c
>     :export:
>  
>  libpciaccess
> -- 
> 2.35.1
> 
