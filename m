Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E804EE45E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiCaWz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiCaWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:55:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9382E6351C;
        Thu, 31 Mar 2022 15:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB18B82278;
        Thu, 31 Mar 2022 22:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C945C340ED;
        Thu, 31 Mar 2022 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648767246;
        bh=LX9sRJomQSNzLVPo+TLLNQVLhf0zSJX7M/h2n5GyPT8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ibv0zJ9jINegOaaYAoQ/WES61Mov/1uBn2DfjaI395tMsoR4BTL3lMAOgOnfFF3Lp
         t38x/S/JZOUAg9zawWw6XU1ua2eFYMUeirLO7kbegla6cPN6AP2M7DSAbU15uRVW3k
         yW0YNgI5bGChzEIDEh5LEDpcw+BSpdEazBV8RIlL1de4JhPzFpe76NnOHUFwDK+wkL
         GZ2mgt2QniU1v4eOY/zemwqoVp+sihWzgwxFRchcQwnrDOugcl0WlP4CnMBHNtMoqs
         Zv4JlxzQo4Cmn2OT4om8XsIwOJV28PtEqJxXQ8qdrYyH5fDuk4KtK8I0WfguKMM/Tg
         FYuXC7tYQxbpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220329113657.4567-1-jbx6244@gmail.com>
References: <20220329113657.4567-1-jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Date:   Thu, 31 Mar 2022 15:54:04 -0700
User-Agent: alot/0.10
Message-Id: <20220331225406.0C945C340ED@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Jonker (2022-03-29 04:36:56)
> Current dts files with RK3288 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3288-cru.txt has to be
> converted to YAML.
>=20
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---

Same comments about clocks applies here. Please send a cover letter
anytime there's more than one patch being sent so that we can easily see
the topic at a top-level of the patch series "Convert Rockchip clk
bindings to yaml and add clocks property". Furthermore, I don't see why
we need to have a different series for each file. Just combine
everything into one series please with a cover letter.
