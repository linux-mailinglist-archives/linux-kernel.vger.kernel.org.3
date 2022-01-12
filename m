Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5248C579
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353894AbiALODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:03:11 -0500
Received: from verein.lst.de ([213.95.11.211]:46247 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242083AbiALODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:03:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6626768AFE; Wed, 12 Jan 2022 15:03:04 +0100 (CET)
Date:   Wed, 12 Jan 2022 15:03:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220112140304.GA27446@lst.de>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com> <20220112071659.GA4502@lst.de> <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> USB thumb drives also use this flag, so I am not sure why it's not
> applicable to NVMe?

They shouldn't report this flag and might need fixing.
