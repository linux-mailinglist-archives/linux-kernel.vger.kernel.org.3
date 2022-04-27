Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF38511B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiD0OyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiD0Oxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:53:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B740936
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DFF304FA;
        Wed, 27 Apr 2022 14:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DFF304FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651071042; bh=hlu8PGcHZuP0zBSWDbHIqFXuineEIkirOaqet9rn/BE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aER+/uXTHpFN7DZVZoCPzaz9KvxQN+fjErYxHxMN++Zpb6lMdc8F0xZ98+JzylX+v
         pgyRAGEdGe63wxwKT6/M9Dox9+QOHsRfVKQ7S9khMQHg6ln4uWwGhAubcJD3Dxei9k
         RT3AhO3z1hlTOLFHu7KBkCZWFxFk/vjaVC5+Ehn8w2bBJQNP6tbp9LVttIJJ3g0XOW
         O0gUoQTHPuVUSwFDR0Jg8Jm+wRuiPpAoTB/GXPQGUH7J2iIS5Y+Mjjvfe03y3efvX0
         M6JvoFnf35KJTD1GSAx48csRE1DzlwqGepzBDA8l4o0/Wgk2C9NtUp4paWEmJZgk4e
         YQBvQRTwK22Lg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
In-Reply-To: <20220427132436.12795-4-paul.gortmaker@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
Date:   Wed, 27 Apr 2022 08:50:41 -0600
Message-ID: <87wnfaa8ce.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> The last traces of the IDE driver went away in commit b7fb14d3ac63
> ("ide: remove the legacy ide driver") but it left behind some traces
> of old documentation.  This removes/updates anything with a reference
> to ide-cd or ide-tape appropriately.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  21 -
>  Documentation/cdrom/ide-cd.rst                | 538 ------------------
>  Documentation/cdrom/index.rst                 |   1 -
>  Documentation/filesystems/proc.rst            |  92 +--
>  Documentation/ide/ChangeLog.ide-cd.1994-2004  | 268 ---------
>  .../ide/ChangeLog.ide-floppy.1996-2002        |  63 --
>  .../ide/ChangeLog.ide-tape.1995-2002          | 257 ---------
>  Documentation/ide/changelogs.rst              |  17 -
>  Documentation/ide/ide-tape.rst                |  68 ---
>  Documentation/ide/ide.rst                     | 265 ---------
>  Documentation/ide/index.rst                   |  21 -
>  Documentation/ide/warm-plug-howto.rst         |  18 -
>  drivers/block/pktcdvd.c                       |   2 +-
>  13 files changed, 8 insertions(+), 1623 deletions(-)
>  delete mode 100644 Documentation/cdrom/ide-cd.rst
>  delete mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
>  delete mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
>  delete mode 100644 Documentation/ide/ChangeLog.ide-tape.1995-2002
>  delete mode 100644 Documentation/ide/changelogs.rst
>  delete mode 100644 Documentation/ide/ide-tape.rst
>  delete mode 100644 Documentation/ide/ide.rst
>  delete mode 100644 Documentation/ide/index.rst
>  delete mode 100644 Documentation/ide/warm-plug-howto.rst

The Documentation/ide part of this is already dealt with in docs-next;
obviously there was more to do, though :)

Thanks,

jon
