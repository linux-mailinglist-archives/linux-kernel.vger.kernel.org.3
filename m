Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F0485E03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiAFBUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:20:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53692 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbiAFBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:20:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01A29B817FD;
        Thu,  6 Jan 2022 01:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4008C36AEB;
        Thu,  6 Jan 2022 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641432002;
        bh=V7HGS0OopQ136yO8OtGTvLKF+frBwmIYiz8Xe3rVCLM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=noc+rQ9dV2MaVJvCcOg0KSt3wQ9P9ZScEo4+01sFIz9Jfx4vQHAQuczNeOEHP/7OX
         SS796A1Bw60n4auLdwxZLKJVh/dchqocDZ45LtIa/8IXuIwe4S5X/4Mll0u7nFIFyU
         GWS0PZdjc/Rb2PDgrSHYx6/gWwfIrGmTgXSr55mV72nj3f7U2H6R3h7N6A2ll7B/Df
         sUxT4oJIz0XPp5IyFuijJiOOAz/o/2jaPuHvEkYomjDBT89qr9jys7fstpECKVA7WG
         mVQxerk+M0OLgEUfojX4eg2jDmHHcuGC9MeWEUh/OPmTekE5YdMeDZMrhGUjr007SP
         ZEeEgawWImkgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1640018638-19436-4-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org> <1640018638-19436-4-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 3/5] clk: qcom: gcc-sc7280: Mark gcc_cfg_noc_lpass_clk always enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 05 Jan 2022 17:20:01 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106012002.A4008C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-12-20 08:43:56)
> The gcc cfg noc lpass clock is required to be always enabled for the
> LPASS core and audio drivers to be functional.
>=20
> Fixes: a3cc092196ef ("clk: qcom: Add Global Clock controller (GCC) driver=
 for SC7280")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
