Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E5B486D29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiAFWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:24:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:51090 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244638AbiAFWY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:24:58 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D4AE5BF;
        Thu,  6 Jan 2022 22:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D4AE5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641507897; bh=6mEAHDrv0nvuTG1xKnA33KLkJmQKOzodBO65//BEm0g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D2ofowbfbQN04i6JhH0LvDu1OXNyN3vYnTlm5Bfysq6TOUTQsrk8DBHCigruBHWZ0
         d+hQ/4IpmL+qp6CToKMQLLeMnoD/Lv/qgjsi/3bWDQa6bda5afSl8d1h/i49tS17Yg
         Tk4qM3yG9sTlj1NDmHlUgaaFEPooZV5reioE1XKOXWHsdmwVLI/nURZ4OTjr4unHYh
         yZNL/PYUFwqfUVy/HV11ih+OhIMAqnxRgEdcGn7/B8m8uCYybc8UJBNH8pXWkALDO3
         MaQnSC6Q13StgJL2wzVTKJ0AU+MmhY5gdym0h77Qqy6qLf2vphEkboaojt4bGLXffS
         LdR/1Z1nauLrQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     James Clark <james.clark@arm.com>, nfraprado@protonmail.com,
        n@nfraprado.net, linux-doc@vger.kernel.org
Cc:     mchehab+huawei@kernel.org, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] docs: automarkup.py: Fix invalid HTML link
 output and broken URI fragments
In-Reply-To: <20220105143640.330602-2-james.clark@arm.com>
References: <20220105143640.330602-1-james.clark@arm.com>
 <20220105143640.330602-2-james.clark@arm.com>
Date:   Thu, 06 Jan 2022 15:25:03 -0700
Message-ID: <87h7agpkn4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Clark <james.clark@arm.com> writes:

> Since commit d18b01789ae5 ("docs: Add automatic cross-reference for
> documentation pages"), references that were already explicitly defined
> with "ref:" and referred to other pages with a path have been doubled.
> This is reported as the following error by Firefox:
[...]
> The fix is to check that nodes in the document to be modified are not
> already references. A reference is counted as any text that is a
> descendant of a reference type node. Only plain text should be converted
> to new references, otherwise the doubling occurs.

This seems like a good fix.  Applied, thanks.

jon
