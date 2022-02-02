Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56144A6F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiBBLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:09:16 -0500
Received: from relay028.a.hostedemail.com ([64.99.140.28]:43333 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiBBLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:09:15 -0500
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 3907961059;
        Wed,  2 Feb 2022 11:09:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id D89622000E;
        Wed,  2 Feb 2022 11:08:50 +0000 (UTC)
Message-ID: <7719a17b34a22f8375fc0d192141c64952e5549d.camel@perches.com>
Subject: Re: [PATCH][next][V2] usb: gadget: f_uac2: change
 maxpctksize/maxpcktsize to wMaxPacketSize
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel.hofman@ivitera.com
Date:   Wed, 02 Feb 2022 03:09:11 -0800
In-Reply-To: <20220202104058.590312-1-colin.i.king@gmail.com>
References: <20220202104058.590312-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gei45f1cxduiugi4jbmn3onqt6wo3x18
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D89622000E
X-Spam-Status: No, score=0.30
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18jHCfyLGhudG7e1CQhdUFVttc/efTcP0Y=
X-HE-Tag: 1643800130-668851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 10:40 +0000, Colin Ian King wrote:
> The spelling of maxpctksize and maxpcktsize is inconsistent, rename them
> both to wMaxPacketSize instead.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: change both strings to wMaxPacketSize
[hmm]
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
[]
> @@ -755,11 +755,11 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
>  
>  	if (max_size_bw <= max_size_ep)
>  		dev_dbg(dev,
> -			"%s %s: Would use maxpctksize %d and bInterval %d\n",
> +			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
>  			speed_names[speed], dir, max_size_bw, bint);
>  	else {
>  		dev_warn(dev,
> -			"%s %s: Req. maxpcktsize %d at bInterval %d > max ISOC %d, may drop data!\n",
> +			"%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
>  			speed_names[speed], dir, max_size_bw, bint, max_size_ep);

better still would be to align to the open parenthesis


