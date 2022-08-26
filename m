Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94DF5A281D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiHZM4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiHZM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:56:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBF511C03;
        Fri, 26 Aug 2022 05:56:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso1579770pjr.3;
        Fri, 26 Aug 2022 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XkBLXQVJw8ZW86CrFrYiPCfjAUbiqv3sEvOCVb/EvSc=;
        b=Cqn9u8oNXzI54I0s51Uc2JY/DSQzc1fLIEyKVQeU/0pVyItwl7jNGtoNmcTCuHe7sL
         b5EapBWbZVp15gPdLMRwcPn3ec9y2ldJxEGH7SXUiCvIDu22+oIdBww4K9o7Zhh66+/B
         XW7G/b5JASUKQ+83f98p0PR4JsvM/2JGBiYO54jp0pUMhkjBmoNTda0XCSRsEBfAjsac
         W1wsk1kdNO/zwDIjLjuuuKTx4YsjshP2g7I0jUFcvtdWDcUTEgTQO11JigpgvdIWwZ5q
         FWFyR5MGMcORMu4VR2nQH8u5uSQthmZ4rFoHkwekLPw3LnZe7wisrH/Ip7X8D6olGdkv
         5Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XkBLXQVJw8ZW86CrFrYiPCfjAUbiqv3sEvOCVb/EvSc=;
        b=uzhASpnERKvZAookbXxJ4KqZV0t4nIU60rGZReIvd61QSEBVRWUOxb5ccNqhKKmLJv
         QmR+2HFKDwCkUlQWMS+b7kz0eM9IgOe8pz/Ram15Hr3pQpsSDDSYTUEP6DcSkAR7sVpQ
         1oelAHugU4nnyqm3cuL/t6LHWdvrsgD2RnIQIWHyy/f+zwpaq1ueUkbnFK/IUSHn87yS
         ty+gBolLTxgWwhB9Ap3CoPYB7F9CQiSSJTHWFg9uPVfwdW9fgr0H6aNIL9SAFDxkqOOl
         tCFcK2+lZKqhoKMQx1GEZ0doUHE5zgzXsl5temBtGbQEjGpejz8Uk+UDegU/Lxpmb+Cv
         5ghA==
X-Gm-Message-State: ACgBeo1xfJv21VZBKlgloEe+mKs+Vtx8gjXHjbPcXnjZpyApCcc3yfpq
        6VRP9VF4Mf5rOhfzileRb6c=
X-Google-Smtp-Source: AA6agR7rUwPxmJVCKQkFKlqzUrQ7J+bAITn1MCH7FHzK84yb7gdtXTu3pmYXx0ipjMuwP52WoAgI8w==
X-Received: by 2002:a17:90a:7185:b0:1fd:768f:232d with SMTP id i5-20020a17090a718500b001fd768f232dmr641766pjk.149.1661518590971;
        Fri, 26 Aug 2022 05:56:30 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b00172ea8ff334sm1527254plk.7.2022.08.26.05.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 05:56:30 -0700 (PDT)
Message-ID: <cc13c32f-0f4f-bb10-c5fa-a04c139cf38d@gmail.com>
Date:   Fri, 26 Aug 2022 19:56:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] Documentation/hw-vuln: Update spectre doc
Content-Language: en-US
To:     Lin Yujun <linyujun809@huawei.com>, corbet@lwn.net, bp@suse.de,
        keescook@chromium.org, aarcange@redhat.com,
        daniel.sneddon@linux.intel.com, longman@redhat.com,
        lukas.bulwahn@gmail.com, peterz@infradead.org, kim.phillips@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220826065132.112340-1-linyujun809@huawei.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220826065132.112340-1-linyujun809@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 13:51, Lin Yujun wrote:
> The following patch adds the specre_v2=ibrs option in
> Documentation/admin-guide/kernel-parameters.txt
> but omits it to
> Documentation/admin-guide/hw-vuln/spectre.rst
> 
> commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
> 
> Supplement the specre_v2=ibrs option to
> Documentation/admin-guide/hw-vuln/spectre.rst
> 

Please massage the patch description so that it uses imperative mood.

-- 
An old man doll... just what I always wanted! - Clara
