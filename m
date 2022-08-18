Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955495990C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiHRWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHRWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:54:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2CF75CC6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:54:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11cc7698a18so382991fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=V8Ue00WUQE3U/abecOIN4Qtb7gfDP0rkPIbdBTWRwKQ=;
        b=TwC/KmwuHZWq4vw/UCux05XfIrbrGDXwdMGDtZHF4kMpe8Ke5Odq9Yl4FYDcTImdAV
         0TZQccZwS9lsMLVPJeYTKTmnNL07QV9+aRIU/IUAER6aOyRguS2I+Hm9IH1KMEt8mHRQ
         Z+C+vt5il7+iiirucudMNeMmgYDEvTFU/DDaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=V8Ue00WUQE3U/abecOIN4Qtb7gfDP0rkPIbdBTWRwKQ=;
        b=mtgtLP2Y969ITmTxwMN7qPnUImBd6XqidOlYVFZ68H2/DkZMrlkuqFd4V3mmI3XWdB
         joMmCAcdsQmOop65j2+GSan63rrBncKlvh1B3QY2sgfdX39zPtdNko+jgsv1qia/PW8J
         3Cv9eL80sxNlfXLKy2egBgySzu+AeAD8+US2nmcQ5C/0Evpvi9ynuCkDfOIGTPY6lZVQ
         Iel6na2HjpZU/dcvN8OsI678/mhNlbxpFeHwbIum849eiPKSNnJfua8xM4rqa/CBT4TC
         E37S4D+FHbLxCyqCprZXJfxStfxFdX0wpGvR3dFFTLg5FxMIVK6fOFhdzJl6/6TxmvRy
         DTGQ==
X-Gm-Message-State: ACgBeo3c3zlh7SuGoBXsAeQvFcl26RhP71hKz/5lZCcQLQ1FLXGCnDHV
        22MyrXKrEh3Ws/FQuHBOQUeZMQ==
X-Google-Smtp-Source: AA6agR7/431Qf3zSUlYzmanWZ8TJjaMqfIqW1eRWqU0Z+3fKxSHUoFfKds3DJsf7AE/upFnBpgjIsg==
X-Received: by 2002:a05:6870:3486:b0:10e:62b:159a with SMTP id n6-20020a056870348600b0010e062b159amr2595050oah.254.1660863258385;
        Thu, 18 Aug 2022 15:54:18 -0700 (PDT)
Received: from [172.20.10.6] ([166.205.92.241])
        by smtp.gmail.com with ESMTPSA id r42-20020a056870e9aa00b0011ba344b4fasm140274oao.14.2022.08.18.15.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 15:54:18 -0700 (PDT)
Message-ID: <a96ca963-6131-f0e6-f43b-3413addae5f5@chromium.org>
Date:   Thu, 18 Aug 2022 15:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add sleep state for alc5682
 codec
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandru Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mengqi Guo <mqg@chromium.org>
References: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
 <CAE-0n52GzxXEsToWzfU1TMuASuC6TKK7NXxYbBQWxNmM74FxZA@mail.gmail.com>
 <CAD=FV=WNuqtpnCr2Zn0z_L1OCiwD8dNzhDxvhfHYuYVmciPbuQ@mail.gmail.com>
 <60b5b49b-eb7a-c552-fcf1-3d3a360f8e25@chromium.org>
 <CAD=FV=UkaiDSYvm7W1tnoty=3dnYTUaEmNcbP7=uEzniELt7QA@mail.gmail.com>
From:   "Joseph S. Barrera III" <joebar@chromium.org>
In-Reply-To: <CAD=FV=UkaiDSYvm7W1tnoty=3dnYTUaEmNcbP7=uEzniELt7QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 3:39 PM, Doug Anderson wrote:
> Ah, searching through the ChromeOS bug tracker finds some hits. At
> this point we should probably move the discussion off the lists and
> bring it back to the lists when we have some results. Unfortunately
> most of the bugs are not public and so having a discussion here is
> just noise for most people CCed.

+1, thanks Doug
