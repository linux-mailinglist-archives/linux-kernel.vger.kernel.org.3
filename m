Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3F4A3336
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353748AbiA3CKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236098AbiA3CKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643508634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhTMfyrjbAbtJcMYDK7fzUfXvPUd309awCDdI/pLbrI=;
        b=J40UFQT//zzSzBPjYkpOSspqhsFH07YrmxiHC0GsC7Zw9PnA/znASP/nzxiec4fgcdkDeQ
        zTDqoRKKIZPsU7H2Q0Sx0qPmaVWwygnxYMWaQi5P50TrzG5Bchi7fcPQUagH6rbeAuRH14
        DrKWAQ+WczFxPA+t59yW1f63WkKE3jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-Cw25cyrBM72GK8TGlt1RNA-1; Sat, 29 Jan 2022 21:10:33 -0500
X-MC-Unique: Cw25cyrBM72GK8TGlt1RNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4689D8144E4;
        Sun, 30 Jan 2022 02:10:31 +0000 (UTC)
Received: from localhost (ovpn-12-238.pek2.redhat.com [10.72.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDBDB5445E;
        Sun, 30 Jan 2022 02:10:08 +0000 (UTC)
Date:   Sun, 30 Jan 2022 10:10:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] docs: kdump: update description about sysfs file
 system support
Message-ID: <20220130021006.GA29425@MiWiFi-R3L-srv>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643370145-26831-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/22 at 07:42pm, Tiezhu Yang wrote:
> After commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to
> CONFIG_EXPERT"), "Configure standard kernel features (for small
> systems)" is not exist, we should use "Configure standard kernel
> features (expert users)" now.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index cb30ca3d..d187df2 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -146,9 +146,9 @@ System kernel config options
>  	CONFIG_SYSFS=y
>  
>     Note that "sysfs file system support" might not appear in the "Pseudo
> -   filesystems" menu if "Configure standard kernel features (for small
> -   systems)" is not enabled in "General Setup." In this case, check the
> -   .config file itself to ensure that sysfs is turned on, as follows::
> +   filesystems" menu if "Configure standard kernel features (expert users)"
> +   is not enabled in "General Setup." In this case, check the .config file
> +   itself to ensure that sysfs is turned on, as follows::

Nice clean up, ack.

Acked-by: Baoquan He <bhe@redhat.com>

