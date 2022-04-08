Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30D94F9BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiDHRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiDHRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:43:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941690FC3;
        Fri,  8 Apr 2022 10:40:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b19so5390228qkk.12;
        Fri, 08 Apr 2022 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEGMMSoqzQV29Yb3vuyxXwWYzXUyMcWqjEt/8PwjhP4=;
        b=f5+kjuwksQh4ROVlTCgr6Bmrfuh7tv7d2sKBntQaNA9RkEEG/8YHNYJS8Lm3GaAKLY
         6wiVB3nqxEc8RbW6j+ID+7Yg3t/yvgZSEZ4R3D8Bt7rlKw6khDqNF62CGtWSYv3EsoZ5
         3JTkkN1Nil0CUHRORoOWuBcWsowiQTlEiM18fOEOvijFXgSVbAnQVgny63DENrr8gyic
         LZhYITb1UhHZsijwT+h8De5Ur9GSKjlTeynpZdblz186EU5fDuv+IHnfXHyTrtg0m9Rt
         NhgW4DzGPdP5EEStA/ZyOVWilT+cYDIGy96rU4Yq7PY4AJ72cI9ZwohsK4kgn6s4wkVs
         GKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEGMMSoqzQV29Yb3vuyxXwWYzXUyMcWqjEt/8PwjhP4=;
        b=vU2s3vgiveMFdxRRoajOMel5tmtox9AjEi0prK+pL38f6DcTWlRxXj5fp1zQ8iOSec
         B0i2IOadn/r1Eg+DvxRz/Tl6FY8NUuC6BL8fwbQaUr/ssl6Pll4L3ECX9zKVATS/cb5n
         La7nxEPBxPJ3CNkTr2kR4Qv0KIA9cY5NE1Cwzo176Yot3xDGzZ+aEnSzOFrSfyJrvTDh
         jANlpV9IaTjQDWgGvpm7lxn8Xd6OFrgfcseIZCGlIC1wF1Mm4TZUVgMm/wf8zBnru1EW
         1TTJqFGaYZa0jGs7Uq5sCrXrYekBJZav2aBwFSyC3KOqxpGwSSNbQTd/iMOsZkDk+6cY
         r+KQ==
X-Gm-Message-State: AOAM530+PWfllESFvAz7ne7JrOw8l3b4y+muR0UVaMmDwykxLLaQWrGF
        iuoGYUS/xJMhT7LGm1PJDqu8a9vAbDY=
X-Google-Smtp-Source: ABdhPJyGWb1/E9mWepAzuuHv95UgS5bl6t4bSWTiiNmVXIifF60fF07UXLQHxTRzwcOEoHEyfASS3Q==
X-Received: by 2002:a37:554:0:b0:69b:ef36:cd6f with SMTP id 81-20020a370554000000b0069bef36cd6fmr1454823qkf.129.1649439657667;
        Fri, 08 Apr 2022 10:40:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:6d2d:3351:3e49:3378? ([2600:1700:2442:6db0:6d2d:3351:3e49:3378])
        by smtp.gmail.com with ESMTPSA id h186-20020a376cc3000000b00699c789a757sm9336207qkc.132.2022.04.08.10.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 10:40:57 -0700 (PDT)
Message-ID: <1ed7ea01-b515-7c0b-4b3e-547d19717deb@gmail.com>
Date:   Fri, 8 Apr 2022 12:40:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] of: overlay: of_overlay_apply() kfree() errors
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
References: <20220408172103.371637-1-frowand.list@gmail.com>
 <CAL_JsqJC6pKxEmwMeirVLwJEbOH0WD+01VEfFXC257a+ZDRtsw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqJC6pKxEmwMeirVLwJEbOH0WD+01VEfFXC257a+ZDRtsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 12:34, Rob Herring wrote:
> On Fri, Apr 8, 2022 at 12:21 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
> 
> The subject needs a verb.
> 
>>
>> Fix various kfree() issues related to of_overlay_apply().
>>   - Double kfree() of fdt and tree when init_overlay_changeset()
>>     returns an error.
>>   - free_overlay_changeset() free of the root of the unflattened
>>     overlay (variable tree) instead of the memory that contains
>>     the unflattened overlay.
>>   - Move similar kfree()s from multiple error locations to a
>>     common error path (err_free_tree_unlocked:).
> 
> What about my question/suggestion on the original patch from Slawomir?
> 

I lost track of your email while investigating the problem.  I'll go
back and look at your suggestion and question.

-Frank
