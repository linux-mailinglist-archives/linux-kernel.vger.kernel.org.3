Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C93560155
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiF2Ncb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiF2Nc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9527137034;
        Wed, 29 Jun 2022 06:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C88A61E42;
        Wed, 29 Jun 2022 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123EC34114;
        Wed, 29 Jun 2022 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656509543;
        bh=yP8qpZ4TtrwMBByHlseY6Kg6bXnoBDLJlgjU0ALhTQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIcmpT1FNHXgBpPbWK0t4a/WjZL6F0bjx6+yXPkp801OOWSkReBxnNGYWH1kxEVVR
         C+YcsUjca6lIRq6bXHhbx+rnZwg7xYNgkeHovYfs6g0mTu5VqvDgraTqWJvyGfAWlG
         6dM8mKgd1NXVklYuuqDt/Sz6+59Wquu9cjiouIil5kUCq+MkCjlKEPMnLNdkhbkyWo
         R+8hYtg2iKxHhmhs2EM8LTCMAgiOcJEX+7srUuHQK3Byl5cHWbIB3cJWIYbpeXxxrk
         1QIK6JA/Qa8Bx0Ni8vf+124WppFr529dgeeh8lBKFavLY3nYAxVT065RjmgJHGBmP9
         1x2Ld6aBoGsgw==
Date:   Wed, 29 Jun 2022 21:32:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 5/9] arm64: dts: ls1028a: Update SFP binding to
 include clock
Message-ID: <20220629133217.GM819983@dragon>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
 <20220428181703.2194171-6-sean.anderson@seco.com>
 <548f2e576a4c299a1139eadb30ca4e67@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548f2e576a4c299a1139eadb30ca4e67@walle.cc>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:47:51PM +0200, Michael Walle wrote:
> Am 2022-04-28 20:16, schrieb Sean Anderson:
> > The clocks property is now mandatory. Add it.
> > 
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> > Reviewed-by: Michael Walle <michael@walle.cc>
> 
> Fixes: eba5bea8f37f ("arm64: dts: ls1028a: add efuse node")

Applied, thanks!
