Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3A578E68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiGRXm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiGRXmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:42:55 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02031902;
        Mon, 18 Jul 2022 16:42:54 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h145so10591887iof.9;
        Mon, 18 Jul 2022 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dLd8cOvv8HoVPf9Qd5agJOJR3BAYQw3KP1yEY5GxLrY=;
        b=ftUYo9BBUYjPmllV0QRe7t51MrZmLBWSJeD7F/faBJfJeEgvajx4yrs1xFF2bFN2In
         Sx9WchAnZHDlTxzt5GeXl5XNKQ4zxA9If1Lgz40WbWeEaboWSCRSXil77S2+pat/yDtU
         u3DQY7P9l4TcmQVBCru3FBj6LEE4iT2GYNgATMs6F6vPEBu/D2YzTllow2Mko17P48Lr
         j0EBqg4Om/QSWJJ4G01BxpfNnx6KLm4oSh8g/gHELZzyL+CKFLxmeq+JHxS5nT/Ovj4y
         VrbGj7u2X/sK9rZmd89AJv2s6krS1uxysr5+E7bxvSsCYvZBWogVUy/qu183eVy4s/Kh
         qcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dLd8cOvv8HoVPf9Qd5agJOJR3BAYQw3KP1yEY5GxLrY=;
        b=MV7t0ileUEmkUJrebdbeGa7fX+hMK/6w+aps1EIyfgWOUfix2lGnavnuX0Cv1gMlOD
         kWyZql5iy+DGyIzVA9SFqvD5FK1M4lB9vy0/fYRR1i/dr7pyx4QufK7yEHQ+gX49B3+/
         vLXIT2FbVw1Qty2P1/nva/v5DLMoq5pAQ/afqEWljaM0OeoAPvSqCtpdMxrXQNyiabUM
         orT+ztHc97Zttx3Crtd3RVq199fnDUR9b5U3jiG9ngiqlEDIr0H0+kurud2Qs/77w9CB
         ManMhfCvdVCQgmGLS6updXWjxZaHxvza5LJ01G4q1NrPsdhUwROUKyxvODigrPrBMR60
         ExiQ==
X-Gm-Message-State: AJIora/V3qV5HT4H6iNx6Dganj1BqcdIcXj3+eo+gm/9TEnPiYJvYjrU
        tada3ihStTcPQfnsVf78XuTpYFFJ9WyVyw==
X-Google-Smtp-Source: AGRyM1srhjBnWDzudsBq1Jm399+BkmywIX129CiWpjDmta8FzdwBdycuNdqBt+rw/UgVPr50G5N1oQ==
X-Received: by 2002:a05:6602:1644:b0:678:8ba4:8df6 with SMTP id y4-20020a056602164400b006788ba48df6mr13933049iow.138.1658187774092;
        Mon, 18 Jul 2022 16:42:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:71f7:9f7:a010:d581? ([2600:1700:2442:6db0:71f7:9f7:a010:d581])
        by smtp.gmail.com with ESMTPSA id e12-20020a02860c000000b0032e21876ea8sm6042489jai.72.2022.07.18.16.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:42:53 -0700 (PDT)
Message-ID: <d9f2ec3f-d531-80ef-d9cc-0926893d892f@gmail.com>
Date:   Mon, 18 Jul 2022 18:42:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] of: overlay: Miscellaneous improvements
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657893306.git.geert+renesas@glider.be>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <cover.1657893306.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
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

On 7/15/22 09:03, Geert Uytterhoeven wrote:
> 	Hi,
> 
> While performing the long-overdue rebase of my topic/overlays branch[1]
> on top of the overlay rework in v5.19-rc1, I identified a few areas for
> improvement in the upstream code.
> 
> Thanks for your comments!
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/overlays
> 
> Geert Uytterhoeven (2):
>   of: overlay: Move devicetree_corrupt() check up
>   of: overlay: Simplify of_overlay_fdt_apply() tail
> 
>  drivers/of/overlay.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 

The patches look good, based on a visual inspection.  I'll build the kernel
and test the patches tomorrow morning.

-Frank
