Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16801484EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiAEHfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:35:10 -0500
Received: from verein.lst.de ([213.95.11.211]:52485 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbiAEHfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:35:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7C4868AFE; Wed,  5 Jan 2022 08:35:04 +0100 (CET)
Date:   Wed, 5 Jan 2022 08:35:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220105073504.GA3524@lst.de>
References: <20220104064708.GA15446@lst.de> <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com> <20220104073625.GA16910@lst.de> <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com> <20220104131952.GA21933@lst.de> <2fb003aa-545c-31a4-1466-8c3c3fc708fb@gmail.com> <0ee407a1-ff5a-4c04-a99e-045cfe90d850@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee407a1-ff5a-4c04-a99e-045cfe90d850@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:47:40AM +0900, Akira Yokosawa wrote:
> > See my pending patch set at:
> > 
> >     https://lore.kernel.org/linux-doc/e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com
> >     [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
> > 
> > This uses Inkscape if it is available instead of ImageMagick.
> > No imagemagick nor librsvg2-bin is required.
> > As long as if you can trust Inkscape...

I haven't gotten to try that yet..

> Alternatively, you can avoid ImageMagick by installing
> graphicsmagick-imagemagick-compat instead of imagemagick.
> 
> I'm not sure what you think of GraphicsMagick, though.
> 
> If you'd like to try, do:
> 
>     $ sudo apt install graphicsmagick-imagemagick-compat ghostscript gsfonts-x11
> 
> This will remove ImageMagick.
> (You have ghostscript and gsfonts-x11 already installed, I guess.)

This works just fine, thanks.
