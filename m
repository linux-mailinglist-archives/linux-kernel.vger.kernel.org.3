Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A54FA1E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiDIDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiDIDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:09:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B4DDF3E;
        Fri,  8 Apr 2022 20:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EA9AB82E0B;
        Sat,  9 Apr 2022 03:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957F0C385A3;
        Sat,  9 Apr 2022 03:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649473618;
        bh=iWRdgGmsyr8l+EDlCYNN0a7qVzDEiDf06oFzHfGEX1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xae8PHv4yHOytB8iSJP8ovj02GllB21nQEdEsuHuuBD8bQo8de/IuqDbM1sgcK2b5
         5F7ZaPjcsxXu5VIZl+4hgybryDKYXiUkq3NDy/sht7qCznfiD797xdNeKINfah+sZW
         +5WnBmLl5e8u0qLnD6x58ZWSxw+b5JEg9O8Q8gvfodzlJuJ1yqbt/pEg46qWhFVE1e
         O8aAMNETZNODTBS3uEsIXAdoyICL/GSdLKu46b+mAvo13aWPkxLgipp5hsYetMyUA/
         6ghxWe3qT6UkFZI1U7RE081uipO+Pn3MhzZwzngIlrBYwGSWw9SDqcTCaV+hkotGDe
         c63G9fMnssjug==
Date:   Sat, 9 Apr 2022 11:06:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: imx: Fix boolean properties with values
Message-ID: <20220409030652.GA129381@dragon>
References: <20220304202518.316164-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304202518.316164-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:25:18PM -0600, Rob Herring wrote:
> Boolean properties in DT are present or not present and don't take a value.
> A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
> matter.
> 
> It may have been intended that 0 values are false, but there is no change
> in behavior with this patch.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
