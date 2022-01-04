Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06A448423E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiADNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:19:58 -0500
Received: from verein.lst.de ([213.95.11.211]:49861 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbiADNT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:19:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 419CD68B05; Tue,  4 Jan 2022 14:19:53 +0100 (CET)
Date:   Tue, 4 Jan 2022 14:19:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220104131952.GA21933@lst.de>
References: <20220104064708.GA15446@lst.de> <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com> <20220104073625.GA16910@lst.de> <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 06:31:01PM +0900, Akira Yokosawa wrote:
> Hi, getting back to the error message, I remember seeing a similar error
> when I failed to permit PDF output of ImageMagick.
> 
> What I did back then was this (as root):
> 
>  # cd /etc/ImageMagick-6  
>  # sed -i 's+policy domain="coder" rights="none" pattern="PDF"+policy domain="coder" rights="read|write" pattern="PDF"+' policy.xml ; \
> 
> In case this resolves your issue.

I've definitively seen permission denied errors earlier in the (rather
noisy) build log.  But I absolutely do not feel comfortable changing
global security policies for a kernel build, especially for something
like ImageMagic that had its fair share of security issues.  Is there any
way to side step this by using a different tool?
