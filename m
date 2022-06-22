Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81D554332
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352115AbiFVHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352099AbiFVHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:03:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37836B4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:03:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a2so26209491lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YERJcMOnhf7YdepXzuOu1ICAIwURGU9KIuX/lgmjuVo=;
        b=VeMQggitH6vIywIo3XNlC/o5Xi45Ws9wLYXL/2QvJ1xYp/KvCWZ7Ms+XOlHD8FEOre
         XAWqtnosMq3SvS5sW2meaDwmXu3iHsPcVgSsCcOxuzV4fgcqIOh4LeZyG9udXU3INAmU
         QKj1uht41px53icB1fjscDsDRL82viptOrNGzzqPnZR4cIKRCZpCPSaT6MHZVsXZsq9O
         rVxhqhBW+SJGD5Eof3+FlcsvEo5FEqbazd6aModuvGPGn4JO4GX9f9GWF1+7slHOS3Su
         JZo79j9KOds39dlXQQ2sefCkJB3jnxNoMlKDQraQUaG1SCoopK5Ax9rh4y6mIlCmPC7j
         GigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YERJcMOnhf7YdepXzuOu1ICAIwURGU9KIuX/lgmjuVo=;
        b=1jqXWoiA49g+/M4qbobv33c/xh6Y0VrMZ/YmH7T7SVkeF37sS7AJQcyWsL7wxnQhR8
         2cibOn4130Z9DgxHRggWwmtL5l/yBrwp03smy5QJQ5gy4bzV81dpHL4AKAb39kgCKMH/
         Ctt/7nc3+/+FMQ5qTeesh1CL3SDYLhK3XH94c5H1x6LsNyB38R+0NjWN07CqSoxf8zBA
         z4ngU5fg4oEaNXg+5ewwcc3otZkMpxc3VTEvY250Gahc5FKwRunTrO+DMSqw2rW/G2m5
         gBtO4eKlYGvnPbhwaBEx5uqUDTH64fh2tmWr9ZCNEk3qjxNW/GgFY6hwIgv+C3coZtb/
         mHPA==
X-Gm-Message-State: AJIora/nqcQAVlk9bCoYfGHG/vDuZc6fPJ4+7ni20wI6yMO178ijtxNj
        uRaRgYslbtwD8tDtagChkCRj5w==
X-Google-Smtp-Source: AGRyM1tTLNAo7oEkZI5yLv+nUNHVjPEiA5lCsNiiw3d4kjelPJ1AyosgX42lNQ8wo/hr6+G+CdVkuw==
X-Received: by 2002:a05:6512:6d4:b0:47f:7940:f70 with SMTP id u20-20020a05651206d400b0047f79400f70mr1341831lff.47.1655881423444;
        Wed, 22 Jun 2022 00:03:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e2c13000000b002558e1bec75sm2321283ljs.5.2022.06.22.00.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:03:43 -0700 (PDT)
Message-ID: <6f22fe3a-2197-b373-8c48-5c146648166e@linaro.org>
Date:   Wed, 22 Jun 2022 10:03:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, svarbanov@mm-sol.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
References: <20220621211604.GA1334281@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220621211604.GA1334281@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 22/06/2022 00:16, Bjorn Helgaas wrote:
> On Tue, Jun 21, 2022 at 11:45:12PM +0300, Dmitry Baryshkov wrote:
>> On Tue, 21 Jun 2022 at 23:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
>>>> IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
>>>> cause the system to hang as its using DBI registers in the .init
>>>> and those are only accesible after phy_power_on().
>>>
>>> Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
>>> this patch?  I don't see the connection.
>>>
>>> I see that qcom_pcie_host_init() does:
>>>
>>>    qcom_pcie_host_init
>>>      pcie->cfg->ops->init(pcie)
>>>      phy_power_on(pcie->phy)
>>>      pcie->cfg->ops->post_init(pcie)
>>>
>>> and that you're moving DBI register accesses from
>>> qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
>>>
>>> But I also see DBI register accesses in other .init() functions:
>>>
>>>    qcom_pcie_init_2_1_0
>>>    qcom_pcie_init_1_0_0      (oddly out of order)
>>>    qcom_pcie_init_2_3_2
>>>    qcom_pcie_init_2_4_0
>>>
>>> Why do these accesses not need to be moved?  I assume it's because
>>> pcie->phy is an optional PHY and phy_power_on() does nothing on those
>>> controllers?
>>>
>>> Whatever the reason, I think the DBI accesses should be done
>>> consistently in .post_init().  I see that Dmitry's previous patches
>>> removed all those .post_init() functions, but I think the consistency
>>> is worth having.
>>>
>>> Perhaps we could reorder the patches so this patch comes first, moves
>>> the DBI accesses into .post_init(), then Dmitry's patches could be
>>> rebased on top to drop the clock handling?
>>
>> I don't think there is a need to reorder patches. My patches do not
>> remove support for post_init(), they drop the callbacks code. Thus one
>> can reinstate necessary code back.
> 
> There's not a *need* to reorder them, but I think it would make the
> patches smaller and more readable because we wouldn't be removing and
> then re-adding the functions.

Ack. I'm fine then with rebasing my patches on top of Robert's patchset. 
I'll send the next revision after getting this patchset into the form.

-- 
With best wishes
Dmitry
