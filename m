Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510D652EB69
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbiETMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348889AbiETMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:01:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6347064
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:01:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso4680441wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=aReDt6m4gVAVUxMzJOmKMPn9OCQ70XcueNdXu8Sl300=;
        b=B4sbnW5R8jskpYKSZolpRLBvgR5YbCEV1yar+tBSXcHmTyRGmVKYQNz1XNfZlI8lF/
         d4anv8dqBilyw2/dB8cgswF1+Z3Aby4QVMJTOyuqEyX1CEyUtuNt514uxgZ29g+8GdG+
         7YcrI3rPS+M1OB59AEjzXiud48+ZWWfA2wau+PgJX5cT74X+Wp/QQqHJWRkdfQeheBlY
         bFk/jxrQioI69tzLIYlM96VKtCXCqKaiR/aJ/JcdiR2/WJHEJ2iXUMY2M4ADXJgKDoqK
         vUGOSBhOFfHTjJhHuXOArZ7fNHLsSOZVb1MHaTiCHz7OWeEXeT0l3V//DOyls/qwxMwJ
         Xy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=aReDt6m4gVAVUxMzJOmKMPn9OCQ70XcueNdXu8Sl300=;
        b=ExHcOuqCF1NIi3s354SANRD/kxW5sf8OZjvyRxY4oZmIZTpq+LP8T2Y4X90pPDYuEv
         7E3kxu0whvL/9ywO4an0Hc+JQjcHt44pjR6IqLdmCrKMuZiBSYimaJleNOdVpje6A+xL
         pmg3CG/GfSVDodY/ucZ9On9Ypmjgcs7IBJD3VEKnjLLN5+72mUW+z5yYJVIjvef6axH0
         T8Rn51GBqM25vAqz4k3K9Jwf5FAZZ7GKxFnEdw9W8kvi8wnrzb0xkzGBogXwveeOTf2W
         yEinRK+dUUzlyFep9h8xMxFKq6JVl0HMNC0eRV7oAIk9B88pgI5sj91rIv/Asny3t1Xw
         Nirw==
X-Gm-Message-State: AOAM53062H0rBE1yTQZ4+0Hokzhr9xKcyzZxQZv8YmqM+WIb0GcWfmsF
        xY1j7VNe+wlLR1cIOU54H0NF0g==
X-Google-Smtp-Source: ABdhPJwQL1o3LxHDMwg/THH0sy/Xa+iZdTNPEDHptuOQWBAjhwHI27Lv6WTvyyNRbYDwCUSA90niCw==
X-Received: by 2002:a05:600c:a45:b0:346:5e67:cd54 with SMTP id c5-20020a05600c0a4500b003465e67cd54mr8522907wmq.127.1653048080798;
        Fri, 20 May 2022 05:01:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:e96e:bd3d:75ff:2c21? ([2a01:e0a:b41:c160:e96e:bd3d:75ff:2c21])
        by smtp.gmail.com with ESMTPSA id u6-20020adfc646000000b0020d0c48d135sm2411675wrg.15.2022.05.20.05.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:01:20 -0700 (PDT)
Message-ID: <8557f7a3-9fc6-393d-14bd-d7bd26c4e7fc@6wind.com>
Date:   Fri, 20 May 2022 14:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next] xfrm: no need to set DST_NOPOLICY in IPv4
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yoshfuji@linux-ipv6.org,
        steffen.klassert@secunet.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shmulik.ladkani@gmail.com
References: <20220520104845.2644470-1-eyal.birger@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220520104845.2644470-1-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 20/05/2022 à 12:48, Eyal Birger a écrit :
> This is a cleanup patch following commit e6175a2ed1f1
> ("xfrm: fix "disable_policy" flag use when arriving from different devices")
> which made DST_NOPOLICY no longer be used for inbound policy checks.
> 
> On outbound the flag was set, but never used.
> 
> As such, avoid setting it altogether and remove the nopolicy argument
> from rt_dst_alloc().
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
