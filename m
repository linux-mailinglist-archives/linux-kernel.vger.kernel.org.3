Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0448355B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiACRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:11:12 -0500
Received: from verein.lst.de ([213.95.11.211]:47341 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbiACRLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:11:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF71568AFE; Mon,  3 Jan 2022 18:11:08 +0100 (CET)
Date:   Mon, 3 Jan 2022 18:11:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220103171108.GB3422@lst.de>
References: <20220103163050.GA3151@lst.de> <20220103175814.5b22a6a7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103175814.5b22a6a7@coco.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:58:14PM +0100, Mauro Carvalho Chehab wrote:
> Weird... when you do a make, it should have checked for all
> dependencies, when it internally runs:
> 
> 	./scripts/sphinx-pre-install 

Detected OS: Debian GNU/Linux 11 (bullseye).
Sphinx version: 3.4.3


All optional dependencies are met.
Needed package dependencies are met.

> Basically, you need the xelatex package for it to work, as PDF
> output is via LaTeX. This is not a mandatory requirement, though,
> as most people are only interested on html output, and LaTeX
> dependencies require to install lots of stuff. it should provide you
> a list of packages required for PDF, with a suggestion of using
> apt-get to install it.
> 
> In this specific case, I guess the package name is 'texlive-xetex'.

texlive-xetex is installed and seems to work find on various other
documents produced earlier by make pdfdocs
