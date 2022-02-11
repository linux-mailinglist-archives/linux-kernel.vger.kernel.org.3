Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987544B22F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiBKKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:17:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:17:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA611B6B;
        Fri, 11 Feb 2022 02:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8419D61E27;
        Fri, 11 Feb 2022 10:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C861C340E9;
        Fri, 11 Feb 2022 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644574637;
        bh=b/ngfDkWDiw92226G+pIpM2EYFAMFZ6kYeblSJjHKcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1oYqHjxxMeI0aCEVvuYhGZFdUSQqWrbJrLweRZKnNQIRTIY32yx3KISfiv+s3rnb
         otFF/DNL2yUw74LDPqu1bXcPLIgVBrvV/p4otbzTGWZUj5etdykV2LbHf/If67tZ92
         T2/ijeW26wnEOJzyGmb7ULn0BW2TCm2kblySPlN0=
Date:   Fri, 11 Feb 2022 11:17:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt8195: add efuse node and
 cells
Message-ID: <YgY3qvAy5lW1tEdG@kroah.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
 <20220128062902.26273-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128062902.26273-3-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:29:01PM +0800, Chunfeng Yun wrote:
> Add efuse node and cells used by t-phy to fix the bit shift issue
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: use hw auto load for u2phy which has no this issue
> 
> Note:
> 
>  depend on the reviewing patch:
> 
> [v9,3/3] arm64: dts: Add mediatek SoC mt8195 and evaluation board
> https://patchwork.kernel.org/patch/12711296

As I don't have that in my tree, I can only take the first 2 patches
here now, thanks.

greg k-h
