Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33076578C95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiGRVR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiGRVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:17:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476DF28705;
        Mon, 18 Jul 2022 14:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2DACB81616;
        Mon, 18 Jul 2022 21:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A47C341C0;
        Mon, 18 Jul 2022 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658179072;
        bh=K/9SDjqw4vYpv+vkfU1NchDdEJsTlnMjcryymCgfXs0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sqCVA01TnIsANagwDR4tSav1T4rDy2FVOcsOKuNZTtzdmtnF2zVKJeBVLO+JlxHc0
         a1yYXfZRi59MvsPQjSLCpwQbZrIsWqmgCZJL8X9d7tP1N7wdLSvhqrlJUkUN/tXiLu
         7hQdxIIKAtkJVqJbNf+GvCUL7pCRmD57EYoeFi6AvRJE2v/efKkGdUx0cYHGXgqwnH
         p+qVuIMzuoLzrBlBAcA/V33hMfN+T56tP5gRE0M/8vNGb1Mgy9Y8dRB9NF7yD76/Ns
         b9wN6tspAHwpcPftH98/rVnzSCxkjc5i8IFq6N0DEhry1iEBczlo6mUp1/HNXZbkc1
         ap2Ik7Trdl1lA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220711115542.1015136-1-abel.vesa@linaro.org>
References: <20220711115542.1015136-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.20
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Mon, 18 Jul 2022 14:17:50 -0700
User-Agent: alot/0.10
Message-Id: <20220718211752.83A47C341C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-07-11 04:55:42)
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a=
56:
>=20
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.20
>=20
> for you to fetch changes up to c196175acdd3ab06114bde2955971bc7282f2b85:
>=20
>   clk: imx: clk-fracn-gppll: Add more freq config for video pll (2022-06-=
16 17:28:59 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
