Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5E5175E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386681AbiEBRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbiEBRg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:36:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4525DE;
        Mon,  2 May 2022 10:32:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D072E5C00A4;
        Mon,  2 May 2022 13:32:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 May 2022 13:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651512775; x=1651599175; bh=O38fQ+vhsG
        3gGTdn+UJjK1HqNAThZrZHdOVpoaDuDIc=; b=MfRDZYe8MasDLw7mnSR0nMcXO6
        4/BCqUrbkFqYZBEg0l+kIuUu6oDux71JQEo4L3/7mxaUcoK9AFLnkicX5gwhdHWN
        jBxjAWO3MdnwOVQ4ez83ZxnoyOWmbSp3YHhyqleeDE+HBesK93l7m5KUTujlaJ8s
        0PfRo43FJ5WOdd31QrOF/H5kAAr1twj/vgproC2yiRYRGE/Ps1kgFFmTd/pXRfzq
        SjRGwbqxkBL4PpMVh+fKGoFh4FytcqeAv/9sbZ1uW7rO+2+vt6/PULnkpeLPP9x9
        LKs3sNjOxlENZiGVC6uRyUrH7ww1I2j+NxJC0BAW5qRnjCwxSdv3/OqZy9mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651512775; x=
        1651599175; bh=O38fQ+vhsG3gGTdn+UJjK1HqNAThZrZHdOVpoaDuDIc=; b=E
        NFahZAk5ymZsCbb2bg/Gia3AhsCEykD3oglo8tKhbCiyBDXqLGzlxuhGI01p+To5
        xGR77tObewUcCG1ALI5rvG54B/1fmHLfECDhSGCvgYxovwQVDBLlBXXRHutaex9C
        Buo7PTm/0Fs+wPvPzrxTSfuCqr/RgtbVqKsxgvfTAYcWcfCb5rFzY39I4bCYR/vg
        4mDbX9Dqj4F7zO63SFgbu7DIV0eWuT88dmqa5aadVsIOp2mofsdrc8U69OufaHIE
        ta8fV8z06i0MxmsYBU+0llN98//hGRCrBQqQq/zQkQFWTY35/TefXboiOnkqwUmk
        GbTlug8kJY/sjPd7XT2bg==
X-ME-Sender: <xms:xxVwYhy2SpiN1vpHDohvZSnkv7UOWSEA1CYaZrVUV1sy2y8L7CX8gg>
    <xme:xxVwYhTOMmlbD4v814N_qBA2LzTYZwNHjENTONxPWKC2WM7lOyEGKEEMsVEV8lWS6
    EIEEGsK_uEiSg>
X-ME-Received: <xmr:xxVwYrUOmLnZKFDuC0Xcj0dGMzd_MNZh8xq0GZyyemV9Jl-kk1JnShAYy1j3wEy8qbeM76wOARdSAKSVdul1zR8syJ8DQXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:xxVwYjhNtGyCWWcsHe0GmGDF8X-J5IFvMV_pQLxcl2kmHgXxXJ8uIQ>
    <xmx:xxVwYjD1CEJmfWGEmVqyU_0Qy-CEFvziBfrFk8CZ-XESFJqJ-EpBfg>
    <xmx:xxVwYsIhQFO4fw5hIX51dstWR7fAk8I8saF5VsyRJZzy8Mu2Qp9khQ>
    <xmx:xxVwYn4zV4CuB7AdrMyFHv8zUngSDZ9eWG1s_x4BaKa8GF7ENN6_MQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 13:32:55 -0400 (EDT)
Date:   Mon, 2 May 2022 19:32:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YnAVxtQNOOhtz3lO@kroah.com>
References: <20220502210728.0b36f3cd@canb.auug.org.au>
 <Ym/DPS99n8K8Lltu@kroah.com>
 <YnAQRQWK6ozI8DZJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnAQRQWK6ozI8DZJ@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:09:25AM -0700, Matthias Kaehlcke wrote:
> On Mon, May 02, 2022 at 01:40:45PM +0200, Greg KH wrote:
> > On Mon, May 02, 2022 at 09:07:28PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the usb tree, today's linux-next build (x86_64
> > > modules_install) failed like this:
> > > 
> > > depmod: ERROR: Cycle detected: usbcore -> onboard_usb_hub -> usbcore
> > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > 
> > > Caused by commit
> > > 
> > >   c40b62216c1a ("usb: core: hcd: Create platform devices for onboard hubs in probe()")
> > > 
> > > I have reverted that commit for today.
> > 
> > argh, I thought the build issues were fixed :(
> 
> Sorry about that :(
> 
> The *build* issues were actually fixed, however I did not try
> modules_install ...
> 
> > I'll go revert that series from my tree later today, thanks for the
> > report.
> 
> I think the dependency situation can only be resolved by linking
> onboard_hub_create/destroy_pdevs() into the USB core module. My initial
> idea was to build them into the kernel binary, however that doesn't
> work because onboard_hub_create_pdevs() calls usb_of_get_device_node(),
> which is part of the core module when CONFIG_USB=m. The two function
> are relatively lightweight and don't depend on internals of the
> onboard_usb_hub driver (besides the device id table) so linking them
> into the core module doesn't seem too ugly.

I'll try to look at this next week, it shouldn't be that complex.  If it
is, something feels wrong...

thanks,

greg k-h
