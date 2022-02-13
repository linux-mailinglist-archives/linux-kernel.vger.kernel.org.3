Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89A4B3DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiBMVgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:36:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiBMVgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C954184;
        Sun, 13 Feb 2022 13:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CA5AB80B65;
        Sun, 13 Feb 2022 21:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204ABC004E1;
        Sun, 13 Feb 2022 21:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644788193;
        bh=4yCJVPEw7EYBsTJLYhlqqqMDIc4BXzAueVAE4/s+j5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R5kR0RE9JKHj2aZsTK1zore29M00MxcceafzYv0Xw01sSyygcrDfUXMMMJump3JP9
         6k14Cdx9owJVoMTxXpou5iFX0cI8mzTAKGV+bUQC4mmrqOBlKa1H54GOSE0Jd5qSDN
         hDqbam0G7pY49soCf40EcdQrqgXL27isIZQzM3ZCbp+uPZG8yyKTP3Vk0nFS0/bwIO
         V6SwBBh5EyDgOaAjrkQPWClOseMyM0siOOzliqpl7y+F6mifJu00NFtKBNZP97Q08s
         uuZl0Ojg1ZhfnVGAS9Tlnj0XM7ehU2MmwPTv5bEmAZPWNcSapMiMPLuG+CHoFUvWwo
         Mlbl1QXcHcAAg==
Date:   Sun, 13 Feb 2022 22:36:27 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] serial: mvebu-uart: implement UART clock driver
 for configuring UART base clock
Message-ID: <20220213223627.72f6e797@thinkpad>
In-Reply-To: <20220211191238.2142-4-kabel@kernel.org>
References: <20220211191238.2142-1-kabel@kernel.org>
        <20220211191238.2142-4-kabel@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 20:12:35 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> For these reasons, this new UART clock driver does not use
> ioremap_resource(), but only ioremap() to prevent resource conflicts
> between UART clock driver and UART driver.
> =3D=3D=3D

These three equal signs "=3D=3D=3D" shouldn't be there in the commit messag=
e,
it should be an empty line instead. I accidentaly forgot to remove it
while I was rewriting the commit message :-(.

Please let me know if I should resend this.

Marek
