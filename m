Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AB4D38B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiCISZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiCISZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:25:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B73674E6;
        Wed,  9 Mar 2022 10:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8900761670;
        Wed,  9 Mar 2022 18:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD693C340E8;
        Wed,  9 Mar 2022 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646850266;
        bh=XVe6hQddOEoUOdatIlL3UN6Z9+g4NeqXw/MGBTd0ohI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oPnm9Kjx0Df4PQFYrsBuv/qvOtTptQNNErvs9lz8pYkdTREQJg7jr8+D52+gSKixs
         QVke9DG+ldd6ylDCKr86ew31CovsoiF8WwuvbZ2E1WZkAnBGDbyuM35+GYhefVZMbN
         XP6OJJVFz6PpuNcAAHS9p7tDVNBKCF/JE8OVWYo5hMyM4unosoCG360jJl3yoqhxGZ
         9J5pxGzcl9wnNMf8eqXF9mSs0rJP1PajyfP1NTOeCkNOPJ1qwhqQNwQslfz6zfbI+d
         t45kEx6k+UnHmPHwTZAyIQkEY4Di12Zo1mGxNE0gQdObOrfBX10/HXhLjhyhZg911K
         n88ntACiKV9Lw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YiHfinMkAQIAQBci@abelvesa>
References: <20220216132214.258865-1-abel.vesa@nxp.com> <YiHfinMkAQIAQBci@abelvesa>
Subject: Re: [PATCH] MAINTAINERS: clk: imx: add git tree and dt-bindings files
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Wed, 09 Mar 2022 10:24:24 -0800
User-Agent: alot/0.10
Message-Id: <20220309182425.DD693C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-03-04 01:44:42)
> On 22-02-16 15:22:14, Abel Vesa wrote:
> > The i.MX clocks dt-bindings are going through the same tree as
> > the drivers, so add them to the same entry. Also add the git
> > tree and branch used.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>=20
> Stephen, will you be picking up this yourself ?

Sure.
