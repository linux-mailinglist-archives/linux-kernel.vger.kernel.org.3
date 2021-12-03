Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6254466F84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350866AbhLCCKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:10:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56564 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhLCCKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:10:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F38C6290D;
        Fri,  3 Dec 2021 02:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C6C00446;
        Fri,  3 Dec 2021 02:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638497207;
        bh=pYYjckiCzk3YEd1gSBjBO3HJ8a/nWBicZ5vmVXY3QJQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UPHy2IXWzWILRb1Q0pEE5RyaxlDN+i70Q7ROUxmonA7TxYza4aKSzxPbY/9G5E5Ev
         /7Td0aJiiWzCjYLVqgygDTq218gwyNyGkpIDTD+1wy8g8Xs9uBqRyoiE6AovX+iT7B
         3iqlbrLGGN1kGdY/ntC9G4T8kd0cdzbm59Y/y6fFlHxZt8LqmyheGSTxoafcq3SEcE
         MdjBpA0fglGhxfHi8yKL2CWdsRTs9Ko9caeGgX06eIA9/vnf97ATvNdgTJ0B/eQX1N
         nT5yRhU9lMvMZlmKX26ZjRCq4FWY6mVS4V7nkDNq9vF++NgsgMWTGs9+yQsxon8Goe
         ncJmOx8FXePBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211129191156.29322-17-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com> <20211129191156.29322-17-cristian.marussi@arm.com>
Subject: Re: [PATCH v7 16/16] clk: scmi: Support atomic clock enable/disable API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Dec 2021 18:06:46 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203020647.831C6C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Marussi (2021-11-29 11:11:56)
> Support also atomic enable/disable clk_ops beside the bare non-atomic one
> (prepare/unprepare) when the underlying SCMI transport is configured to
> support atomic transactions for synchronous commands.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
