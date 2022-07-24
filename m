Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BE57F64A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiGXSUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGXSU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:20:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727DD6563
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:20:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x91so11485458ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uI1N6WkK/h63C9rbKNyx+SGUibFjnftNpfGsKc2oH1Q=;
        b=XXkwpGt5kj6PscZBJ5obVoPrx6Khm099P26pavsm+5SvelQcnuyTe2TOSdGaIa6rw0
         2IoTEh1HkDAg9Nv5oUwTUAeO25qChm/gvwWOhj5MYG8rgigGAF7GbOo72tXHD+iTNHvW
         w03e5o1awpe9Nu3m0g3IajFFqLPTHJDK9mxMixpJzl4Rflj1OQ600FPtSZtIl5Ikrr+W
         lo+lSiqwZxuWy3jd9siVlab4Q5n4lqaB5JCH2ORV3THW9rnoSzsVlEPRxKC0Y2EX0gss
         L/qktS64GKASTr/Y+pAU/n52ebNLru2WMqKWVybvA9ARj4cLZEcbWFnIkUDDpl9cVEn5
         eJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uI1N6WkK/h63C9rbKNyx+SGUibFjnftNpfGsKc2oH1Q=;
        b=IEtR3VuowD9DvXRnlAI3edZPZwR+Cl53lQTS9+twbcJku+aEVt+UJuKJULeTcuqZih
         1OphzSxQ0eURb3CwBBihCbRSZtq/lxKYmTjRjVD+m+sLZVbWPxqcdEtgttrLwDdjqBN+
         WqFRIwR6cLdkseyCDy2LdUPIT3JdXWIjGDkweyXHg8DgjzCLGLxzZ/ILT3I17T/LdxBA
         ll1xFot+LQDwaykbLrj6nppGMnrOf6Kazb2/8aibIzxVIabuTdAshndlRtRaO2S/nxCK
         wn4wt6iH4siWOfihHPc+5uDce+RSnd4yy0GG58rYiMn8G/W24XIS5PwE/Fu00ko7uwUA
         DwdQ==
X-Gm-Message-State: AJIora/RACv82+rKEF8CbeI6f10MLTFFIVXdX4e5LNWCGTGaMQxNh6b+
        yjcMckbxvDU0/m3h2CaSwn3v1p0Y+Ic=
X-Google-Smtp-Source: AGRyM1uhS3lZc04a86/lX8TdJ9u8aqBpF7GFqNmQt+8e0DoCpX1UTzgQD3N0PptBdINUUSroom56Mw==
X-Received: by 2002:a05:6402:3217:b0:43b:dee8:4cb6 with SMTP id g23-20020a056402321700b0043bdee84cb6mr8378680eda.157.1658686823971;
        Sun, 24 Jul 2022 11:20:23 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o22-20020a1709061b1600b0072b14836087sm4419955ejg.103.2022.07.24.11.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:20:23 -0700 (PDT)
Message-ID: <03a784f3-660d-60ba-e921-03f676b95fcc@gmail.com>
Date:   Sun, 24 Jul 2022 20:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: remove two unused function
 prototypes
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220724153349.138741-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220724153349.138741-1-martin@kaiser.cx>
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

On 7/24/22 17:33, Martin Kaiser wrote:
> I forgot to remove the prototypes of OnAtim and DoReserved when those
> functions were removed. Here's two patches to fix this.
> 
> Martin Kaiser (2):
>    staging: r8188eu: remove OnAtim prototype
>    staging: r8188eu: remove DoReserved prototype
> 
>   drivers/staging/r8188eu/include/rtw_mlme_ext.h | 4 ----
>   1 file changed, 4 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
