Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F556294C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGACyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiGACyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:54:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A455C9C8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:54:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so1075031plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=GLMQpIWkkm7sR/k0chK/u6zd+kQLtQ2ql+w+EaC3crs=;
        b=sH6eE+4YBsMDGwzfKMUcw2sdWOGSUtfi3WgeLD8CINpM+QAZsZNKUpY7bnmzbphq9Z
         0ob1HO5vlOPb+Kx0SqBHVIgK4Fr5kUtb3k71xI9TEG4o9Y7MCqceYbqlVh7FUcR5GB4f
         T5PVrG6WkRD2VWDkqGQ3q7EscEBsfOTlwXhbMw3LjO78wwNiGwM8/y6mbLqAaJr7upvA
         xvURof8t0I0WqYMCRTDfWpHB8gT6g3uWV+6XPanoIiQBynqhPMaL6/X2FrQMteh3YPeF
         /rti1PdrKrTcUeQlAs40YDqGqZa6zeXjCjzv6DDMGuVf4xHI8tjtD3Mr+G8aWHEcjw1g
         v3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GLMQpIWkkm7sR/k0chK/u6zd+kQLtQ2ql+w+EaC3crs=;
        b=8QP4PHMpEx6f78lvtE9p+WWO3aD7NkwmJ7wGrKVgFmjwtBReg7J6kKhse4IEbv3P9o
         nBvTud+zZPulRfZn9NEPtlbSHbvOZO4ltwGaCHLx51TH2RahYM2lzmCxadYFjeGxfUkh
         +6Wt2E7o9Xo4KCNUD9n5vI7APrHYoVifxLVHs1S4eetMmkeHx7zM/+ABBC7JCKipXJUH
         V1if8CsachgEGHCAVE+ubahbMmUirX7EGGfc2QrbawmhUuEIatM76tLgOSzGvjSqtSQr
         uNc0AthsD+NW3qnsvnTyclK3d0/EarL7USboFqcUm7fmLU7x+O42SnBObh0nnjTBMBUO
         2Wzg==
X-Gm-Message-State: AJIora94O1H7agzqApWjJNgCQJVUwTeL213/xgzmHpEV2yCOW6UdFLSP
        45ev2bacN6nhQw3XdXZ60V7EPA==
X-Google-Smtp-Source: AGRyM1s0OUFNbQK6YNX9w9TiO9NMraFJYAXIzZhtQSsThAo3DWvP+Jq5H/L6ob17WI93c0LpUwbkcw==
X-Received: by 2002:a17:902:d2d0:b0:16b:b955:9b46 with SMTP id n16-20020a170902d2d000b0016bb9559b46mr2902952plc.125.1656644046400;
        Thu, 30 Jun 2022 19:54:06 -0700 (PDT)
Received: from [10.4.63.220] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b0016a214e4afasm14317749plr.125.2022.06.30.19.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 19:54:05 -0700 (PDT)
Message-ID: <347d724a-c411-229f-7b13-a0cde1b2f518@bytedance.com>
Date:   Fri, 1 Jul 2022 10:54:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [External] Re: [PATCH v2 0/4] virtio-crypto: support ECDSA
 algorithm
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, berrange@redhat.com,
        pizhenwei@bytedance.com
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
 <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
 <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
 <Yr1TuPM8yvJUoV9r@gondor.apana.org.au>
 <CC761178-556D-44F6-9479-5151C69476C8@bytedance.com>
 <CACXcFmmxDVBrnp3_0UzN+VbAjDaUSNtoUBz5fM1Y4u5yqL89qA@mail.gmail.com>
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <CACXcFmmxDVBrnp3_0UzN+VbAjDaUSNtoUBz5fM1Y4u5yqL89qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/1/2022 7:12 AM, Sandy Harris wrote:
> On Thu, Jun 30, 2022 at 4:37 PM Lei He <helei.sig11@bytedance.com> wrote:
> 
>> I have explained above why we need a driver that supports ECDSA, ...
> 
> I do not think we do. There are some security concerns.
> https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm#Security

But since tls1.0, the ECDSA algorithm has been retained to the current 
1.3 version.
https://en.wikipedia.org/wiki/Transport_Layer_Security#Algorithms

Best regards,
Lei He
--
helei.sig11@bytedance.com

