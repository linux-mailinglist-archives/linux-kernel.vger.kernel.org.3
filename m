Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58E9486FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbiAGBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:50:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55086 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbiAGBuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:50:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73245B824B7;
        Fri,  7 Jan 2022 01:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C20C36AE3;
        Fri,  7 Jan 2022 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520210;
        bh=/CgJHQ+YbZ1KI/MydlOsveZ/TMMheplQgs1E/1qx9YA=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Y8XMs2kkaavo25wkHJxpUgvA/g2vKO+qhyRC+QguYGg+2uG5791mZ10MRhYxj8suG
         iaBiq+rQ/AaGH2ntgTPKysJHnw46v9gD4KfrNyMu5AZmYJbdFn8z5ok919MPE8ZGZI
         pXxYdmBftdi36NfmibDD5AkI1loHuI0wfqhxUSugaFeuzgOU+IO/p2XKPa/jRxmwmX
         oUfNPZgq7WHc8wWy+g2lPt88bTRgAEEvoH5x0hkXxaFiRbHPE1ISC+ULzCWIRmOXtY
         dhSyWuN8tTtd+p134W0lQGp6pE9mhMBRkofLnZOTWrn7KG0w2bfibDXhM5FjcnJHHD
         xHJdP4+2tjFZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-7-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-7-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 7/8] dt-bindings: clock: samsung: convert Exynos5410 to dtschema
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
Date:   Thu, 06 Jan 2022 17:50:08 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015010.14C20C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:55)
> Convert Samsung Exynos5410 SoC clock controller bindings to DT schema
> format.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
