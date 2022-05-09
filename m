Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB38352077E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiEIWYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiEIWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:24:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E8E25C68;
        Mon,  9 May 2022 15:20:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A73CD732;
        Mon,  9 May 2022 22:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A73CD732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652134853; bh=8mExUUzkzmAyXrY8dedy/L10D7FiCxQzXMq6gVmHu/I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AAXoH52bpvl3xSV+0nGmwQVi/FBzyIJ1RoPHEGv26NIz6VXXdypqLQYNZsE5NDFL7
         fqKHMxBnaS0s0lXA+LFM3bMzFrpOj9uIJTOVDf4dX/IA+IBFzTJuTtS408SEOtf/Y6
         kKjHA0p2Z7dcDiYvpvIfpCy3XWlJ1vTTO5mj3gEOjqXhNb3lRKFCXOgm5eyJTbuT2p
         AgLvBu1sAWZNmNHEQIvqhacCCpmy+EF7K78uy1lXFDu4St/HPHnYDN+e5OnMy1OOiG
         2XwTWmCTEkczsYQtIA81QdwFOKfcd32Tb408Rp98LinMcB+IegXO/dz1GTzK0890yJ
         ZeD2dbGWTOkIw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: drop more IDE boot options and ide-cd.rst
In-Reply-To: <20220424033701.7988-1-rdunlap@infradead.org>
References: <20220424033701.7988-1-rdunlap@infradead.org>
Date:   Mon, 09 May 2022 16:20:52 -0600
Message-ID: <878rracpq3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Drop ide-* command line options.
> Drop cdrom/ide-cd.rst documentation.
>
> Fixes: 898ee22c32be ("Drop Documentation/ide/")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> I missed a few things in dropping all IDE documentation.
> Hopefully this is all of the remaining pieces.
>
>  Documentation/admin-guide/kernel-parameters.txt |   20 
>  Documentation/cdrom/ide-cd.rst                  |  538 --------------
>  2 files changed, 558 deletions(-)

Applied, thanks.

That said, it created this docs-build error:

  Documentation/cdrom/index.rst:7: WARNING: toctree contains reference to nonexisting document 'cdrom/ide-cd'

I made the obvious change to fix that.

jon
