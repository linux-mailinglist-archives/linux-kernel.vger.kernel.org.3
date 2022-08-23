Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F359CE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiHWBx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiHWBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:53:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36343C160;
        Mon, 22 Aug 2022 18:53:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p13so160630pld.6;
        Mon, 22 Aug 2022 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Kacjm70FQm89JRlW4fxMW3VvkdKPicdgw1Nz1f/0eD8=;
        b=TRAqeSVahhJMcsLu+Y1+Vi7/2L6A1AsplmxjlNrTORgYTNl8rUsuuPwo1OxFhl1ABa
         w+RZOLzk3X7wmfMmpkwnfheFvIpo6NRWe0zDMUH2ySXk/uwlwytCwpzYD2eLNmwyQVEB
         YhLUZcPjDwPOXi6ZSytR1z5yBzyArBnyNauRN8Ulb/EWU9QKyQrCm9AlO0tVabPx29CV
         yqoxep+6OkWlSf3Xqakw4Zi4FuSbTYmY2AaT3qhWZsQnNDBdN8RJX0UQtR94is6yJnX7
         NrJ1muM1FQ8+/vpG86G33fytc2MH8e5RZ9irKwC1cbJJ3hpVRcW1y9JdVJzk6ey231Ty
         Qyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Kacjm70FQm89JRlW4fxMW3VvkdKPicdgw1Nz1f/0eD8=;
        b=2U5sVoTbxwImWjGr7cUSp0GuVuzani9BJUY52wC6OupFT4wqRNJLYirNsVa/2hmf1v
         HKGQNOe5osMw6Af7vHvr2/yKuNoqKzvca88yraXWwdlYN4dXhpSL39slULHZCXArrkVP
         ybHAN7xGu6u4+RAAhTIPq5EbFc+eJwMh/+mh49XIzsi7qX3ecK7+f2rGVsavSr8d6TcP
         E5dA3hBRuaLveir9TdjNGKV4mGAN8J6bjPtVnRC/5AWADZg9FL4fOdqdhloTkx52AtRE
         jZ9RYDRcu3fjfPm9GMieKK6NkRlZMuf9Nd15ABIad8zgyQz5Q4vfGzA5Myh2zSR+TBUK
         9aRQ==
X-Gm-Message-State: ACgBeo2MQruvSn1SGuu/0LwcHF0JbIN1aSooUcOoJzWsDatHW73MszCI
        DE2+7th3/OV13Ztoo3twIexmP3P30Ds=
X-Google-Smtp-Source: AA6agR4EHEwVlo/lFTTk9Ic97Wlv3JkCe8qeyCpNFXr33OYwHHlV8Lc2GyzNF1KMdgLpYi3mc4H59w==
X-Received: by 2002:a17:90b:1d84:b0:1f5:b66:7460 with SMTP id pf4-20020a17090b1d8400b001f50b667460mr1090565pjb.50.1661219632206;
        Mon, 22 Aug 2022 18:53:52 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id n60-20020a17090a2cc200b001ef81574355sm10625894pjd.12.2022.08.22.18.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 18:53:51 -0700 (PDT)
Message-ID: <6d9a7094-274e-1227-d92b-5b282cdf9763@gmail.com>
Date:   Tue, 23 Aug 2022 08:53:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Content-Language: en-US
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20220820000024.2494003-1-alexlzhu@fb.com>
 <86a26310-eae0-35e8-ede9-e71825db1416@gmail.com>
 <3C5EA425-A548-47B2-8590-35C38D6D47F2@fb.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <3C5EA425-A548-47B2-8590-35C38D6D47F2@fb.com>
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

On 8/23/22 05:17, Alex Zhu (Kernel) wrote:

>> The changelog should be below the dashes. Otherwise LGTM.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
>> -- 
>> An old man doll... just what I always wanted! - Clara
> 
> Can this be merged then? Or is a v4 needed? 
> 

Please reroll (send v4).

-- 
An old man doll... just what I always wanted! - Clara
