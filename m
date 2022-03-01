Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE174C892C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiCAKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCAKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:24:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D956222
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:24:06 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A67CA3F1CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646130244;
        bh=Xjhp/CXOOSUteuBUcGQJQGfNTsSZQGbcPmAbNzxC4NQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MZCxDQ/CnvCAHxh3L87F9sSvqUAHig+8AKQpvR5rwtRGzHVWF9V1k9g6aDiDVOQUK
         Ytxa3qa4ds1Y6P1dgePbRC15A4ccJE2WSxuV58ydAOZ1uC6BQPl80ZZazi5VGG3DC8
         n8XP3WXZAB7kNicsji8lFQeF4zZnDdi8Qdj9R9sKsJle8Be7AVn1oxBfP9O4xbmPUT
         hRwCxWB2R/fVzAjBXVKEJCKWv+fC2jv5EK/ClDhaQEQkHgEl9x9Nur31f0oUPqabwn
         LI0gYRFwz2whX/o0v8Zh7i6W4ONnmL5dBogD73UgqjQQaWZ1u4HwLKNpgbm+5KL+Xi
         dha17QMl3FlYQ==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020a056402344e00b0041593c729adso496509edc.18
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xjhp/CXOOSUteuBUcGQJQGfNTsSZQGbcPmAbNzxC4NQ=;
        b=sqMj8aOA2cA2zY+7bQOBN+RwH4fIvEpi3+1h3WAmS9vcg2Z45I4ZqGxjXxcsMafGa1
         SgwC4P79JMuH6XOk9YpFOQgl91TrPvAnGKTZx7jzZl4IaQrPEaX5siHggkML/FlKdpXP
         25pgfRy0S6SYtW1BWlGwUd8HkT1k7kFc73ZcI3+J4r59Zy0uUeS0wsri8xwFcyB2g3Ud
         8lita1NUcvcpUOERtpXzHVunIW/qvHpaGC8MnNHkLJMMNjRxk9h0xkdp3UZh4jwJI5l0
         0+JwzwoaLEEYCXw3iaBwRF++D7sCvnBawkcvABwQ9KiGIw3CZ2NRKrD8RU96sWar3+/j
         Pi5w==
X-Gm-Message-State: AOAM531gS2nvr2LrT820+FazxP9W3QttmXuNc/mSCsB/XUKtk/QsR48S
        1+NMsU4rQ7yZmnL2AFhkZJTRB+MnypwIMjqfaZ+Gw/+osp3oHpIyKjJQPabojx1jmPF6VuMcDvX
        6F5Qcg3P7fmocK2G6myR+0EzZmJJy4RkZuF4mdeGR/g==
X-Received: by 2002:a17:907:a088:b0:6d6:f8f9:b15a with SMTP id hu8-20020a170907a08800b006d6f8f9b15amr824007ejc.203.1646130244354;
        Tue, 01 Mar 2022 02:24:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWe/UtN8F4RzBRq5b4m/3WBqmFuFUYvz/vZz9tEnuqk0rT7rK+KwECBeH8+rP48tkDqNED8w==
X-Received: by 2002:a17:907:a088:b0:6d6:f8f9:b15a with SMTP id hu8-20020a170907a08800b006d6f8f9b15amr823986ejc.203.1646130244136;
        Tue, 01 Mar 2022 02:24:04 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm5174727ejc.42.2022.03.01.02.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:24:03 -0800 (PST)
Message-ID: <c7fea223-b958-deea-70b2-a649e3cc0ec4@canonical.com>
Date:   Tue, 1 Mar 2022 11:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] net/nfc/nci: use memset avoid infoleaks
Content-Language: en-US
To:     Lv Ruyi <cgel.zte@gmail.com>
Cc:     chi.minghao@zte.com.cn, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        zealci@zte.com.cn
References: <664af071-badf-5cc9-c065-c702b0c8a13d@canonical.com>
 <20220301093424.2053471-1-lv.ruyi@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301093424.2053471-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 10:34, Lv Ruyi wrote:
> hello sir
> 
> I think this way: On 64-bit systems, struct nci_set_config_param has 
> an added padding of 7 bytes between struct members id and len. Even 
> though all struct members are initialized, the 7-byte hole will 
> contain data from the kernel stack. 
> 

That's reasonable. This explanation should be mentioned in the commit
msg. Also just initialize the array to 0, instead of separate memset call.


Best regards,
Krzysztof
