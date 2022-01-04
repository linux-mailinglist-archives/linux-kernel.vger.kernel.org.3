Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961C483CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiADHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:36:29 -0500
Received: from verein.lst.de ([213.95.11.211]:48947 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbiADHg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:36:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D37168AFE; Tue,  4 Jan 2022 08:36:25 +0100 (CET)
Date:   Tue, 4 Jan 2022 08:36:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hch@lst.de, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: make pdfdocs fails on Debian stable
Message-ID: <20220104073625.GA16910@lst.de>
References: <20220104064708.GA15446@lst.de> <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:32:14PM +0900, Akira Yokosawa wrote:
> I suspect you are suffering from corrupt RCU.aux (or whatever other
> intermediate files xelatex generates).
> 
> What happens you run
> 
>     $ make cleandocs
> 
> before
> 
>     $ make SPHINXDIRS=RCU LATEXOPTS="-interaction=interactive" pdfdocs
> 
> ?

The last lines of that below:

LaTeX Warning: Float too large for page by 8477.29312pt on input line 10581.


LaTeX Warning: Hyper reference `Design/Memory-Ordering/Tree-RCU-Memory-Ordering
:forcing-quiescent-states' on page 104 undefined on input line 10593.


LaTeX Warning: Float too large for page by 9533.29312pt on input line 11384.


LaTeX Warning: Hyper reference `Design/Memory-Ordering/Tree-RCU-Memory-Ordering
:forcing-quiescent-states' on page 104 undefined on input line 11394.

[104] [105] [106]
! Dimension too large.
\color@b@x ... #3}\kern \fboxsep }\dimen@ \ht \z@ 
                                                  \advance \dimen@ \fboxsep ...
l.12718 \end{sphinxVerbatim}

? 
