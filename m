Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2D59770E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiHQTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbiHQTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D11C8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD1661480
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D158C433D6;
        Wed, 17 Aug 2022 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660765648;
        bh=RlznfQgTn+Zb69qUdCkZoQUpTrnL73CXphk9kJNJFHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bAfkLGolSdo3TKS9rqeOUu76NFl9PJTUgF4T2R4WoLYhjeCpFLXiRnUVRfzuj9OUg
         kQqk1/dsTB4P+KsaUO5GCu2QyzJ5V3rgDmNbTq6rTXBOCErMbtNH4CcWb5oX8CtJ1R
         ITfOPhAr3lMAeN1NumI2wbmHQVeX/xyteeCCpHTAq5RjydUNz1dcn8a0IvVzZdyfpm
         RlUa3g4KVQGKI1y+xZZSVLhXaWeTZhCQ2MSB85hAWJYF7mxvneHSoRIhM8kqMeNhO5
         TDOKrMMG36wCVLTZCaf7llyiZDrYZskC1+MIhnHMlRJL97sUzJhdyVasjOQfeFhAmF
         EdsRIKabPWzRQ==
Date:   Wed, 17 Aug 2022 21:47:22 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        josef.schlehofer@nic.cz
Subject: Re: [PATCH linux-phy 3/4] phy: marvell: phy-mvebu-a3700-comphy:
 Support changing tx amplitude for ethernet
Message-ID: <20220817214722.461b18c1@thinkpad>
In-Reply-To: <20220817193119.4463-4-kabel@kernel.org>
References: <20220817193119.4463-1-kabel@kernel.org>
        <20220817193119.4463-4-kabel@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 21:31:18 +0200
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> +static u8 comphy_find_best_tx_amp(bool full_swing, u32 amp, u32 *true_am=
p)

...

> +		tx_amp =3D comphy_find_best_tx_amp(tx_amp_mv, full_swing,
> +						 &true_tx_amp_mv);

OMG, I changed the full_swing parameter to be the first one at the
last minute and forgot to also do it in the function call.

Will send v2.

Sorry.

Marek
