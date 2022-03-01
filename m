Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39934C9553
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiCAUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiCAUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:03:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01270336;
        Tue,  1 Mar 2022 12:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F9A461681;
        Tue,  1 Mar 2022 20:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAACC340EE;
        Tue,  1 Mar 2022 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646164939;
        bh=UUVYbmulLMUrxKXtd4GDe7HCMoTaW7UmSbQD4MyDMB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D5kGyTrI2spf/l4NhdmT6MAfu6xixhKJBqviPcNaGRRDED6ajN1UzpP5rXAYiiuia
         jTBj9CGU34KkG+O57KUHrA3ewxgVMa5RSQpdXpQa/c6cO6uE9TJYin/jEeGU+h3K79
         GNKln+BmV1OsZplf7va3TlkqAtFHEHgmgMR7P3xMJleJv8STfn4Ah+WdZMauHmpSnb
         0JMEpV8Jew1RdVjBpmik8GdluzN8ZI4PPi8+y6BsLrblZ8KiX7eaOE0G0XhL8nrN4P
         synUu/GHEihS+iTVu4SHcXDVotSKNn+tpN9DDxa73RDy6xGJB+J9Y+p0pFJMR3jWRx
         0AD9vkEDXV3VA==
Date:   Tue, 1 Mar 2022 14:02:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     trix@redhat.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        corbet@lwn.net, bhelgaas@google.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgaarbiter: fix vgaarbiter doc build break
Message-ID: <20220301200218.GA642697@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301192909.294900-1-trix@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:29:09AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> make htmldocs fails with
> Error: Cannot open file ./drivers/gpu/vga/vgaarb.c
> 
> The location of the file changed
> drivers/gpu/vga/vgaarb.c -> drivers/pci/vgaarb.c
> So update the docs with the new location.
> 
> Fixes: d6e1898bfa5b ("PCI/VGA: Move vgaarb to drivers/pci")
> Signed-off-by: Tom Rix <trix@redhat.com>

Fixed, thanks!

> ---
>  Documentation/gpu/vgaarbiter.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbiter.rst
> index 339ed5fecd2e4..bde3c0afb0590 100644
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
> 2.26.3
> 
