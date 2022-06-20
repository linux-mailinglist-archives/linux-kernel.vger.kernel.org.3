Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5A5524F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiFTUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiFTUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:04:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107F6341
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so23152237ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XwA7zkpBKMOa7D6ahvef+MzrRp6DsCvkHXwYy4FzqiI=;
        b=P2gDeGV3k/r7RAKVxZ9/QjwPRwuf0EMwLboNOSL223k+Gy49GmkW1W/fLLx7Y0qDHZ
         WnxwAJzRMBaMcKMjPmfDELUOztgKWAVbPXieRedDs0mUv+gKTHVHuarBJfkzWeJMBuiR
         qkSbMOpdJb8tf9gOc+yvpv+9inlxaySAoKjq4d0V8eqgU6oBcXoGDVE5N9XSkVir12g6
         QSGe1nC+VZRi624UrQIORS93a8wkeT8/jPpCcqhVDgjRyXiEauODN0Urx1jZez7GhjaA
         2b2hG132gR1ihRmeSjtkrUH0eaXx9OfdDNWQEzLBqML7nBUr2EH2U4tIquZ1ch5wcPXa
         87sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XwA7zkpBKMOa7D6ahvef+MzrRp6DsCvkHXwYy4FzqiI=;
        b=JyBefZwXrogzEf1k8ZpTnqZ2bQTzbEvcgeh0B8Foi60NKPcayggP+4gsV2Jj7M+oD7
         VQxF72dY+KadAK2pJI0s61NrrlsJKUivzYDRyj6ZSwvvtKVrXKzwJW4HXMzHs3Wk7YSC
         q0XrWhiWfaLAHVRBzddIjxJBG4wGi3v061GFLOrvdSu1cjtvj8lVPBNLLaSSpdLoRNEV
         c4YDT2J3FlcKTnGMLG4x6P13z4vhFf2Qvhx5AncHxZdUv0hVoJ+FOmVJfzMY/u74BWFs
         iL7XUqKGlwDMetYvD84VBII8sZFiDWTK3ig0x8dD+TDrOImzjIz9HsGfRloiN8VgK7+e
         Qf0Q==
X-Gm-Message-State: AJIora9lPFuRJK1WlPcfyRPTdhYaZZGdxWEHIMOW9hIX1jBlllpOjfk3
        CHz9iHrgfMitXSuLqds/Ynk=
X-Google-Smtp-Source: AGRyM1sY14201r8EiKcD4MYti4igobBBgrd4ld+Bv0vP7AV1cqCnfFzQ7WYB2chx1Ihz20IWlwayTQ==
X-Received: by 2002:a17:906:74c2:b0:722:e1e2:edea with SMTP id z2-20020a17090674c200b00722e1e2edeamr370227ejl.658.1655755485204;
        Mon, 20 Jun 2022 13:04:45 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm6561454ejc.25.2022.06.20.13.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:04:44 -0700 (PDT)
Message-ID: <f1731d4c-e66a-b7e0-d460-7729a41d1cd2@gmail.com>
Date:   Mon, 20 Jun 2022 22:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/5] Fixed some coding style issues and spelling
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1655666628.git.marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1655666628.git.marcus.yu.56@gmail.com>
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

On 6/19/22 21:42, Chang Yu wrote:
> Fixed a few coding style issues and some spelling errors in the
> comments.
> 
> Changes in v2:
> Separated the original big patch into 5 smaller patches so that each
> clean up is in its own patch.
> 
> Chang Yu (5):
>    Staging: r8188eu: core: rtw_xmit: Fixed some whitespace coding style
>      issues
>    Staging: r8188eu: core: rtw_xmit: Fixed two indentation coding style
>      issues.
>    Staging: r8188eu: core: rtw_xmit: Fixed some spelling errors in the
>      comments
>    Staging: r8188eu: core: rtw_xmit: Fixed a brace coding style issue
>    Staging: r8188eu: core: rtw_xmit: Fixed a coding style issue
> 
>   drivers/staging/r8188eu/core/rtw_xmit.c | 28 ++++++++++---------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150 
Adapter
