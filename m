Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478494A335D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353818AbiA3Cqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240673AbiA3Cq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643510788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcOcmEb5ngGy0dZAQ9mUDW+ZAjVj+zk/0lR2PgFjLiE=;
        b=RbvzkUBIi+MSDvNoqrfpGB3F45vJapanNYWJXQsCQU/KhPuTecepxnw2qlgIggqMIzX+rf
        2II+GCcmDBDayifpJXY2WMz1Dk8FebCXjOMPnoF8KORnBDQ0MykSBTskI8F3vtULZpedez
        +d/GcOdBvZONt86zCR4J4KB/GNBCBzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-_VSw3NT0NqiU6JSdBclvyA-1; Sat, 29 Jan 2022 21:46:23 -0500
X-MC-Unique: _VSw3NT0NqiU6JSdBclvyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E504E1F243;
        Sun, 30 Jan 2022 02:46:21 +0000 (UTC)
Received: from localhost (ovpn-12-238.pek2.redhat.com [10.72.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C83412E34;
        Sun, 30 Jan 2022 02:46:20 +0000 (UTC)
Date:   Sun, 30 Jan 2022 10:46:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] docs: kdump: add scp sample to write out the dump
 file
Message-ID: <20220130024617.GB29425@MiWiFi-R3L-srv>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643370145-26831-3-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/22 at 07:42pm, Tiezhu Yang wrote:
> Except cp and makedumpfile, add scp sample to write out the dump file.
                                      ~~~~~~? You mean example?

I think we just give example here, but not list all cases. seems
adding scp is nothing bad. Anyway, except of the concern for 'sample':

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index d187df2..a748e7e 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -533,6 +533,10 @@ the following command::
>  
>     cp /proc/vmcore <dump-file>
>  
> +or use scp to write out the dump file between hosts on a network, e.g::
> +
> +   scp /proc/vmcore remote_username@remote_ip:<dump-file>
> +
>  You can also use makedumpfile utility to write out the dump file
>  with specified options to filter out unwanted contents, e.g::
>  
> -- 
> 2.1.0
> 

