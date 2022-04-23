Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3167E50C658
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiDWCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiDWCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EA13539B;
        Fri, 22 Apr 2022 19:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3173D61563;
        Sat, 23 Apr 2022 02:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E8C385A4;
        Sat, 23 Apr 2022 02:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679568;
        bh=0MnhiBkDTqfJrZ1djD2Yts4XXJT4BYD6t/G8WOVnua8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DjqWEcm/4on4m1Kp0+9ZXJrDrCQp8svEXidHBUlui7rSL4/3Y1zpzTrtWLyG4vvmN
         EQXaJr81o2uByAz1Beylux2Akr8Kr+XblOd7Cy+JUFNZy8AWkXEjf25shVQruPVEkw
         md67qND4mfbXGhLZF/658ACYYLq2NKzYttUW3jVPyWktDA0pGlIDXqTADO5PwpggFx
         9/oKY+Gau1ztO/Oi7rnOr1bjoO2lrmlkrhOt6OZKKHQMeL+F5Jng4cLBwdIljxgEMO
         Kos4AYtNiGAtVwLS8C4IVla9eYExi39VNELqI+L3D4niXuZYZ4vmoqghIdlAY9NlNy
         tcGVmAsOe5cSA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220406050321.26177-1-guozhengkui@vivo.com>
References: <20220406050321.26177-1-guozhengkui@vivo.com>
Subject: Re: [PATCH linux-next] clk: keystone: sci-clk: change `struct sci_clk **clk` to `struct sci_clk *clk`
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Apr 2022 19:06:06 -0700
User-Agent: alot/0.10
Message-Id: <20220423020608.808E8C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guo Zhengkui (2022-04-05 22:02:32)
> `struct sci_clk **clk` is unnecessary. Change it to `struct sci_clk *clk`.
>=20
> Also fix functions relating to it.
>=20
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---

Waiting for Nishanth to review.
