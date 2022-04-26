Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC850ED66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiDZARZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiDZARP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18368121957;
        Mon, 25 Apr 2022 17:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7AC8616A1;
        Tue, 26 Apr 2022 00:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C89C385C1;
        Tue, 26 Apr 2022 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650932046;
        bh=2FOsJiddo45DA7RHNnCi2Bn9DQXpbl3AJ3EcT/AOxBw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U6pWz8LyVzcsf/92YG4ugjprMZ4FZGYfug42tfRoqMlqLNFnZ/Fa1t2X6fH4YYEaO
         cWYBF6/Msounp9BkA7WPFUTlxCpfeXKe9lD5uWM8ysQ39ZRV2hS3MszUZ97ifkVb21
         pNg2tUjyxl1ITyKZ8fEgE/2JDRfWXGSnJ+k0qICCnyvV27gJHpXpFVnm+CQ5O1FxhX
         iWYy1cB/3hznCGW1FlS7gIV4sIiOCyXemTaHg1yBMAzac60P/Vud7qyIPmG2BtB2iy
         5buwVW1NpLxw/KXRA80xwcPRH7ikVP6CvpCPPIYXIA3U1TsBTXCvUTWMTL9elnxf40
         gbYLFRyeT/p2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-15-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-15-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 14/15] clk: mediatek: Add MT8186 mdpsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 17:14:04 -0700
User-Agent: alot/0.10
Message-Id: <20220426001406.08C89C385C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:50)
> Add MT8186 mdpsys clock controller which provides clock gate
> control in Multimedia Data Path.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
