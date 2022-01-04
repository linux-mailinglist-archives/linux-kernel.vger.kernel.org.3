Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4AD483DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiADIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:16:58 -0500
Received: from verein.lst.de ([213.95.11.211]:49077 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbiADIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:16:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C82668AFE; Tue,  4 Jan 2022 09:16:54 +0100 (CET)
Date:   Tue, 4 Jan 2022 09:16:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220104081654.GA17682@lst.de>
References: <20220104064708.GA15446@lst.de> <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com> <20220104073625.GA16910@lst.de> <df9183cc-aecb-6b8d-0580-92c2a678d69f@gmail.com> <20220104075655.GA17315@lst.de> <931f9f77-e418-4359-65b1-cb7432e37a0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931f9f77-e418-4359-65b1-cb7432e37a0f@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:07:20PM +0900, Akira Yokosawa wrote:
> > Current linux-next.  But I've also seen it with mainline from a few days
> > ago.
> > 
> 
> Still can't reproduce with sphinx-build 4.3.2 on Debian bullseye.
> 
> What version of Sphinx are you using?

The one that comes from Debian:

hch@brick:~/work/linux-next$ sphinx-build --version
sphinx-build 3.4.3
