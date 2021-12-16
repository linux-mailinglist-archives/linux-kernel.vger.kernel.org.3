Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C60476BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhLPI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:28:38 -0500
Received: from verein.lst.de ([213.95.11.211]:59569 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhLPI2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:28:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1FC168AFE; Thu, 16 Dec 2021 09:28:33 +0100 (CET)
Date:   Thu, 16 Dec 2021 09:28:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     broonie@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: manual merge of the nvdimm tree with the ext4 tree
Message-ID: <20211216082833.GA24677@lst.de>
References: <20211210174740.2695216-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210174740.2695216-1-broonie@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:47:40PM +0000, broonie@kernel.org wrote:
> I'm not comfortable with resolving this in something as critical as ext4
> at this point on a Friday evening with the code motion that's going on
> so I've dropped the nvdimm tree for today, I'll look again on Monday.

Given that it is Thursday now I've done the (pretty simple) merge
myself, it can be found here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/ext4-dax-merge
