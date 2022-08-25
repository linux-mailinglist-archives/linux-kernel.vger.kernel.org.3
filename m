Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569F5A078A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 05:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiHYDJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 23:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHYDI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 23:08:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B139D8E8;
        Wed, 24 Aug 2022 20:08:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm11so17346106plb.13;
        Wed, 24 Aug 2022 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rJV1X80qKRrJPMqZEvRGTgnK143O/UyyGVJH4c1rwxA=;
        b=mHjKmJzTk2b2+7RxJQnTfVbuPgrvBJxZsNyglPx62qD2HJd0whYEpwoO14G82UJNA2
         MgvUYb3JNAKy4puj30zLhcqRi2GcKQlSmm0Y5yksvDvQ0brxliQDwPexwbHXMcnKj5Ah
         JiI8t3x0rop0rVmpMM3REwu/NSWZPds6m5JtcH4qZ5IOSEhOb9+YxH641I610Czjar20
         IBwfTBQZZd/ONrxm8O3u0jP/hdQSCyfraN2WQxNwYzdExoYgiq9bD7O9aH3CpRc2fQyY
         dc+NDQytZdGaaGZAeBTeINGlc/Qf18EGze1MrsEkSb2kAa/4iecDdUS6s7BR9e3H46HN
         wSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rJV1X80qKRrJPMqZEvRGTgnK143O/UyyGVJH4c1rwxA=;
        b=D+0NCDvnwgwhqkMCGim4p3AmgkBqLL01bmzndXZuZFI0oaltO6qgAvlFxWju50tk2b
         CnlUxwVFFIqK3XUEtssq5WVX3vZ8MyW9hQvIEUZ0Zps8CdOu25U+qSAn5vD3XJIPwIod
         hDke7IAAJFnF5qFs6x7Col9b9bQ+SUZ1kWTZJGJjz6NPQr1xXqpz/6+EgW93mJjrTLxc
         v/ra9uc24PDr+PYybM7/nRRWAjT5psYQ9NjQnJp2FKkjs/KAlns3emI9L8o+dhAIG3ya
         ZF0WOUgffxlD0aIQ7qef1K2hMK2qNT+uQLRbB/zVMi+VvBM6Y9ZmrP36g+Gz5M3HTlHw
         iO/Q==
X-Gm-Message-State: ACgBeo3MID4FutA1bVmune0PbdPKY/aq13QGTlxD8AMcgoEq1keaCY25
        2k1EWDXZLD6+DxbcH+RLTH1vjeJ+PUwaIQ==
X-Google-Smtp-Source: AA6agR4mSOWTwBhztkPQhtTTNbsyw2XH2yDUCtmS2Zw8CB5DbTgx5BA+vNQGwNpgBC6DFcR87Irrcg==
X-Received: by 2002:a17:90b:3e86:b0:1f5:2b4f:7460 with SMTP id rj6-20020a17090b3e8600b001f52b4f7460mr11560796pjb.97.1661396937824;
        Wed, 24 Aug 2022 20:08:57 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b00172feb2bab8sm4856993plf.159.2022.08.24.20.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 20:08:57 -0700 (PDT)
Message-ID: <df8c22fb-878a-3d98-4a9d-9000b4a2ffa7@gmail.com>
Date:   Thu, 25 Aug 2022 10:08:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 15:08, Lukas Bulwahn wrote:
> The description in 2.Process.rst is just a description of recent kernel
> releases, it was last updated in the beginning of 2020, and can be
> revisited at any time on a regular basis, independent of changing the
> version number from 5 to 6. So, there is no need to update this document
> now when transitioning from 5.x to 6.x numbering.
> 
The drawback of having quick list of recent kernel releases in 2.Process.rst
is that the list can be quickly outdated with newer releases, unless the list
is updated for every upcoming merge window.

There are two options:

  1. Programmatically generate the list, using last 5 mainline releases
     from Linus's tree, or
  2. Simply point to kernel.org frontpage

CC'ing Tony (since he last updated the list) and Randy Dunlap for suggestion.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
