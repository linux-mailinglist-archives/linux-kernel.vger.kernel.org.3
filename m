Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6548BEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbiALHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:17:04 -0500
Received: from verein.lst.de ([213.95.11.211]:45088 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234731AbiALHRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:17:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2531368AFE; Wed, 12 Jan 2022 08:17:00 +0100 (CET)
Date:   Wed, 12 Jan 2022 08:16:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220112071659.GA4502@lst.de>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:31:54AM +0800, Kai-Heng Feng wrote:
> Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
> entire Thunderbolt hierarchy as removable, if system firmware provides
> correct attribute.
> 
> So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
> userspace daemon like Udisks knows it can be automount.

GENHD_FL_REMOVABLE means removable media as in floppies or CD-ROMs,
which does not apply to NVMe at all.
