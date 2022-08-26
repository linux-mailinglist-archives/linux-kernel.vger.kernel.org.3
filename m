Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD75A28A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiHZNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344346AbiHZNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:33:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082CDC5D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:33:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r141so1160575iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bm4tNFuy7lSf2+m8K3Mk3PHBL0KBtw2bz6p4BIebiH8=;
        b=4rmQtelHxrXF2TehFEJmJDM3lHeF+2qSetwNFnF/P/zC3gHySXd3t2+mS4RMBRfqp+
         BlNfWSXG8ipBdGO6V0gMY4TG464nywtsNx/nJ+FsktyVWv+hUq7pmk7L2OtYDd6iud3j
         fInjKY9s3mR/Rvjo50SCrkVzHVyXOyAmjukKyvKeEacg8EEsIEHsFfvDhTJnRvDe+K+G
         S5QNrXosnVYg47XJHVQcMJzP4aOo2d37N7k/bmFcwackGUw7RwAwIEgagWqoSRffZoVc
         GiG/YEfLr4fzrIT8uVdM0y+DXMG0FVdcKehgU+wWzrOO0Wl49QKNuNk1fqYPWCdCb41t
         xcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bm4tNFuy7lSf2+m8K3Mk3PHBL0KBtw2bz6p4BIebiH8=;
        b=Wt+kMyggurHvDswuouiepLwHupo+fqBmjsUwzrJkK6HJIt3ukF+cJ1RCpt7OrdyjUM
         OzdUa3D7ItAdy7lzu9yuAqbXEdmy2fD6gzfq2neiVauSgkRjWA3M7yQ7Zz9+fLcpxv0e
         V1NmjmfsEgGvhTDA4Yn8ZF7tWUQC0DzF6xM9LDGNW6K3mxceztPyS0eJhC8BaiMNOuUc
         QY+vVO7XeUBW90wNFNUFPpN3slfTWSTHoubKVrPEfpyHjU1ke+h9CrIDpDMSE2yU+Wlz
         6Dd58BTfQbnkVI7kBFRWzxFs4eR4ilIEZJCBGdrSIB2uriR3iNu1n5xEZ/DAXubJB5PN
         bE2w==
X-Gm-Message-State: ACgBeo3p0ZmYe3aGxEvdzTKbfA1nBVnaWjLU6r0TfJqna11NWiFV6uNl
        SUIOyUlxWvC6YlGFr8JWBFSXWg==
X-Google-Smtp-Source: AA6agR7F0eMxPcgqhP1YNe+QE43HU/WkX+NniCKip1RcGWHW3S3Wl/CWmsLIO535/YTQCkewOgiTeQ==
X-Received: by 2002:a02:cb5b:0:b0:341:aebb:d13 with SMTP id k27-20020a02cb5b000000b00341aebb0d13mr4010731jap.176.1661520813508;
        Fri, 26 Aug 2022 06:33:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v12-20020a02b08c000000b0034338e975b3sm927694jah.50.2022.08.26.06.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:33:32 -0700 (PDT)
Message-ID: <4fff9af8-90c3-86f9-37c7-75dcd3e95dc0@kernel.dk>
Date:   Fri, 26 Aug 2022 07:33:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] blk-mq: determine in advance whether batch alloc can be
 performed
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 7:26 PM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Some conditions for judging whether batch alloc can be performed are
> included in "blk_mq_get_tags", and this function is only used by
> "__blk_mq_alloc_requests_batch".
> 
> This patch introduced a helper "can_do_batch_alloc" to prepend the
> judgment condition and avoid unnecessary function calls.

Curious if you saw any differences from this? Or do you just consider
it a cleanup?

-- 
Jens Axboe


