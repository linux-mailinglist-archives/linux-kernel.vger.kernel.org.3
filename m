Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2524C574E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiBZSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiBZSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:10:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD68496AA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:09:56 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v22so11745676ljh.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U5sOQ1jTzm9XSVpV/OKjAlxcVR0vJA4ED1l8Ev97KWM=;
        b=SFOJ7FTjxQTx+bYJHRKQPO6xOcVXk3wLR6oXIR+93hx7aj+tFMQK19xU5W+rFCVNli
         cETA2Q/ObnZN9v0fPf1Lh5/Bhyan67ON75vJXbYqdrItMNzgqTj9zxLVjnuHXBMfd6+v
         /fvLHZDWaybZN4rQZLPMDkZu4HGD+nO1kbARV3m0tsvswzwUC1dyUbEsn02rvJHOYh1E
         ez9dNs1zaBuU0iaVqx3eYKLJR26c0Qr9xLwmrtTmqew9MaB4xhwusWpjxBBJRLJml7EX
         7OCJefIB0ryJrWDN20WYZ8dJSCdbkijbyrJ15xoqmKT/5Acpgn9BFKvZkZvhij51n9VA
         e8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U5sOQ1jTzm9XSVpV/OKjAlxcVR0vJA4ED1l8Ev97KWM=;
        b=66Q7WvVrtyYY1T96c6eq0CBHRcso6FerOGsPvsLe+HFhXuZUEbQiJL44RQ43G+ZXdV
         yvXVEi/IgOLnIwcNik2b2/PY0kxMqKohcEnF/CMY1j6do7nfaTyKdsEnHJwgKIb2yNHU
         jisyvgZWWTNxiEt47D6Vaoels7Sc4AnYDc18Qp8PyO+TlGTsdzyiJjg+0fuHL7LsP6Js
         Tkj+PJHgdIODGTWOC5zJuSJTUStvnkUTELRYryMCgnGpBIu+8KRf2IXMuIbK4PCgJ3I6
         hjuaPZR+pJ5krZJhrLO3CJAoJZM0A4jgRmQxAvM2ofcyGkRYsDAP7Sq3TdS7CLnl99pG
         n/fg==
X-Gm-Message-State: AOAM5300zZ/iEpxviAakHnahCYITwbeAUYCnaXhd8m+egUnLjxigp218
        cbhowfNjo8Zd7ul7SMMdj+w=
X-Google-Smtp-Source: ABdhPJzx0Ma7VXZgIULeaqVKBuajBNniwc+CQIUn5JeNf/1pL6MUTZnOiF65aXpOp/1ozu6Zc5Tmfw==
X-Received: by 2002:a05:651c:90b:b0:23a:c39a:16d1 with SMTP id e11-20020a05651c090b00b0023ac39a16d1mr8791694ljq.332.1645898995099;
        Sat, 26 Feb 2022 10:09:55 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id a21-20020a2eb555000000b002464680f089sm635681ljn.80.2022.02.26.10.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 10:09:54 -0800 (PST)
Message-ID: <2dca7337-e657-02c7-87a7-6c94f31fb49e@gmail.com>
Date:   Sat, 26 Feb 2022 21:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/6] staging: r8188eu: cnt is set but not used
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220226144843.1118951-1-martin@kaiser.cx>
 <20220226144843.1118951-4-martin@kaiser.cx>
 <1c44c931-5b90-03d8-94bd-5e68682c4787@gmail.com>
 <184f741c-60ed-fe32-5705-08f9769e926a@gmail.com>
 <20220226180706.wierfb2ancom32zn@viti.kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220226180706.wierfb2ancom32zn@viti.kaiser.cx>
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

Hi Martin,

On 2/26/22 21:07, Martin Kaiser wrote:
> What exactly is this doing that's not allowed in a tasklet? Does it call
> anything that could potentially block?
> 

I mean infinity loop :)

> If I pull rtw_alloc_recvframe into the loop, that function uses spin_lock_bh +
> spin_unlock_bh, I guess this is ok. As for recv_func_posthandle, I don't
> see anything where we could be stuck...
> 

Yeah, I guess, it's how it meant to be (like in 
rtw_free_uc_swdec_pending_queue())




With regards,
Pavel Skripkin
