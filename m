Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8544E44CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiCVROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbiCVRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:14:29 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382123BC;
        Tue, 22 Mar 2022 10:13:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id yy13so37659526ejb.2;
        Tue, 22 Mar 2022 10:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QmMg/EKl0xW35GBff0jTfkrQ8CFh3/OigBZ5YvVUReU=;
        b=jtSTADFjdJuSvZWBDAmW6G/s1zf5oHTB5mDzfygCkDS5N1NoDCJ2nAHFcUfJsr+9YH
         F4rvLrISfSnSPojA9V85BrrMFDuS3vjwByYLxtYR4/aBNRqI2WE9vagT8L9QzgKwht5u
         wrMyhunKtM/xM/iadqVxcpwcQ4EYA8n/QC+cb/tQ/i9ZWBom9JGg4gDvRc2dkQvVP6HK
         Xgtr4IMDCZ9zf4R0RnhMCR6mJ/dhq0uaY6XLOS1Vsln2QW99VsVtyVYqK4QuLLKY02+X
         lEJCyysGeV7EKKAKZk6Ruj8dB66aG/H4wPqOOQLoJKqO3j92voa9iGsZum1RQijrPZOH
         RBhQ==
X-Gm-Message-State: AOAM5323lE/q6YG83Gg7NCPkw23kdmLm5zAg20FxuU5E1DaVIQftLnVz
        Z5MoqDstVnu3nZyZlJIDliA=
X-Google-Smtp-Source: ABdhPJxWdW95mHvyeWIKeZhKft9eNVv0dZhvZT4MHND9OWy+6l7gJbnt1Tx4cTshSto/2gJnQdZpEg==
X-Received: by 2002:a17:907:608c:b0:6e0:5204:7454 with SMTP id ht12-20020a170907608c00b006e052047454mr2415804ejc.225.1647969179633;
        Tue, 22 Mar 2022 10:12:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm490106ejb.101.2022.03.22.10.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:12:59 -0700 (PDT)
Message-ID: <3c345ba1-8339-e8c2-8d14-b75d1264bb4d@kernel.org>
Date:   Tue, 22 Mar 2022 18:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/4] usb: host: export symbols for xhci hooks usage
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9@epcas2p3.samsung.com>
 <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 09:59, Daehwan Jung wrote:
> Export symbols for xhci hooks usage:
>     xhci_get_slot_ctx
>     xhci_get_endpoint_address
>     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
>       getting the ep_ctx information to know which ep is offloading and
>       comparing the context in remote subsystem memory if needed.
> 
>     xhci_ring_alloc
>     - Allow xhci hook to allocate vendor specific ring.
> 
>     xhci_trb_virt_to_dma
>     - Used to retrieve the DMA address of vendor specific ring.
> 
>     xhci_segment_free
>     xhci_link_segments
>     - Allow xhci hook to handle vendor specific segment.
> 
>     xhci_initialize_ring_info
>     - Allow xhci hook to initialize vendor specific ring.
> 
>     xhci_check_trb_in_td_math
>     - Allow xhci hook to Check TRB math for validation.
> 
>     xhci_address_device
>     - Allow override to give configuration info to Co-processor.
> 
>     xhci_bus_suspend
>     xhci_bus_resume
>     - Allow override of suspend and resume for power scenario.
> 
>     xhci_remove_stream_mapping
>     - Allow xhci hook to remove stream mapping.
> 

NAK, because you ignored my comments from previous submission. It seems
you prefer to silently skip answering to them, not CC me and then hope I
will not remember what I asked for.

I am sorry, but that is not how it works. This is not how Linux kernel
is developed. Please answer my questions. If they are unclear, ask for
explanation. Ignoring all my questions/comments and resending without CC
is a NAK.


Best regards,
Krzysztof
