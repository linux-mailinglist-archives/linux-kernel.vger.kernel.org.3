Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262E4C3980
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiBXXD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiBXXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:03:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C45198ECB;
        Thu, 24 Feb 2022 15:02:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4CA361C18;
        Thu, 24 Feb 2022 23:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F07C340E9;
        Thu, 24 Feb 2022 23:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743766;
        bh=u10Q6g/I+ogzGwtgPaqDmJG26cVK24cTEVj70cXovLs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ua/eCRDI1puTPBxPslyMQ/jb7gslDdqvJ1cRUVQIABVV1Gvj52b3U2q29+1vY1nM+
         ujiUg9KfCTjrf/7GR9LON1YrsqV1GNS1yWTd0CdtfKfe9QDNBChEMhU16JVhXzK503
         +Vvhoa+/doSpsoRt5HW5FiO6rxAAAPgzg5NLe72G+tMxzVa0WA01P9pO+71oQfonii
         pAqZ7FZHoYBT0T5iyIOX2pP3bxqwsjd0N8aeJetiXWMsEXMrVmdRUZKTNpF24ARLqD
         9vnr3xhydQzovlymHQqlCnGNHqYWY9jhxuw8chA+FyB7MEsUxAvdp7eeJiaeCu6S1O
         qGC9jX8R8sOgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220219152818.4319-5-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org> <20220219152818.4319-5-kabel@kernel.org>
Subject: Re: [PATCH v9 4/6] dt-bindings: mvebu-uart: update information about UART clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
Date:   Thu, 24 Feb 2022 15:02:44 -0800
User-Agent: alot/0.10
Message-Id: <20220224230246.02F07C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marek Beh=C3=BAn (2022-02-19 07:28:16)
> From: Pali Roh=C3=A1r <pali@kernel.org>
>=20
> Device "marvell,armada-3700-uart" should use
> "marvell,armada-3700-uart-clock" compatible clock.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
