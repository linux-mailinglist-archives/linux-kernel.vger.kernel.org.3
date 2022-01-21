Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BD495725
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbiAUABe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:01:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:51166 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378241AbiAUABd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:01:33 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1069E7DF;
        Fri, 21 Jan 2022 00:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1069E7DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642723293; bh=e09aVzfiGh1V0glBBFqdYT6NALcRou3j07mgEDAOaXY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M9+EO0/03LtfNCLdMhR7xQbzNmqYcDQm7mPLxe3DdqrKjt6Xoo26NvvIVKdN0HLm8
         JQAPR8kAI/wx23cqGcwdr0vb/LpGbjDSVWdJrm+JCuMp9NZlc7Ge1Vw+2BuNmr0QoP
         ZLP42vcyRecFL9JBF0UAgqlvJe9SZa9F9hz7LdLeDKJib0eFnyr3D+n+R+PfoXlfCO
         mdpmsj5ecuY+DRBVhhgl/sgjvl9IkgDs4Y6h8ifsNE32ILENIy0ODmyVPAiKGLSZ5m
         zm1lfbSpeBoAzkqDJVbyZwjkyoQOP99cyuN3jUgsyFJEviGvC8YahbdSGnif5d0sPa
         yMHhh7TG9wotw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH -next v2] Documentation: fix firewire.rst ABI file path
 error
In-Reply-To: <20220119033905.4779-1-rdunlap@infradead.org>
References: <20220119033905.4779-1-rdunlap@infradead.org>
Date:   Thu, 20 Jan 2022 17:01:57 -0700
Message-ID: <8735li553e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Adjust the path of the ABI files for firewire.rst to prevent a
> documentation build error. Prevents this problem:
>
> Sphinx parallel build error:
> docutils.utils.SystemMessage: Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
> InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.
>
> Fixes: 2f4830ef96d2 ("FireWire: add driver-api Introduction section")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Tested-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> v2: Add Tested-by: and Fixes: from Akira (thanks!)
>     shorten path in error message;
>
>  Documentation/driver-api/firewire.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
