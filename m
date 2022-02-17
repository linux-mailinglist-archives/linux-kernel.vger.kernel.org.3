Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC664BAB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiBQU3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:29:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343651AbiBQU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:29:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66485C3302;
        Thu, 17 Feb 2022 12:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93B561C27;
        Thu, 17 Feb 2022 20:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BA2C340E8;
        Thu, 17 Feb 2022 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129755;
        bh=MBVB/V4HtFGVcnuF8jusIP3cu1MRbIMiN9GJFCtixlg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TmhzH2I+N4ljfo2SVnhoeFHVVt8QPUMXw8I5hTMQ6OC3gayYY1eqiMPpWxrTcDzTR
         +gOWQZXu9lNoFJfY4y6T9DNCFr+rQml7/+S5VMw4GA/jgVSdP1lnpuM8MdJ3fNqTkW
         GzJXbIzSX0R4ISIUeeUIqt4Zk3mX3ln1SNmuinaDKuVNnOdgo+uDegXxccCM74286Z
         SfEVxM0t+nSJ5QtEmEnzePJUh+JY+v70DDlJkG9HyFVHhJhDxjTligB+immW5z1gsK
         gx9oqiXXXo3WGmQdVSBxoosIkaP74VIwqWBF4Ipy41nA/1nSc1gcPExgPWb783rntK
         X402nlvGfuatA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-28-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-28-wenst@chromium.org>
Subject: Re: [PATCH v3 27/31] clk: mediatek: Unregister clks in mtk_clk_simple_probe() error path
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
Date:   Thu, 17 Feb 2022 12:29:13 -0800
User-Agent: alot/0.10
Message-Id: <20220217202915.42BA2C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:30)
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
>=20
> Now that the library does have APIs to unregister clks, use them
> in the error path of mtk_clk_simple_probe() to do proper cleanup.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
