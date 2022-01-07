Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE387486FFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbiAGB71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiAGB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:59:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E29C061201;
        Thu,  6 Jan 2022 17:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4134DB82350;
        Fri,  7 Jan 2022 01:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E8C36AE0;
        Fri,  7 Jan 2022 01:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520763;
        bh=0x4HzWhrl/GPA9f9GJo5oiTM/fxY75mmm4HIWLZ2+Rw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G4ZWrNnegOXvUQNdbngXaZIvKAnMp0Xn+LNXsJHnaA6kcMQJxxJ16WDgFr6TK/4gO
         VNtGi8jpA0iBGiBEwNYeGlX9LR+/hH1pYuKSB0D5MeVriJ1WTxdxEwkKDFgqm3oSNl
         o3cqOGz3Hcva8zn97oSKNVzKbVT9cxnf3/vU60yedvb9Cg4E4xlWIkM5e6nBSmCesL
         B13qrQnXgWmDKb72kGA4b3TDPLIUv9Qo4JQshVMX9E394hCmfWzdu4UszcxdZnHKEs
         4rti1QoWx8HLUaPET/AORnLz5cTISW7EDNCsSF5hh/L0pxRKLJB6MbKKJ6Bfnd0wDc
         WrZr1WGEAVqRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211212180527.1641362-6-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com> <20211212180527.1641362-6-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH v5 5/5] clk: x86: Fix clk_gate_flags for RV_CLK_GATE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 06 Jan 2022 17:59:21 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015922.DB4E8C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ajit Kumar Pandey (2021-12-12 10:05:27)
> In newer SoC we have to clear bit for disabling 48MHz oscillator
> clock gate. Remove CLK_GATE_SET_TO_DISABLE flag for proper enable
> and disable of 48MHz clock.
>=20
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> ---

Applied to clk-next
