Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A04E3F11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiCVNDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiCVNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:03:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4145985BC0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:02:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e5so3615312pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/XbYmdchGb4htIgyglLZmtK2Rqo0eR5QKNfFg2mxH8=;
        b=TFPNMS9qTjP0AvWCDwmzNwq5vcwJPaA9h+ATwVKFM9eUj0XaV5kZt2be9vvjr4LGcQ
         DF5xrzSXGINDeq14lyZrHGCW8S7YkcTNTSr4BTKMuvI/0DQN9sggYqY7QC0T3vJNee86
         lKyKPsZvmARNTeDT5O6qAdS885M1wtzNEfZkVL5/05KB0rzbD4/1ZYF6vrwRBjZGA1J1
         4ltnMBsV+AGjQneA8ux95gebwUKY0d4oUO7LSXYPTYXs5hro22X60OZKR1uUn1A+dRwN
         8919m/tDL8B1cCrGkq5V2oYWIB8EIhCuGXyypwNES9wUiaSmpjCCPmdAvY5mwrkWDvgy
         4/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/XbYmdchGb4htIgyglLZmtK2Rqo0eR5QKNfFg2mxH8=;
        b=hX0ijcDyZeN+hehsdLtVNGyr33azKx2u5YYFu9qDbmtotLEN/bqTxJKkKWKbE25Lg1
         mgIVhjXmU6ZDJlLnw8x9+ifwZFh5o6rJopVFXbStJ8yEYqNYVc4u+hWrqPcRss2mnY6d
         dsMjN/Iwh4oxXc+B5hd27lTBIRr05XFDsg0TJNzdJmgeBSG/tHRMV/SXq03rueufFYiv
         UGT1aGUvyYjf/Zmwbnz0YssZqWXauGlHwtUqbMFrKvh8vCd1AuXVzSHi5Z07MBaf2tB6
         lR68i2uFCoc/o6Mqc6w9ZQ7q7qcMUHcSUbU3unn+zY7WwoQ3Ja6XYhmGNKUOugbssbZ7
         Q2HQ==
X-Gm-Message-State: AOAM531p61IXgQXcGe/ioVc7+dzZF97ZW6T8qZx1+YOZIzkzF9OKurtK
        PLONRYc/JpdTPG1wlbj/QX9duA==
X-Google-Smtp-Source: ABdhPJwFI/IRn1/8u+uFGz/5nbAX4iuEA+B9DgJePrej8zIN1Ok43G5ao3329yIy/Ob6/yjwYYmSig==
X-Received: by 2002:a17:90a:628b:b0:1c6:a410:d73f with SMTP id d11-20020a17090a628b00b001c6a410d73fmr5051550pjj.96.1647954142569;
        Tue, 22 Mar 2022 06:02:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm2618177pfj.151.2022.03.22.06.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:02:22 -0700 (PDT)
Message-ID: <650655da-e719-4e48-5dc5-2e6529674f65@kernel.dk>
Date:   Tue, 22 Mar 2022 07:02:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: crypto: crc64-rocksoft-generic test failed (wrong result) on test
 vector 0
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        herbert@gondor.apana.org.au, kbusch@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YjmeVttXDd/FPwUP@Red>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjmeVttXDd/FPwUP@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 4:00 AM, Corentin Labbe wrote:
> Hello
> 
> Booting an arm64_defconfig with BigEndian lead to:
> alg: shash: crc64-rocksoft-generic test failed (wrong result) on test vector 0, cfg=\"init+update+final aligned buffer\"
> 
> Reproductible on the virt qemu machine.
> 
> Furthermore, none of crc64 files have clear MAINTAINERS entry.

Keith, can you send in your BE fix? The commit is upstream now.

-- 
Jens Axboe

