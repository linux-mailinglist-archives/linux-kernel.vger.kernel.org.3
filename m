Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06C4B84DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiBPJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:51:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiBPJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:51:09 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB272B4079
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:50:45 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c10so2396348ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5BSEQWlpqzUNC7cde1R/udWhNZ/HbmdZRR8iTULYXlQ=;
        b=QE29adL5btNluj+3qUfq1CYwY0DrPQHuRx6PkLyu+fXmQ1T5ixOOnHG5wDFt2FBVVX
         l56hP8Da+r2H1KEnMaRO/piSebG92stURNx3gtaA4KmOoEisT4yr47IEzS7cGlRNnmF0
         KkEF0z+sQbSapCgNtDsFW5+FJeX28glmDHN+biX7B5dMIC2Xup1lqufrvq8MMjnXgcZc
         i0efQNA5OpVzDD2eU9TujFZQQ6yKHb8QSgikwBh/82vUQBkeFEf/5s1aYcL/eJXxOIJy
         yyAtUKvYn84hc4/J54m88HVyGZM1bJJ7iLXGFvNeNOj+GxFi3cVAyisWspXlUzo85wmI
         GJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5BSEQWlpqzUNC7cde1R/udWhNZ/HbmdZRR8iTULYXlQ=;
        b=JTXW5tRXXx5Bypuf6CGMNhgYWy/9tax1UOqRkjUIBmc9Kn+pdsBci1RPc93w85NfZt
         y4iCnMMwYUSMztsXahTO61nMC/mII3B0DvEEol+ZixZo1Y3v1SsYYQqRD3PQpXJ3WLFF
         DOx/T9v4SFIhZg9k+9huu6WEXe5S9CmaXJ7u8WH6/1LZaDyb8PP4PxzWwZpZMgGu2La2
         vmPta+FVh7DDcTdCWT7WteU3ixN5siVEIVTRXjWShYh9u5sHfzPyf+bkyT5LdsPmVTYe
         wcbY9Wm2ef4dgbt1X+XTOsf3ewM6X9gl+NzSDIEMCZu+97BzsWlOFyzNKJ6ZtIYKM1rF
         DSEA==
X-Gm-Message-State: AOAM5314c1q8JjzCyoXnhPe47C+xZYkafxH4mVCOEqxTGWMzFGbGWk3c
        BZoCs3lfET3SHFUxTSLrLUQ=
X-Google-Smtp-Source: ABdhPJwMpnx9ZO+IdlvQw5i56UM/gTv6nAVkEK2NfXUX8SBX6DfFhJN3S4zO6dATaFZIZzewh8t9rg==
X-Received: by 2002:a2e:bd84:0:b0:244:c1e5:c6a7 with SMTP id o4-20020a2ebd84000000b00244c1e5c6a7mr1438956ljq.228.1645005043169;
        Wed, 16 Feb 2022 01:50:43 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.154])
        by smtp.gmail.com with ESMTPSA id v11sm1248197lfp.95.2022.02.16.01.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:50:42 -0800 (PST)
Message-ID: <85740a8e-e654-7742-642f-44d01c323c26@gmail.com>
Date:   Wed, 16 Feb 2022 12:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 03/15] staging: r8188eu: remove converted DBG_88E calls
 from core/rtw_mlme_ext.c
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220216010709.791-1-phil@philpotter.co.uk>
 <20220216010709.791-4-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220216010709.791-4-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 2/16/22 04:06, Phillip Potter wrote:
> Remove all the netdev_dbg/pr_debug calls that were previously converted
> from DBG_88E inside core/rtw_mlme_ext.c. Due to the sheer number of
> lines, this patch is separated out for ease of review. After some thought,
> it makes more sense to just entirely strip all of these calls, so that
> debugging code in the driver can be more consistent and useful going
> forwards.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

[code snip]

>   	if (pstat->aid > 0) {
> -		netdev_dbg(padapter->pnetdev, "old AID %d\n", pstat->aid);
>   	} else {

Ok, this one has same issues as 2nd one. I am going to stop reviewing 
this series for now, because looks like I am missing some context...



With regards,
Pavel Skripkin
