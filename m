Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF73508519
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377283AbiDTJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbiDTJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:41:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD4205E8;
        Wed, 20 Apr 2022 02:38:17 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E22E1536;
        Wed, 20 Apr 2022 09:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E22E1536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650447496; bh=0NzDxonImRhcRK7m2RGoPtMTw81nEVFFUstwMY8oGEQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LygPhmyKr5Y7EC5qtRGxwgca1T27iM/CBNtkfZWnlCH0gzaDCXw8Fb6/xKtMpOlM4
         lldCdsExTQK3ShHD5UrHtC5mrwpkw4/3/8VmX0E4x8Q48Vwt29uS2e8DZp9dPtSPxZ
         1yC6DA+9GFNYoQQO2lp8KuISqo3Pf1HpMrLz8sqIYvQRafLctb4Yg5qi6GFa/grIpJ
         SouBBnPvaQ8tfmYDikG7QWaY76z58Ncg0y0mnJw/YcUY4DRoTjoBOphGs6DJmJ8gRQ
         SDF7zLFLjSVsjMxUgLq79LitXjVKW6kKmfShhN+K2gi5TAhnHhI8j4DQKwJptsyzWg
         0MWUVVFpH5NNw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: move watch_queue to core-api
In-Reply-To: <20220419025416.19434-1-rdunlap@infradead.org>
References: <20220419025416.19434-1-rdunlap@infradead.org>
Date:   Wed, 20 Apr 2022 03:38:12 -0600
Message-ID: <87y2002iyj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Move watch_queue documentation to the core-api index and
> subdirectory.
>
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>
>  Documentation/core-api/index.rst             | 1 +
>  Documentation/{ => core-api}/watch_queue.rst | 0
>  Documentation/index.rst                      | 1 -
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/{ => core-api}/watch_queue.rst (100%)

Applied, thanks.

jon
