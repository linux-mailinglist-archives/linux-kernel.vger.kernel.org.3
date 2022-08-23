Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18D59EF78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiHWWvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHWWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97158B997;
        Tue, 23 Aug 2022 15:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DAE61684;
        Tue, 23 Aug 2022 22:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC2BC433D6;
        Tue, 23 Aug 2022 22:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661295103;
        bh=FI5BJugEJC8DXwEEDV8AbPhCAa7rer3r+AMS+ThaNy4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ejEcJUApFwz+LN91B3P1eUrKmVgbkPUEkIyVEZKh6MPGLamVebN8a+kpfcZvKnJlC
         wCcnhPZKxNVkK4w98KZPe6K1qMPXxpMVDrhGStp3X9BMO7FBc9WVThT+04QOoGRihx
         Ikd5E+Z/JE43prPw5f7Wf1lIH5+tOS4M7FlnOKKBPjdWZ7SMe+yQcBTL30RsXgJ7Go
         kKNn2QpNteLNprfOrUncX03KIJUqN5GoF3Ww//pa3/rXWvUht6sw2NGvY/gtVMX6v8
         dnts1R+sl0TmpFK/SmIUDS+NK2iNwwlEQQ5MbBJ6HBu/gLpcui6jPDLFR+DTsmm+bi
         pjuHlt03jXQrQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220713154953.3336-4-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com> <20220713154953.3336-4-stefan.wahren@i2se.com>
Subject: Re: [PATCH 3/3] clk: bcm: rpi: Show clock id limit in error case
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Tue, 23 Aug 2022 15:51:41 -0700
User-Agent: alot/0.10
Message-Id: <20220823225143.5CC2BC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-07-13 08:49:53)
> The clock id limit will be extended in the future, so it would be
> helpful to see the actual clock id limit in case the firmware
> response has been rejected.
>=20
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-fixes
