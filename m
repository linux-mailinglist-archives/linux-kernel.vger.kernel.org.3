Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1E54D78F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351045AbiFPBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355839AbiFPBzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:55:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8B396A2;
        Wed, 15 Jun 2022 18:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F9FB82266;
        Thu, 16 Jun 2022 01:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31226C3411A;
        Thu, 16 Jun 2022 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344528;
        bh=oVm8/EKnQZlRLAUqOfhtBTItjxghsAmMsXEoKcCzWMk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T7snCEzpRDuYN6Cre/BZH7apg77atmg/A34PxJfg96eAr8Ixre3dAz1gsw/ebvpmo
         w3k9S1LEBmqNMf8a91eEb0XgM92aMXNNB2bK5wYqmXpvv24eBCpoTuwh82ZykWuojz
         Ix0rnCFyiMLkJ8I712o3Pfg15kLDiMWPVxIuC5JDfdSahubSpS7Qu6vV5Le19SYlqo
         PmpS6dlw1155zrfyqLX1T8o4ZTnbouum4eoVx2M4NxGONf9Wd79lCtmZyVU3lqy4wv
         3V57GtnH9BNkk9df6weUm52Z/yBqcgRlxD4ckbl6/nWgXCWEaK4av2cgVPB8+DeZ2q
         ZWi8yF5Us+30A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-18-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-18-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 17/19] dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:55:25 -0700
User-Agent: alot/0.10
Message-Id: <20220616015528.31226C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:44)
> To support reset of infra_ao, add the index of infra_ao reset of
> thermal/svs for MT8186.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
