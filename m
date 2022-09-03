Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9F5AC127
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiICTfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiICTfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:35:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09A2B627
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 12:35:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so6747905edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SZHgv5PGtCOBVjWnaY9l+4AtXRMYbHOX4QK5lq24Xw8=;
        b=aw2e70151gm0RXhKYCpGiSN/b/Y9kL3kKAnQ6GeIPbheh9RyeJtsymmdTFXBzYIFJN
         eLpaxD5GDU81Kb16mLqlGun90ktfMKNHcgWAMVAXicC55KNq/rtAaNbPqh976P5fplZE
         k0i96oHIDjhDl1nQWgpbtTIhmy6jP3QhLmRFVe2wsXIwHiRfgWIq2Qj/1/ChgenWiAjE
         UeP8yD0+NlPun/hI5obF0Tm3unP0fVdUxrakYhsW6lAatiVHVtz+zSXdiCbludVUGuZn
         LYzUrVj4k/9e20thps26T4Z9mZWZvH7KrAQ+cQVFD+B+E6pf/wjNuWul4X3U4mtImkhP
         +iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SZHgv5PGtCOBVjWnaY9l+4AtXRMYbHOX4QK5lq24Xw8=;
        b=lnUSyRtD1DSGyWL5xl/uQWnu9Ltf2L3eLfWUWF1RACpx/bs52K5lHEYykBIFPVHDZK
         Xdh3F8Rt8yNbZlNQseISOZTRZuQYakJ4nluOAPTlsSaoopOxqO03XtTMalx7W5nLu7xP
         9s3Ij226nhjPllUVUYjupuXr4bTvlKPiLk8hNIjrt4mSLMsVZArMMrWpA7UL3hGmzjXG
         toaoIuzLtAmqRMAdOkWhUuh77CVG8PbuwtDPNhhi6EnI3Oif4gj2ChITQ0vkLW00ls6r
         2VGIZU/+ss4NJ6c/MeDZzbPkzVfmSN3NVOKVuAMtjIN9mBU15IrZrIRKxSMnD0m+c4NM
         G5JA==
X-Gm-Message-State: ACgBeo1wKE6gBwAxghBW8JPegejRU8ENmbq0PvkkfuKuF/lgZQkbceGd
        +H7UMUYg1YJ3LD85UZwu9ya4aA==
X-Google-Smtp-Source: AA6agR7q6aT7eQlA38Bx86V/paq66mjVk60WTiiO5KXucMRB5h3tP35ghuO/9XRP+5IZq/wMMhGA9Q==
X-Received: by 2002:aa7:db0a:0:b0:44e:5868:f489 with SMTP id t10-20020aa7db0a000000b0044e5868f489mr522344eds.299.1662233713881;
        Sat, 03 Sep 2022 12:35:13 -0700 (PDT)
Received: from ?IPV6:2003:d9:9740:fc00:bf68:310a:7021:7923? (p200300d99740fc00bf68310a70217923.dip0.t-ipconnect.de. [2003:d9:9740:fc00:bf68:310a:7021:7923])
        by smtp.googlemail.com with ESMTPSA id p23-20020a056402045700b0044792480994sm3611258edw.68.2022.09.03.12.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 12:35:13 -0700 (PDT)
Message-ID: <ffe3f49c-55d7-3c28-78a2-7998fa3ee914@colorfullife.com>
Date:   Sat, 3 Sep 2022 21:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
References: <20220902152243.479592-1-jiebin.sun@intel.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiebin,

On 9/2/22 17:22, Jiebin Sun wrote:
> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counters
> greatly improve the performance. Since there is one unique
> ipc namespace, additional memory cost is minimal.

With ipc namespaces, there is one struct per namespace, correct?

The cost is probably still ok, but the change log should be correct.


> @@ -1303,14 +1305,16 @@ void msg_init_ns(struct ipc_namespace *ns)
>   	ns->msg_ctlmnb = MSGMNB;
>   	ns->msg_ctlmni = MSGMNI;
>   
> -	atomic_set(&ns->msg_bytes, 0);
> -	atomic_set(&ns->msg_hdrs, 0);
> +	percpu_counter_init(&ns->percpu_msg_bytes, 0, GFP_KERNEL);
> +	percpu_counter_init(&ns->percpu_msg_hdrs, 0, GFP_KERNEL);
>   	ipc_init_ids(&ns->ids[IPC_MSG_IDS]);

These calls can fail. You must add error handling.

--

     Manfred

