Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B60466F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhLCByv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhLCByu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:54:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F227C06174A;
        Thu,  2 Dec 2021 17:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC1362905;
        Fri,  3 Dec 2021 01:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B25C00446;
        Fri,  3 Dec 2021 01:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638496286;
        bh=jhJPZM482uKMz6Qw8sbJjBKIK+BUQ8yyPkUjidZ2XqY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=coPlukwK7+X8OGnE6m3jUkoQEelKzc/PlBg8nWJ0l4dO7XHSGawBD1f83OzaXLN0u
         +m6B7DxfrofxQOkwiN2N3WitwZCP7bNfpOx6QpCEFyYsiEKL1si+TYja6JUyfYLlzP
         ENe+y26H4oVBAvBoTXU7nBy25MC/k+YUqNm7DQZQIs4+Mt1U2b0xlCPaBMwT8duCXj
         /nZ0edWR2w3rY+1bs11XTzUryQWNucpScBXf64UJ6KPx8LHtgL/sIKaEjqGwyfcURK
         iY1G5AIRlPYeSotWqV5mjofs3TK3VcfvLinXzro77ZHLDOmNlBFLy54NXApaDh52vd
         bMwI3RaLlkf+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203013901.3460496-1-bjorn.andersson@linaro.org>
References: <20211203013901.3460496-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Qualcomm clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 02 Dec 2021 17:51:24 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203015126.40B25C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-02 17:39:01)
> Most SoC specific clock drivers are picked by respective SoC maintainer
> and then sent to the clock maintainers on their way upstream.
>=20
> This has however not been the case for the Qualcomm clock drivers -
> which doesn't actually have a maintainer per MAINTAINERS and where the
> framework maintainers have just carried the Qualcomm effort as well,
> presumably as a result of Stephen's history.
>=20
> Move the maintainership of the Qualcomm clock drivers to use the same
> model as other SoC vendors and document the ownership by actually
> introducing an entry in MAINTAINERS.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
