Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622152C4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiERU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbiERU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B289224A5E;
        Wed, 18 May 2022 13:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB6760BAA;
        Wed, 18 May 2022 20:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252BC385A5;
        Wed, 18 May 2022 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652907483;
        bh=1WJPcHTdTaVSdtyvz3UK5hOnZSpj7NJhAuMXlCaEDDE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iis6bWy+lgz4LiufzIfovMUvIvJiwllrt7oDu9zV32wOnya5zt6cHQmJcRCsHYFiI
         iw+Flb3zRj80bGIJ/UXvMK7VTvD2+8nb7eo5auFQxy4Nzjwq/X+HzSehnKrzalqMxS
         20hBwFt3mYajD6arX2fm27G34BUM06XNNp/JRiKAw/XgZJFDYwUoljQtpEFWm31nxa
         OH632ol58F/5+1qSvFm7EHokoOhNWJ09iGDJgK+k40NsKpfUd252VCKA1QKCoB+1/t
         JHUVx0OVRFMQS8KjrHMQYJKwHRARMGD/rG6YbVcuMSc8jbw6hTweefi0EGeDBquy2c
         fljSF3eVZedhg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220428164454.17908-4-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com> <20220428164454.17908-4-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 3/3] mips: ingenic: Do not manually reference the CPU clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com, tsbogend@alpha.franken.de
Date:   Wed, 18 May 2022 13:58:01 -0700
User-Agent: alot/0.10
Message-Id: <20220518205803.7252BC385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-28 09:44:54)
> It isn't necessary to manually walk the device tree and enable
> the CPU clock anymore. The CPU and other necessary clocks are
> now flagged as critical in the clock driver, which accomplishes
> the same thing in a more declarative fashion.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
