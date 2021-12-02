Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C2466D84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356676AbhLBXSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhLBXSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:18:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97425C06174A;
        Thu,  2 Dec 2021 15:15:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 602A4B82526;
        Thu,  2 Dec 2021 23:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F410CC00446;
        Thu,  2 Dec 2021 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638486916;
        bh=GQ8t5bpF4TlGlqrWcvkPnUaG9pj98dzkZ49NTmV5V/Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aMQprVnru08ro41CKEiAqMtm+pRUByoLOGbH0Nefik1QSqLaiyryxU0KBm/3k34xD
         Xth0yN9YdAVh2vSwdWqEtlsBgeMFgec92Mf6ObdQ6jmL7XS/Egmw8QsfZBo//yAIrB
         B3W5PoB9gPAKGSuG49Y1xXjwodVWW6bpFvRwZ/0C9dj1ToaMUBdGgwBrG2EYzZPmYk
         TK40Sk6Yu6Zovi823r/M65iApkKVN6hlBRS4IeAHsNtK0UqnhGQgM8kwsqmmi5F+sJ
         44K/s5+TIyQKRqIJ2IDewA/htRJu9pTwkvKZHBvBXtF0rXejM0CX1vBPjsLvMI2f5M
         BiSVFXxZC54XQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211118082858.165538-1-deng.changcheng@zte.com.cn>
References: <20211117011244.158541-1-deng.changcheng@zte.com.cn> <20211118082858.165538-1-deng.changcheng@zte.com.cn>
Subject: Re: [PATCH v2] clk: Use div64_ul instead of do_div
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     benjaminfair@google.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        zealci@zte.com.cn, cgel.zte@gmail.com, deng.changcheng@zte.com.cn
To:     avifishman70@gmail.com, cgel.zte@gmail.com
Date:   Thu, 02 Dec 2021 15:15:14 -0800
User-Agent: alot/0.9.1
Message-Id: <20211202231515.F410CC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the subject. It should be "clk: npcm7xx: Use ..."

Quoting cgel.zte@gmail.com (2021-11-18 00:28:58)
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
