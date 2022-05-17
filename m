Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFB52AC50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiEQT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiEQT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF583F30A;
        Tue, 17 May 2022 12:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EBFBB81BFA;
        Tue, 17 May 2022 19:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00D7C385B8;
        Tue, 17 May 2022 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652817476;
        bh=QVklpDo74/Kog4FBVwNzGdZ5OJE+y+BK+jYRxPRDdug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nYtAxqBrH24ApOXF2cmS1Yg3p1FLVc3n52EoNXNH+69e/7okG5EFy3WdF/l3BAwkN
         EVqWcnapYqNw/GoSzC4TTHZ9tzV9Cvnv3xc7Dy2smvD2dOVtgc0OTAz+dPXeMiHUF2
         nzDisdctmgzPGPTq/dXN9Je4/tDJEvfqM/Wt4V6ot4ECSXERvUXn3ZhPSpJcEEvoTx
         cbz9yENbVG5qouig5mNCvZH6aYlZ8DobQUWFkizcP77MwX4KAjeX6mYdmemAc9XFzI
         80xWPIXX9t9dV4N2TT/6cPkWnNK98HJzjGzAxi9i8Xk2lCTgDLdkj9X//TppMPRnod
         zB32jOh0/nHjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220517085720.375941-1-abel.vesa@nxp.com>
References: <20220517085720.375941-1-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.19
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Tue, 17 May 2022 12:57:53 -0700
User-Agent: alot/0.10
Message-Id: <20220517195755.F00D7C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-05-17 01:57:20)
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc=
17:
>=20
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.19
>=20
> for you to fetch changes up to cf7f3f4fa9e57b8e9f594823e77e6cbb0ce2b254:
>=20
>   clk: imx8mp: fix usb_root_clk parent (2022-05-17 11:42:07 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
