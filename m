Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1514948E23C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiANBpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiANBpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:45:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2DFC061574;
        Thu, 13 Jan 2022 17:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9779361DBC;
        Fri, 14 Jan 2022 01:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E127FC36AEA;
        Fri, 14 Jan 2022 01:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642124731;
        bh=pBKJYbtzsoBjwRvqujAPXh3tzGQAMKSejZM0stQ83b4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hdjP56UUNvO45mGOQaKBcLVqzkJfvtq0DUQypiH85brKACUYo979cnumocERQ5wKB
         uBybsQ0cOaixYOVUZtj/jEioEUDwgMyq5Jn+azextgjrlQi/OpRJJBTMBaTpghPJrJ
         as6vL4p6Rrr5J0waI3G0pdrE7hcjG75JCOfpopBqRPdPE98aH6n8AqbpYViQV+noXY
         Ix9Zs0WNaTofDOHNc7MSGH6tkcCTEzzwRNqQ48+MBKlYmpb8fON3t8yqPD3Q+0juHH
         dZCH022DEYwKYvKboOvnm6oJOlrAaRnKVpEJ2K6fWLxYXPBpMV70wgbLrbpecD2Vg3
         s3azhKSOCELOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220107182451.139456-1-jose.exposito89@gmail.com>
References: <20220107182451.139456-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH RESEND v2] clk: mediatek: Fix memory leaks on probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org
To:     =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        mturquette@baylibre.com
Date:   Thu, 13 Jan 2022 17:45:29 -0800
User-Agent: alot/0.9.1
Message-Id: <20220114014530.E127FC36AEA@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc the clk mailing list on clk driver patches.

Quoting Jos=C3=A9 Exp=C3=B3sito (2022-01-07 10:24:51)
> Handle the error branches to free memory where required.
>=20
> Addresses-Coverity-ID: 1491825 ("Resource leak")
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
