Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63547E886
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhLWT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:57:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:51028 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhLWT46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:56:58 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35F472D7;
        Thu, 23 Dec 2021 19:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 35F472D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640289417; bh=MHyjBvzmgZrvZFAiTGoiATGgI82aSmddBMk66e66VQ8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AiwKxvy+oJTPy0IAEECsdpgw+nNw5YLNfthNvXoLLR/C6YcWC9fZGvmEALNP64sLj
         uUb0euxRVRlQvL2HAwob+Vek1xnkyHX0FiZ9dtZF3BL3OOGyRqINS4h46sQPakoRG/
         pMVc/zG245aI99F9FLmiGyQLo5obyjX+IIVxwfowKrAc0W83LIvVkXlrrEsU6ILQxg
         rREp9ceAGBV3G3fR4ClfRQNNJWDwiCW+jKXHw+VUWCPnVmmBAo7ocOKzy7s+TcmlKB
         xdVIbxNReJ5/wW/PEXeGzvnuqpFUg+7K0j10lWVNtS9Yqu2f77KjEXQgqDQVmElTso
         0pVSP6NOZ+qzA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
In-Reply-To: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
Date:   Thu, 23 Dec 2021 12:56:56 -0700
Message-ID: <87r1a3drhz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> This patch set improves conversions of DOT -> PDF and SVG -> PDF
> for PDF docs.
>
> * DOT -> PDF conversion

So I'm unclear on the status of these patches; Mauro, are you happy with
them?  If so I'd like to get them in before the merge window.

Thanks,

jon
