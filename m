Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA946E3FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhLIIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:21:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43488 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLIIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:21:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E22CCB823D2;
        Thu,  9 Dec 2021 08:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A602BC004DD;
        Thu,  9 Dec 2021 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037865;
        bh=kSIIusx9xaK/GoMoLZqWX0pvenSDfG9Wd5vs3wVEza0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BFY1NywGgTHu26oMmfuVs4DolrjrLzoJe553GPfbbcQV+KD2ATzsVVtxJV56RFitE
         AttxpkmeN2Q9AKuZ0dunWgq3lHQw3Shz45sCtB6tSFA8O8L034VcauyjSeB1xZpMWr
         m6TAPUcfyBXRFrbu5KcFNROE+6VbE47+qN6C2PyhI5bTrOTEtlFtVluJMtGML7BCEp
         zz5Y7I2GHZohKVS5WXGI2jtpb5XsMKWTe8AbbigDnqWwGrmshMZumgM/0PORX0J/2j
         0Um2lV6/NNJq+YjAKjKOvRVus/XIrGMT8n3uAVFMyUR+yOB+xngyXc8/6Xf5u+wc/X
         VZ9L8sA/WGY5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211127173036.150535-1-colin.i.king@gmail.com>
References: <20211127173036.150535-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk/ti/adpll: Make const pointer error a static const array
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Date:   Thu, 09 Dec 2021 00:17:44 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209081745.A602BC004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2021-11-27 09:30:36)
> Make const pointer error a static const array, removes a dereference
> and shrinks object code a little.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
