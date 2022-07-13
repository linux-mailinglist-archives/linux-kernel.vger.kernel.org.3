Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD47572E71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiGMGvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGMGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:51:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A56C48CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:51:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p6so9617664ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h+uct/42Q8M6Hz8PpnusIGnQ/q1XqpsJvX0E6hd4PoA=;
        b=D5oHkdR48+vS3Om/EyDHPKxoqu2leWD6lqgxKuWpJonXrwEj85+HDq9Kd3mmAXrwDg
         FnFY6PQGFjWsTAkf6+5cphIlxrymVJr+t0eg6+gY9n/3mhNrvSRuiQg2cs+mS8SVn9OQ
         wcOG2PEl3kJb1HdqlTEKBhtTIxezc7Ub2fTXUsam850ynui27elsUyPG7u1Yc5LdWSUN
         Vwg9tV5mF5XctRpgN7sAGsy59Harx9nY8l6IjAsvfHpIag/AqA3F+Pe7qd1ohOeXbvrH
         NaRFoIj0MNcf9O6zViNH/Kvxn63AhnSfvK3EFbWWQAO1y4OHRo/UlAbCOt0NkWACrt/b
         l3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h+uct/42Q8M6Hz8PpnusIGnQ/q1XqpsJvX0E6hd4PoA=;
        b=Lp9IpJPTywQ1LjHns/EoZmIK0NVSbJLN1k2xxOjH1TQPDuEzUkAt14OrDuVj16IdQp
         bNk0LI6kk3QpW7UVLAtFhNd2PYSF0ZTq9PU1K6qTSJ1R4QZJtNIoD9MOdI25BpXHAabU
         a5Uh7SlJ+w7UDwHXKU4z/B41F6MvBEbZN8GAE9tnlExJqu/6tuFuYyzbilEvTKHMASdH
         KW45rmf+Co9ACgprcsskpTMH+ItnDZAPxEvnWyOHSP4xANW6bU5ujaXn5CM1tjQchosi
         QvMqi2qdWlYY1bT1pSqudoYP3XjcT6tyy2HbbkydbOl8SBFaIRd3A3GcHqKptG1b+Ks6
         qkKQ==
X-Gm-Message-State: AJIora+gWebYmZPfZ7MGwRSO2+stUVTaIaYgVjku9fUzKIErV+4N9EJ3
        IM0vcGjyT7R75tnRVlcZKjI2Yg==
X-Google-Smtp-Source: AGRyM1uaJ4J3MO1KmIouHLS+USEPJTlTXorStkT7p9tkjJEXg7tnQjXa8+W5Dr/66Y5NkqHYYbDyXA==
X-Received: by 2002:a2e:b889:0:b0:25d:38ce:976 with SMTP id r9-20020a2eb889000000b0025d38ce0976mr943413ljp.357.1657695108134;
        Tue, 12 Jul 2022 23:51:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id v1-20020a05651203a100b0047f7419de4asm2625735lfp.180.2022.07.12.23.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 23:51:47 -0700 (PDT)
Message-ID: <3184e602-33ea-14fb-485c-5f54d020cd8b@linaro.org>
Date:   Wed, 13 Jul 2022 08:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
 <b1829902-c271-a677-f423-99dbc85cba89@linaro.org>
 <BY5PR02MB700920503721C0C490BDAE2FD9899@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR02MB700920503721C0C490BDAE2FD9899@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:35, Joel Selvaraj wrote:
> Hi Krzysztof Kozlowski
> 
> On 12/07/22 18:57, Krzysztof Kozlowski wrote:
>> None of your patches reached recipients and mailing lists.
> 
> Thanks for letting me know. I didnt notice. It was shown in patchwork
> website and I thought it reached the mailing list too. I have RESEND the
> patches. This time, the cover letter (0/5) seems to be in a different
> thread and the rest of the patches (1 to 5/5) seems to be in a different
> thread. But all of them reached the mailing list though. I am not sure
> what is causing the issue though. Can this accepted? or do I need to
> resend them again?

I saw your patches but not connected to cover letter. As you said, lore
also misses them from cover letter:
https://lore.kernel.org/all/BY5PR02MB700954C6003BC5D5B6AAB1B7D9899@BY5PR02MB7009.namprd02.prod.outlook.com/
but they are on the lists:
https://lore.kernel.org/all/BY5PR02MB7009A49AD394747ACB80F746D9899@BY5PR02MB7009.namprd02.prod.outlook.com/

It's fine, but you should fix your setup. You can use whatever tools you
prefer as long as you create proper result. The easiest is however to
use git format-patch --cover-letter -5 && git send-email ....
(and useful also git branch --edit-description && git git format-patch
--cover-letter --cover-from-description=subject).

Best regards,
Krzysztof
