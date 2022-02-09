Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8C4AF711
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiBIQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiBIQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80C03C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644425066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KaPxvUPz73vOAGz6EpqAVnHUMksefzUrg4OPSPo/82E=;
        b=EO5+ml0wGH+2oUb7ToKNMCPM5zT7DGq22SZFRsJtoED5ylMJsCMUl+ycCItPVr/x11RE8W
        IOkZoAV7R83kYVwHrm1VnqUoQOEfcmdp6c8120FJo6PrjokkQDdQzzzFbJNqNqQHkpfaHN
        8MKMzdd1Q4vXqeILMiYQvYX0EF68mz0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-fc1Rizk8O7mJTR8XlA1Nwg-1; Wed, 09 Feb 2022 11:44:25 -0500
X-MC-Unique: fc1Rizk8O7mJTR8XlA1Nwg-1
Received: by mail-qt1-f200.google.com with SMTP id h5-20020ac87765000000b002cff8751c63so2170457qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KaPxvUPz73vOAGz6EpqAVnHUMksefzUrg4OPSPo/82E=;
        b=qk4FC9BDtByoSwwExhA/Q2aUr3F3djSQ3rY0pQbAJgjJLwbMWI1JJmnd5TXKjrZ6Qb
         +P+NLnSj5SgPAEFBdtRyDHaqIzDWb4b+AXT2PjdpRrZ2o8eyWDhq4DDpt3lWLqpiyYXS
         cjxiMs59Jvrboa6y0Ct3MXkp/WLqfKCoTi3zTtCaqSslFjvdlovAYb1rICOrFSrw3bQJ
         AMf7y3rhoFCUXbmnj5XODshi0WfBkeYDVHXibo6vToId4V0VO5h6FP8Mma53oB4cIhkE
         f2rYb7+jNcNi/sA6I7RarfEWOVmZsVTLWSQOb0oMtKhF67OtPTFkvb+X2Y9O+1WBHSh5
         255A==
X-Gm-Message-State: AOAM5311IP+0i9hVy+4kjnyy92u2aLAz0IgKFghqLUSE3DonAdKpmlmQ
        v8klNoSrftXTbm/SXRFiqPkNBTZuFeR3Nx5NOQjYgUG2wYRpC+kF2SRr/GftWdURaVTHSTdK2Jv
        JaQ52h4mrW9g5j60mkM1H7HuS
X-Received: by 2002:ad4:5f8a:: with SMTP id jp10mr2065522qvb.14.1644425065009;
        Wed, 09 Feb 2022 08:44:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybkvzBKSgzu3wGFvXoOyk0MMma2dAefl2ZmvFzuoL1BtcD2RSBS5I5yrk8+S9FDrmA/r6VMQ==
X-Received: by 2002:ad4:5f8a:: with SMTP id jp10mr2065512qvb.14.1644425064775;
        Wed, 09 Feb 2022 08:44:24 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q15sm8760820qti.41.2022.02.09.08.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:44:24 -0800 (PST)
Subject: Re: [PATCH] spi: initialize ret variable
To:     Mark Brown <broonie@kernel.org>
Cc:     lhjeff911@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220209163029.2299009-1-trix@redhat.com>
 <YgPs8U85ZFbDWYlx@sirena.org.uk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <61a545d5-224d-86fb-2fe3-406c3ffd78fb@redhat.com>
Date:   Wed, 9 Feb 2022 08:44:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YgPs8U85ZFbDWYlx@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/22 8:33 AM, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 08:30:29AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang build fails with
>> spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
>>    uninitialized whenever switch default is taken
>>          default:
>>          ^~~~~~~
>>
>> Restore initializing ret.
> Are you sure this is a good fix and that the compiler hasn't instead
> identifed that we should be returning an error in the default case?

If setting mode to idle is not really a valid state, then default should 
return an error.

The old behavior returned 0 and I am treating this as a regression.

Tom

