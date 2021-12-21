Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614ED47C8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhLUVFN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 16:05:13 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43858 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbhLUVFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:05:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0FD4162DA5F1;
        Tue, 21 Dec 2021 22:05:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id skrSN4l_iYPS; Tue, 21 Dec 2021 22:05:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8FD8762DA5F6;
        Tue, 21 Dec 2021 22:05:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LRyrFTE1UGnJ; Tue, 21 Dec 2021 22:05:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6B04162DA5F1;
        Tue, 21 Dec 2021 22:05:03 +0100 (CET)
Date:   Tue, 21 Dec 2021 22:05:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
In-Reply-To: <20211215165612.554426-1-hch@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
Subject: Re: remove set_fs for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove set_fs for UML
Thread-Index: kfgbhqyu4t3Fte1ZQWak0oXXZdXyZg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

----- Ursprüngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
> CC: "x86" <x86@kernel.org>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 15. Dezember 2021 17:56:10
> Betreff: remove set_fs for UML

> Hi Richard and Anton,
> 
> this series removes address space overrides using set_fs for UML.
> 
> Diffstat:
> um/Kconfig                   |    1 -
> um/include/asm/thread_info.h |    4 ----
> um/include/asm/uaccess.h     |   21 +++++++++++++++++++--
> um/kernel/skas/uaccess.c     |   25 -------------------------
> x86/include/asm/mtrr.h       |    8 +-------
> x86/kernel/setup.c           |    7 ++++++-
> x86/um/asm/segment.h         |    8 --------
>  7 files changed, 26 insertions(+), 48 deletions(-)

So far UML seems to work with these changes applied. :-)
I have applied both patches to my UML tree for now, I assume x86 maintainers are fine with
patch 1/2?

Thanks.
//richard
