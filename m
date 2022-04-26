Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600EF50ED4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiDZAQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiDZAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E3110565;
        Mon, 25 Apr 2022 17:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFEDB81BA9;
        Tue, 26 Apr 2022 00:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4FC385A7;
        Tue, 26 Apr 2022 00:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931984;
        bh=Hrh1VQOQSxMXh2r9jSxNFGh79oV4DZwnQhUUgmt9wNI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iUNtM2bvex+d7TZEr1gpe9H6tZBpSWAwUA4rgzANJjviS+rHpawWhpqOpBIj2nadt
         9GUlPORNZm92b8O6VWKFOqC5pZU7Mmj5mgB06vHWonkU1Yf5wiA90X4K3+fbVrIMvz
         ytCFVsPJKtk1bMycpepOT7yMLHcbNEEcRFMOAMR9iqC0VrY1cM2iU9SMZfLOZ7tbjE
         DMAyUBj/cnWPCW3Yf7JWDmjnnLaHEBj9r9Ux8pKFiVCQ7m5NiBYYkqj6FP1VBvEFEF
         j6LXD/jDzi55Zksr6Am81fKtGXg1DftdzNzYxdVEX4/Ku+1llAEQmHmKX+WJLWXupg
         Z9TPZ1QhkKVUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-8-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-8-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 07/15] clk: mediatek: Add MT8186 mfgsys clock support
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
Date:   Mon, 25 Apr 2022 17:13:02 -0700
User-Agent: alot/0.10
Message-Id: <20220426001304.10E4FC385A7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:43)
> Add MT8186 mfg clock controller which provides clock gate
> control for GPU.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
