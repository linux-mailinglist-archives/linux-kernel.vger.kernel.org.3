Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0752C503
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiERU56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiERU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:57:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE920F4E1;
        Wed, 18 May 2022 13:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4794B821BD;
        Wed, 18 May 2022 20:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B4C385A5;
        Wed, 18 May 2022 20:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652907465;
        bh=hNvnMNGwVFP3i+RgR8W3Ac6dzYcK1NDEZnTWAf9kxR8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PsWKcx/zLVK204PpDVuuGERmyi94v4chLDATVEXLTNVC1tQrLFr4tyOJ3p2lUMHLW
         xwIJpr1WrXpC4+4ikcnlkiCEFL4UWEX53ylYChyeNz5M+LehHAdMOlUmnu5t7udXCu
         8tpCQfKnPOPBl5KmhlUX2pWmdrpz05OKyRDCjjUvkxeC1Jrnxpy7/jkdW+u+QHPvN6
         453AgoUp1Dp8WGqT4+mVqLRgkxeaKia49WRlrrj6lA5MuzisgUwmwCIxg447mOmRZ+
         mApjit19t9PS8hJ7stO1yWdPB1gjFt/YBiAfqs0GO+S7bmR1DQSJGKnrR1CEIySjLe
         rxQu4EzJk2Cfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220428164454.17908-2-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com> <20220428164454.17908-2-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 1/3] clk: ingenic: Allow specifying common clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com, tsbogend@alpha.franken.de
Date:   Wed, 18 May 2022 13:57:43 -0700
User-Agent: alot/0.10
Message-Id: <20220518205745.726B4C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-28 09:44:52)
> Provide a flags field for clocks under the ingenic-cgu driver,
> which can be used to set generic common clock framework flags
> on the created clocks. For example, the CLK_IS_CRITICAL flag
> is needed for some clocks (such as CPU or memory) to stop them
> being automatically disabled.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
