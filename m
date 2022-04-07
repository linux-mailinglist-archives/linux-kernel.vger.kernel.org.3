Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B604F720C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiDGC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiDGC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:29:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40D170DA6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:27:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y10so4186082pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jajC5BGIaV4LB8uC3hkkHcAtM8jdKonq9kD1jt0KnnA=;
        b=l2t9X4a/n72LRCWsLI8EiXgO90/WMgWbUvgL/0hDWwSYc6Ss0zIgdfiSLNwf2ojK1R
         dAYMo6PgiL4Ui/JLXWG9/s7VMQvpOTZAwCelgjbvT8gd8RBnxGZyRmTMUjr9+6Ida60/
         HjLHvPOy7kWKeuJQ/IGJuOvW/3sjAtWvsNNQZs1tBLJwbXhNvRFyzwKV7rMA+IE76bIP
         MnyKUJ2naBDJhPIytAZnfbWYycI/T3zCV/hutgxFFtDRr+XILPurGtWJCehjefzvwped
         1H4rC1WUhzucFxTFocScJKAotd+7d1MN8FlvpT1L9ul8bhedRAeUooJcXoqo/TI1ykbF
         Hyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jajC5BGIaV4LB8uC3hkkHcAtM8jdKonq9kD1jt0KnnA=;
        b=yAIS4rvwJ2i/gIF2YP0QxRW9gcaeSwBBWHlLP7ZsvjDFTRLCUbNtv5oRxUPVFYLOSW
         VhbEZD5JmXZwX6EED9KBe1PF8660PgJccEhv0he1FTiOGbEigr77fe8APJWGP5xo3x1y
         SW2K5/qmGKrvJ5jBD3fv94iuP4PdvMaT1xnWvAwokddKKaHFPTUVQ7u1lsmvNpUMWO+9
         jvrd9qEyO/zpwJ2FSO76vwKoZSpTCWUJT874BXlfMN3DexkaGciFIbcI1PHp2LyWKAsj
         +Hif+Mgv6BrgUlK2Ha5wMSnXECzMp5XxkZlXdrX3rYho019lqS6YJJJlznh0yo8SML7w
         9Uhw==
X-Gm-Message-State: AOAM532i4n21n5qZAmrb/E2iBcYRAvJfre1vZqszvngJ3BzkugwIeXEi
        rRVMKffD5XJX9aTtnoByIfiwUu9zO+Ez0A==
X-Google-Smtp-Source: ABdhPJy26+SuwuVBNC58dLxtjGfLm2HqisHnxbZezvzi8L85ph5a6ucD+44+mWBG36v+lzvl/8vN9A==
X-Received: by 2002:a63:51:0:b0:398:a2b7:be6 with SMTP id 78-20020a630051000000b00398a2b70be6mr7482275pga.214.1649298424129;
        Wed, 06 Apr 2022 19:27:04 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:f010:ec92:b46d:e5a7:1343? ([2409:8a28:e6c:f010:ec92:b46d:e5a7:1343])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm20648818pfl.15.2022.04.06.19.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 19:27:03 -0700 (PDT)
Message-ID: <69edba11-6d15-b80a-5840-86834101f76d@bytedance.com>
Date:   Thu, 7 Apr 2022 10:26:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v3 3/3] arm64/ftrace: Make function graph
 use ftrace directly
Content-Language: en-US
To:     mark.rutland@arm.com
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
 <20220224093251.49971-3-zhouchengming@bytedance.com>
 <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
 <20220322094100.73dc3ad0@gandalf.local.home>
 <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
 <20220322104956.42203163@gandalf.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220322104956.42203163@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 22:49, Steven Rostedt wrote:
> On Tue, 22 Mar 2022 22:14:11 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>>> You deleted ftrace_graph_caller above from entry-ftrace.S, if we can get
>>> here with some options, wouldn't that break the build?  
>>
>> The above ftrace_graph_caller deleted is only for CONFIG_DYNAMIC_FTRACE_WITH_REGS,
>> and I tried using a low gcc version that doesn't select HAVE_DYNAMIC_FTRACE_WITH_REGS,
>> it can build success.
> 
> OK, I didn't look too deep into this.
> 
> I don't have an issue with this patch, but it needs to go through the arm64
> tree.

Hi Mark, would you mind picking this up for arm64 tree?

Thanks.

> 
> -- Steve
