Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AD50ED4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiDZAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiDZAQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9273110565;
        Mon, 25 Apr 2022 17:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6920EB81BA9;
        Tue, 26 Apr 2022 00:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D5EC385A9;
        Tue, 26 Apr 2022 00:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931975;
        bh=1S0FvoIpEdceZXw7ckYhCxPUbbfBBXYuI1fZcX1qkB8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qXbMQH5Y5Zs7nyPw6+oGJ7K0tNFY0IkjBA4l186hWIxcmDUhr1mfAlBD/9tVb6hif
         E2wxcV49PWkjodXQqUbxhjFgURpoKN/tP/tIbhOGzBEvTqqfqC8li70F+/txOhU9yp
         ZLGTRAp+Ww0HcY7LlhG2DeON5Kmzd4Ofe+74F3f/AZ9mpvvnhTSLsk9KG/O6nOZQvs
         sB1hdKcMc7hAN+3AF5s2BCDQasGksCJ1gGEGtCT7G00B2aiiHW7ksm42F3EIsXG2Ta
         msyfrPKaknrgvr160YhpfHlWOR+IEsKhxipK/kcK5khf0Jtd6h9PsI/2T+1iFkNtpT
         NAdL2Bi1l3gig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-7-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-7-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 06/15] clk: mediatek: Add MT8186 imp i2c wrapper clock support
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
Date:   Mon, 25 Apr 2022 17:12:53 -0700
User-Agent: alot/0.10
Message-Id: <20220426001255.16D5EC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:42)
> Add MT8186 imp i2c wrapper clock controllers which provide clock gate
> control in i2c IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
