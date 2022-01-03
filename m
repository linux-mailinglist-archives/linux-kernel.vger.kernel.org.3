Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB534834C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiACQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:30:54 -0500
Received: from verein.lst.de ([213.95.11.211]:47201 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233889AbiACQax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:30:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7096368AFE; Mon,  3 Jan 2022 17:30:50 +0100 (CET)
Date:   Mon, 3 Jan 2022 17:30:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: make pdfdocs fails on Debian stable
Message-ID: <20220103163050.GA3151@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon and Mauro,

when trying to do a make pdfdocs on my Debian stable system I can't
get it to complete.  The output below is from linux-next, but mainline
is the same.

------------
Running 'xelatex --no-pdf -interaction=batchmode -no-pdf -recorder  "RCU.tex"'
------------
This is XeTeX, Version 3.14159265-2.6-0.999992 (TeX Live 2020/Debian) (preloaded format=xelatex)
restricted \write18 enabled.
 entering extended mode
Latexmk: Examining 'RCU.log'
=== TeX engine is 'XeTeX'
Latexmk: Index file 'RCU.idx' was written
Latexmk: References changed.
Latexmk: Log file says output to 'RCU.xdv'
Latexmk: Errors, so I did not complete making targets
Collected error summary (may duplicate other messages):
  xelatex: Command for 'xelatex' gave return code 1
    Refer to 'RCU.log' for details
Latexmk: Use the -f option to force complete processing,
  unless error was exceeding maximum runs, or warnings treated as errors.
make[2]: *** [Makefile:29: RCU.pdf] Error 12
make[1]: *** [Documentation/Makefile:115: pdfdocs] Error 2
make: *** [Makefile:1772: pdfdocs] Error 2

