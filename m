Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7294AAB0B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381015AbiBEStQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381008AbiBEStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:49:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB00FC061348;
        Sat,  5 Feb 2022 10:49:10 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z7so13516253ljj.4;
        Sat, 05 Feb 2022 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Jj9K5dwP8LjMYSakV6w2NbI0X90arTWO6yjeTMl0HoQ=;
        b=a4vYr2ni/oF+O6QTvByHZ1MPbXpJk7smNv9hdBPlye/PPBhwoNJ91eUduwgGJLOuLq
         i054evbesbNSODWP4TH8KsfvPiwBX0oxVnP+THBpI4vlCcCsHRVXKuilh2TNusdh8Az3
         43mL32w3DsyDIr29FsYdeJe/jbq0lR58jXgVV/GN8CRQf/7jG1Y/t4bIVsNI5NlDZH2p
         rz0+viYTnqfthCowxad77heyP2gxGxq3xOzWMAzNwWlolJynLkc5GMR7lptc3XjolSGa
         gZAI6w9hYLmujmJewxWm2xzV8uFhYeniMkqyaUm1GsERMaVMyJuvXYRz2fTmKsM3epFK
         GYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jj9K5dwP8LjMYSakV6w2NbI0X90arTWO6yjeTMl0HoQ=;
        b=8SCx0iqvH66hYM+sVfEMZ8MJlgYfOyEPTRGCP68beqZ1BKfdvi26nINgmhAb51q2g+
         tq7AcONmQjW33zNRH2d651yWrfuexfeJ7PhNsvxElh0Dl4qs6DtoGTWeEDcUAs3Ja+lC
         0vTSDZeXTQHcycrVw+XyshDg5RgFj3C5VdmVWMVDuAnaJc7SQTAMQgcnD48ra0wdp4Yn
         kFWVL+1k+CffrggT4T+Y6uZ7mm2CmSelv6pMYiwtvuF52N8fdHj/uyk7G5hwr5ZlBGyv
         W0fJY7gIuthvcImdhKDIqnddHkr5GJYSG3OMKvnHr/qjNzVQPqv6C+i4rfYfnj3DF4QG
         ri4Q==
X-Gm-Message-State: AOAM530VW7siColW5nzEjKUxWrPFeNe5ukvnks3v5dNGsBpsOObJTdiu
        iqpaCNlBdpy8q2IYXBbJC6b8rcb6Gr4=
X-Google-Smtp-Source: ABdhPJwK+kyJ67tWazfJAktYR+5xBewfF8ut5J3MbpEc/SIa7JOqZfjUtcR1TY6rYF7tKaIWDDKK8w==
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr3401593ljc.291.1644086949193;
        Sat, 05 Feb 2022 10:49:09 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id o17sm809411lfu.180.2022.02.05.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 10:49:08 -0800 (PST)
Message-ID: <97ee9356-9b36-6c46-9cf8-620819b053e3@gmail.com>
Date:   Sat, 5 Feb 2022 21:49:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] dt-bindings: memory: lpddr2-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-6-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220205120043.8337-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2022 15:00, Krzysztof Kozlowski пишет:
> Convert the LPDDR2 memory timings bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../ddr/jedec,lpddr2-timings.yaml             | 135 ++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml  |   6 +-
>  .../memory-controllers/ddr/lpddr2-timings.txt |  52 -------
>  3 files changed, 137 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
