Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6616F48F2D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiANXIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiANXIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:08:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EC0C061574;
        Fri, 14 Jan 2022 15:08:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04C50B82A0C;
        Fri, 14 Jan 2022 23:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD63C36AE9;
        Fri, 14 Jan 2022 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642201719;
        bh=JSbd/2JJlrn7NdVeL7yUu515yOv/H1ir0i6L8o9BVwc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DXAKdbNFYESDd5ZoJyBcxJB+BBj97Q5GGkm9E76xYoMhfKwRs6dM1ui9fmoK/Kv04
         J1jcrshP/12K1fCmxUTnuWkNKNyLa31emQokPOacDisBwgKXKRSEOAveXaQxidtba+
         Mcg1z90AWHGBmpeEhivMt5xCYvfH7AMf5h0ZybURoKuXN49ShVzR6wkogdhM/+KuIC
         gwE/O3idr3zzbRZYKQJjHK8BZRUKunCxdyyVqxp8b3vGPpfjTC1Ay/FblhiCbGshfb
         2d+lA/XoSEVQDFmNDjqNNmC0pa5ZZr4m3HcgpHJ6RqJjz/8wviuBPUbKCwUFnz4+Xy
         jJ0tvrZKOWA1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211220195646.44498-12-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com> <20211220195646.44498-12-cristian.marussi@arm.com>
Subject: Re: [PATCH v8 11/11] clk: scmi: Support atomic clock enable/disable API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Jan 2022 15:08:37 -0800
User-Agent: alot/0.10
Message-Id: <20220114230839.ABD63C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Marussi (2021-12-20 11:56:46)
> Support also atomic enable/disable clk_ops beside the bare non-atomic one
> (prepare/unprepare) when the underlying SCMI transport is configured to
> support atomic transactions for synchronous commands.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> NOTE THAT STILL THERE'S NO FINE GRAIN CONTROL OVER SELECTION
> OF WHICH CLOCK DEVICES CAN SUPPORT ATOMIC AND WHICH SHOULD NOT
> BASED ON CLOCK DEVICES ENABLE LATENCY.
> THIS HAS STILL TO BE ADDED IN SCMI PROTOCOL SPEC.

Why are you yelling on the internet? :-) I guess I need to ack this.

Acked-by: Stephen Boyd <sboyd@kernel.org>
