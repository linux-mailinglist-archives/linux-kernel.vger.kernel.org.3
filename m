Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E961534B43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiEZIOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbiEZINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:13:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787023D4B2;
        Thu, 26 May 2022 01:13:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v8so1296718lfd.8;
        Thu, 26 May 2022 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6XIUrzcjTsp63WT6KUFudVsfMqzwjs/ISF26+AtGKYc=;
        b=M473zBFhKBpYDZLMCH3iHGNvgO8yBDEhAs/CCtpeY3diR5OYtHK5Qp2dggVdgz3N2/
         NDre3BufT92wpRo3Hz/F4U6W/CI1pK6jPKkf3IlY7ax6VtMPPnMFcyfOLSbBFpHIGE1C
         t0Di2WB5JNJgyvgBOsa81+6649T4/gEhXaU54YTUpNphkCaIJYhC5xV0HIRxF0i04qUp
         Od6Try1IZD3jc28JPo/cdyackPBRHN9we2AVEv0wEPOZSidbrWBghVQRibpGleeClHgs
         ipUmtJWVVgAqmM35TGBvfe1pC6XeOesixtOR2NVX6bHhPL+pyC29dQGfqTVorRNZU3vC
         FHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6XIUrzcjTsp63WT6KUFudVsfMqzwjs/ISF26+AtGKYc=;
        b=7WfiJVr0GFInQwdrCUgXWcNAChCZTpA3pc5+pBEJy2fw15WMmuEzf18wtiCEa7w/Rv
         JklRB1m4y+XC8KnSJUslOSnQZcdpDAqzXs/KbynVsAm23xoZhBipp7ZWhGvtp583aqGz
         ufmFheDZJNtC+awAi02WDSLKhD9CmHE9222ByIGT+p92nor04tqxTCcznNsAPQog8vuj
         vzGCGoJAfR0CqzhJpRB5c/Bl4ApOUcx7cMhegMB4DkkFWek8WvwW7JmdRXCMlayC5FJy
         IHmyMYDphR9IMggC6VsnlLwOQ9B0G61g9dESB93G/6pqcDd3bv/BhL7vGfQ0Sgd423cM
         k6lg==
X-Gm-Message-State: AOAM533+RCCk6k8i23SzEvPDBLNMbOTkW6I/dIhIo/M8T5l/picIYMgt
        sP8VR881zkrU9BLzJSgB/SGQDDVg3x0=
X-Google-Smtp-Source: ABdhPJzH8WmTstQykYFVsAS9QjVDfZgRXQtHx/7ka8Z5KQ7wLl7iBlWFS2b71GlxRV7/nbrKITusFA==
X-Received: by 2002:a05:6512:3b14:b0:477:cc51:b2c3 with SMTP id f20-20020a0565123b1400b00477cc51b2c3mr24809657lfv.263.1653552829449;
        Thu, 26 May 2022 01:13:49 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.197])
        by smtp.gmail.com with ESMTPSA id dt14-20020a0565122a8e00b0047255d21202sm205638lfb.305.2022.05.26.01.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:13:48 -0700 (PDT)
Subject: Re: [PATCH 4/4] sh/mm: Kconfig: Fix indentation
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
 <20220525124007.45328-5-juerg.haefliger@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <be49dcae-af31-c825-6ab4-05c59deec9d8@gmail.com>
Date:   Thu, 26 May 2022 11:13:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220525124007.45328-5-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 3:40 PM, Juerg Haefliger wrote:

> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that

   s/whitespaces/spaces/. And you don't touch the help text here...

> violate these rules.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
[...]

MBR, Sergey
