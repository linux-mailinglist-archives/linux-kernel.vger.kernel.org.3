Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB6486FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiAGBtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbiAGBth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:49:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A04C061245;
        Thu,  6 Jan 2022 17:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD1E9B8240F;
        Fri,  7 Jan 2022 01:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1BAC36AE3;
        Fri,  7 Jan 2022 01:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520174;
        bh=3o2G6JD9amRUelZr5aMAQDHKzUMENPC+3606VeElBGY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Yb5PS061HDeRei+bWNpcG1Q3HH4L+L+v3GTvDfNyrS4WRgw7STOLS737Fy9eGj79q
         CGvQOIgE9BnAYRy4ez+6KWNSzTiJvE5lYYBvKneyDh4DEzpWDwzNBEfQU1DxbRfsNU
         q/8Sgv9gejYXCmF20VVtWhXaygP7q3ZaiscUhPqskcW5I/EBDbEXDyD2uslSYRVeur
         +lwHAdK15iSdZLvhmXeBEQV1IzejG14G2yg/gmUDZlAsViu57RJFY8unuXYAys8rnD
         NtvwsKAuilsbg/QhMSl3bbzwemqnY3O0fnFbyml7W3pMK4+ZJfDXEl4qwg38dBUCMC
         6w1jyXJMJWwAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102115356.75796-5-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-5-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 5/8] dt-bindings: clock: samsung: extend Exynos7 bindings with UFS
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
Date:   Thu, 06 Jan 2022 17:49:33 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107014934.7A1BAC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-01-02 03:53:53)
> The UFS for Exynos7 SoC clock controller requires additional input
> clocks for the FSYS1 clock controller.  Update the bindings to reflect
> this, at least in theory.  In practice, these input clocks are ignored,
> so it is rather adjusting of bindings to existing DTS, without affecting
> any real users.  I understand that is not how it should be done,
> though...
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
