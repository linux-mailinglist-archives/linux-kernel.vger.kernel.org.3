Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58080486FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbiAGBt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbiAGBtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:49:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04223C061245;
        Thu,  6 Jan 2022 17:49:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE8CAB824A3;
        Fri,  7 Jan 2022 01:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE22C36B01;
        Fri,  7 Jan 2022 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520162;
        bh=u3FM4Xo+X8I2IxoK0MjPERZneL8hetxdUVASiY+EXxU=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Hqz4DPP1J4kC3BcAkwyfrDvrA6xfhxLoLzHgJHijaR3Hx/18SjllU9UvzXLuWgf5M
         zO9kMPEx8qL9vTY2Kc4VW0QLsoy3r0ONLTsd9MyXwNImR+XW0xxhjWmke4/YutwhGx
         FICTIoZPx11vliBAnuMPm2R5LYykNP/Y2m21hN1CwN8awr7v8S+U8CxQvUn1maonZS
         rQFhrLM7VU66AclJrXY+3J1otryyIXJ1uHQ07B/YCw9wXHIjaqlaFOWeK7xkst5uNe
         vcO8RuSBeAgdKH43dwkiWoH0jq5lF1ssSt0m0i0ZwTrEU2IhUpWlo4gkdVc7qxY1a3
         94c45/dg0RnDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-4-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-4-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 4/8] dt-bindings: clock: samsung: convert Exynos7 to dtschema
From:   Stephen Boyd <sboyd@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Date:   Thu, 06 Jan 2022 17:49:21 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107014922.5FE22C36B01@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:52)
> Convert Samsung Exynos7 SoC clock controller bindings to DT schema
> format.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
