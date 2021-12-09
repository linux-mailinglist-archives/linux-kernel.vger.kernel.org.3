Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD99E46E456
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhLIIkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLIIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:40:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF24C061746;
        Thu,  9 Dec 2021 00:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B5BB823F6;
        Thu,  9 Dec 2021 08:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6C4C004DD;
        Thu,  9 Dec 2021 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038991;
        bh=LFIggLMpewC9uZQ1lQPk16RmUqYPsYlDDBIf7nXZwIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbnUnJx01weAzTaaRT+k1ztsTOBn/f4y7J/ZK7jd3ctZL4m0MXcc3hddjCzuh2fvv
         b6AJhOf2xl8byo7w9My8dWS6ghNKn9ZrrNp3JulALXas5Y8JQ2v0j8AIEzq4BSf5AW
         isBJ+/sI9o4kHIe3mI+794FuLpkYtrMCNtemBuy7ZNDYnVwSiEd+VztG9JsNmKG3gm
         bg9HDnk7hKB5kYe4MWJev7WCazdbSoHZ4MsJyfGoOb75wYBewPvbFOUby3hltWiPgM
         14UhClkUlyYXCDYsa2eY9uzcSPg55S2f3+gA1eyYSuX2yb/B5GxvCenI/tL8+JjEcu
         Cw8HPXb3Lq/Zg==
Date:   Thu, 9 Dec 2021 09:36:27 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself as modules maintainer
Message-ID: <YbHAC8fU7WSu6U0r@p200300cbcf38f1003adeadfffec0265a.dip0.t-ipconnect.de>
References: <20211209082850.10021-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211209082850.10021-1-jeyu@kernel.org>
X-OS:   Linux p200300cbcf38f1003adeadfffec0265a.dip0.t-ipconnect.de
 5.13.8-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [09/12/21 09:28 +0100]:
>Luis has done a great job maintaining modules so far. As I'm planning to
>take a break from work soon, I think we're ready to transition over fully.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 43007f2d29e0..a92145633fbe 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -12866,7 +12866,6 @@ F:	drivers/media/dvb-frontends/mn88473*
>
> MODULE SUPPORT
> M:	Luis Chamberlain <mcgrof@kernel.org>
>-M:	Jessica Yu <jeyu@kernel.org>
> S:	Maintained
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next

Grr, I forgot to change the git repo line - will resend shortly.
