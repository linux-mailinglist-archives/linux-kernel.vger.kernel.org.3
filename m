Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255FE4B7B41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiBOXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:32:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBOXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:32:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290066639;
        Tue, 15 Feb 2022 15:32:23 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 86BE835F;
        Tue, 15 Feb 2022 23:32:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 86BE835F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644967943; bh=7DxpN4wzbn4CODMyzgxFFGlGqYFqY22/e9LTczIG2OU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TK7Q9BwRKshNVecx6N+fGxQUGPpzAzKMsPjmyXQdznW9W9hSUdz282IGXvSdnXJx+
         3AILEsoCpm9x1dkVxbOb4a6/4BRj6UJ/I/WiM1AK0PvcRWaJrcLVKkBzpPCS2O8CxX
         K0fwE4HiH0MFvPNF058/462Q2+Mfpk1yu+KIaiaeaIZpIE6JkEZpEXjwf2A1FLbEui
         Jku8lZr6OD9am2oLSW/psVj2/3Gwg5BQdZ5hokQ5mq7rOJnyINA777TQS+vji8GLYD
         Jj19Wtz/KFHgAQsfA62b1svcVgdd8anpml/IN1AY3Qg24gg+s9o2w4Vj3uSKfXPKOq
         yWGKo1hzvckHw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ethan Dye <mrtops03@gmail.com>
Cc:     Ethan Dye <mrtops03@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] block/zram: Fix wording in optional feature docs
In-Reply-To: <20220207235442.95090-1-mrtops03@gmail.com>
References: <20220207235442.95090-1-mrtops03@gmail.com>
Date:   Tue, 15 Feb 2022 16:32:23 -0700
Message-ID: <874k4z7lko.fsf@meer.lwn.net>
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

Ethan Dye <mrtops03@gmail.com> writes:

> This fixes some simple grammar errors in the documentation for zram,
> specifically errors in the optional featue section of the zram
> documentation.
>
> Signed-off-by: Ethan Dye <mrtops03@gmail.com>
> ---
>  Documentation/admin-guide/blockdev/zram.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

This document could use a lot more help than that, but this is a
start...applied, thanks.

jon
