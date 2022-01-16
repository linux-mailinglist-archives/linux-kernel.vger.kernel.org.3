Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32948FD24
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiAPNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235265AbiAPNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642338699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2735UOsX2lbYzncmWz1w1L9NtF8LEvgUZSTpkTuP8AY=;
        b=Q5OOoj2cmwpzox/T4gxBwg31r0KYjk1194blmpXRijv3x26edMIwC1SnGJ+A+BuZc2px1l
        a9X6lcNXF3ziA+wCV89Dsj4toozd33JuJp1HjhtXvAW8fn+CVC0wl5mHG7Cs/ywPVhNWAo
        o8s3jv3v7JtkaSfPqD6Yz/9lVY3La1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-BUJ0pTtAMfqT2TIWkY5_Xg-1; Sun, 16 Jan 2022 08:11:36 -0500
X-MC-Unique: BUJ0pTtAMfqT2TIWkY5_Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E51D1006AA5;
        Sun, 16 Jan 2022 13:11:34 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3684578AB2;
        Sun, 16 Jan 2022 13:11:31 +0000 (UTC)
Date:   Sun, 16 Jan 2022 21:11:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <20220116131129.GD2388@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/22 at 12:34pm, Guilherme G. Piccoli wrote:
...... 
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.
> 
> Currently up to 16 symbols may be passed in this list, we consider
> that this numbers allows enough flexibility (and no matter what
> architecture is used, at most 30 panic callbacks are registered).
> In an experiment using a qemu x86 virtual machine, by default only
> six callbacks are registered in the panic notifier list.
> Once a valid callback name is provided in the list, such function
> is allowed to be registered/unregistered in the panic_notifier_list;
> all other panic callbacks are ignored. Notice that this filter is
> only for the panic notifiers and has no effect in the other notifiers.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

This patch looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

