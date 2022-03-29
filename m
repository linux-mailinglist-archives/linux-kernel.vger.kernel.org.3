Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3864EA8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiC2ICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiC2ICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:02:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9591EC52
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:00:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j15so33343941eje.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+uk8AzkPR+i6sZoorwmR9wgRQDw7+TFP3D119VcOmrE=;
        b=gYK2W/6b0+HzW5noH3ibvMHAFaSjfIBjku92dC03u1C9lNzZU7Xkl8LGFEP+f/zSa+
         X+hAopxmm48S3FnkQF8eX2gVIzJFhSdARXlaidd80BRGyVQKjghX3WbW0jf9bAUquomT
         6mtyEhJlpbQyNc6PMrygbTbCBuRfto5sYm0Xf7+Sb/mAzgeMTKocGp7LqB465WuKpWdD
         zqGUFjwVANgEZx3FH8ewaU9fFtaC6uWK/A2eeQnD4I8Fa8MoZDb2iJk6pcrRBFTisRyO
         OulRPp3LlxIvN2CyesRIBoxQSKyMNxY6GIFnWmPc/icFAESozkuudebGZbPHQ0BWrDVq
         jVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+uk8AzkPR+i6sZoorwmR9wgRQDw7+TFP3D119VcOmrE=;
        b=vhY8iclcy9PkkxY8kN/sjggCu0uXcTYGX30+QeyfTgSl7XZ1ZXOg5A0IdWnAUfInlK
         d3fvtsSUc+gxXuypR44FtRwPMV7f+j9jSG9YgdT0ZGQbh3dcSZ6Qw/rqFwcT3r4k2vnA
         rHraOmdBO0/g/W2EMjSUNv68JwvF87ikcCrSAIq78YS31Z2GzgXNaV2Kjf9S0Itu1Ozk
         LyTue5etlByv5tzBoqgA52oOoiNbeSuh0Jfp4AzShrPcuyulceUhiXklims7s10W1ySV
         OvnkFCrrhbVThC/rsYon3/OjNLvxvwQvkMnhyrwrh2QoDe4AQkv+tsH7zfJ2MiPseL4+
         Rslw==
X-Gm-Message-State: AOAM530OHer+/+HwxmstwaJQ1EyYzKBgCdIzaUFYIwYfax6CYK4NNEZC
        3AluUsBgocb7X9YQdTLqEkj0Gg==
X-Google-Smtp-Source: ABdhPJwmvS8Euc5V6qwM9HJtgNyBoBR1jRJ/H88JjdEc9dOVPFykuv2rRB3ITEGiCJhHvy3w52286g==
X-Received: by 2002:a17:906:29db:b0:6df:ec76:af80 with SMTP id y27-20020a17090629db00b006dfec76af80mr33428342eje.177.1648540831519;
        Tue, 29 Mar 2022 01:00:31 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm6855669eje.178.2022.03.29.00.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 01:00:08 -0700 (PDT)
Message-ID: <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
Date:   Tue, 29 Mar 2022 09:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Content-Language: en-US
To:     Minghao Xue <quic_mingxue@quicinc.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, robh+dt@kernel.org, jean-philippe@linaro.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ztu@quicinc.com
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
 <20220329074610.GA20342@mingxue-gv.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329074610.GA20342@mingxue-gv.qualcomm.com>
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

On 29/03/2022 09:46, Minghao Xue wrote:
> On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
>>> Some systems want to set the interrupt of virtio_mmio device
>>> as a wakeup source. On such systems, we'll use the existence
>>> of the "wakeup-source" property as a signal of requirement.
>>>
>>> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
>>
>> I don't have enough of a clue about dt to review this.
>> Pls get some acks from people with DT expertise.
>>
> Hi Michael,
> I had a discussion with Krzysztof on the first version of patch. And we've
> got aligned. 
> 

I thought I reviewed this and provided an ack, but apparently I did not.
Sorry for late response.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
