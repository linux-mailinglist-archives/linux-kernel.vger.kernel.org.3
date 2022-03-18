Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0874DDCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiCRPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiCRPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:19:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB81D97F9;
        Fri, 18 Mar 2022 08:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85FDAB823D7;
        Fri, 18 Mar 2022 15:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81F4C340EC;
        Fri, 18 Mar 2022 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647616669;
        bh=oLe8eYRKc5mB6dnNPWIAdYHtfTcjBNAqKdZiyh7ObrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eGdIhiOp8mNArconyZjeb9dtSKHNHK0I8V9+0YNCI9cV6tzZkj/kmC52w02iikoeK
         AIWK2kyiSbthQB55qKYToMb1/npKEwzzDahmEGcl6TgwuqMRC4Lpscg51LkeD+/qv4
         giGO8bIDNGURwnarJKrhfQQVTb/U3ZQfsFqbQ5GGEw+CTpi0LOx4t2MHhGKQbQ2w16
         UADChbN8Qml2bc/RiPmFBogXCe3bNBccSkmrV5M1zw552X09k44P+zTKUKRP7ezQ4Y
         ciHP8cSAvbMexotwkuWFF52A7SOeMik4D6xbI8THsZrrZ8r05wYGQq+qwjsXJIQmC6
         zBlXJUQBBh1eA==
Date:   Fri, 18 Mar 2022 16:17:44 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator
 warning"
Message-ID: <20220318161744.5814b7d7@dellmb>
In-Reply-To: <20220318141441.32329-1-pali@kernel.org>
References: <20220318141441.32329-1-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 15:14:41 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This reverts commit bb32e1987bc55ce1db400faf47d85891da3c9b9f.
>=20
> Commit 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilization")
> contains proper fix for the issue described in commit bb32e1987bc5 ("mmc:
> sdhci-xenon: fix annoying 1.8V regulator warning").
>=20
> Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V signal en=
able")
> Cc: stable@vger.kernel.org # 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v re=
gulator stabilization")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
