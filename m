Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93483470E72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbhLJXQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:16:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53584 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhLJXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:16:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DAB2B82A17;
        Fri, 10 Dec 2021 23:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABDAC00446;
        Fri, 10 Dec 2021 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639177973;
        bh=mtSAx01w2gVTwJLrDFpFNdB1B7dqyNri3Hk9MjPRLXs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j1kiKVxQgdM5tI2HRLzChD5ZPWrjfDID79B/w/J9/5v0OqE8yne3MgmgJL/3MeGE2
         fgjLCWf8kaPPJrMvEcXbfov7VsRu5lEx4KTCMIK/dniP5URclNpooLAlOMPq+vXl59
         hSLMBTnRCJT8P3BundaiOMfQwQb0vPSCIdomDj6SDQlNakflSmtV5o0isZTtyvBlVF
         nmH9NjsbdGUg0L9klAdjPsdmUE4/tF5+u7GTKhtcHdbSDyN0DfuQF/KV3BuVPfpbUW
         WNc0heJi0wprP7p/OA04UJ4SiH72YxyEnEkIJi1oNAkI4P6fZHdXMEyJL47ySsO27R
         Kf4XgkzVQ6BVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211210024446.425056-1-chi.minghao@zte.com.cn>
References: <20211210024446.425056-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH clk-next] drivers/clk: remove unneeded variable make code cleaner
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     chi.minghao@zte.com.cn, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Fri, 10 Dec 2021 15:12:51 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210231252.EABDAC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the subject to indicate the affected driver.

Quoting cgel.zte@gmail.com (2021-12-09 18:44:46)
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> return value form directly instead of
> taking this in another redundant variable.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
