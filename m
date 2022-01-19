Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A849416F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiASUF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:05:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46000 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:05:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D80CB81A88;
        Wed, 19 Jan 2022 20:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15995C004E1;
        Wed, 19 Jan 2022 20:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642622724;
        bh=WETv3X7CMWAxiJd6kJ5202hY9BumADpmPipnmE7jRRc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lkxTmAKMPE8VYox3ea1nm1pTyRDVTfcSYa4zu5NpReRB/HVyyySaeaqJv1pL6Go6P
         jwH/VIrLLsgpX6hQajFl0rk1UJw2cv4fgiF6eICwqk6EVctGrasCPdITThNTVngKlN
         PsDbwSaZZPopGwv4gOMfN2Foz4QKCnlpwWqdJdU8IG7LJTCLrOREMUV3mYynTTPdvG
         YpIv6kZRYY8ZMJzV+SgcNFErhV6Cybu7sRa5FPVvh5qwXp0UVvedK5RJ5AsN1v/KL4
         tliaQ60cxW060PwOC+zG68URG3Z1qik71YDq/ajKltn0HIvL8cVxAHc5CUSdpMxrjX
         ToMx034KO3y8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220119123658.10095-2-sam.shih@mediatek.com>
References: <20220119123658.10095-1-sam.shih@mediatek.com> <20220119123658.10095-2-sam.shih@mediatek.com>
Subject: Re: [PATCH 1/1] clk: mediatek: relicense mt7986 clock driver to GPL-2.0
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 19 Jan 2022 12:05:22 -0800
User-Agent: alot/0.10
Message-Id: <20220119200524.15995C004E1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2022-01-19 04:36:58)
> The previous mt7986 clock drivers were incorrectly marked as GPL-1.0.
> This patch changes the driver to the standard GPL-2.0 license.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---

Applied to clk-next
