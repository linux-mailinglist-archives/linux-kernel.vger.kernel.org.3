Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA282486FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbiAGBtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbiAGBto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:49:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E4C061245;
        Thu,  6 Jan 2022 17:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD6B61E4E;
        Fri,  7 Jan 2022 01:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2217BC36AE3;
        Fri,  7 Jan 2022 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520183;
        bh=7d6SgrBTM7S5WXqCXMhmurIE7717FogEGCjrXrv3vNs=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=d+xhBy74LrN6Sb/QggJ7OKzlHuZxjslCB4LRGh5et4f8eDo655gw1ZVAKJ1sKAJvy
         oqVGXK7T3IRVRoT5x3jCMGX6KbBCSNIx3OmtPbZkTntgbAesxJgOi7rgIC6wDwqHEr
         Yoxrf2n3/Am+NbybnmgdeA7RLJ8kNMW2fKdingF4HrW6ZsFXLXQ653b5qkOwLGoUn4
         b1t3+tYSWFD67dZfjd0U4+1hD81Nr6Nfu0enAD+JHE1sci7FQPFHwxTA37/OdCHuML
         eM5XXvo7tB18uJS02UmPU03IgBDYZp8oF++LJIou/DgRVQF1k/vG5YsG6PZjsUBCT/
         UMxW6qcN08PTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-6-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-6-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 6/8] dt-bindings: clock: samsung: convert Exynos5260 to dtschema
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
Date:   Thu, 06 Jan 2022 17:49:41 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107014943.2217BC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:54)
> Convert Samsung Exynos5260 SoC clock controller bindings to DT schema
> format.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
