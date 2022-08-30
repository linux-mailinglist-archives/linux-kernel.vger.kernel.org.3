Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF95A6D49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiH3T0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiH3T0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:26:06 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60B7C196;
        Tue, 30 Aug 2022 12:24:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11eb8b133fbso14740901fac.0;
        Tue, 30 Aug 2022 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nMfIlicbImZPPdYjDdFxMGUe/ZvoWmo2d4qN2Qx94yk=;
        b=Y2JQz/DDrHaYk9buAFizaLMZpmkFVrkAU7PgjVV69XqIRK8WrIQbi3s3vQHUuigSkB
         pKsG1uDMCacBReZLGOGG/Iq0VeZYHY/3fO/oRu9pUAzlOoo1s1ALlXMzRxq4oXjDD5+N
         GbjlBkNsjXZYXNejM6a+jV8vo14KG9WsF7Lc8kQfXb32yw96NzHIpATQIZDfDhu0H108
         PC5jAFZ/zw8tvD9qHDJHZ4aHtykjasG6HgdOrMnCqiRxzJFAb2IGcam5tXpUlsl7uQXe
         vVim7bvy5JzyVkqs9shH5ud4nBWEHgbYLmJjOz6kx/evGOYPPWYg41G6uSbNYhkahmb4
         4BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nMfIlicbImZPPdYjDdFxMGUe/ZvoWmo2d4qN2Qx94yk=;
        b=Elc/fMs+sEirI6bZ0ahYLRs9A6pt0+oVIJsN1q38pnZe9xNcAM40lAMg0i542tjUZw
         ugXx4vWbNpc/vsbmiJiiNA5oQIMz79HTWlD3OJQdIXW4eJE0Uu7PXjj6Zf0fhzLNmKCZ
         OZlvYYIR8N+RGfhEuJ1eaZWJT4BfeHwgIE2sNbQhuXwIAnBQJv7JHEnwoMOz1D5xs2Yt
         nUE5+k8mRdgSRVGFhP785LitoxJBQPHd2Zo4QDcLTwdKrRe+VixRByvdeTZpYCtRWBZy
         gL17tNOHomcFJdudi2hb3xL22IcszbJgOa4ESHfWl0IFdTpH90gGkn0xbyTS5wKllWh+
         oc6A==
X-Gm-Message-State: ACgBeo3+yW0fqkXixIrUodY5Toc36NTuAO9JteZoEhJLSdTdX+82jkbn
        beFGiYsmkk1Irja7XdPHgRjDrc5bg44=
X-Google-Smtp-Source: AA6agR6CXVvnQjNt2Dos+c6sjfq+mvytlUSymEmg4DWIHFf12CNlantKs6iccoXwh2oBdN7hVEoCRQ==
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id ay43-20020a056808302b00b002f9eeef0f03mr9931795oib.128.1661887466037;
        Tue, 30 Aug 2022 12:24:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:891d:81c:f58f:3bd4? ([2600:1700:2442:6db0:891d:81c:f58f:3bd4])
        by smtp.gmail.com with ESMTPSA id l21-20020a056830155500b00618fa37308csm7707864otp.35.2022.08.30.12.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 12:24:25 -0700 (PDT)
Message-ID: <7111c94c-a85c-2f51-f94b-ed60080b1717@gmail.com>
Date:   Tue, 30 Aug 2022 14:24:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay
 interface
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-4-weiyongjun1@huawei.com>
 <Yw3mE1UX1z/fGSBL@sirena.org.uk>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <Yw3mE1UX1z/fGSBL@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 05:27, Mark Brown wrote:
> On Fri, Aug 26, 2022 at 02:43:40PM +0000, Wei Yongjun wrote:
> 
>> Add a runtime device tree overlay interface for device need dts file.
>> With it its possible to use device tree overlays without having to use
>> a per-platform overlay manager.
> 
> Why would an entirely virtual device like this need to appear in
> DT?  DT is supposed to be a hardware description and this clearly
> isn't hardware, nor is it something we're providing to a VM.

Good point.  Patch 3 seems to not be needed.

-Frank
