Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207058B790
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiHFSSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiHFSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:18:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1049E0C5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:18:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so9974692ejp.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=t5qohv5RDM5IrZrS6+vN/4UZNFBJ+KbvGjNAvkYlMZM=;
        b=QqUhfCZiFq1pEUjhiiEQu10NBEvel+df4K9NXFIv4SvAb9aRLf+oheLkWCK1gcgiDx
         deZ+w7KPnF5esGravY1WQ3Mj9AQATgJIhSp9ZNAUjripJOHCqNruXuMUo+Z5L3aGwcTL
         K/Z2yGYEmMTxq+rcjIfTtCrRCgGowr3C2UpG7Ylr8k4nqHA1s0DT6qLkra2F65Qx/Ccx
         7iGkKG9dztXQmcTYNJ7Kcnt/8Sy1elYQB7C8jOVJ6RVVp/Zjh1QF8XhCHtsmyKcGn8r6
         SdaF0beT/wlvNbWHVcKHxWs3OZGdC5RWpje1PI6n2sk/5RGhrrZj6aJgDj+2BEc7cdMp
         0ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t5qohv5RDM5IrZrS6+vN/4UZNFBJ+KbvGjNAvkYlMZM=;
        b=J0QTHWFXx3CPONySjbEbhSY40jszshKODm5PEp5Zo8ehQC+pQz00uViSI8ns291i0N
         ebbUJk9Lpm4ij6oDJZSk7goBEW4kTfc2wgn/KYV2d97p9fCNDRarqltIWkafJRRYIU3b
         /BQiWqD+ts79QYTg+PE88tuvxrvCRw3DOq+RKRnbX7SH9Pw7s8Ba7jKdalhO8++ojkr+
         nxaop8hoA9f+mK3rKBVNpGHSeq1e1IZ+8W2EDLEPGbaTj9XWWOPXF/lmGdABqKUmA8xX
         e1YAI/fkCsy0BnBi+Dkpv3K0q2WRpqJCqorhuGUvL5dkRb+5IlRUUEyp8zEqwqM3gJoc
         2sIQ==
X-Gm-Message-State: ACgBeo3JyCnLsYc9qsLYn0JOz5rOC8hyHAv7NMEsPiU1Q7U6c/waliFw
        fJ5tg872ov8MNoBsRdpxVu4=
X-Google-Smtp-Source: AA6agR6DG9Y9PndiMwSz2LwYF4lRS533IFujIRkczri4muyYnCSwS1I4DE9J+rcDIoi50tPASmFiVw==
X-Received: by 2002:a17:907:2e01:b0:730:9ecc:cd28 with SMTP id ig1-20020a1709072e0100b007309ecccd28mr8843994ejc.360.1659809914545;
        Sat, 06 Aug 2022 11:18:34 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0073100dfa7b0sm1939376ejo.8.2022.08.06.11.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 11:18:34 -0700 (PDT)
Message-ID: <1a16a42e-4680-fc4f-8902-f15b1c39aba8@gmail.com>
Date:   Sat, 6 Aug 2022 20:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: clean up phy_CalculateBitShift()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220806060929.11022-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220806060929.11022-1-straube.linux@gmail.com>
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

On 8/6/22 08:09, Michael Straube wrote:
> This series simplifies the function phy_CalculateBitShift() and
> cleans up coding style issues in that function.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (3):
>    staging: r8188eu: use ffs() in phy_CalculateBitShift()
>    staging: r8188eu: avoid camel case in phy_CalculateBitShift()
>    staging: r8188eu: clean up comment for phy_calculate_bit_shift()
> 
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 30 +++++--------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
