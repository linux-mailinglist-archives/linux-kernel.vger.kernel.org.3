Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBC4AAB10
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381020AbiBESul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiBESuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:50:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1764C061348;
        Sat,  5 Feb 2022 10:50:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b9so19035563lfq.6;
        Sat, 05 Feb 2022 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uGrPgHFv/iAmSdnuaZW4kaZJfyfi4C90B7qxQcLb3S0=;
        b=cwx5kYfZEBbAhyCbc2fJwkjL6CYZOPR4uO+reB7+M40ptBqFX8dc/LtrlnxWiXIvnB
         cDcaWcdtUMURGNWFlHPnRNMKhLFfgbmotHKA6W+/JocV3diXnA3ejDDqPLsOqBMK9Q7K
         1Fivi9uS4ArFrzYiDvWAIg9yidRJD/1LkhkUiHht4qljhUKK0MMk1EYWz8b3POuMCooN
         4w3QkDr/cpCU68fPqSLD1SzVZPY2a8b3AEpkHweKpK81jJv3Q06G9gh2xLkZygAxD1Oy
         CVOkGIuiZ2ESAiRy6hLObxtrVymVZLTYCrsKimv4Puw8kVqj05Dq8GMkBRT2+shhC1sS
         MWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uGrPgHFv/iAmSdnuaZW4kaZJfyfi4C90B7qxQcLb3S0=;
        b=i69hhwOHsSw1dxHDx+6E/K4C7vF10zq1a82ZVt497hpmR+/jvvHoqbOlQgqJ51q8hx
         AuR7WkuIq5Lytr5fbVykK8KQ4HAmz9jQhz1uuBIZV4fglRJddUXqRWCzdqFW4oPhIZCs
         uX8dE1FZXw3i3n7PxyqTn4lPdzuR2+uEbVr5ZR6nu4Uf8O6sWyozN3uTQLmz9PGFZEDH
         Chd7N4YkLd+74zmw+/EUD09Gg6o99TtsYQqRUy5CKi0ncAvX4fhe9H1HgAzegoq1ziPg
         i66rhhm6RC/HAkDmtIG45O8ZXXZf+3AgGUE9aLTZ/8aJIEAruEhZqYhNJen4PKkUGcaA
         kqBg==
X-Gm-Message-State: AOAM53347KlRvyq2xGEqB9uRr5zP+99X9P2PkUK71O5ltHQ9EHB/Dogp
        I90dl9rt0DK9BdJw70MUTKWEpgx9hQ4=
X-Google-Smtp-Source: ABdhPJwPXUPOfkA6hlAPBUBrum6YJPHtkzgpj0pRCyKEgg7xRVsIfZbEGD3J+rjPKTEA0Cd0YBmtBw==
X-Received: by 2002:a05:6512:3405:: with SMTP id i5mr3315803lfr.393.1644087034412;
        Sat, 05 Feb 2022 10:50:34 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id i29sm811758lfv.131.2022.02.05.10.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 10:50:34 -0800 (PST)
Message-ID: <a204a4eb-6615-26db-facf-ad284c1732d7@gmail.com>
Date:   Sat, 5 Feb 2022 21:50:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] dt-bindings: memory: lpddr3-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
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
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Maximum DDR clock frequency for the speed-bin, in Hz.

Why max-freq is specified as a register? At minimum this is inconsistent
with the lpddr2 binding.
