Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A574CFBAD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiCGKmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiCGKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:21:44 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661E91AD9;
        Mon,  7 Mar 2022 01:59:09 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id g3so6852395edu.1;
        Mon, 07 Mar 2022 01:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=emPv8yHEbh1YE9SCKIsxMDOq9Zz4Ptvwa2GcQv1Z+hM=;
        b=OadxZxp3Xtab4zSTRwEelj2mSf/dusqrXVrNTqv4640Mi6G00TgTPwln74KdKpcyfA
         aRJpEG7QBc7BkeQ+G+MN6o+RaQMki3BGhhyWsKJQZRYqFjAJFZGgQxELOkDhK/Z8MUxp
         TrRkJNZ6GlF2dYKnKNcMH7gYffM/Y3dCB8L7oXeEZqOLLQwAXhUoZiiQaii5Qe0up7i+
         U/r7zKNfnoCumb8IT5Mc6bSxesQOBpxcfGs/JnTtYOJFt9cWK6bOS4in+FLp7qb6zWKw
         LrR/BTvm0J75eoeBU6bTebtwU/U4Cq8MuJhgVZur0teLb/pOqHL/ApjHRqUeu2aS0oBy
         gkcA==
X-Gm-Message-State: AOAM531RtyyinLdspxleDgRnHwSM68KQig273CLXzmGT+3IYINC35PQP
        jbkdgsLo3BFzZeWQp7AaCBc=
X-Google-Smtp-Source: ABdhPJzoGyYfAYB6nfgcVwSAi8fMR9L+WN8Rrg/k8CRIYX2dSeQXs/V/a8sVhQrMlIsmK0vawbtRWw==
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id n11-20020a05640205cb00b00415e04a5230mr10324425edx.352.1646647148186;
        Mon, 07 Mar 2022 01:59:08 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id w15-20020a056402268f00b00416474fbb42sm1343613edd.19.2022.03.07.01.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 01:59:07 -0800 (PST)
Message-ID: <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
Date:   Mon, 7 Mar 2022 10:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
 <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 07:23, Daehwan Jung wrote:
> Export symbols for xhci hooks usage:
> 	xhci_ring_free
> 	- Allow xhci hook to free xhci_ring.

Instead of copying-pasting the name of function, please explain why do
you need these symbols exported.

The "Why" is actually one of most important questions, because "what is
this patch doing" we can easily see...

> 
> 	xhci_get_slot_ctx
> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> 	  for getting the slot_ctx information to know which slot is
> 	  offloading and compare the context in remote subsystem memory
> 	  if needed.
> 


Best regards,
Krzysztof
