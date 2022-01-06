Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD46485DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbiAFBOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:14:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52060 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiAFBOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:14:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B1D7B81ECF;
        Thu,  6 Jan 2022 01:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAFDC36AEB;
        Thu,  6 Jan 2022 01:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431677;
        bh=NifPARzIUWxVVMfXw82fQLUCwvDHOQjnxecIU6EF+zw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jHSRuWxNP/lmPC0BC5hmAtNxmUyr+0pqCixmFgl525rCJMtD2jOxwATgZ9SVrFPHw
         hGKDp8mYeOyxWlv11mwFlXMNPqUd/H9APcwG1oyRzImrr7BbCbR+cngsdRCkHEmTkH
         7UiH1VPEJMm42uO2prwPWC8MlQXpqfVIbXxjJHZd7cy+g7umgfaYpvp7vHGDebv+Or
         BigkffGAucdl7gaSOkUsoArnNxMPZi8htBozthYtxlGAFXRVzoT4X0bJCWbIy9P7HU
         tc0tjp01WIJwg/fblRyL++rSgaThX0QY1XzW++RbzjqEyIGYgJej3WxLXATZU88aIt
         MowuaOrjA12aA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211025031038.4180686-5-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20211025031038.4180686-5-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:14:36 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011437.2CAFDC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-10-24 20:10:38)
> Add entries for Toshiba Visconti PLL and clock controller binding and
> driver.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---

Applied to clk-next
