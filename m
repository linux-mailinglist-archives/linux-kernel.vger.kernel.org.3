Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009C4834D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiACQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:35:36 -0500
Received: from verein.lst.de ([213.95.11.211]:47213 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233987AbiACQfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:35:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDA9668AFE; Mon,  3 Jan 2022 17:35:32 +0100 (CET)
Date:   Mon, 3 Jan 2022 17:35:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Potentially broken error path in bio_map_user_iov()
Message-ID: <20220103163532.GB3151@lst.de>
References: <CAKXUXMy=M42hapfG1S4ZT1v5WEdH2KYiF8Cgukmf48=FKFCyJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMy=M42hapfG1S4ZT1v5WEdH2KYiF8Cgukmf48=FKFCyJg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

we can just remove the queue_dma_alignment check entirely, the caller
already ensures bio_copy_user_iov is called instead of this case.
