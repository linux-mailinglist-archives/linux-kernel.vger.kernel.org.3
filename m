Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB04849AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiADVFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:05:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56686 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiADVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:05:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09392614B6;
        Tue,  4 Jan 2022 21:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ADFC36AE0;
        Tue,  4 Jan 2022 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641330300;
        bh=UqJw3mKeb1L+ok0+XSeNdOLrQu68Adeve9BZkDGU/gA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PnDkNfCkv+YJUUt+W4jQGo70zl4lsWo6YsvNXaq1Tz6e4MdalqkVKejvQljRJsVz3
         +OPSP1wP5XD5F+lpgCrINcyW4XH6CILXbFC5NHfIZJBiIRbCaEAe+6F1BLAt9kEQaW
         bquYv+kE5p+KOwJYfBGToixAPHuYi+ckNoiN1+O20a4C0jToM9uMBIE75OqhkWmL0+
         40AwNChXURGuzBrElIyDoQUU0zKLO7+LxB5eodquZFvboLfnmxz1SznBCwUII4mxfJ
         ErpxG7UgReCbbbrk4fr5EKJxOoOi7oYDgb67uL0bHYlcwgBLGagE2KeFEKEkgGnX04
         7umGUseh4zWyA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1639866882-9578-1-git-send-email-abel.vesa@nxp.com>
References: <1639866882-9578-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.17
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Tue, 04 Jan 2022 13:04:59 -0800
User-Agent: alot/0.9.1
Message-Id: <20220104210500.59ADFC36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-12-18 14:34:42)
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0d=
bf:
>=20
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.17
>=20
> for you to fetch changes up to 9dd81021084ff22cf88a180d720f4f4b47392059:
>=20
>   clk: imx8mp: Fix the parent clk of the audio_root_clk (2021-11-22 17:33=
:12 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
