Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50DD498F52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiAXTv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:51:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36706 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbiAXTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:41:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C648F6153C;
        Mon, 24 Jan 2022 19:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A1C36AE2;
        Mon, 24 Jan 2022 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643053265;
        bh=oprGMI/K+YqT86d7ztdKp23qNaPKO+vEI0XjzYsXDaw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X2M6cVNicD7eeYBg+29gG6dP2NJnkKavYPtaNgIcKaGYhgcvAMtQlDTNSn5R8rvcO
         8Po8Od7KSdzu9afJjnDXYUT3RQ+2tIc+3Uv5xm3NsTOgeuwJHgbWWrgUrHCzDbUZPt
         GdEZKjomjYMT+4xgXLmTtrMbsvBr8DjfwGOmkKbZgxslBiBdY6TWbs++fwZ5atZJVK
         waRV+25l8Xg6tS5NK9hDCJGuW1qznGdcM/UdmTr1HfLqLOewdqvpi5inV+qbbAla/A
         skPKA8GyQ4SfZrRYGgsUYQr4VYQERxYcCKReKsBMyjauHZdN31keMH2xO56o+lHfmd
         GDuFiF5/aBD9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220124171415.12293-1-tdas@codeaurora.org>
References: <20220124171415.12293-1-tdas@codeaurora.org>
Subject: Re: [PATCH v1] clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 24 Jan 2022 11:41:03 -0800
User-Agent: alot/0.10
Message-Id: <20220124194105.260A1C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-24 09:14:15)
> The current implementation does not check for D value is within
> the accepted range for a given M & N value. Update the logic to
> calculate the final D value based on the range. While at it, add
> support for 2/3 divider in frac_table_pixel.

Please split this into two patches (at the "while at it") and add
Fixes tag.
