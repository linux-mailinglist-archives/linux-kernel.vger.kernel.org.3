Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D949486D41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiAFWfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:35:18 -0500
Received: from ms.lwn.net ([45.79.88.28]:51094 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245175AbiAFWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:16 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D6415BF;
        Thu,  6 Jan 2022 22:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D6415BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641508515; bh=Y0LmZfNZgo9tJ08FAwoxR+CuTUO2Jk0oHi6rBTGQGbg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H9neEsESaj4jc3YJO4tDXA4NGKycjEAE1ylPEVUsu34Xjrhi9QyEdhrKFyaNTV5RG
         Fgsaj61HzabWMvjOtzHGirfJ3BqaFDUU6Lo0mvL2ZWMmXNZM2grD4/ilhXaV6uRka+
         Do1ocWMA6C1CIpPkd/YCVdVY35YnXhE1Ye2EIM86x05zyGFqsiOHcpeMl2RlPnfbgV
         51nxnWYwLt6EbNnntUGV/GSHz+FdV2aVjEmzGp6/E3RHA6J7n7kCXFK792cmJDikGl
         j6VfDJZz2mgf/wfwFMFZOb7uMUbT7Ypuxe8jNqj7FerEzVO8y4hU9lI/7pleiAiZe+
         +e2AlBs/xFVMQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts: sphinx-pre-install: Fix ctex support on Debian
In-Reply-To: <63882425609a2820fac78f5e94620abeb7ed5f6f.1641429634.git.mchehab@kernel.org>
References: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
 <63882425609a2820fac78f5e94620abeb7ed5f6f.1641429634.git.mchehab@kernel.org>
Date:   Thu, 06 Jan 2022 15:35:21 -0700
Message-ID: <878rvspk5y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> The name of the package with ctexhook.sty is different on
> Debian/Ubuntu.
>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  scripts/sphinx-pre-install | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

jon
