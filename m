Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05474C52DA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiBZBCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiBZBCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:02:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C42036CB;
        Fri, 25 Feb 2022 17:02:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863DDB82FEA;
        Sat, 26 Feb 2022 01:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C694C340E7;
        Sat, 26 Feb 2022 01:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837322;
        bh=f9wGFkLeWSGBEzWqLI2xtDVY/ByTASiBoT2L8HwEuTs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=poq5h1NXaRU3oUcY34I+/bKIOLm8CKxUa7zLMYQ5tOZ/iyKx/zz9n8QeSGlgAHAzQ
         W4d0AOeb8O5zmydkUK0GMMzP9YTe+U/wlh2QAfqRX4usMxq7CrtwFsaDIgSBBQvwWW
         7C994qJQz/KRdRyY+UjRdeGJz0DtVlO0MFtdnvWLCzo6uxmZS7ClRD9KM4y3JINArb
         Cy7jlaxJNM/3e49y88cNJ4IrSWk4hDslsI0k7IL3JAXsaNn2WmDFCQ/2tNsVmW6yDq
         2WcZ+Xqm9mlV8yR3NQ2z+1mry2H2AxUGCx06MvE5wNq7gqhNkm2LH8qUJ3Y14CKj9J
         PuqVcZsG+PhOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-7-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-7-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 6/7] clk: qcom: Declare mux table as const u32[]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:02:00 -0800
User-Agent: alot/0.10
Message-Id: <20220226010202.2C694C340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:12)
> Now that clk_register_mux_table takes a const u32 *, we can declare the
> mux tables as const u32[].
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
