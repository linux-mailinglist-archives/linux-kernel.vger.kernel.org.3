Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05B4D6C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiCLEuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 23:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiCLEuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 23:50:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0812C2;
        Fri, 11 Mar 2022 20:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15E99CE2B7C;
        Sat, 12 Mar 2022 04:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A66C340EB;
        Sat, 12 Mar 2022 04:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647060532;
        bh=m/uKqo1VqrzJroecat0mLWKV7uy61IF6O8ju1Tzeapk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sk3jB4OgQkZJWIl58l2qL9i0IGIwud/9lMbE6CnBcSlz4eHp/qTv8BNndqHpb4hnw
         TSfhIDdQRl7qM0TS46UD+xRd2RrlqH6BI55b4P5zCFXK40mtn8NCi69atqsx2do6wC
         OPs0KsoBtXXDVogwuQpS1dZzEKx4kn6mumTlGRaVGr971E5bqHDp3GySvkkPF3xyEf
         FX9yr9W8IGqlv8Ik17G8R5rrXkRCN/x1zkMCfdDKiqFmOdDUmD8b+mXuLtc7QYBn3K
         tddXdugCeMRaf/zN1+DsqNYmDtYVnm4rBqie1IFrX+1sWZDmmBg5LG02dmQhDqxKDg
         WFQT1qVOQ8VGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208183411.61090-3-povik+lin@cutebit.org>
References: <20220208183411.61090-1-povik+lin@cutebit.org> <20220208183411.61090-3-povik+lin@cutebit.org>
Subject: Re: [PATCH v4 2/3] clk: clk-apple-nco: Add driver for Apple NCO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Mar 2022 20:48:50 -0800
User-Agent: alot/0.10
Message-Id: <20220312044852.06A66C340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-02-08 10:34:10)
> Add a common clock driver for NCO blocks found on Apple SoCs where they
> are typically the generators of audio clocks.
>=20
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> ---

Applied to clk-next
