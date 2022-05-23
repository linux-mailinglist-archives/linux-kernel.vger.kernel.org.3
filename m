Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84765530A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiEWHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiEWHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:25:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785EC4617B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:21:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so533751lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SEfmqDqkFEX696SZ2gTxY8Wvy6BNeXZ6T0MQiA7SKio=;
        b=qIGf2F71X4+l3ZnR4VTUsUYTa4+nP1usaz9fXtcqUsBc+DxabJd0Pek3M+IJ1Q9WiV
         kdvIGOOEnJFHCRUkR41HhjDFjY/OJjpOdSPnTpwgaad5yjmScNqjOO9tUYJXx3HTpyKV
         76ui4a1JNwJX/yrVaif5FjIj4G2PL0b2/zAI2ijK/xJCqoeaJlizpfIFgLFA6x2kG/mm
         C4qWRgmuRFqRmpifygp3pnWYhDhSzcRHwQlWnj1pzOuO7W+LT5IgUA/Z4pc8QvMINHea
         4agHejBEy0Ll1+epo+y1v3PpZw9SUvyB3QuyKDVxtsTlAyR1GEI/eUNlSgMikcV/t+By
         Sryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SEfmqDqkFEX696SZ2gTxY8Wvy6BNeXZ6T0MQiA7SKio=;
        b=euDJ+cZbx6PCXzglpxQHtf2CJnY+z/WR70figOn5SZlNe1K8INf54WVpt0aQHywMRt
         SPuTqhqOmebWD8P3VXWTt4x+vxASHPW22SqGfv9aEqpN8wcqOkpdOd6r5uJ13SqJpoEY
         Fhb2nvFpQnWjGNiYmf/U13diapfvGC8J5Ktx+5Cmx7u61SCQbCT/FgdPzk52PNSdX49U
         8HRgglzAgyPAnHMSNndsVtUNYlZIRvY2DfHLiInDDLlvuEDIU5WmAey7LQ9PhYztp/uZ
         u5yJaBCWhWJevN/CwYAm6dXlMMU+/vXB7jo0PBe/ABM97XaYhoor0fKbKrgA82rt8Mgs
         TGLA==
X-Gm-Message-State: AOAM530Y/9rkJDkLgKAoR4b7IT/0iiX2xLWAWNrNb9qAsCLYXMZyI4sO
        kuJ38JFhfc5KjSEFLNw7PRWKnA==
X-Google-Smtp-Source: ABdhPJzySbuijwZ7sGwLLG5uguH3+PrkjAEfjkhpoIN1N2Ky3SeI9U+ELPWCH8rKPGQyNwITp/kjeA==
X-Received: by 2002:a05:6512:280b:b0:477:b181:223d with SMTP id cf11-20020a056512280b00b00477b181223dmr15453250lfb.146.1653290473825;
        Mon, 23 May 2022 00:21:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 4-20020ac24824000000b0047255d211c8sm1821422lft.247.2022.05.23.00.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:21:13 -0700 (PDT)
Message-ID: <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
Date:   Mon, 23 May 2022 09:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522195138.35943-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 21:51, Konrad Dybcio wrote:
> Hi,
> 
> removing these properties will not bring almost any benefit (other than making
> some checks happy any saving some <200 LoC) and will make the lives of almost
> all people doing independent development for linux-on-msm harder. There are
> almost unironically like 3 people outside Linaro and QUIC who have
> non-vendor-fused development boards AND the sources to rebuild the
> bootloader on their own. Making it harder to boot is only going to
> discourage people from developing on these devices, which is already not
> that pleasant, especially with newer platforms where you have to fight with
> the oh-so-bright ideas of Android boot chain..
> 
> This only concerns devices released before sm8350, as the new ones will not
> even boot with these properties present (or at least SONY Sagami, but I
> doubt it's an isolated case), so other than completing support for older
> devices, it won't be an issue going forward, anyway. But there are give
> or take 50 locked down devices in mainline right now, and many more waiting
> to be upstreamed in various downstream close-to-mainline trees that should
> not be disregarded just because Qualcomm is far from the best at making
> their BSP software stack clean.

I actually wonder why do you need these properties for community work on
such boards? You ship kernel with one concatenated DTB and the
bootloader does not need the board-id/msm-id fields, doesn't it?

Not mentioning that in the past bootloader was actually not using these
properties at all, because it was the dtbTool who was parsing them. So
in any case either your device works fine without these properties or
you have to use dtbTool, right?

> 
> One solution is to chainload another, (n+1)-stage bootloader, but this is
> not ideal, as:
> 
> 1) the stock bootloader can boot Linux just fine on most devices (except
> for single exceptions, where beloved OEMs didn't implement arm64 booting or
> something)
> 
> 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
> only create an unnecessary mess
> 
> 3) the job of kernel people is not to break userspace. If the
> device can not even exit bootloader after a kernel upgrade, it's a big
> failure.

The job of kernel people is to follow bindings and since they were
introduced 7 years ago, I would say there was plenty of time for that.

If the dtbTool support for the bindings is there, then there is no
breakage, because you had to use dtbTool before so you have to use now.

> 
> If you *really really really* want these either gone or documented, we can
> for example use them in the SOCID driver, read the values from DTB and
> compare against what SMEM has to say and for example print a warning when
> there are inconsistencies or use it as a fallback when it fails for any
> reason, such as using a newer SoC on an older kernel, without updates
> for SOCID read (which are sometimes necessary, which was the case for 8450
> recently, iirc).
> 
> My stance is to just leave them as is, as moving them anywhere, or removing
> them at all will cause unnecessary mess and waste time that could have been
> spent on more glaring issues..
> 
> Konrad


Best regards,
Krzysztof
