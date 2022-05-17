Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06849529E93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiEQJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiEQJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:57:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6D38181;
        Tue, 17 May 2022 02:57:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so977324wmr.1;
        Tue, 17 May 2022 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vkbPSe6+lbN9CgRiuIs5X2zmL0tJEg4PuoARLaGrjvs=;
        b=OosLfLz7al3FcOZC7A+KBKjtG62QHZMTp+4/P4+CXZ6od3wajq6h0IvIK++O4SRbnc
         fK0X36zpiYXLjUGV5JSdKvbFIeSGqyWxjC6Eu6LhzNq0/vBW22bNpbyoTzYkiTnIbZmx
         7m+X1EVuosimr7zWLMXeOQxDDzfTpUFxqTQNlpouG/kOhBT/rcFTBcE33zZRgpJ0KOo5
         MrPKmLtsyjUkbTyQWr4+DBCwMD9jDv0g2DT7nWMOuTgwrqH1stHzbxS31l4cEXrzwbgk
         nnfnZjrlHwx5rFT+F1Px1Zb9D+irjdobOmsFHehYqON55+owGp+IDa6Z+gtWv3DTsfi2
         MWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vkbPSe6+lbN9CgRiuIs5X2zmL0tJEg4PuoARLaGrjvs=;
        b=ypt8siMpI9uB2K3cjfNdG1/JQOPWUS3iwI8l0Xj+QyUgbLXgkIA3LFA9U1HSzY3I+Z
         QPfjAjAv/8osP8ZQAdrnmsnVsDd/lwGQKmRp2DONpAaqepZ97PBDDVa2Xu5wLUWmDwPY
         6dpHTKC3CPvRUyITP1XJiD3XWDuMdghlpG0xt0HetrFaFN6Hm8kniIRU2jAGdv29SlgW
         VST8tc6+IlrCQ+NOh+QVE89nzvQkE2PJIGOw5MXzu94VwNnG661574jiCLb16oU9PPfM
         QfYScPCRXm4/bs8ORYuEsstI1FwzZYia65eAT7MxchR6kscax8Tq4j/GYtowX55zUZls
         52yA==
X-Gm-Message-State: AOAM532cHejepq7QJHaK6EjYhSvZDgAzsixvCRwSwYP8CtgBxU8u5lHI
        aBZVTSP0My3vm2pdHxGJ/AY=
X-Google-Smtp-Source: ABdhPJx2Y7sHu8IoFE8w1v+BrUgCcLNWC3tjiunbkuXLBwpxYw6yZeq3jVkMV9Vc9/hzmXYODRpJ6Q==
X-Received: by 2002:a05:600c:240a:b0:394:18b:d722 with SMTP id 10-20020a05600c240a00b00394018bd722mr31834039wmp.177.1652781459678;
        Tue, 17 May 2022 02:57:39 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c13-20020adfa70d000000b0020c5253d8bfsm12028639wrd.11.2022.05.17.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:57:39 -0700 (PDT)
Message-ID: <dde746ce-5663-e12f-4537-4206945b6b59@gmail.com>
Date:   Tue, 17 May 2022 11:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 00/10] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220506042004.hqzpb66shak4y7rz@vireshk-i7>
 <86851bd03128cc61082d516ebff929d3637063cb.camel@mediatek.com>
 <20220512052732.iqphgpveoyrqjlqg@vireshk-i7>
 <af82434adea0b648d74ed5ffd123e0faaaac6508.camel@mediatek.com>
 <20220512054825.aqe4g4lupuqj3rcq@vireshk-i7>
 <ca85977bcff2e3de925d7ab834b8654ec5ddf8c1.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ca85977bcff2e3de925d7ab834b8654ec5ddf8c1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2022 08:05, Rex-BC Chen wrote:
> On Thu, 2022-05-12 at 11:18 +0530, Viresh Kumar wrote:
>> On 12-05-22, 13:33, Rex-BC Chen wrote:
>>> Matthias is not the member of mediatek, so I think we still need
>>> his
>>> feedback for these three patches.
>>
>> Please ping him and ask for his feedback then.
>>
> 
> ok, I will do this.
> Thanks!
> 

Sorry for the late reply. I'll take the DTS patches through my tree. As I'm late 
to the game this will be for v5.20.

Regards,
Matthias
