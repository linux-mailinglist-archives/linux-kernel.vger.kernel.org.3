Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B343E48FD36
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiAPNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233233AbiAPNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642340345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cp5M2AGP5P4N6b6EQKr0vl4nAKthbkR6iiQTidIywuQ=;
        b=b4gYr5tri//+j84Dfnb1zxHYzoXTBJfC4F2+kxPJu+I2sBmhTfvXynQw+AtFxyad2EfC0j
        xxYplHqIhLV31NJnH4YETbRgl2Cci0uiEytA5jsn+zQY4iK6O8AS74/us5eyLDngMdUfzH
        lp346KClC2idleWzHWgRgY+nePq9Kmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-xbtBAwTnOzqAyXi4zY5DnA-1; Sun, 16 Jan 2022 08:39:00 -0500
X-MC-Unique: xbtBAwTnOzqAyXi4zY5DnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF89802924;
        Sun, 16 Jan 2022 13:38:57 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9F7105C891;
        Sun, 16 Jan 2022 13:38:51 +0000 (UTC)
Date:   Sun, 16 Jan 2022 21:38:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
Message-ID: <20220116133847.GE2388@MiWiFi-R3L-srv>
References: <20211206160514.2000-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.

I go through this patchset, You mention the benefits it brings are
1) simplity the code;
2) increase compile coverage;

For benefit 1), it mainly removes the dummy function in x86, arm and
arm64, right?

For benefit 2), increasing compile coverage, could you tell more how it
achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
purpose? Please forgive my poor compiling knowledge.

Thanks
Baoquan

