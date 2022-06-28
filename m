Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F855CC61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbiF1JUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbiF1JUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:20:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5EE1CFD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:20:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so16731443wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iJvJeBFpz28dH7Emmp38T6q13VYqZEB+Imtu7meZ/PA=;
        b=zuAlvozB0Kiolri5o+HIUBZ51FaTZMno18VyPKij1FRXRDnc5a5Jv125q38tpsIpNG
         Bo9Fqr7yOgMirXCOcl6PzdxGcfvjxv3yp0KhX/1klvk8Fgh9wpJXqc/t1FaQTJHEoI3Z
         LiFLWKOqdedEFLT4CC53GBsMBYYJZRXT3SpXfsTEW7KGKLsSLk3l4FHN62dBvuOz5a7s
         WjfYQJP0sNky2aOjdgc4w8VHQhKz3ZhzWLJflT7qzzRZSjWTIXZc/to1dddLrM0fY6ku
         XJDcJyXHDcZ0uWqdG2jDelFkWXeyN4jycv1W+fkjJzSpVsJcAoKnJ+otgVAi5HYoVPMz
         4qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iJvJeBFpz28dH7Emmp38T6q13VYqZEB+Imtu7meZ/PA=;
        b=yUSWS1lymb0Yxt+iB+XJ1GdPSp4qcvCO5Fdr3FyyNHqm6Nb99q0rnvlcw+9fH7cLA5
         1sARh2ZldH8cGYI+RMzBf7rXzb4p9DH0kydqZr5z1sKq1/2EjWX8OPj7W5csRitryX/R
         N/MaXUXnJWEjmmsYrbc0Ra40AHYdk0HTvCO3fJolO9d4rxwAXu8GAVVdcH/tqeCAXNhp
         vVWouHAk7t50hmM49ywDx+hIuD+t5Py7UwaiRwYUDk9M/tDGsEtZQ7qh3aUXCXk7X0g+
         xa0SX9Byl8JGQZ93nu+opcZei+QMsA4x77+0sf9htp1BDUi955K2Oj2vgUmlJAi+fTp3
         gVkA==
X-Gm-Message-State: AJIora/mquNk09m8ZyOKuiwPda/g94suaY4dZiICTwa8JlYevhPH2Fgw
        +eoHWg8bjssowoZgQjYeUxDbpg==
X-Google-Smtp-Source: AGRyM1vT+3Dy6Jla3zzjXKIU5td43C5V93dy4JxQCyT3Dq+0zfsvY7ApDVVOJvrP5S1NfUAP9YYdBg==
X-Received: by 2002:a5d:428d:0:b0:21b:a1c1:2b04 with SMTP id k13-20020a5d428d000000b0021ba1c12b04mr16415861wrq.106.1656408015478;
        Tue, 28 Jun 2022 02:20:15 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm15719403wrr.63.2022.06.28.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:19:33 -0700 (PDT)
Message-ID: <28eca0b2-930e-8688-6544-e6c13a809df8@linaro.org>
Date:   Tue, 28 Jun 2022 11:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] dt-bindings: qcom for v5.20
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20220623145837.456817-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623145837.456817-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 16:58, Krzysztof Kozlowski wrote:
> Hi Rob and Bjorn,
> 
> I am fixing/improving quite a lot of Qualcomm bindings and I produced several
> separate patchsets. They wait on mailing list for quite a long time, in some
> cases two months, so I decided to grab all them and send in one organized pull.
> 
> All patches here got Rob's ack.
> 
> This also brings compatibles for Qualcomm boards, therefore it might be
> desirable to merge everything through Bjorn's tree, however at this point I
> want to just get it merged as fast as possible, because I am really afraid they
> will miss the v5.20 cycle.  Therefore the pull is towards Rob, but maybe
> First-comes-first-served is also good approach.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-bindings-qcom-5.20

I'll prepare a second pull, including fix for cpufreq bindings.

https://lore.kernel.org/all/20220627143340.477120-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof
