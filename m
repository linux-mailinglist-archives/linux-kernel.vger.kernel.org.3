Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548574BAAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiBQUZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:25:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiBQUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB68F9A3;
        Thu, 17 Feb 2022 12:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B3B61D5F;
        Thu, 17 Feb 2022 20:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB756C340EB;
        Thu, 17 Feb 2022 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129496;
        bh=DnKAXPQhLMpQ6fPVXGirHN4IFHlLR677G67d6iGe+Rc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ng++DHIpj7piXKi5aaQQlALz367dz4xf2frYRfBImQbFytNL/oIjfEkvm0fQLZl4R
         Hh/0j4/s3ZkOfUKi16FbCKJRaUuYW0KMYuaVBBrSuyvjbNjHqO2yc7Bd6Hh5UsZ+R8
         Su500G3lY/sA2OK9xPp3SDNpCBe16xslgkkRXj8AE0JrGEjnHEAi1FsMciMXl9sImP
         SKkJlabVP/rycLa46bnY61vhJZ31q47+HAOcYTCp1dOi4buARVhXNoojl6OE/OAarI
         milaEB6lQEAi7V8xxuVjsCDzSPH3ieaLB7QxWBcNMu4vHCoilMYhr+SGnonhHiLMlr
         b+7pl2ykwkxpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-11-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-11-wenst@chromium.org>
Subject: Re: [PATCH v3 10/31] clk: mediatek: mux: Internalize struct mtk_clk_mux
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 17 Feb 2022 12:24:55 -0800
User-Agent: alot/0.10
Message-Id: <20220217202456.AB756C340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:13)
> struct mtk_clk_mux is an implementation detail of the mux clk type,
> and is not used outside of the implementation.
>=20
> Internalize the definition to minimize leakage of details and shrink
> the header file.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
