Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE694C52E0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiBZBCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbiBZBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:02:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DAC2036CA;
        Fri, 25 Feb 2022 17:02:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5943CCE27FA;
        Sat, 26 Feb 2022 01:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9CBC340E7;
        Sat, 26 Feb 2022 01:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837332;
        bh=s3uxVknzRgf4ZtLVDNn/SWgZmKi4vM3vX/Dr0awPoAM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QTevI/z1kScguSDOxT421Kt6eqC6xPaxY5HoM7SiiZgQLCpVoe+RVUgb4DJpa/QM7
         AX51Y+Bb+1p+H58FlhYbTj6ERGPOlDJEtYkoxIgmWWDGYKbuzFygrPMtR75q/rM8wD
         tnr5TV/K9vLxtzQOMfTcQhdRKv48u/oIJoeasg8JkCiFRv3QWpIhcSMCKWKPfY6XsI
         sL4tjJfWEO60MlP/EUHdiQ46MZ+xHEgxDaCEJsPYIIb3lfJBpC80fcR9UQWSxj6VU0
         UdTDgyikVrgKNJrkvpP9D6+HsLHUCpRmrzANfkat5faURrtIio3RxI3rWjGA2l+XSH
         J60FeeIfKEhQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-8-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-8-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 7/7] clk: pistachio: Declare mux table as const u32[]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:02:11 -0800
User-Agent: alot/0.10
Message-Id: <20220226010212.BD9CBC340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:13)
> Now that clk_register_mux_table takes a const u32 *, we can declare the
> mux table as const u32[].
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
