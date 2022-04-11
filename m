Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76A4FB127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 02:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiDKAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 20:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiDKAxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 20:53:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDBD35A97;
        Sun, 10 Apr 2022 17:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68E8BB80E61;
        Mon, 11 Apr 2022 00:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC1BC385A4;
        Mon, 11 Apr 2022 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649638279;
        bh=Ycpdp14bx0RRRmkHQGJeM0fAdXUvQ5hx27l91yFjGWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq6FBQoH1aujh0fWe2tsMZONWLf9KZrbhAhp/3wTmsmvIMrtlTX4nKE7eicbjbyDA
         GcamPLVUcd+CAWeDJ3pbPkzr3EiNp5rozkNss0KOeBmjuxxNNlqNdl4c3drxlaOYHW
         UBFg7tB5Eo6xBzyT/3WR9m3UQau6WMPqiwhAXGEYKJVbpA0du2v0/wWSErlzH5sSzi
         JDr2C0I5xUteky1jYxUuWPSx+k+CTaw/4/3h7a0rGkINphs91pVrMwVieqd/34bxoA
         9YSkai0iNTRWMf0BslM2dqaGRQ1SCkyWuNl21atyzdMjuB1t5hqmGQZKSl3Uk94nJS
         Ujbj2YJTyu5Rg==
Date:   Mon, 11 Apr 2022 08:51:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: use ocelot-8021q tagging by
 default
Message-ID: <20220411005112.GU129381@dragon>
References: <20220330113329.3402438-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330113329.3402438-1-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 01:33:29PM +0200, Michael Walle wrote:
> Enable the ocelot-8021q tagger by default which supports ethernet flow
> control.
> 
> The new default is set in the common board dtsi. The actual switch
> node is enabled on a per board variant basis. Because of this we
> set the new tagger default for both internal ports and a particular
> variant is free to choose among the two port.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
