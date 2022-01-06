Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E1485DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiAFBOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:14:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51912 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiAFBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:14:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4BA4B81ED3;
        Thu,  6 Jan 2022 01:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5AFC36AEB;
        Thu,  6 Jan 2022 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431660;
        bh=YLn2lH10I91g4YKXm/xF1Rczipbukf9/H0jYFStLbTI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u6Zdca3/a+l8muV5p/JqJCRK6XwLByK/mgLVR08CTsXsk4odqAO7GhkBiHRXgpCAw
         xpekc+1DquNptxlfWDr5tvbt0ytIVWuxRHFtzIbrBIW7l3fPWLlIxZMR3MPfdonZ1C
         Drgb2GDy9pbxjNgkICrTA6TOBtsL5N82/qT3AhXx8/03NnjZUgwQ0rEWYiKuctOMVt
         ldnP4m6c6X61OFcuu8cxm765KgaahdRpakQHRyz3BFGGyn3jUMChQpc7VrJS0HE5sW
         Jk709gEZpp/MwZI719s3mauxOamQ4LgtH8MiuMUGF7LZXNX+4JoSLrNiwffEwOJkSq
         6E0uXaiaP28Gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211025031038.4180686-2-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20211025031038.4180686-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:14:19 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011420.5B5AFC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-10-24 20:10:35)
> Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next
