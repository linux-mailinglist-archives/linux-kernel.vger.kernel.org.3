Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3F4B8048
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbiBPFkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:40:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344649AbiBPFkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:40:42 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8235BD2ED;
        Tue, 15 Feb 2022 21:40:30 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BE76C2B00296;
        Wed, 16 Feb 2022 00:40:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Feb 2022 00:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=zLCfwTEqPgbAts1m8jwlP8PVBAXIZUQ47054Ba
        XjuWY=; b=O59SGJn7XntFau15KVosBLouNjMxmYwm8UF+WWX0P9e0EwfCoUYc1S
        lc6YM6F5yHeRqe0ZL/mLXQu8UT8N9a8kZ52ecv7cQbYxz9FjL/lnwiVkwYMHa+CH
        tOtqwEQybObOdBFTh0rTxwgsucQBjP0tQtj0pQ2Sf2LPCW7wk3cB17t428ag4AzB
        /BCEkJHss6l+9XLaOCz0ADzROfvDCMzYfMjT9KdQp77iOpbjuv75bZMsiIHWHHrO
        qkbGsGE2xRQh/SO17Cblm4nlN1TqwOAs0pOQjVVhHIBQaqOj8ceyznTKuMAb1XZR
        5Ux/vz8GprHnlJ2pi8WpcKV83L66FWMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zLCfwTEqPgbAts1m8
        jwlP8PVBAXIZUQ47054BaXjuWY=; b=Zo49S1EPi6J3CgIp82dMnuKxxk9dNijRv
        E5HYNb6sUgMUvuO3nTdFMV+nJjj4C2gjlLYVo/4rI25261e7q9ZpSEoWh/3XI/MX
        /Ys3NgTt1MR54NubXbpE35ZOuzJCU1nP3Cbhtc1CFAApl4HqdnZbG5FJqTZ8O5d/
        nZfoCicWntqje+1Tq2IqMF0dV8OT+lXi9vLmvxeLTl0RZV0tSOcxinwmgyxxewhR
        8r+NSLdimyXyUX9vS5U1XdUi9CRTKMNBSGu0Abk2ecwiyxGN00+MUBvEv+8G29wV
        focJsVMfdBVZ+oheV3eR7BDdMRWNlY4gSwdPDeGRc+snwoUF8YfOg==
X-ME-Sender: <xms:So4MYgnpfovLImmYJP9hZlmB8Wr48TyQrMF9IDvWoZEy8OV9IWQ75g>
    <xme:So4MYv1qqVSWDMsEeSEKLYrJFoKdPJkqviFudCYeK_tBDx2Poio8y7Bh-ky523m_f
    3jfCpa1rAk2v5fsY_E>
X-ME-Received: <xmr:So4MYuoz3kCa2Ly-okMgNSANrM-nHAmwbBLRyIhuoeleES18sslH89CU-VWb1mNEGyEKi3CWCkPWzyoBkMZJ4fkULtdvCv-rE1Lh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeehhfehfffgheelgeeuudelhefgvdefveekudevjeevjeev
    vefggefguddufeeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:S44MYsnC2027HY2O_ggoA7jlbwEy7k1NIZE2QRnFv0BfxbpSHHFzXQ>
    <xmx:S44MYu1JIrPHRlPjKQl9F8LdP21A4vDI4_D4xZw9fv57c7I5p2QGeA>
    <xmx:S44MYjsEZ0HDxq18kszsewLm2BnYv9e3lYu8XgOLEQA3SproGExS1Q>
    <xmx:S44MYswnezxtDk4uQdE-l-FiFCTnpOB_SE6BELfR_VwttKE_lOG2qDatezM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 00:40:23 -0500 (EST)
Date:   Wed, 16 Feb 2022 15:40:18 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] Input: docs: add more details on the use of
 BTN_TOOL
Message-ID: <YgyOQuN9+IEsCsoA@quokka>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
 <20220203143226.4023622-13-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203143226.4023622-13-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 03:32:26PM +0100, Benjamin Tissoires wrote:
> The HID core stack used to be very relaxed considering the BTN_TOOL_*
> usage. With the recent commits, we should now enforce to have only one
> tool at a time, meaning that we can now express that requirement in the
> docs.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> changes in v2:
> - changed to explain that switching tool in one EV_SYN report
>   is not nice for userspace
> ---
>  Documentation/input/event-codes.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index b24ae7d292cc..8741d390b184 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -137,7 +137,11 @@ A few EV_KEY codes have special meanings:
>      code should be set to a value of 1. When the tool is no longer interacting
>      with the input device, the BTN_TOOL_<name> code should be reset to 0. All
>      trackpads, tablets, and touchscreens should use at least one BTN_TOOL_<name>
> -    code when events are generated.
> +    code when events are generated. Likewise all trackpads, tablets, and
> +    touchscreens should export only one BTN_TOOL_<name> at a time. To not break

I still think s/export/set to nonzero/ to avoid any ambiguity with setting the
evbit on the device vs setting the value to nonzero here, but the remainder is
good, thanks :)

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter


> +    existing userspace, it is recommended to not switch tool in one EV_SYN frame
> +    but first emitting the old BTN_TOOL_<name> at 0, then emit one SYN_REPORT
> +    and then set the new BTN_TOOL_<name> at 1.
>  
>  * BTN_TOUCH:
>  
> -- 
> 2.33.1
> 
