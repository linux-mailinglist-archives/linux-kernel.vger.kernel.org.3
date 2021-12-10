Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01346F84F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhLJBTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLJBTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:19:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CF8C061746;
        Thu,  9 Dec 2021 17:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12607B82702;
        Fri, 10 Dec 2021 01:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE3C004DD;
        Fri, 10 Dec 2021 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639098967;
        bh=UuY7UXFeegHRNpZnz6Uim3x7uDO6NcZK6IGYr2y8AKk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l2AbTvWcnvNawkrlOpdKM/WCiEblUM4382g8ukJAcl/M8iRJCYH7PiKtwIwdAC7B4
         d8K/L4YD8ajTQiLKWy661zsayVQ4zGpEvsd9LsnzpaEYICtRE79MK8ky6yDuNHcoEp
         H5PAVTOVzWMyggzl/yiHylmUIP1PD/UpzSU7FIFNiHrLI9dkf9CATJyQ6AEBl84r9r
         VYEpTGAeoN7ciBeuBE+BVFW4emzIBpqKgoedjg9QNyHHuValZdMgj51Cn0tyTu/us2
         jOC/pkTZtEpnE4/vXij0TbCg3SlPix5VBT9YTmg1MdzfbqKkf8uzXWv0OCBX/sZP0E
         UwFlwvPfbKv1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211208041534.3928718-2-sboyd@kernel.org>
References: <20211208041534.3928718-1-sboyd@kernel.org> <20211208041534.3928718-2-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: __clk_core_init() never takes NULL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 09 Dec 2021 17:16:06 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210011607.A7BE3C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-12-07 20:15:34)
> The only caller of __clk_core_init() allocates the pointer and checks
> the allocation for NULL so this check is impossible. Remove it.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
