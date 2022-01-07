Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC0486FE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiAGBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344475AbiAGBud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:50:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F0C0611FD;
        Thu,  6 Jan 2022 17:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1228A61EA4;
        Fri,  7 Jan 2022 01:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DA7C36AE3;
        Fri,  7 Jan 2022 01:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520232;
        bh=O9FXMMfiLrwZpFgmUmgej+Yhp/UA4yUphxLvMkYBpGQ=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=JkD1W0W8IdE7gpBDHtTlUTYKVpAVTdeKjyw+74ic04D7P278ap9OEDadQ9VZBpgiM
         enRbPDRf3tHxPkjIOLZRTDB6PdVfIbkiUHI0i2khXkQTYO9EFrchsvPcd4IrSNU5ig
         08Fb1cVyERoPzdity6ki+6kEyR/aWNHv67KO7iict4hlwBXK3sLgiXBjGRJGxX0S7U
         Mzdj4zSk+QqVKCSQKupvpgmaadR8qw593/jienMUX+n09WAUjt8dAQUNHqKmgCG2VW
         XxuG1VZ54nS9cNkK6v2JTMELJngF4mK09T+pvjRwLq57Vb0/Z4ijhgvzYYAvhDLNNx
         bJD7kq4t3HLiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-8-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-8-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 8/8] dt-bindings: clock: samsung: convert S5Pv210 to dtschema
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
Date:   Thu, 06 Jan 2022 17:50:31 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015032.68DA7C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:56)
> Convert Samsung S5Pv210 SoC clock controller bindings to DT schema
> format.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
