Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4E485E10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbiAFBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbiAFBWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:22:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BAC061245;
        Wed,  5 Jan 2022 17:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B465FB81ECF;
        Thu,  6 Jan 2022 01:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6418EC36AE3;
        Thu,  6 Jan 2022 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641432119;
        bh=FWjd97uCUcwS44A4mF4AzRTCkKk3jDmIJyUX2bUCvr4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=luIngZZdxFVpNBjA4QEYYAhvro3zCvs1yF/k7pzISPGahQ2mrhoqZbpva6K87yAWM
         pgqzNi+bmR92lURFcS5NcC8sxrRAjAOT9V1ZNxLlAc0vBsQdFevov8Z2iGAIVP4uKP
         sRD9gaxVp9N4luGYJw17Nej4Jr3RvuGXOpydryG3dVKqAFuZBWeghOj19PfA90B35K
         n8MkL2farIJLbVwO7b/1+f0uDhjGZOKgWdEmqafbUgv+MLIG1j8w9kHi+StRWo1d7Q
         AFUxzrB6OSNvQEJuBAJEZX4yXaBJRMBb0MMaGd4dvD/J/g4e/xLsKDV8qkLG15RA4n
         gheKjMyucGkBA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211218211157.188214-2-avolmat@me.com>
References: <20211218211157.188214-1-avolmat@me.com> <20211218211157.188214-2-avolmat@me.com>
Subject: Re: [PATCH v2 1/2] clk: st: clkgen-fsyn: search reg within node or parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:21:58 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106012159.6418EC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-12-18 13:11:56)
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
