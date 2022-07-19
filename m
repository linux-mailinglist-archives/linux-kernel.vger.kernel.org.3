Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58965794C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiGSIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF96286C6;
        Tue, 19 Jul 2022 01:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27E08B81812;
        Tue, 19 Jul 2022 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901FC341C6;
        Tue, 19 Jul 2022 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658217702;
        bh=MPn31g5DM36GxUKdneF5aM9b7MR33ynCtw9uF8ye1Kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JEKQQXvAtzyUr1Iy+FKp+r4lahFxgM3G2IvvoDbVvyB1Rskpgk9jZeP6wMQg78Nl/
         kP64nwnlpXPjhhWjp/Ysn3+B36J1LDMJbE06U9xhokA4YPQ8tNwFoYTqN9fuO0Cqbr
         T7U3TXLpr6AU6WGoOwytp8Oowx2aw85yfi0Z+Gvqy/8dJhkQWfSWr5Sk/aeeHcl1r0
         4iXXRKyBzWEOCCMMjtCmLtXzjY4SerwE1xuI/RR9dznKg/dLeyloYeI8YSvkEir4Vn
         KUGh97UvfLFD2XytrgfFVnQwhVKpwHZTvl20iYmaj2EZmaQXjjAnpno3TMFznEjeAV
         Bs/AKrs1Hf9aQ==
Date:   Tue, 19 Jul 2022 10:01:38 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Antoine Tenart <atenart@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: inside-secure: Add missing MODULE_DEVICE_TABLE
 for of
Message-ID: <20220719100138.49f8ccab@dellmb>
In-Reply-To: <20220719075403.15379-1-pali@kernel.org>
References: <20220719075403.15379-1-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 09:54:03 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Without MODULE_DEVICE_TABLE, crypto_safexcel.ko module is not automatical=
ly
> loaded on platforms where inside-secure crypto HW is specified in device
> tree (e.g. Armada 3720). So add missing MODULE_DEVICE_TABLE for of.
>=20
> Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto =
engine driver")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Acked-by: Marek Beh=C3=BAn <kabel@kernel.org>
