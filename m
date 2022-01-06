Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C795485DED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiAFBOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiAFBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:14:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63146C0611FF;
        Wed,  5 Jan 2022 17:14:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B066198A;
        Thu,  6 Jan 2022 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BACAC36AEB;
        Thu,  6 Jan 2022 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431671;
        bh=Ic6wobDqilycX1vLqnFwXJhJY75RZ7eFvcy98HhFV6o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OOo1n2WJBdUlwXeDUioNBUuqxMTb1pQFMJiChchcBmTNu1V/RbN2fZNSLe4MUk+xF
         0+KhATYn+KE/KrQNmAydd6l0vpr2sDca1A2Q7mFe1Y50V8IIzUA+S/aRNs35uzy7F/
         cJtzFYDZUmCeRGX1bTTL0/7OLXtvhTKqHzeAdUYsUi9FjzMvpBC+zmIL1I0MrgxcvX
         FlQ/LE2trpvJ6Uy9P8tbMfzEkM14tA86vQgQTV3Y7seG6erTdz56pV9zDKxcT8EWYd
         o9Crsbcu7aoxtOCC6g5L2PzKuRjc2vOQgsRtzK8hLY6BhefuZ2O1e8Q0NU4cP3KYhV
         ze0kII6/mBnWQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211025031038.4180686-4-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20211025031038.4180686-4-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v5 3/4] clk: visconti: Add support common clock driver and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:14:30 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011431.4BACAC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-10-24 20:10:37)
> Add support for common interface of the common clock and reset driver
> for Toshiba Visconti5 and its SoC, TMPV7708. The PIPLLCT provides the PLL,
> and the PISMU provides clock and reset functionality.
> Each drivers are provided in this patch.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> ---

Applied to clk-next
