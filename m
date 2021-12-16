Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C51478034
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhLPWzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhLPWzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:55:22 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20466C061574;
        Thu, 16 Dec 2021 14:55:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C43A435F;
        Thu, 16 Dec 2021 22:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C43A435F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639695321; bh=MpwRUi9k2UEzBE3OFTmt5qE2hRxURjOtpNoV1ny62D0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SW6xMqTPp9Y4ywMwg/fe06Ylj7H5y8foqrc0wSMIb71NGAqUlBT164daaNyXSAlPw
         5NqFGQKyMUlqHuJxmtfVpPQCpNNyBbR+J6kWSGJRIOX8d3xK12pn0YVZjjnp5bCt6i
         8tBy82LY7FBwYInXKtF8wIyZ62OrlEPL4WgAD8gcjMv+UZMC2RhTpMDebsz6Z58JQf
         kWtFmUTQNzGmllGNLYBAZ39yZy9r1+fShJ1aJdMGRExqvcX7kGg9UPFD1+ZijVELnB
         CjDGw4vKRrHfFjk+nlDeYvdmHqqILhlzyOFnL7+R6/Z9hs0EYueKHE6DycmBn1VGiD
         UZHlsd4LrtqQA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/2] Fix some issues with DOCS_CSS and DOCS_THEME
In-Reply-To: <cover.1639212812.git.mchehab+huawei@kernel.org>
References: <cover.1639212812.git.mchehab+huawei@kernel.org>
Date:   Thu, 16 Dec 2021 15:55:21 -0700
Message-ID: <87y24kcg86.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> Randy pointed a couple of issues with the DOCS_CSS and DOCS_THEME patchset.
> The two patches in this series address them.
>
> Patch 1 fix the usage of "make O=<dir>".
> Patch 2 fix some documentation issues (a typo and whitespace issues).
>            
> Randy, thanks for reporting those!
>
> Regards,
> Mauro
>
> Mauro Carvalho Chehab (2):
>   docs: Makefile: use the right path for DOCS_CSS
>   docs: address some text issues with css/theme support
>
>  Documentation/Makefile             | 6 +++---
>  Documentation/doc-guide/sphinx.rst | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Set applied, thanks.

jon
