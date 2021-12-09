Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9525646DFC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbhLIAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhLIAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:54:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D05C061746;
        Wed,  8 Dec 2021 16:51:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B88CB82338;
        Thu,  9 Dec 2021 00:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF4C00446;
        Thu,  9 Dec 2021 00:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639011067;
        bh=lDpvo5Y5XkMJZEGTr3nhMxq/klLuv+XPxGliSChu3X0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T/yyH422MMiUfEh4eFWKCXrPA1rT3ZCwMR7TYt9Iy6ePpoqbiNvwhZ9Vykf00DqCc
         S635kFYlwPJQxoUeqz5vb0nEcUU4Tpw+4ZsbMq8akVz4HX5ePiWVh9lYMqGcuOk+IO
         hNJsfXZKGc12P9JX/uL+MyKlbe0rpUEmMcpqGVFFZlZ99j3vdpFy9uK8Tl0OEaW3nJ
         NZ9+Hi5p6aMjMXTlUajDbheSs0WOs6GfMW9gnHKY9D3IVa+aDO4jqYEhdDDczW4sRI
         9cfkeeovr23xZAx8cJUcobkJ7/+ZUdvL/Q0hXEqlgdGrbd0XUh5rMb5jXbAafkl1uz
         mH67mXCKf3yaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e7c9b7d4-8fef-57f5-b774-9931f5ff40ed@quicinc.com>
References: <20211109043438.4639-1-quic_mdtipton@quicinc.com> <20211208015324.86282C341C5@smtp.kernel.org> <e7c9b7d4-8fef-57f5-b774-9931f5ff40ed@quicinc.com>
Subject: Re: [PATCH] clk: Fix children not voting entire parent chain during init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Mike Tipton <quic_mdtipton@quicinc.com>, mturquette@baylibre.com
Date:   Wed, 08 Dec 2021 16:51:06 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209005107.98BF4C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Tipton (2021-12-08 08:16:52)
> On 12/7/2021 5:53 PM, Stephen Boyd wrote:
> >=20
> > Let me see if I can fix this up on application.
> >=20
>=20
> Sorry, did you mean you'll address your comments when applying the patch =

> to your tree? Or would you like me to submit a v2?

I fixed it up and applied it to clk-fixes.
