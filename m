Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4F4CC24C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiCCQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiCCQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:08:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51201289BA;
        Thu,  3 Mar 2022 08:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E0AB82649;
        Thu,  3 Mar 2022 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2260C004E1;
        Thu,  3 Mar 2022 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646323660;
        bh=JUAMqXpAdqUn/D3f87kpWGt2AtTz5QVg7TJMjFQJj58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqBqOd1qp6TjwKlGtuLyBWwEGqT+dmxnjyL4DHzwLxFkq+ISPvaxU4rwmEFoLTrue
         IMv0jrk6+L5DbQZF7OMB0OmAAXez22kHmIJSHGe47+TXJL8R+BLWYVbVGI9PH3EiKA
         4zGy/9lrt7Qi7TuygiXG1WHTok4PxvWCIsmo8Vq9xrTDnvOSjuSUUpF++HCK8lGOoL
         yskWCR/gWXmrohYA9ckCKvU5zG/G64Xp1HbasDKwEWl0DTmR82tEBDTllEe1Wbayqa
         2uc9YH1Jjry39kWONMAwx9W73WbUDjfIO4i3Jl1JW+o9F6LUYg2fglo8mE64Cby+0n
         xcXJnqb6AV7rw==
Date:   Thu, 3 Mar 2022 21:37:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the soundwire tree
Message-ID: <YiDnyLj8AQmTbEJh@matsya>
References: <20220303215930.014e72f8@canb.auug.org.au>
 <ef2bdf6e-37f8-46d8-fdd3-4e548104b52f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2bdf6e-37f8-46d8-fdd3-4e548104b52f@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-22, 11:00, Srinivas Kandagatla wrote:
> Thanks Stephen,
> 
> On 03/03/2022 10:59, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the soundwire tree, today's linux-next build (s390
> > allmodconfig) failed like this:
> > 
> > drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined but not used [-Werror=unused-function]
> > 
> > Caused by commit
> > 
> >    74e79da9fd46 ("soundwire: qcom: add runtime pm support")
> 
> Fix patch is on the way.

Thanks and it should be in -next tomorrow

-- 
~Vinod
