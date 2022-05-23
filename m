Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09525307F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbiEWDGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiEWDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:06:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4C31209D;
        Sun, 22 May 2022 20:06:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so16242871pjp.3;
        Sun, 22 May 2022 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9KUhbCXdZX0MhogUwa+J1pf9lfQ3OPQ+jbQCzFSIPU8=;
        b=gCtc9JUFj269VkQ4t/c705n8Wwt7OHeVQUsjEPopi+UPlnGOsISI1ZXISIwM3AmTn9
         ouusUG0KB0+LoYh7uKiirOuDG9pztoAtbsO3zuNizeoLm9o3tfxzPV+Be4rNaR9kmLcv
         MF71bl70vD5TPaAmGhHG8vTAuP6I3PXK8okQUQGD+F7Vbh6TL+j+t8kQRGGIwIgfCwUZ
         WL2WjH/KL2ZSdI3GFE+VAdLE9WaSnHWm1U+5LXiyQ8Q1nfAdb90Xv7CLbA9+WBvjczjR
         Iq6R+2xBqWBluYc5gZZlaHxQZwiyVlLwg8A6LfgS16cfyjAdk6tXQOCMqxEb5DTTX1Gu
         qkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9KUhbCXdZX0MhogUwa+J1pf9lfQ3OPQ+jbQCzFSIPU8=;
        b=lyA2DcUSTNp+kOQBhPhq5aDyf1ijl+eOd1cuLjoagjxazKNfZeHWS2Z5ywUz/EqsV9
         cWhRoZ2PiBcfIqoxGgcLketfPvzG09BAh8cPYV2tVBvY/JK4k8kI26DPxqRROQcE8XHd
         Xqqht+qp6dYrLzgtpVMUATwzceoygSy8tV4xQzJVMpGegc+/dpjIWKMgv21ewxUVmO55
         Sh6t64k6No/k1xLHgF2pMhO4cvBatsronbT4rkgHmLR3pJ0JiIuruiI5mr71JbKxEWbL
         xsNHOkY7701idwfgRU6WVp9edrUm5IeddGphUyoPHuYHLCOgcWq9Sk9qwvE2Ir3cSonI
         1CdA==
X-Gm-Message-State: AOAM531U6i5GilA/oFwB6r89Cx8lX/Ht/VGFD3yYR0N+DUL7mbJUNdGC
        0ClYP21Z4uMMiqu3XfNe/1I=
X-Google-Smtp-Source: ABdhPJxx+3f1F6z7AQtbrBFnk6SsTvQtXO+CZXoK6FNjahhXPcpgwZEwxI0ul6mLrCIToBYhi5Vi7w==
X-Received: by 2002:a17:902:74c4:b0:162:1e9b:2bef with SMTP id f4-20020a17090274c400b001621e9b2befmr4608203plt.10.1653275172561;
        Sun, 22 May 2022 20:06:12 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0050dc76281bfsm5868521pfo.153.2022.05.22.20.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 20:06:12 -0700 (PDT)
Message-ID: <d55d4532-44ba-9750-f7aa-0c6ffeb147c6@gmail.com>
Date:   Sun, 22 May 2022 20:06:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] soc: bcm: brcmstb: pm: pm-arm: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220521111145.81697-16-Julia.Lawall@inria.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220521111145.81697-16-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2022 4:10 AM, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied, thanks!
--
Florian
