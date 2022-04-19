Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17150693C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiDSLB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiDSLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:01:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B31BE80
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:59:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u18so20753100eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=O5CBBgo2XmuqRHrX5N+WoSNjs6N4HhMETq+ywg7Z0Yg=;
        b=GwQsMWFyaKqitOw2K4ERs71CebQ9j1lhJey/Ao6nQts3Wc6SMEgn4CdC0WON4y0Vrm
         i0yLF+4KbXWY7wiXOwo5nwO1XBJHRDKbNCdT9k2sQw7zbLTdP5rHacXzTeEcXBmkkh7g
         LxOftPR7vhQqeOA/C/0Mxj9IrFGcP7MUx298tHlp5QiSf2M8rCwHc+TVL1A2oqF2aQrZ
         b4pPubgl+bMvC1s/E4Y9g03d3nwBBmm/KSCdcNoQCO2cP43OFyK1UUKzvc/meCcBFg+i
         2/fTeTRXNzm4KPH9ZUAt7CG4JI+lDp4IAjPYS8jJJWr+28pRQWHEdHfPu/R3RxtLoFZQ
         XQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5CBBgo2XmuqRHrX5N+WoSNjs6N4HhMETq+ywg7Z0Yg=;
        b=JtgobnEYpt/Ad3K4OcymPjoK0emGaV1ZeMyaAKapEj+nWaWcWvQjWR7b41bemEH4QB
         ZQIkplAYklrfwPkY/02SOMH7djHKlVOVi99nqDbYWOWzD9NNo8Uc12r/G4ryaDk5DkY/
         9NbfbM16+407pw1C3F8lvv28kGunoDB2uvpYNETWEWdFgaM6MzqV3ZR2Ms4n63BF4pro
         X/8Wf6IX3Oeuq0tF9qivxsHCYMUsQueBarwFIvgJVQqwN53867QsCtnCLY/AOeQApIHm
         TA9OJjlmHMoQDgX6GSNsHDDD5bl+uh7Y5cY7dNHgoqb1MOwN2z8fBZxzkcOYpewVHKlb
         N8kw==
X-Gm-Message-State: AOAM530UhWZiQA3TmVRDJrqtURxUdpQgQ+9C8jO1xNbPdmM+UtEct0O/
        u9PwhqaKoET58iJXsoJr/WF7ug==
X-Google-Smtp-Source: ABdhPJwtQ1BLQn620Xz+U8W+fow3tkpwQwbmB9aa9f+Wmx3sMsqJkjgv/5hgcw5cHgx5EnIoTMeDAw==
X-Received: by 2002:a05:6402:1e8c:b0:424:1d6:1b71 with SMTP id f12-20020a0564021e8c00b0042401d61b71mr2007309edf.211.1650365951850;
        Tue, 19 Apr 2022 03:59:11 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b004229daeaf37sm6311685edo.40.2022.04.19.03.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 03:59:11 -0700 (PDT)
Message-ID: <20b63bd8-b527-43e0-884d-bf9fe3cacb19@linaro.org>
Date:   Tue, 19 Apr 2022 12:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
Content-Language: en-US
To:     Conor.Dooley@microchip.com, green.wan@sifive.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        alexandre.ghiti@canonical.com, palmer@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
 <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
 <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
 <61923e45-6594-6dfc-5e2f-e808af99e7c1@linaro.org>
 <9f8faffa-0b0e-2fba-7f2c-56c82ec7936f@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9f8faffa-0b0e-2fba-7f2c-56c82ec7936f@microchip.com>
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

On 19/04/2022 12:57, Conor.Dooley@microchip.com wrote:
>>> Not sure that this one is actually needed Krzysztof, Zong Li has a fix
>>> for this in his series of fixes for the sifive pdma:
>>> https://lore.kernel.org/linux-riscv/edd72c0cca1ebceddc032ff6ec2284e3f48c5ad3.1648461096.git.zong.li@sifive.com/
>>>
>>> Maybe you could add your review to his version?
>>
>> Zong's Li patch was sent 10 days after my patch... [1] Why riscv DTS
>> patches take so much time to pick up?
>>
> 
> Oh, my bad. I incorrectly assumed that that patch was present before v8,
> I should've checked further back - sorry!

No problem :)

I don't mind Zong's patch to be taken although in general I believe more
in FIFO (or FIF Served) style.

Best regards,
Krzysztof
