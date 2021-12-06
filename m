Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E889D4690FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhLFH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:57:37 -0500
Received: from verein.lst.de ([213.95.11.211]:49434 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhLFH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:57:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28AAD68AA6; Mon,  6 Dec 2021 08:54:06 +0100 (CET)
Date:   Mon, 6 Dec 2021 08:54:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Message-ID: <20211206075405.GB10917@lst.de>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.16.
