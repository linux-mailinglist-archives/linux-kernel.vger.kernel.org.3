Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9855B2BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiFZPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:49:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E2DEC3;
        Sun, 26 Jun 2022 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1HGEtHzkdYFCGW7ANqN5HrrMrcP7Zd/q8tMBeRZp9zY=; b=eo/KMH7QYwiA0mgyV2DsXE3ikf
        4rfMDuFFuJaaHw0TOGYReukToi0g2Zv0FFd74fm+noB1w9Z8ifGtRTez/2w2Acdm1cxWZFd4OW03h
        8GxWvN9zCC2jLYNkLbodRv8mvAfRhKFYvVfhlOAELCh7frmUSpKL/So7TwNnTH623tU3MSQYkKX28
        logrbUbNHXkny2ODJnNMsV0b8PTUM18ooxSTVDwP6b6XpboB6U/vr07jYZEopThmA4fKuWAJWhZ9p
        0IjZXWGPpEibep0wXbNGLfPbUXaDwoQrfMvxphDKSMCMICL/tO6XoSdGvboh5/jWAurvs3XOQ7gNP
        ehmNMTnQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5UVU-00CXe7-OU; Sun, 26 Jun 2022 15:49:04 +0000
Message-ID: <065c391b-ec72-4a72-7ca1-55093082164d@infradead.org>
Date:   Sun, 26 Jun 2022 08:49:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 10/20] Documentation: update watch_queue.rst references
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Oliver Glitta <glittao@gmail.com>,
        Peter Xu <peterx@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <1c220de9c58f35e815a3df9458ac2bea323c8bfb.1656234456.git.mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1c220de9c58f35e815a3df9458ac2bea323c8bfb.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/22 02:10, Mauro Carvalho Chehab wrote:
> Changeset f5461124d59b ("Documentation: move watch_queue to core-api")
> renamed: Documentation/watch_queue.rst
> to: Documentation/core-api/watch_queue.rst.
> 
> Update the cross-references accordingly.
> 
> Fixes: f5461124d59b ("Documentation: move watch_queue to core-api")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
> 
>  Documentation/security/keys/core.rst | 2 +-
>  include/linux/watch_queue.h          | 2 +-
>  init/Kconfig                         | 2 +-
>  kernel/watch_queue.c                 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)


-- 
~Randy
