Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04295575081
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiGNONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiGNOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A539853D34;
        Thu, 14 Jul 2022 07:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 598EBB8257C;
        Thu, 14 Jul 2022 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CAAC34114;
        Thu, 14 Jul 2022 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807948;
        bh=ArZBoOm8jvPL7I5/Gjx7tFExl/co+JVWFRZ85SkiT68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsQGIV+R2LrtzUKUiTHv524wMXWQ0+CCkh7VAveaA9h1cpyyQ4jHdjUMcgRxAEGzu
         hkMUpf7qOz9dZvjg8UeA/MRkI44tcgjWKMG7ktbr2tCXZsL5tBDJRTHHwhlev3ciWm
         Fi9ZTldnK7PqwO8KfusnwZsy+jBpkFVkF6+t9+jw=
Date:   Thu, 14 Jul 2022 16:09:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: remove useless condition _ep_queue()
Message-ID: <YtAjkUtY7QoJ0SAp@kroah.com>
References: <20220711152503.17657-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711152503.17657-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:25:03PM +0300, Andrey Strachuk wrote:
> Comparison of 'ep' with NULL is useless since
> 'ep' is a result of container_of and cannot be NULL
> in any reasonable scenario.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 2dbc5c4c8314 ("usb: chipidea: get rid of camelcase names")
> ---
>  drivers/usb/chipidea/udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Subject line is wrong :(

Also this is not a "Fix".

