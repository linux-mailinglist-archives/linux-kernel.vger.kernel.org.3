Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9550EC47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiDYWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDYWwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:52:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F22113CAF;
        Mon, 25 Apr 2022 15:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34D34B818FA;
        Mon, 25 Apr 2022 22:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8670C385A9;
        Mon, 25 Apr 2022 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650926972;
        bh=65ZfwId3z88lOwarYLJJhKmde8T17svhcGfPB01Bnvw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CrrSdpUqm4Tmvc9osrbNHIaPBwyO3lJXvtU/LDsR18kATGOLwlzYSE76KpTrC5/qc
         teHsGxBZiE0jvEEtNeaYbsgwR4UkI6AFguyJkEe92+qum0SFjtSpxVc3EmbFFrmw5S
         KZVpI2vUA7Kc4OmHr/Hatj0o2ai+Nc1J0PKL45g6ZFcD1HqxbiQU2Nw5xPvaz5f8RL
         ZtqmGQWEkI+qqMdgJsQDBhSWsQbWowgiwTaEQWIz1I4leCWE+UzXoW+bYbF7J8gljb
         jUtRpZmQKr5CoujoMXZ7CHV7AqJD7zYprzDCGD6RjAvYu87tW1kdwlh8hpypUI9tX8
         t5oomTJ57X7VQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220424182227.1364966-1-colin.i.king@gmail.com>
References: <20220424182227.1364966-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: mux: remove redundant initialization of variable width
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin Ian King <colin.i.king@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 25 Apr 2022 15:49:30 -0700
User-Agent: alot/0.10
Message-Id: <20220425224932.C8670C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2022-04-24 11:22:27)
> Variable width is being ininitialized with a value that is never read.
> The ininitializtion is redundant and can be removed. Move the variable
> to the scope it is required.
>=20
> Cleans up cppcheck warning:
> Variable 'width' is assigned a value that is never used.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
