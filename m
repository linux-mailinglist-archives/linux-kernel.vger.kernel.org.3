Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C8485E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiAFBVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:21:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiAFBUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B67B619B9;
        Thu,  6 Jan 2022 01:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC02C36AE3;
        Thu,  6 Jan 2022 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641432038;
        bh=LA3+mrFJJfQeXQpZkoy6bwopnm+qcX4aqg5IW7PfQ90=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WwJRp+HxwH2HBhZH4WLpcDEM+PoAvVSnMv7XC/kuHhKUZwZmN1KmZTUv0TWASXYMq
         do0tSRW+24XHO4Dj6p4HuCemcmqQXspfuzD6BNLMZEt5qaGwZ5JRqeHTgIS9U7Gw9x
         olBbicBPyuZdvsMiMz6zErNVjaIoonjdX1FIp/7aVSCH8fcNJ5hNKIfdzQ0Z8Kug3h
         xdNrVQ80FAd9KOR6+AVhBEWPCK4ai04RF6tTBUItcIOas0P1R7un5mrlfoNLqf/X2Y
         fW+EczAVunpVvrOKEPJHb8pNC3QRsIzMeyvAXAbzGhBmL3mpI01k5aPBMT64MXhoy9
         Vbv5A04BDuqYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1640018638-19436-3-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org> <1640018638-19436-3-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/5] clk: Enable/Disable runtime PM for clk_summary
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 05 Jan 2022 17:20:37 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106012038.AAC02C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-12-20 08:43:55)
> The registers for some clocks in the SOC area, which are under the power
> domain are required to be enabled before accessing them. During the
> clk_summary if the power-domains are not enabled they could result into
> NoC errors.
>=20
> Thus ensure the register access of the clock controller is done with
> pm_untime_get/put functions.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
