Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE549500387
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiDNBTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiDNBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:19:29 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F04E38E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:17:06 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 89E15184A;
        Thu, 14 Apr 2022 01:17:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 46D6336;
        Thu, 14 Apr 2022 01:16:59 +0000 (UTC)
Message-ID: <eda6a3a94b768f06e67581bbc4d9974b391f0651.camel@perches.com>
Subject: Re: [PATCH 4/6] staging: r8188eu: place constants on the right side
 of tests
From:   Joe Perches <joe@perches.com>
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Date:   Wed, 13 Apr 2022 18:16:58 -0700
In-Reply-To: <d2469155c37b8677a8dcbed28bc0840745d46f76.1649880454.git.jhpark1013@gmail.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
         <d2469155c37b8677a8dcbed28bc0840745d46f76.1649880454.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 46D6336
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: ucutbhqknse6ajuz6ibq95hioue4rq3x
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19QSXj0Gs9SivOGdTGlKjF8xaHxB+z/K+A=
X-HE-Tag: 1649899019-213656
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 16:11 -0400, Jaehee Park wrote:
> To comply with the linux coding style, place constants on the right
> side of the test in comparisons. Issue found with checkpatch.
> WARNING: Comparisons should place the constant on the right side of
> the test.
[]
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
[]
> @@ -1997,19 +1998,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
>  	else
>  		pnetwork = &pmlmepriv->cur_network;
>  
> -	if (0 < rtw_to_roaming(padapter)) {
> +	if (rtw_to_roaming(padapter) > 0) {

Do you think this change is the same test?

What happens if rtw_to_roaming returns 0?

[]

> -				if (0 < pmlmepriv->to_roaming) {
> +				if (pmlmepriv->to_roaming > 0) {

here too

>  					continue;
>  				} else {
>  					rtw_indicate_disconnect(padapter);


