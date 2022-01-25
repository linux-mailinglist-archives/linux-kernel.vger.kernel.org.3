Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB949A870
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318780AbiAYDHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455538AbiAYCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:02:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C05C0619D0;
        Mon, 24 Jan 2022 16:56:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0008960AF3;
        Tue, 25 Jan 2022 00:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFBAC340E4;
        Tue, 25 Jan 2022 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643072167;
        bh=HGL+ZuBOHbR5QhIj3i8dJ+BOoFj7BWUdJb5AT3Nbmgk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G98934XM7FvuZKrSQlupbv5mzhDZPcGmLNSpyGKYSZxmQtJnSKTtbY6YPfaj8tFAS
         1r0R9d2QOtNocB1Z0Z7O5dRWt+X5inWR1jTVZXBqHatYd9RM4SlydSVXtTaATBCzmB
         G0+K5JxsLUw+eF0NFvBKn+tJ7OLvYgD8BPfGBWfNkJ9y+jcV9VYm8gnYEeG/5ofgId
         Uvkr6447UGI8cuDFB5WvupF+adnZweJxTX/atXz17zOY8Yi2O+9alFIiJmc6oN8YCq
         kxV6oB5nXOzw+y8B2sejSJKKq9kQCVQ137pI4h1QzcO42Fa7ZT+rdHc+F7zzALfMIY
         JJdCofjxz4JxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220124052038.6242-1-miles.chen@mediatek.com>
References: <20220117090030.13064-1-miles.chen@mediatek.com> <20220124052038.6242-1-miles.chen@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: add unregister logic to mtk_clk_simple_probe error path
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     chun-jie.chen@mediatek.com, ikjn@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        weiyi.lu@mediatek.com
To:     Miles Chen <miles.chen@mediatek.com>
Date:   Mon, 24 Jan 2022 16:56:05 -0800
User-Agent: alot/0.10
Message-Id: <20220125005607.5BFBAC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2022-01-23 21:20:38)
> Hi Stephen,
>=20
> > Stephen pointed out that there is no unregister logic in
> > mtk_clk_simple_probe() error path [1].
> > Fix it by adding unregister logic to mtk_clk_simple_probe().
>=20
> Chen-Yu's work [1] already addresses this problem. So please ignore
> this patch.

Alright. Thanks.
