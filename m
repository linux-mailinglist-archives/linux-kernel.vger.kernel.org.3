Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8403507A37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiDST3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiDST3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:29:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF5B20BFA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:27:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so17318928lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lhlyNCLzJ6McMJUtv9VTMDlhizwAjxEKxLhqW8mvjg8=;
        b=SopT+69Xn63wAziS3TcdW2Qm1lTV+/qLNJX3k3gPKVzHHiPEPyBrlUJcsL+bA+c1kt
         +X52z/O9bMTR/wrFsHi1gakrNsfORvZFFVYzzFcmoEPRug0VXEl2Iw8brkytl+TztN05
         tmjiv0+uf6fLiAM7PYkTvVpDwNbDg2fVhEl4ieEJJLeRubz2bBDExDRiFTYGmYJyCsEh
         P3gvAnAjPZezZFMTzgrV1esWyBP6px8Q9GgtgYzfdRca0+Rm9CStqIh5OxQZBP8+cEVd
         BoGf+eiHXvbLTk9URBuN1FjP2mlpyAXVKO5niQ/MKiYuPhbSbgdYFg+j+wH5w23s2Bdg
         Gpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhlyNCLzJ6McMJUtv9VTMDlhizwAjxEKxLhqW8mvjg8=;
        b=oOyHcUhQXtLrSztpeJ+YeHWcB3BSPp1BpHxnIMjfopXKngbti79hJFo0Zd7LyfpSaA
         2dQWbEy3zUIBK9S7JRwWA0GkwHdWGCwQ9kJUjHyLDAplE8xrojJvLJGAD+xIrbHCX6eA
         osytlBx7ANkXt5BiqP1ZTpjiUgTrQP8RVAnahwsWqyyxprQV3xhn2jCwdA9JDqyG4BIF
         ISezhneQtERqVZXmNpB0xNPhra0zYkuCu9YeIOzRF+29MyDAjCLNt2E65k6IerJFRINQ
         lJT3Snfjfj25Aa7PWwuR93brQtr+N3RZHO8f2KAQSZkw8v8ce3WpOsR/wgU9Jzqubohg
         l/Sw==
X-Gm-Message-State: AOAM5329NUNmXDnOL3sGanWudvg9XBDMlsPl8zRDq+LV6aJWmAm5ReWw
        ge7QNWufaR673sKT/ta41X6Dj+vaDSk=
X-Google-Smtp-Source: ABdhPJyG6Y2wM2dlef5vHBfqM+j2lOpiyejc/Vlsh69n+HFv187qrGImjua7LcKfLwi08QZ069kY0w==
X-Received: by 2002:a05:6512:318a:b0:471:8f3b:e2bd with SMTP id i10-20020a056512318a00b004718f3be2bdmr8179411lfe.129.1650396426859;
        Tue, 19 Apr 2022 12:27:06 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id s14-20020a2e2c0e000000b0024db3275cd4sm1034812ljs.12.2022.04.19.12.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:27:06 -0700 (PDT)
Message-ID: <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
Date:   Tue, 19 Apr 2022 22:27:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

On 4/19/22 21:19, Jaehee Park wrote:
> The free_bss_buf member of pmlmepriv is unused. Remove all related
> lines.
> 
> Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---

[code snip]

> @@ -55,16 +54,6 @@ static int _rtw_init_mlme_priv(struct adapter *padapter)
>   
>   	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
>   
> -	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
> -
> -	if (!pbuf) {
> -		res = _FAIL;
> -		goto exit;
> -	}
> -	pmlmepriv->free_bss_buf = pbuf;
> -
> -	pnetwork = (struct wlan_network *)pbuf;
> -
>   	for (i = 0; i < MAX_BSS_CNT; i++) {
>   		INIT_LIST_HEAD(&pnetwork->list);
>   

And now kernel will just boom here :)

I am sorry for not noticing that from the beginning, that's my fault. 
This pointer is used in very weird way, so let's come back to initial 
patch: just remove 'if' before vfree().

Refactoring that place is the separate task


I am again sorry for wrong suggestion,


With regards,
Pavel Skripkin
