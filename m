Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD474CCF29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiCDHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiCDHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:38:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9722BE3;
        Thu,  3 Mar 2022 23:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A28B8277C;
        Fri,  4 Mar 2022 07:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89550C340E9;
        Fri,  4 Mar 2022 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646379459;
        bh=SmoE5UjCUd3W++2b9JAzb4pzBTmdPhYj9JV4FeqbwQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvwa8W5hvQcan5zzohua0lgoPw3VZBVtg0hvKlj7SsrvmzpLqL8CohsxrLXmXrtW0
         I0of4Aw/lIpl4s8unT+MbFrOOOGOtddERTK0vUsLcARNsu0Rt6/+aUPV0RelVs0R3c
         Ez2U6pHgUsQy/qC2WFR5iJuZC9NdwK2JhjnIut0o=
Date:   Fri, 4 Mar 2022 08:37:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 4/4] usb: host: add xhci-exynos module
Message-ID: <YiHBv9j5fhhOBe/K@kroah.com>
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220304062618epcas2p2e3c73b5c4ed0c9bc0ca0c02aa658d3fb@epcas2p2.samsung.com>
 <1027007693.21646375582736.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027007693.21646375582736.JavaMail.epsvc@epcpadp4>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:23:58PM +0900, Daehwan Jung wrote:
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

I can not take patches without any changelog comments, sorry.

Especially ones that do real things, like this, please describe what
this does properly.

thanks,

greg k-h
