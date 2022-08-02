Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E105587911
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiHBId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHBIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:33:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7171EC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:33:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d14so9048067lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1ozmbsN2tgjXvPMdLMQFGo2ZV9fcaQMnF+02jQaScWo=;
        b=xiDFHToAk53VqqiejooYK/XgNB5mKuNz8WRx/QqME+8fOqnbf+fM8Vxd7FAAatCyJx
         hvU1TGDiOfHaUWhFP2YZApPg5ShXnWIAsahH5o+ul7zbNBW7rWJVihGhwjvE6teAvwdK
         wLsAJiemDPc68V7aQLFnMwgFh6kH3OyAVRyhk7UG5hqJ3fqzttbWyFfDezbMEdIxHz2X
         Hqo45gVcyArFQi+RpBv2sk8UlVcnIeNqwwgRqJDTw17K1rhw2xyHkrolTK0jzqqtk/Zc
         Cqz4bsnwSgM2QmwYMTVCaYGsJhGX1Gbiaz9dgELpIduIQq3AoBVrcYurKvBIRnTKBz+9
         v/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ozmbsN2tgjXvPMdLMQFGo2ZV9fcaQMnF+02jQaScWo=;
        b=CQpDOnNr64XvQjmizSQIFmdDqCZwSjdxM7m4OuGeEnwFSzg1zwrRXFspNPFi3Lu9tA
         v5JiqDo43uF4VsK7I2agNWl1CwI3Pjvs8kLtP7yatCsO0QIN9u7jFszyO9A7JMIlw4eL
         Nv4G8AVXVBwS10SCslbTeRnYhocRSakD8oW+m8fbdP8B4OzDEU3ZLtblRJzpgx99Ohhx
         stEX7aMJe+wNmx+LWe5bgtxBYXKtXbj3vAoXrgtP7lUFIgMhuppWgAu4OJsvpFZ7I1tX
         AfRfww6pc+j8JCz180uwed4rkZbzXbBy5w67vCA3Qqjjpv4lkwrhCfWQaCBY6c8K1X8N
         I0uQ==
X-Gm-Message-State: AJIora/9rgN1vOLFEKXIUSQLWxCOxs+hsTTRyQd5V+87mB7MKEuzSJy2
        toyweBU969ukPvpKS+Np1kJ1tg==
X-Google-Smtp-Source: AGRyM1sQl5cqH63HPgknS6/o1ykpwybk//qudzbfgglFjDL8qQJpX626a+cQNqh9Xlkj2+M40g0KWQ==
X-Received: by 2002:a19:dc4d:0:b0:489:63cb:20c7 with SMTP id f13-20020a19dc4d000000b0048963cb20c7mr6494786lfj.101.1659429232964;
        Tue, 02 Aug 2022 01:33:52 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e4611000000b0025e1ec74e25sm869652lja.43.2022.08.02.01.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:33:52 -0700 (PDT)
Message-ID: <64e3702b-f09b-5a2e-b6a5-4c8752fbad77@linaro.org>
Date:   Tue, 2 Aug 2022 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 9/9] ARM: dts: uniphier: Remove compatible
 "snps,dw-pcie-ep" from Pro5 pcie-ep node
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 13:58, Arnd Bergmann wrote:
> On Mon, Jul 4, 2022 at 2:20 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep" compatible,
>> so this is no longer needed. Remove the compatible string from the pcie-ep
>> node to fix the following warning.
>>
>>   uniphier-pro5-epcore.dtb: pcie@66000000: compatible: ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
>>       From schema: Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>>
> 
> This sounds like a problem with the binding rather than the dt file. Is this not
> a designware pci endpoint? Should it be documented in that binding instead?

Depends. We had one or two similar cases, where we dropped the snps/dw
generic compatible, because device was actually quite different and
could not match against snps/dw compatible. IOW, if device bound/matched
via generic compatible it would be entirely non-operational. Logically I
think it is okay to drop the generic compatible. Different question is
any ABI break.

Best regards,
Krzysztof
