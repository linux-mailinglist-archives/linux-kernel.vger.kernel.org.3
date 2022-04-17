Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF550496C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiDQUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiDQUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:25:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF113F13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:23:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so7706800lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=umLOpU+0I1iOAgBTudA/7ZDWer0bJgohRBccjT2TBm8=;
        b=BGZfXiD7+DzTdHXLzDwTfT5VuQwbA4EiqSj0EnZgDj/7WlOXLkLUsFUVuYiR9sSX+s
         K1MhK5dWyCahlFIjG/Cb3ODkMITf8l70gxB/Sn7vKPBqyetVndafrZq5gYmU9ihSFER+
         rBjiVTJ5ZDRAUv+L5ZojYqEkB1mCxVWxjNkimUGLnUZ1ioGa7m29qgEbz+hEvIFxE5Yv
         VudMY2nsIIIGHQk2w+yi57BLsfCApv6D7CXZF/3Pz49lKHiMeGEkYqvAsw/RL/Pk9+e1
         N69TnQnKiPvJea3yxdSDNXAt/LE/MMzjGesb9gjyn5oYl87PWe9UzrtvjtLUcz6ejOPw
         Ny4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=umLOpU+0I1iOAgBTudA/7ZDWer0bJgohRBccjT2TBm8=;
        b=N/8BlHoxUZvANxUFc7TwNO7r3wCmVPfN9A7h49t+d3DWqjI7JOkOsI2n43qLnicSc/
         LEApRJ0/b+JEXoVjVhJMRtaJb1Zl5Fo9cZWluhVIpaKUTTLK7zuFfXp1nhP2azMOxASU
         d5WhjGMp0BR0JJXtx5tQ+1zSIE9CPty/zEKw5gRMBHiOw3MXDM7R+H1B5VRvPduXDCBc
         Hdysp0dNuBXp6w025kSvaayw5ziRSQsCSJBYVfB+vxx9RnDVtP6OaF35TLc7XbuXVpSI
         JQEmEYr0F7dY+Nzvuf5NOxucMom4yhpcGqr2Da/L4ZkKtVd7ogCA4UwfXzGHdBTE4V6O
         gDfQ==
X-Gm-Message-State: AOAM531SCAOXpk+tUfqO75uoSOx6YL5q8ba4haA/xkXFGDQoniInljB+
        TYt7NLuQRuvNjBnTgqKyH7E+TwRxGI1c0A==
X-Google-Smtp-Source: ABdhPJzqDTzkV1w/pnVoQAQOWVEYmGJ7tIQvYYLX/K1xknW3ohqlHF6jl3oekIxTFjE4eopmbK0//A==
X-Received: by 2002:ac2:435a:0:b0:46b:ae5b:83e8 with SMTP id o26-20020ac2435a000000b0046bae5b83e8mr5941240lfl.485.1650226985931;
        Sun, 17 Apr 2022 13:23:05 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id u18-20020a199212000000b0046ba06a6a19sm1015663lfd.143.2022.04.17.13.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 13:23:04 -0700 (PDT)
Message-ID: <6925e230-b816-ea9a-067f-60cefecd8af7@gmail.com>
Date:   Sun, 17 Apr 2022 23:23:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/6] staging: r8188eu: remove 'added by' author
 comments
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <c0eaa7cbc61d89967d81ef864c1a791f4adb1978.1649990500.git.jhpark1013@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <c0eaa7cbc61d89967d81ef864c1a791f4adb1978.1649990500.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

On 4/15/22 05:48, Jaehee Park wrote:
> Author comments "Added by Albert" and "Added by Annie" are sprinkled
> through the file. These comments are not useful and can be removed.
> 
> Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>

I don't remember giving that tag, but now I am OK with it, since patch 
looks good

Please, don't put random Reviewed-by tags in your commit message, since 
it's not how Reviewed-by tags work

> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>




With regards,
Pavel Skripkin
