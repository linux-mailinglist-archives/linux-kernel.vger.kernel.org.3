Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48CA486FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbiAGB7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:59:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48318 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiAGB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:58:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7140F61D99;
        Fri,  7 Jan 2022 01:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE163C36AE0;
        Fri,  7 Jan 2022 01:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520738;
        bh=8Ijx8ZyT8dEygn6iwCg9DUdEOIDqEPhPd7GJ7L9oovs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VSGZO9QSmdLy8TfiZ8boLxqj5oYpOFFJUbz91drbiv1mpvx7U6QvJ0+gkmTEwMs56
         oSng3x1Ecy1w20+KnryDPl+1+2I42URILz4wbB8NeYk0W2xVPBA3RnHayrIPwLKRtD
         GQg8ss4qtBcZUas9kxN7p0UHmC/DGzTyu2npj6BXsxykFB9NQeaHsaR/wj5uKlKd6d
         IXwEuMmewFpJGw+InK2IKf6Ck0ViTN6QcWvb8C96tFqI3SpG4sSUwUkSUH/U/WzWHN
         zKp61+XEdmXzAyZZaCErdTZKW6fe4a68boit34JiOxuer8sMR1fp36RUFmVnCehCMv
         khk3288hubWrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211212180527.1641362-2-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com> <20211212180527.1641362-2-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH v5 1/5] x86: clk: clk-fch: Add support for newer family of AMD's SOC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 06 Jan 2022 17:58:57 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015858.BE163C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ajit Kumar Pandey (2021-12-12 10:05:23)
> FCH controller clock configuration slightly differs across AMD's
> SOC architectures. Newer family of SOC only support a 48MHz fix
> clock while stoney SOC family has a clk_mux to choose 48MHz and
> 25 MHz clk. At present fixed clk support is only enabled for RV
> architecture using "is-rv" device property initialized from boot
> loader. This limit 48MHz fixed clock gate support to RV platform
> unless we add similar device property in boot loader for other
> architectures.
>=20
> Add pci_device_id table with Stoney platform id and replace "is-rv"
> device property check with pci id match to add clk mux support with
> 25MHz and 48MHz clk support based on clk mux selection. This enable
> 48Mhz fixed fch clock support by default on all newer SOC's except
> stoney. Also replace RV with FIXED as a generic naming conventions
> across all platforms and changed module description.
>=20
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> ---

Applied to clk-next
