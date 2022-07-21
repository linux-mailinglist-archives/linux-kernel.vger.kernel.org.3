Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931AB57C3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGUE75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGUE74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:59:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D56A9CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 21:59:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ss3so1088990ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 21:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GwpkC9yTrxhMXwq2N8bYIHvfqMibB4bpkErq4zQeW9o=;
        b=D0S0JOgroVz3X0uzXJFoqCgvDR+ZbwU6hxFNKpeMj4gfbN1yT0enP4HINK/eVVTBlq
         thwbQ6beAt3o+Xd2vbFwDHurOEH3nnWLGVmHevz62YLKteYOlR+jtnovk28QHUrdAoAA
         YkuHzcTU0HKvM7VvMEuNhcYItEK/zHTN1UzSlczzHV1ofcNoNc64iUpkYbWB3BJoRxDR
         SXPoIyenX+YXX64uxlG+S8tCeq7iQXCPgYNpjON62+OfxLB4ZjtldgHoRY+31eiJauFD
         ss7yY+dT0MHRoS4HWluggFUBy+2w+nP3Nn3u3qrlsd5xLtpU7eO7HMF8aYGAZMGjeILH
         bhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GwpkC9yTrxhMXwq2N8bYIHvfqMibB4bpkErq4zQeW9o=;
        b=ADyru6YTP+Ck4PK55nTvXY6xeBeYeMTNlLlSi6jGOGfQGt3vgPc/zu516XYhm8uOJi
         g3LaGEB9wixZPa8JUhXNE7fEBlXzf1MqPJcEzy8qCnDLLf/IQyqgQAoJ8u2cNrh6savY
         XIAB/gQvf2MvQZa/okjoaRNONi0hJcwa0vX92xqXteP6ouFOEB5l0Of5PBrprhJGhUGG
         lSLBzTnopoE6pw2j3qhWm535HpxO3LCa6fz7Ut6wyb0vFBUV+qvkvUhr584xkmkq9/ch
         iW4qlvEsatsmq7B/IHtSYkT0xe/cbR+V0x6H1sxwgq4m64L5iEVu374e9ZNCSpKqigHW
         cJRw==
X-Gm-Message-State: AJIora+D+GEW0yioixtAbBG8774J0ni8XorDPF9i0p7cKJd/v/s6YUp9
        PZXrqYzRbZCLo8Q/q2YRitcbknaW4gw=
X-Google-Smtp-Source: AGRyM1vDyKpAZWy12vt6CcoeVg2TA45Wx+akFGzi0UaT6Z/WxzJtnvaGdbOGmYlL3Iv+8QsP1VhpNg==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr691963ejc.161.1658379592068;
        Wed, 20 Jul 2022 21:59:52 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6957:c533:5c06:b4c0:1c8c? (p200300c78f2e6957c5335c06b4c01c8c.dip0.t-ipconnect.de. [2003:c7:8f2e:6957:c533:5c06:b4c0:1c8c])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7cf98000000b0043aba618bf6sm395784edx.80.2022.07.20.21.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 21:59:51 -0700 (PDT)
Message-ID: <b12cf068-9494-b38c-a1a9-8ec3d68f906e@gmail.com>
Date:   Thu, 21 Jul 2022 06:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: Inserted empty line after declarations
Content-Language: en-US
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <a2747f00-99b8-10a2-edf5-7dd6fd7a1f8b@gmail.com>
 <20220721035146.11719-1-abhijeet.srivastava2308@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220721035146.11719-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 05:50, Abhijeet Srivastava wrote:
> Warning found by checkpatch.pl script. Resending this patch after
> correcting my Username
> 
> Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 5b6a891b5d67..6fbf6e4234cf 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -25,6 +25,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
>   
>   	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
>   		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
> +
>   		if (c2h && c2h != (void *)pevtpriv)
>   			kfree(c2h);
>   	}
> @@ -323,6 +324,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>   	/* prepare ssid list */
>   	if (ssid) {
>   		int i;
> +
>   		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
>   			if (ssid[i].SsidLength) {
>   				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
> @@ -334,6 +336,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>   	/* prepare channel list */
>   	if (ch) {
>   		int i;
> +
>   		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
>   			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
>   				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));

Hi,

I am sorry to tell you that this patch is unlikely to be accepted.

Reason is that you need a [PATCH v2] subject and that the change 
information needs to be below the (signed off line and the "---")

Find an example here:
https://lore.kernel.org/linux-staging/20220718021241.GA8270@cloud-MacBookPro/T/#m7a25ce1dd320c742bfb0ca0236ca06476d8dd8eb

And read about the canonical patch style.

Consider that the next version you send is not v2. Because this was v2. 
The next version you can send is already v3.

Thanks for your patch. You can do it.

Bye Philipp




