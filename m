Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F785524EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiFTUC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFTUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:02:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8D1CB0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:02:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s124so14720736oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XZYTVNN3OTIFAKlJr31QtDNYvtTZSjURUEwd4yxlavE=;
        b=IuJJXPocprRwnIMc5qD8E0ArJ9j4zrbdncIaUPN6SHFiyJROFTTfiQ4fWadbPTup+d
         lyXWq7eKwk76iJz90VgOMKvpLQ1Q7j+RygtKUZlFCS13F4apJfy5w3oKi2E0DDQZrUSl
         WLro7uhGls+p++NMILOPKPMgqoViBBF/qn5cBIZGBRMX3B6MJyK+iZYAaaPsSrN+V9Dj
         OPz1wpegOSVmr6xAGV8+VH9H+cY7zmsg5KSSPNtuqtqvNyevVQwFWmdO4E9Bf5sBRGE8
         0aZLFqQvK9xh8V/8+DXbLTehnUl3/6HSJK+oladrYWSbISfHb6tl2EWBJaPWWD1GUHhG
         D3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XZYTVNN3OTIFAKlJr31QtDNYvtTZSjURUEwd4yxlavE=;
        b=wn09gfg+rv45bGMvgleF8z02Hl2guZ3qfwVKZbpC/jZ0XIpTzpUkoMK3m/izoA7z3f
         /kEE2lZVWjXMO0clY0GZ7wnxgKOdBToNiLCFz7nR105JixP2wtvNiONJu/W2z50eUNPe
         xmOpxsfktieu05mkhdd9i+0b1KFqWoejuMP32MNMQM9YLApyF7A0NwXpnJvaHWo0WiOI
         C89fcQ+6aUzRlEPzqykM10ihDUKgiJ7YQd8tD5fSchuuqNbvxARawib6s+zeKb1m3Ghr
         Kj+R4D54Em0IbU904G0wa+jlvq8TUsO8TycbjcCZ2kKuAJnQfzP1ISqAConLyEXPl7qQ
         4jqA==
X-Gm-Message-State: AOAM532D41M440MRdSUpt9rZts9LMmkUQIEuJKleDlRTjvMYxmVMvbka
        ri6NUEvBUaeW5QzJTwxM+RlroZvJqds=
X-Google-Smtp-Source: ABdhPJzUcP6Xsquvvp31yhoKLnPS5U+zovKalrAzvTPyCdjqjdcvxUC1lxc61U6Ui+Crb/cWMQdINg==
X-Received: by 2002:a05:6808:1999:b0:32f:2fc:aed1 with SMTP id bj25-20020a056808199900b0032f02fcaed1mr17560674oib.255.1655755332744;
        Mon, 20 Jun 2022 13:02:12 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s204-20020aca45d5000000b0032f662af5d5sm7928355oia.1.2022.06.20.13.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:02:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3a73a59c-29a1-5f96-ad0b-476c46587fcd@lwfinger.net>
Date:   Mon, 20 Jun 2022 15:02:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] get rid of useless header file
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        phil@philpotter.co.uk, paskripkin@gmail.com
References: <cover.1655745123.git.namcaov@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <cover.1655745123.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 12:19, Nam Cao wrote:
> The stuffs in basic_types.h are either not used, or already defined in
> the kernel. Get rid of it.
> 
> Nam Cao (2):
>    staging: r8188eu: replace N_BYTE_ALIGMENT with ALIGN
>    staging: r8188eu: remove basic_types.h
> 
>   drivers/staging/r8188eu/core/rtw_recv.c       |  2 +-
>   drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +++---
>   drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  2 +-
>   drivers/staging/r8188eu/include/basic_types.h | 19 -------------------
>   .../staging/r8188eu/include/osdep_service.h   |  1 -
>   drivers/staging/r8188eu/os_dep/xmit_linux.c   |  2 +-
>   6 files changed, 6 insertions(+), 26 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/basic_types.h
> 

For future patch sets, please include the "staging: r8188eu:" part of the 
subject of the cover letter. It makes it easier to sort out the rest of the 
patches; however,it is not necessary to resubmit this one.

The two patchesw are fine.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry
