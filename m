Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150D3485E13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbiAFBWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:22:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54344 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiAFBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:22:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D12DB81ED1;
        Thu,  6 Jan 2022 01:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B6CC36AEB;
        Thu,  6 Jan 2022 01:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641432126;
        bh=LDsuddmVyCNfFam0Jb1mRZ6bRN9QVH2bjAXJWN1eGQk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KcjEPO7k3QiOQMIzaE1RM63tbZXUWDq12drzA2tnZXeZ+OplhJjS9fYr7j9CLVHXY
         YN0WDI3KcKdO1hcbmYB1mOmVdzWSbRQR6u8X0/3zofg6GFfqKCSIzM6ZtPFCqrTSeI
         J93aOOH9reZLQvAqeWwaezpOzHboVE5wWGhmBvraMhb6XIP115M6lfHtleXbSKKHBh
         R9C8gn7k5dNo6byiYpjhC8rlhaguqzioCAaKemArAGoB7A+oY4ftsNbsXaXxxqV9EA
         T2Z8b8lJuklPLkctte2Gedsz+flXntqQorOYGaUS91aIZK54yLqr4HJQs6vE8P01Xn
         ZE9UVH21ywEeg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211218211157.188214-3-avolmat@me.com>
References: <20211218211157.188214-1-avolmat@me.com> <20211218211157.188214-3-avolmat@me.com>
Subject: Re: [PATCH v2 2/2] clk: st: clkgen-mux: search reg within node or parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:22:05 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106012206.A2B6CC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-12-18 13:11:57)
> In order to avoid having duplicated addresses within the DT,
> only have one unit-address per clockgen and each driver within
> the clockgen should look at the parent node (overall clockgen)
> to figure out the reg property.  Such behavior is already in
> place in other STi platform clock drivers such as clk-flexgen
> and clkgen-pll.  Keep backward compatibility by first looking
> at reg within the node before looking into the parent node.
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---

Applied to clk-next
