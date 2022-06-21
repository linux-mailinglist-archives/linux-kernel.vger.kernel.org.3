Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2F552A09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiFUEDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiFUEDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:03:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33E1C906
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:03:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i64so11933425pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RZ9pEW9/Xss2opj8NdBtkbickpuy+86/XGNBBbLjj9A=;
        b=U/KM7/RGGAnmCDAb1dEN26UirE2cOMgyRV+35pgeM0ybt2bdeb0PTBkB2ayjnu10BS
         yWKkD5HDJXwOgjJHOCw/I7FnkLp4au79qt4thvPFloOgRQPsZ+1ZCGPbUAHlNinJPW2f
         V/xZK6UpbakbYNN6a3FErpTEqvh2TE6syjx5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZ9pEW9/Xss2opj8NdBtkbickpuy+86/XGNBBbLjj9A=;
        b=Lk4wrehHRmXh0EveF2YDloXk2z7xSv+mMP5Hn3wfn/PK52WMYbdsCwLqArdWl2H+vq
         LZhbAAE5Z3u4lxlyn6ru8atKernU/HKnvm2xZCsuM0mltWo5HBmRlWFyfenV7cjHo+nZ
         rS7B+AvW9HTzIjFdjw4i6J87/GbqxG5odlvJZ1rxeFbZVYBoCK3LQ4TY2m8kKryW5aGj
         4StwNUva8MnrBGSNrV5ddLSvTiHA7HBLlPTfpbh6RS2LCT52sbJ05qev1Fn+6GHowYIF
         RvkK3IkdyO8W9KgDnr0GjVvlvKfL35loORuKew9gnddsOzh9eIoTmC8RQpfr3xvefZLh
         roCA==
X-Gm-Message-State: AJIora/LLz7O4OX0yuJNa6rgCRITtR4xlIWjrj/6Th8/Eh8kFGwkB+Y2
        nNGirhUqt+wxgFMuVzqerBAcbA==
X-Google-Smtp-Source: AGRyM1uGzkWyJhK+WU7ooPGx3elf7o3UQYfv7Wrax6G4YMN2oUt6eFQPMZaxlCvlPPvF5Gk/rZnTYw==
X-Received: by 2002:a63:8f1a:0:b0:409:fc0f:5bee with SMTP id n26-20020a638f1a000000b00409fc0f5beemr22852083pgd.427.1655784213235;
        Mon, 20 Jun 2022 21:03:33 -0700 (PDT)
Received: from [192.168.86.125] (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090a431600b001eae86cf683sm8970569pjg.42.2022.06.20.21.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 21:03:32 -0700 (PDT)
Message-ID: <b0de876b-3815-8a31-56d0-2052d83dcff2@chromium.org>
Date:   Mon, 20 Jun 2022 21:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts
 files
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
 <CAD=FV=XV_FOTT1WKBEUVCXJgGtay1O8qDi7Mj4BG1AUL6nh9TA@mail.gmail.com>
From:   "Joseph S. Barrera III" <joebar@chromium.org>
In-Reply-To: <CAD=FV=XV_FOTT1WKBEUVCXJgGtay1O8qDi7Mj4BG1AUL6nh9TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 5:14 PM, Doug Anderson wrote:
> Something in this patch series you need to talk about how you relate
> to Stephen's two patches, AKA
> 
> 1.https://lore.kernel.org/all/20220602190621.1646679-1-swboyd@chromium.org/
> - arm64: dts: qcom: Remove duplicate sc7180-trogdor include on
> lazor/homestar
> 
> 2.https://lore.kernel.org/all/20220518172525.3319993-1-swboyd@chromium.org/
> - arm64: dts: qcom: sc7180-trogdor: Split out keyboard node and
> describe detachables
> 
> Probably that should be in a cover letter. At the moment, it looks as
> if you are assuming that patch #1 is there but you're assuming patch
> #2_isn't_  there. Is that correct?

Yes, that's correct, and I'll note that in the cover letter.
