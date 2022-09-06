Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8654E5AF81C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIFWsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFWsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:48:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1998D2F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:48:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nc14so26469104ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=c0YMp7uUNJ8VX80tzikEyZ18fVbZxRq+/0RRSygWun0=;
        b=i2xifLi81jQUR6j2eM6J5pMZzoLSXSSQCTE9cSVu7548RZTviW1YOQaTkmMBxJzXCK
         l5q3ZQrfkq2Wfo0BMEMSjVDpGcEdHIOc9qOkyus87LNdtMsTAmjppY2fN5clAZWU8K0c
         2c4rXSkp4HjI9ESQL8A/Dvi60qywFAt4LYdJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c0YMp7uUNJ8VX80tzikEyZ18fVbZxRq+/0RRSygWun0=;
        b=BwX+zlT+YAV4Cp/tDhNJe9rKaCWWU79oaTGsHlxEfp8L3TQLbYjSDJgTc/6jhmzURN
         KkndFuzk1Wq6KiMDwx7VWs+sFuQM9iN4IZhaP2tWcR3gBUfgMsUYxZ+KaKE6bUKdexgA
         hUSzo7UrLevz+KNd4Y7tYCZLGczIbFMznO6tJU7nuDiEYHzgHyOcnB1j/k3FK0jbCPlI
         HFYz+5JybLv8HPp6J+gzBfLMtPbXOBoP/FGQQJVkjEhq9j6JTfnnzjg0JnVUO4MXas3H
         45JGaoNcf2M9h095ysxOqfH0VUT7CRNGvpbL45MpSYaBtC/9WaSRHNaa+66/GJ3QfR0i
         PhhA==
X-Gm-Message-State: ACgBeo091dJIcDPZ2WH7Gi526JdD/c/kOy3NeEwFvBOshVm3u+M/cdvm
        qwMbtL4FjU+U+BfPi4lrGvANNTRrNVhMPDrU
X-Google-Smtp-Source: AA6agR4/bGq4Zko4QWr22bYG/tancogTIxOOIdX5lMEmAY2IBguPqjIJyBUoRHSrpmArlgY/6wJqeQ==
X-Received: by 2002:a17:907:96a2:b0:741:4bf7:ec18 with SMTP id hd34-20020a17090796a200b007414bf7ec18mr429534ejc.95.1662504486551;
        Tue, 06 Sep 2022 15:48:06 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id ed3-20020a056402294300b0044f02c3d3bdsm543967edb.32.2022.09.06.15.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:48:05 -0700 (PDT)
Message-ID: <c8023c22-d3a1-f7de-0d86-0f06c60bc165@rasmusvillemoes.dk>
Date:   Wed, 7 Sep 2022 00:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type()
 macro
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
 <d2399574-ec64-7765-b6ef-1e792a7e0d5c@rasmusvillemoes.dk>
 <481c1c85-3af8-da6f-b532-598a004b102d@acm.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <481c1c85-3af8-da6f-b532-598a004b102d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 00.42, Bart Van Assche wrote:

> Since I would like to implement the above suggestion I tried to look up
> other uses of the __UNSIGNED_CHAR__ macro. However, I couldn't find any.
> Did I perhaps do something wrong?
>  $ git grep -w __UNSIGNED_CHAR__ origin/master | wc
>       0       0       0

No, sorry, I did. It's __CHAR_UNSIGNED__ . Here's the description from
'info cpp':

'__CHAR_UNSIGNED__'
     GCC defines this macro if and only if the data type 'char' is
     unsigned on the target machine.

Rasmus
