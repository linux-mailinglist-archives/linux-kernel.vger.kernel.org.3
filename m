Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1699046ADC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbhLFW55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:57:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46270 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377486AbhLFW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:57:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD021CE17E3;
        Mon,  6 Dec 2021 22:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0AFC341C6;
        Mon,  6 Dec 2021 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638831234;
        bh=w2hBPIdoO5Kdp1AYRxSZN0iP/9ZTsG6n+fAcZi4UiLg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=max2/U9KoDJJw/w45Ei5FVUT3ib/yaLgob3pTmVvIMlOFACsFiYzAV2b3WH8khJJX
         N8rmEd+8KEcgslenRlJqo57z+Xvz+sDL9dY8oJ0DLmtCfSOEys3iCsMaqjhNBjBsy8
         2+vXWnYpfcMTsAHOfv35dL5lwUhxyFDKxX4lRpQrYfbt3hGTGwylxoJnBJrbPy+zFc
         iZMTOQWcDhzxkrlZi8Xdf95hEecPeBIypyH+wQvY7l0ZJ6mX6Gc2UQszrQPItTIU3+
         P+/f5f87niesITTvFvqkyZ7XaQg/do7e+m4jqYIu6tRiovL21asDwSoe873EibRtd8
         KF6PDu9T4rMlA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203141515.2448129-1-dev_public@wujek.eu>
References: <20211203141515.2448129-1-dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Wujek <dev_public@wujek.eu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Adam Wujek <dev_public@wujek.eu>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 06 Dec 2021 14:53:53 -0800
User-Agent: alot/0.9.1
Message-Id: <20211206225354.BF0AFC341C6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Wujek (2021-12-03 06:15:31)
> Add a sysfs property to check the selected input.
> <input_num> <input_name> <input_name_from_DTB>
> E.g.:
> cat input_selected
> 0 in0 WR25M
>=20
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>  drivers/clk/clk-si5341.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

sysfs properties need documentation in Documentation/ABI/
