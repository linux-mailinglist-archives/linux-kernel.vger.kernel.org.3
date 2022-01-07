Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD537486FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbiAGBtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbiAGBtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9FC061245;
        Thu,  6 Jan 2022 17:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94513B824A3;
        Fri,  7 Jan 2022 01:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B246C36AE3;
        Fri,  7 Jan 2022 01:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520155;
        bh=EnngooTNyFmWW24LcqtNqc0H4IlqYpwJ/rNAHHhhSfI=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=CWVxowHwaSx4cceSBJleaGg52QWcEuCe6n34cOLajyMJ7waFPwpGsT9EtiErgyeJZ
         MMWzXr/b45ZzUHmlXEM8w24spdaHHrMm/GjBOLeeL+9dmJQsqWk9CK/eoXAD5JyXsv
         Q0qWu6JqxpAkt9+sFXblS1HgGFezCFjl/jH1iS2JzEyTl40DJjVy3U4mQKzxiwurBa
         nQzrMajoRodzN4U9ahuVebPWuvNvaNRXi/7dYv6NI1uyY6BPSgMzntg250a78hzG92
         hOwd2EH6FxhTVSqHwFdaZOo57pjldKBlaXQCeUeA1OUl16sa11DB3SBmPq0S/XhrK1
         /a2MOy5qr0GSg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-3-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-3-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 3/8] dt-bindings: clock: samsung: convert Exynos5433 to dtschema
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
Date:   Thu, 06 Jan 2022 17:49:13 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107014915.3B246C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:51)
> Convert Samsung Exynos5433 SoC clock controller bindings to DT schema
> format.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
