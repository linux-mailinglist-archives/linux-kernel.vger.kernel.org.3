Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4A052C5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiERV4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 17:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiERV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 17:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8365B7;
        Wed, 18 May 2022 14:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 511916130C;
        Wed, 18 May 2022 21:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30FEC385A5;
        Wed, 18 May 2022 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652910346;
        bh=8ycTWVvX6puDTwUNj5c6I9dNAAzsSHDh5Ka/xeEnI9E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hWuW8UDwTfv0LOlg3CyRoDs8RmNiVuXq0WUcLqmXOUror4WQhUTbUN5tSE/pRSC/O
         k3T17CqC9B4sCpL0Ct/PDfImMKDXmfJNtzTUG2nM34k/JsudmBEjW4KDFtQFoFilmj
         WtiFub+zvVC3bvI0hY2cmgZDmtk3w3YBmn+N1lVm2ddBzcQ0ayfUOTVTN8WGpLafKF
         KknqABLM1ejmCaSlojhWPC+3tn3sKTV5QLRcqOG0WNPO+UuLUIsUXyoIoVo95DcnIH
         BvYfSPh1pGmw/22W3nl6D7KW2mrs+HRKbl7qoI1N4cqljxy7e6DQ3Cd42xnWSIyhaY
         dXnLbmrARS9hg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220510104804.544597-1-wenst@chromium.org>
References: <20220510104804.544597-1-wenst@chromium.org>
Subject: Re: [PATCH v2 00/11] clk: mediatek: Move to struct clk_hw provider APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Date:   Wed, 18 May 2022 14:45:44 -0700
User-Agent: alot/0.10
Message-Id: <20220518214546.A30FEC385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-10 03:47:53)
>=20
> Patch 10 fixes, by hand, a build error from a call site that was not cove=
red
> by the previous patch.
>=20
> Patch 11 converts the last usage of clk_register*() in the MediaTek clk
> drivers.
>=20
> As mentioned above, this series includes parts that don't build, but are
> split out for clarity. These are patches 3~8 and 9+10. Once the patches
> are reviewed, they can be squashed together.

Sounds ok to me. Please resend with the squash and I'll apply them.
