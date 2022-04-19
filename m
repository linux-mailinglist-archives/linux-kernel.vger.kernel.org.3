Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2B507904
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353154AbiDSSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357689AbiDSSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733561F60C;
        Tue, 19 Apr 2022 11:33:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2747662pjj.3;
        Tue, 19 Apr 2022 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CKt7NnL2WCnYF3IJkaP6ANmOKulqn9UJ42AVdgrbYZM=;
        b=ELQufKHWhcQ7POnzX5e2nsQYuOrNbCdzc4rlKefQO1wspKrz9BRzgKAtklOBFDuWHg
         gKQLR1L38bDUzbqpEsJ/851NmgDP/C0XkUCBCutyErpI+ILrrYdHSKU35BLxuHBZe4n5
         eIN+6QZk5flzABfB5OBaOJnnc6daZRDC8pEkQJkob4JzIQVdzoxtaMjYx1cj/B0oceV0
         BQQZ7QH2uv1gJ14izA68jXC/CXq5elJJfEOsSk8u2+rlUVUVpp/nKxWqLvLIJpkhLs2E
         fB5X5ZS68dHa1kVGjH+z3pYEcwYPYy2XhL2odWjd52sjnjAyGOTgVlsECW3ZxpHnSaEG
         VahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CKt7NnL2WCnYF3IJkaP6ANmOKulqn9UJ42AVdgrbYZM=;
        b=7q1FXZuonjhckfRfick1gGNHHWtl/vHcQ5a/p/StiUtLbloZBrkYcz/fzq6JiXxx6o
         IDmiJroUEnYGIP/430k5xvvkJyK1Zy/oz/cDUZqcyulsNa6QdGII9euhD+cISUVjDAq6
         30ezZV44ojXicXcoojze6hoHO3P4lo4vMHMMw2twqRYSN4aV3kEo+IgWNGOYN/idqZDO
         hubMwlqPl/wtfChTKAtAeJLFHV69pqo5c4ldDR3wxPDFFD+lMVL4IsAvDaApdJnAnja8
         gv62S7LuSQ0nNXUOvec8TqpoW/DsKNzsLrIqXNYKkQvemgx+jaBHV2VWk6yvs098SloX
         LDAA==
X-Gm-Message-State: AOAM531E5sch/D8sd/NpG3Jr0I67fHv/25q9i3TNXW/r/YZRJBrZoGGO
        uNBPUAuX0BwxKKJ+Eezh1mY=
X-Google-Smtp-Source: ABdhPJyK+JBVMlycoxvLkKXqa1o8rQ1mr2VI/izO1bCtrLEYx5oYkb8TO/1X3t5D1i0FmVRl8mgDRw==
X-Received: by 2002:a17:90a:1b02:b0:1cb:a256:c0a7 with SMTP id q2-20020a17090a1b0200b001cba256c0a7mr19733587pjq.185.1650393229989;
        Tue, 19 Apr 2022 11:33:49 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b005048eef5827sm17963074pff.142.2022.04.19.11.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 11:33:49 -0700 (PDT)
Message-ID: <f8d78967-8842-57de-9464-4e281de2e7d7@gmail.com>
Date:   Tue, 19 Apr 2022 11:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] soc: bcm: Check for NULL return of devm_kzalloc()
Content-Language: en-US
To:     QintaoShen <unSimple1993@163.com>, f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 1:35 AM, QintaoShen wrote:
> As the potential failuer of allocation, devm_kzalloc() may return NULL.
> Then the 'pd->pmb' and the follow lines of code may bring null pointer dereference.
> 
> Therefore, it is better to check the return value of devm_kzalloc() to avoid this confusion.
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, 
thanks!

I modified your patch to have a Fixes: tag as replied, and follow 
Sergey's style recommendation.
-- 
Florian
