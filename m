Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB84A6E40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiBBJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:57:06 -0500
Received: from relay.hostedemail.com ([64.99.140.27]:25200 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiBBJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:57:05 -0500
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 0E224601EA;
        Wed,  2 Feb 2022 09:57:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id DD81E80009;
        Wed,  2 Feb 2022 09:56:41 +0000 (UTC)
Message-ID: <358563808e6cad1b003e4c5488cf65ff1267f1d8.camel@perches.com>
Subject: Re: [PATCH][next] usb: gadget: f_uac2: Fix spelling mistake
 "maxpctksize" -> "maxpcktsize"
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Feb 2022 01:57:01 -0800
In-Reply-To: <20220202091933.580713-1-colin.i.king@gmail.com>
References: <20220202091933.580713-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD81E80009
X-Spam-Status: No, score=1.60
X-Stat-Signature: 8s9f1roqfggujywr3xzpjx5e6wm4xc68
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ZFAGlReJmYZL2admrM2pyTvRcuBbmLaA=
X-HE-Tag: 1643795801-100853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 09:19 +0000, Colin Ian King wrote:
> There is a spelling mistake in a deb_dbg message. Fix it.
[]
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
[]
> @@ -755,7 +755,7 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
>  
>  	if (max_size_bw <= max_size_ep)
>  		dev_dbg(dev,
> -			"%s %s: Would use maxpctksize %d and bInterval %d\n",
> +			"%s %s: Would use maxpcktsize %d and bInterval %d\n",

why not just spell it out? or use wMaxPacketSize from the uapi include?
---
 drivers/usb/gadget/function/f_uac2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f2237bcdba7c0..13b59128121a2 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -755,12 +755,12 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
 
 	if (max_size_bw <= max_size_ep)
 		dev_dbg(dev,
-			"%s %s: Would use maxpctksize %d and bInterval %d\n",
+			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
 			speed_names[speed], dir, max_size_bw, bint);
 	else {
 		dev_warn(dev,
-			"%s %s: Req. maxpcktsize %d at bInterval %d > max ISOC %d, may drop data!\n",
-			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
+			 "%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
+			 speed_names[speed], dir, max_size_bw, bint, max_size_ep);
 		max_size_bw = max_size_ep;
 	}
 


