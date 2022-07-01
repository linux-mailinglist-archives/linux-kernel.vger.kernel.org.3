Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26546562783
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiGAAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiGAAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:00:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986425A2FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z191so773914iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PAlUtN7SL9XFXUbrECixMis635HqzUUk73c0sMI7wYQ=;
        b=DfCQu91v2qJm2MCzhcjWTkOT0huxiIQlwiVZG5YzaTebf7Tsp0l6inrI7eLwxnLfcp
         JlzvwikYppEaqvHZ8OOKoLOWlA48NEpZU1qT350aXgMNMAFcKQvJfm7Vsp8vgzUsVNdq
         0A0/687El+GnlHIf6Kt3F4csRQPHJQcE3kIwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAlUtN7SL9XFXUbrECixMis635HqzUUk73c0sMI7wYQ=;
        b=pgKp4Hv5k63bKUk37uPeQFllfNllGWitXo8iy2+GAlidUd2a9ooqk7wJ7Fn+DEMuEl
         Zd5lAmJzRVZwUqqIQFn5QmgVHRWddg7m9bxvXUKQsj8qMGhsHqRPHHYYVwsMvCvqyTbu
         W1kpbJfrBvptuDyG99ybdMJypzEuY3FHxff1jN1b1vPPj/unEUALffrGYz8sVlWw/kjA
         HiAhtFU6R7/feDm+YpeB3bZpxgOWs6GPCVoRW4CoqySInMlmghii2eDrpdYSfOaNjQzP
         tlydWN5463WNi4b50dVe677xcGHCrfUp+WVxpG8KQ7JK+9G9saA+AnpxhCFeRtwok0y3
         sRog==
X-Gm-Message-State: AJIora+GNJyZ+sPoLAJA+m8zYyZ/ZC9wR8Y5Z+jYCgS5QTgxymuDog7N
        dKSJnlQuqEEkOu2WcHNCbjO4wQ==
X-Google-Smtp-Source: AGRyM1uSw8B+vZBkRjINHHYqtDGj7eh6OecWI5/rZOo1JZbRK/1RZMWA/BuiiXZfsp/eTd53J4KbaQ==
X-Received: by 2002:a5d:890d:0:b0:668:afd6:5477 with SMTP id b13-20020a5d890d000000b00668afd65477mr6274571ion.195.1656633628037;
        Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k6-20020a02cb46000000b00331743a983asm7798694jap.179.2022.06.30.17.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 17:00:27 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
To:     Siddh Raman Pant <code@siddh.me>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220628064621.14427-1-code@siddh.me>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <390aca1b-3b48-e0c1-07a1-ec8c29f0b8af@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 18:00:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220628064621.14427-1-code@siddh.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 12:46 AM, Siddh Raman Pant wrote:
> This adds the maintainers' information for the
> s390 ChaCha20 self-test module.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf141501..0fcacd715b1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17438,6 +17438,14 @@ F:	Documentation/s390/
>   F:	arch/s390/
>   F:	drivers/s390/
>   
> +S390 CHACHA20 SELFTEST
> +M:	Vladis Dronov <vdronov@redhat.com>
> +M:	Herbert Xu <herbert@gondor.apana.org.au>
> +R:	Harald Freudenberger <freude@linux.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +S:	Supported
> +F:	tools/testing/crypto/chacha20-s390/
> +
>   S390 COMMON I/O LAYER
>   M:	Vineeth Vijayan <vneethv@linux.ibm.com>
>   M:	Peter Oberparleiter <oberpar@linux.ibm.com>
> 

Doesn't look like you cc'ed the maintainers - please do and resend.

thanks,
-- Shuah
