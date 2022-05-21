Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6352152F820
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbiEUDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiEUDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC8FD1F;
        Fri, 20 May 2022 20:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AFA61F07;
        Sat, 21 May 2022 03:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C49C385A5;
        Sat, 21 May 2022 03:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653104475;
        bh=Pr0c0419Y9JxpQnOMWb1nkjfUw4FGJu/N5zDlJHBLPE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TogqE2uBxxDY1bY2+eU1JRvcTnfqmQcUjpMzIhli7mdKWNCy2UytJjZW1vndBKpLs
         aAwZqvZF6na56hMTE8UKUp298ziukNH3zKC4+6UpZpXkLhY4KG83Nuogt9MkG9AEfy
         PKZRrzPlak+0IuDxOWfx30K33NulkZx+D5CeRa07b1jARpay3XMfjou/DepdH6+pZQ
         kmJmVZh7gkzfuFbBlZT6ep8B881IvaO6DYqKnKTndodvZuH2xB63/Msgc81FNs3KCZ
         D2S7VTsHw3kwiolL9Als3KmXLw+g3kVVOBt6xWKrpzA1WDBob3t+DIxOov9nqcSB1w
         CnSobQOc7VhVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220324071019.59483-1-jakobkoschel@gmail.com>
References: <20220324071019.59483-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH] clk: ti: clkctrl: replace usage of found with dedicated list iterator variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Tero Kristo <kristo@kernel.org>
Date:   Fri, 20 May 2022 20:41:13 -0700
User-Agent: alot/0.10
Message-Id: <20220521034114.E5C49C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jakob Koschel (2022-03-24 00:10:19)
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>=20
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>=20
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>=20
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXP=
wr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---

Applied to clk-next
