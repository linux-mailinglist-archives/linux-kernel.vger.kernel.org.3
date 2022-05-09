Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E151FEC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiEINvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiEINvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:51:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2D1A8E24
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73CEDB815D1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D484C385A8;
        Mon,  9 May 2022 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652104059;
        bh=amria7wosvXRbRogGsIE7iClbJBQtvonyk9Lq2cJIro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bS0PNNDMdCwlP/jCpxhw9aAL9XvLfFIfuAqs4vDs22QZ3wyKarpw/yze7Fmx+uIE9
         5OKii4cKpeTMXpQsCkRMWiuZLn4VG+1CfOAZ1XS6Yg3fSb+eSwPy9jQuiyOclih8xX
         KlXkoGjboxgtv5zksXjAKjfppuclLJ90Dnr6yRx0=
Date:   Mon, 9 May 2022 15:47:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] nvmem: patches (set 1) for 5.19
Message-ID: <YnkbcSiOYs0ZpjEP@kroah.com>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:26:45PM +0100, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some nvmem patches for 5.19 which includes
> 
> - new nvmem provider for Apple efuses.
> - support for regmap and TA 2.1 devices in sfp provider
> - add device tree node support in nvmem cell info
> - brcm_nvram provider to parse cells from dt.
> - few minor clean ups in qfprom, bcm-ocotp and sunplus-ocotp
> 
> Can you please queue them up for 5.19.

Not all of these applied cleanly.  Can you please rebase and resend the
remaining ones?

thanks,

greg k-h
