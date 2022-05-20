Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABF752F5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbiETWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347550AbiETWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:21:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269455676E;
        Fri, 20 May 2022 15:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF3CFB82E18;
        Fri, 20 May 2022 22:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA73C385A9;
        Fri, 20 May 2022 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653085299;
        bh=qJwASo9Th0s9B1XSYYW0kv0RCtC/qm3SNe5fIxpPzqk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ldtVo39yD8ihAPF/im536M8gIymZBYh4K7JvPCFy9MwHQ1MODy1tspqewrOnr7c0U
         RtKekES6aGdfhgfcnzAxm7wHIFFWWvoQ6N+jZ0WryofsBO0v8+P9v6UtMo0n8FEmCE
         jg6DlQ+aJqG67s7H1PiZxCNedhzVcANf9R5epbGCawA6p+4u4RuVPZMO6khfuLavHU
         7RLfyiGGkQSEjz6RWf7AzEqIe7PsvkcWuK/3FHFHWuIJNOLnVvYsOYIfY54Wzfj9qc
         UBSEyU1AuabTZujmTiUbI+N0P8u1E4Ma+v8C7DlRE2mgtHq9BehLu/bNv3zdxYAcYa
         xrl6PYvCgsv5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <26c2fb0c-e58a-5864-4256-f60f948ca634@gmail.com>
References: <20220429123133.28869-1-matthias.bgg@kernel.org> <20220429123133.28869-2-matthias.bgg@kernel.org> <YnGjScfQA9axBYBO@robh.at.kernel.org> <26c2fb0c-e58a-5864-4256-f60f948ca634@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, allen-kh.cheng@mediatek.com,
        weiyi.lu@mediatek.com, chun-jie.chen@mediatek.com,
        linux-kernel@vger.kernel.org, ikjn@chromium.org,
        miles.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, matthias.bgg@kernel.org
Date:   Fri, 20 May 2022 15:21:37 -0700
User-Agent: alot/0.10
Message-Id: <20220520222139.2EA73C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2022-05-05 09:47:30)
>=20
>=20
> On 03/05/2022 23:48, Rob Herring wrote:
> > On Fri, Apr 29, 2022 at 02:31:31PM +0200, matthias.bgg@kernel.org wrote:
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> The msdc gate is part of the MMC driver. Delete the binding description
> >> of this node.
> >=20
> > An ABI break is okay because ...?
> >=20
>=20
> Because the code controlling the clock gate was moved to the consumer. Th=
is node=20
> did never ever represent any working implementation of a peripheral. Just=
 a=20
> lonely clock gate that wasn't used.

Can you add that to the description and resend?
