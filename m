Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8840B52C89B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiESA2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiESA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621EF5B3CF;
        Wed, 18 May 2022 17:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFDD7617A4;
        Thu, 19 May 2022 00:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F77EC385A5;
        Thu, 19 May 2022 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920106;
        bh=1+Ve81jnUQKmFYBZA+Izq7rgffaqeZ8+yGQjo73k7vE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aN/YapCN5WzG2CzLXsVxJsSyCyRpZrREdQXBxUh/ZjkDKP+KUVl/foBEj6nY2qORY
         nrHqTcuEs49KsNQbIobCsp4iEC/ey075j0yB7JyfZgJsbLE7AxtUVTF1HsBBHmM5Gp
         kbM7kEYfuN/6g4282B4JnY56/jt4D6d3amg67lTF8/omMcclVXJn33qXCPg3gOPdb8
         on9GeJMWR/atVHNoYllqIopYaYGLInlV5Ibxxakls4bcKegvwLLBNhjiRp7BlmBi1i
         v1onNrx8uKPTd+tihXzFjkUytCgKaYLiZTUUztzCVulVzsVavxo78YjeXKtgfgFQ4L
         OBOFCYyYHwY+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220509090939.845-2-sam.shih@mediatek.com>
References: <20220509090939.845-1-sam.shih@mediatek.com> <20220509090939.845-2-sam.shih@mediatek.com>
Subject: Re: [PATCH 1/1] clk: mediatek: update compatible string for MT7986 ethsys
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 18 May 2022 17:28:24 -0700
User-Agent: alot/0.10
Message-Id: <20220519002826.0F77EC385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2022-05-09 02:09:39)
> Update compatible string of mt7986 ethsys clock driver to fit the
> devicetree bindings document.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---

Applied to clk-next
