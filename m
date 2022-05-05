Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDE51B6BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiEEDy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbiEEDyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:54:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEBD4614F;
        Wed,  4 May 2022 20:50:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so3277011plh.1;
        Wed, 04 May 2022 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VFz644Io2Z3f1sVIwfPGsEigStI4YD3zKfl46VshVCo=;
        b=ASFAg6oJ7wa2qu9Qgt+jd6DErwjcmkoKsihWEX4rlMqQNuiG5olsLbv94uV29Hz19I
         0oSutOudnFw7QB8S4a/g/3sRGgchmMUlkJzub4bJWXtHWqT/mZsbaAbu62tyRDlAkrNw
         paKRCzMGnbIIPyaQ0ftOLNXhEI+pCso76smeMoqz4xIQwy3IX4vI9AaW53Q/y1vcCVPO
         LXgV0miUdIfNj6eFIXzfO+0CtJZODKCfsLI4RL3kx4TYOR0bLRPzjLta0Vhmd68q+3GC
         sC7ARmrv13ZaGi7mbK7JttnHPgOJlEIPYqrWq1Uxy2/dhUvyej29t3DMM2ZBnHv5QiUr
         Ef0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VFz644Io2Z3f1sVIwfPGsEigStI4YD3zKfl46VshVCo=;
        b=CLYl063THIclH6SPRmWDyN8SVCKVFqIBBH3wLy5Vt0FCZDXocOJHYf8Qsj5lVPfelL
         48nUQkti9S5PPGfsqdWFUOmWo38cREMnOg4T55sPGlJQTxBcSGfoRoWIeSWKTd4R8Syi
         B4Z3bg9YswZquIstOav1sUalLDbDMCkioGFTEHOHEzcu/2CuicvLY44ysGWu5utfnFfD
         UWBQRZ9gpi0pG4lII2vFntovMiqRlo0saFLNkMwDRklkLypDrmgWFIEWALm7t1mfBZa8
         ghpeRLa3ty9CCmdFXoKGRnRQ+xfxdPdvl0b6dWsFoHnACQdU44J2VPM9nheQit53mnA7
         txXw==
X-Gm-Message-State: AOAM5338zmcRUMhRiUP0iGm6v/mfB/JgwUBCHgr8dFA2KRUdonlV4h0O
        xFsQrR59OLF8rt54yC+f4dI=
X-Google-Smtp-Source: ABdhPJwjFZNxx8QHMUzYSKmG0LbcdjYdP173DySlMXG/LsiKBqT4/KdJo/p+G/TlHMoRHwKjxCXzsg==
X-Received: by 2002:a17:902:7c81:b0:156:30ef:7dec with SMTP id y1-20020a1709027c8100b0015630ef7decmr25255237pll.74.1651722629440;
        Wed, 04 May 2022 20:50:29 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0015e8d4eb228sm288275plo.114.2022.05.04.20.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 20:50:27 -0700 (PDT)
Message-ID: <99f380f6-170d-99d7-6307-f788d44cec9a@gmail.com>
Date:   Wed, 4 May 2022 20:50:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] gpio: pca953xx: Add support for pca6408
Content-Language: en-US
To:     Justin Chen <justinpopo6@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
 <1651703357-25154-2-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1651703357-25154-2-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 3:29 PM, Justin Chen wrote:
> Add support for pca6408 which is the 8-bit version of the pca6416.
> 
> https://www.nxp.com/docs/en/data-sheet/PCA6408A.pdf
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
