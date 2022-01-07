Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771A3486E91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiAGASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:18:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52092 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiAGASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA7761E80;
        Fri,  7 Jan 2022 00:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A9C36AE3;
        Fri,  7 Jan 2022 00:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641514689;
        bh=nCrqN1gixElapyW4wIoqI1rbQMvwPXyoXKP6XwJCgq0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UHkO8udkc0cTHJsahiPvsYbo8dL9t6KBtN+bfRihrB8OfesxZifZcFekZzWhDE5df
         G0hCsi1+IzzKhKvERTX4gXXhgwv7yJFJWWivdXcAcmBivPGxbhl2CJKEC1EfrWauuC
         j9z4BFinPN2w5dOBdBfELK2z81ViauOZtiPJ65h1zNZGGChpsgWuHKd46Jy92F7vLd
         g8oNQrsjwvexTywUOzluljTJAFss5ncaun856JKBnp+i1Q9eT9O3PW3z/rezPBcBT5
         hJCq4az6KbN59VohhLes6GxVomEi656SgdyeLoTxJ+O+jAm7qm+nNrAq6VTvQhRy/u
         DB8jNzlpE/6Kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211010043912.136640-1-bjorn.andersson@linaro.org>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v10 1/2] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Thu, 06 Jan 2022 16:18:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107001809.309A9C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-09 21:39:11)
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
