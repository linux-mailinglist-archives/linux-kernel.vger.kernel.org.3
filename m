Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31C50ED4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiDZAQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiDZAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3D120139;
        Mon, 25 Apr 2022 17:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 573CFB81BA9;
        Tue, 26 Apr 2022 00:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35EAC385AE;
        Tue, 26 Apr 2022 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931993;
        bh=2pOIqk/1MTAUoNZqI21mUlSzVaSA+8cvo6c8NdB/7YU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NnewxImx735aiqVB/1VgC9Md61kBQIn2GEKRnk7xpdj7vWB2kVeDtsxj34LWUoETQ
         qbg/068f+c1mmYLMbOp24211B+2ruFRIBGTkjXLT/6uBxUmb1xckwuRi/DQKkX1q26
         o+JilLLZnQw/v5MZWW18hqoFPUOJghGu5aITXO8Ddq1mqCg/oLP/+Yy1OavmnDtez7
         uoCPrVmnh2hQKeCK+nvlnCxcaihc/KOarYq7dqKmjV5ybqcrJJLa9qEbA6bxNabJaa
         tI1Z2NZ20/nwcTvnyvNQCW4k9ICWSVAIR/ulboWje9RCJCfEw91iH5TOuqWx3LEti0
         qCOCp4TRS9XpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-9-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-9-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 08/15] clk: mediatek: Add MT8186 mmsys clock support
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
Date:   Mon, 25 Apr 2022 17:13:10 -0700
User-Agent: alot/0.10
Message-Id: <20220426001312.E35EAC385AE@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:44)
> Add MT8186 mmsys clock controller which provides clock gate
> control in video system. This is integrated with mtk-mmsys
> driver which will populate device by platform_device_register_data
> to start mmsys clock driver.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
