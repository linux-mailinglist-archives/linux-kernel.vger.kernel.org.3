Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDF532CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiEXO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiEXO7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:59:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4068022A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:59:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 740511F44568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653404347;
        bh=2v1XmEozL7oSUbTJ0GKuAnaHJIef9ToTFHENZzxZSMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3567lSqGv4eYVGfC1nFRndhtOvQvfaSkZCzTS09wkJv4kGcgOlIO2CIVmmzbfW6A
         hBwcKhWUMBXgMBSig4h9G34hOJKXRxxola5XR+lykDzVtJ21TisLkaQ7yhW0T1rD8J
         EiL+ZPM5oLDJkbBXbTzXa4PM8vxRSujjAuMrDPe+pPJ4zzbHLJxUijomu9svL4f+1I
         s+TELtKHbxG5YzNZvNULgvFk+Ji/GE6jAkp/WPS5TjgqtAIU2SVKvGjGm8a0NDHMsR
         WyRvGyx9wk6SFZyd8w17NzGeVdGvoasm8bEHNz+FZAXlwrFlgNnoduAEDqp4BD0DOh
         xDD3RqfxdOeAw==
Date:   Tue, 24 May 2022 10:58:59 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Job should reference MMU not file_priv
Message-ID: <Yozys2n+hJmdknfg@maud>
References: <20220519152003.81081-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519152003.81081-1-steven.price@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
