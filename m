Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAE48F986
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiAOVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiAOVRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:17:15 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACCC061574;
        Sat, 15 Jan 2022 13:17:14 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1C412ED;
        Sat, 15 Jan 2022 21:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F1C412ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642281434; bh=oHnYu0rr3p20Z4FUpBLwUPyOBZ53vco0yv77JVEOIlg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hdO3397ZgeEJHrvDZ7lAznlTToCNgAaoVEp39x3rP1CxW6vfURBRmxu5D+7Wzz7MB
         KKC+ruZgYuUth73OtpheVYgtb7BANlyhGiaF9neAqpHTREZLqkCrunFxpTtGb/687k
         qIe4he5D4hN0h/2v/MhJYNSwgJCwbegtvcFeSJ78kwA9DZOacratTL+XbLC8nBMIPX
         +axF/eAIE+BRq1UFLELWAf5nWHeZNQbKH5H8x8W+UUFke1XHibCmtCipEaj7Fd7Lqt
         iWUHwyfnbRnYD/tJJu5nfAeU+o/eLnBcbMmWDspTe0JarxEuG78XCatnkekqLLsezv
         8SsxmluxbQkrg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
In-Reply-To: <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
 <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
 <20220114094535.5bb9ba94@coco.lan>
 <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
Date:   Sat, 15 Jan 2022 14:17:30 -0700
Message-ID: <87bl0c7l79.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> We are in the middle of the v5.17 merge window, and I think of this
> series as a v5.18 material.
> Which means it won't be merged into doc-next until v5.17-rc5 or -rc6
> (mid March or so), unless Jon thinks otherwise.

I'd rather merge it rather sooner than that if possible; 5.18 stuff will
start going into docs-next shortly.

Thanks,

jon
