Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F434E6B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357082AbiCYAxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiCYAxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:53:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C86BB914;
        Thu, 24 Mar 2022 17:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 273EFB82709;
        Fri, 25 Mar 2022 00:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45A3C340EC;
        Fri, 25 Mar 2022 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648169490;
        bh=o5w4forM0PQDaQou02BEP4f9ZlEL8vngVEYp+H2Z3UM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E0xOsdDMVk16VFeeZBne45dxJSO/iA356gJi7Z4Af44CvpscVIV0Z87Faz0iu/bAL
         GJkND377RHIiVF82EvSzitCu2iM1v6FqM4TegzUSxZuK+paMFL3uRS6QV0krWB9ElQ
         ACGmqg7tAOMWr9mgjnbg3+nHKx9EN18fsLuD2DD81ZXh913Iy8HIph4zrpnOHXJtgG
         C53Cyj9wurTyTRb/gS/a95GtTSgZ7H5/VZYKv4JI+phTw9azcA2oHvJsQs6KtYLgzQ
         5/ArwYJWb5P5GEd8b2uMIGEH9kcEQ/zeUXoGsEpZwVapWRHdCxk2S4HJc8JgiWd2CV
         CAq08Lr3cumiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
References: <20220324133229.24035-1-jbx6244@gmail.com> <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org> <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, heiko@sntech.de
Date:   Thu, 24 Mar 2022 17:51:28 -0700
User-Agent: alot/0.10
Message-Id: <20220325005130.C45A3C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Jonker (2022-03-24 12:51:36)
> Hi Heiko, Krzysztof,
>=20
> Question for the Rockchip clock maintainer:
> What clock should be used here and other SoCs with several clock parents
> in the tree?
>=20
> The clock.yaml produces a lot off notifications like:
>=20
> /arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
> is a dependency of 'assigned-clocks'

'clocks' is not a dependency of 'assigned-clocks'. The dt-schema should
be fixed to remove that requirement.
