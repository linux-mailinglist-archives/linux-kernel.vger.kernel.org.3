Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA34FB12D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 02:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiDKA4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 20:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiDKA4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 20:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0161572D;
        Sun, 10 Apr 2022 17:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63168B80ED5;
        Mon, 11 Apr 2022 00:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF8EC385A4;
        Mon, 11 Apr 2022 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649638474;
        bh=rHmqtbKujz1oumBfQyH6US6UQG40oo7hEHJvzLUxX4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qqw1DzrX8HDF4Z8nDWHUPix5K+JLU8m7wz3curLSEb8A6dPWFanpmUvRALJzJ4rwb
         eLrQPp195BXch5ljoCiN+7mTFo3itcQFSlsucNmTopPdeGElp/PIvPHaVwTvPG68ll
         sqAeCYSJ7QU6fZnLCNu8mTvVZoNbC3KeSS7uxTo4ZbuiXGSHbAnfVL4oJh2Fah/d+e
         dgBNCVgBUaQ/GukWqW8wA5lZoy2lsQ90OO4Tt0z9hhj++Bj3T1THztmdoz7uE1M2zS
         A3aQ39OwkZwksmEtjN8+wLlk8hZQ5hF2MSfJfS0LnkjHx9klG/OYA42qwdSGeb3hb3
         Bs5zFMFf7ziXQ==
Date:   Mon, 11 Apr 2022 08:54:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: default to OTG mode for USB
Message-ID: <20220411005428.GV129381@dragon>
References: <20220330113442.3402940-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330113442.3402940-1-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 01:34:42PM +0200, Michael Walle wrote:
> At the moment, the dtsi will force the dr_mode to host. This is
> problematic because it will always turn on the Vbus voltage regardless
> if the port is host or device. This might lead to a "shortcut" between
> the two USB endpoints because both might have their Vbus supplies
> enabled. Therefore, the default should be "otg" for any ports which
> aren't host only (from a SoC point of view) and have a user of the dtsi
> file overwrite that explicitly.
> 
> Move the 'dr_mode = "host";' into the board dts. Now that the dtsi
> doesn't set the dr_mode anymore, we can also drop the 'dr_mode = "otg";'
> in the board dts because that is the default value if dr_mode is not
> set.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
