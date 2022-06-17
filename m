Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430B54F3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381469AbiFQJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381457AbiFQJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:05:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084639156;
        Fri, 17 Jun 2022 02:05:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so4905338wra.9;
        Fri, 17 Jun 2022 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o/0mDcIFSqHQ/My738bTZT2mjhpWfk/KnpoBd1WgU1c=;
        b=dAaofN78+s4gFUVaIZ/nesusmR50ONgOtZ4su/WxPvXUq1uGErzGDltaEY5sYNQNZu
         vPaQG7MRjYmBjy3fOYTGflgW+h0bY+eedmQIzG2X1B66UoKYNTj38VHXFXUzq2w3egYc
         vx2PMzcy5jiC1dsqLu0Gn3uB2j5roTyVGJT3pC/eKEPM/afaxzfuOYrMp6w6wyua9/fd
         9Nj8Vb2O/FHpsjuZ0UWGG4KmQqCDMqlcSRHQOtGRUy5aV7uvmVVflFUkInLcwFi/WGfi
         JrSsf22hoYStFwsEa4P4tzdLhDBbpQn9PLfaGHWr78OaHRbZvGFlV2/7N+VAuNBgzNzY
         SHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o/0mDcIFSqHQ/My738bTZT2mjhpWfk/KnpoBd1WgU1c=;
        b=DiYq+tKs51ENohedERs/IzvkNHIZQ2sLB+Wu8WyPNz+kZJx2E2jMTJ+Pz4uPQlXEhZ
         nzzJNwmcItN52KTeaQqL/cmaM2P5j/EfZ74FksTsi9t+HqZpm6InxVTLBER/AxlPjnh0
         okPC5eZMoQgYeld3qvcCq/p0IBNb7DqwXoxpjlXUw9dqZhH1gQ768Eb42PslG+dECu/P
         ns9cBvEk+FOoIh/RRww5bUqlAiQANjp/wSMReCzPdwHKKLiU8cVRaoMni0Ek5t8AD5af
         25ExOurOfljZWwRh5WDB1Q3oaAmmK5HacW0EWY4UDeIZp/gvWfEjIvhMyTuvA13xmup5
         2Wng==
X-Gm-Message-State: AJIora8rpeQXAvJgl7PqxhyANPHyUMAPHo5eXHStB5tnw5AwZHmRpz6R
        ilCFCsuBaMSbS7QybJ/mQFY=
X-Google-Smtp-Source: AGRyM1vQCHbGNsNTZ28s2YR1fjPVRB8ztyhZ6H2QaXGbiVCH22jD5I467k/8uSrhKWH3FoPIeIx2hA==
X-Received: by 2002:a05:6000:2a9:b0:218:4bf5:a43 with SMTP id l9-20020a05600002a900b002184bf50a43mr8481741wry.154.1655456720070;
        Fri, 17 Jun 2022 02:05:20 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d614e000000b0020d09f0b766sm4004776wrt.71.2022.06.17.02.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:05:19 -0700 (PDT)
Message-ID: <0a01e2e2-b188-d670-7063-2e35fc3cc350@gmail.com>
Date:   Fri, 17 Jun 2022 11:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: adjust whitespace around '='
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, arm@kernel.org
References: <20220526204402.832393-1-krzysztof.kozlowski@linaro.org>
 <1338cf79-d57d-d13b-896b-abc0c726a238@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1338cf79-d57d-d13b-896b-abc0c726a238@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 22:36, Krzysztof Kozlowski wrote:
> On 26/05/2022 13:44, Krzysztof Kozlowski wrote:
>> Fix whitespace coding style: use single space instead of tabs or
>> multiple spaces around '=' sign in property assignment.  No functional
>> changes (same DTB).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Output compared with dtx_diff and fdtdump.
> 
> Matthias,
> 
> Are you ok with the patches? Any comments?
> 

Both applied now.

Thanks!

> 
> Best regards,
> Krzysztof
