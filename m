Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887A74F0C60
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbiDCTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbiDCTnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:43:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26761393C8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:41:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y36so10766853lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oxxr7bPrjDPeIv+VJE5lRRshNToYGMZqrjQO687UQao=;
        b=cUeCCbNktrqD8Qdg/Ie+X2m0MNc0hrNxfmuXM2wBiFDHhl46u9/mKs8HR7T4wCkWvc
         +ubhIMyDFcicqREcmOZlIcNhCR6lFM4ul0rlS497aeH+wqn56IkC330+goC/As/9Jp3A
         kVycyL5ri3MQnboWNN9Ppe6cRZmXM+Ywa65PzE/fN/E9XYhUXXDzzfRQ6i/rV/qC2oN/
         eHPXDHkgDgrZxPF6dXl/KDSawSzdsaMk/pw6dzNyiN9jI4cyM6aJkaosrkQTFdGP1A+h
         duR/pbwcxi1sJ4rUrXmS+55XNxUa31J9skrVOYM7Kh4JUxVuVWd8jkI41fCst0ra/Ao6
         tBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oxxr7bPrjDPeIv+VJE5lRRshNToYGMZqrjQO687UQao=;
        b=2wOKojeh3v9AbAi657UnO0fKL5+UP7C9Gfi27A8NAbBqkuDB9t27pItvdzGrP7TGx+
         2mjnuwE9s70kue6HfaMU0+WQXbzH1iHMUatOgsadUOYInu6M9oNtiaPZR7iiSqsW0RVS
         3ehlIpMAd4WGNgKTKAzGj9lVFlBoDZ+hdVXEF03tN6KAEKRJceA9cNFCJcieyPuPiWGa
         DrPsn7qyrUJmeUxXTr/vALr08SINDOs8/udyG9ot80wdaO0yw3ym4aTAGnb6L4UMR+sR
         LBx8uFO2TRNIkMOyWOIeIE0VLEVtZhG/zIoULvDzCBR/+TylQqYLs3/2kE6KvSj+ts96
         gKpw==
X-Gm-Message-State: AOAM530/qU6aac3Z7yqdpixbtrELjrrdpXQKfvb3hqP869f+lYukxu9r
        dAK4UhxRvlGCmPFd7wu/Bi71rQ==
X-Google-Smtp-Source: ABdhPJyOvbhXo/NIFiPA1rBXSDpVn2irDyvsKus+NU3HIiTdO2BhuimM4/7nodeyg61Y+BeI1rdZdQ==
X-Received: by 2002:ac2:4e03:0:b0:44a:c82:35e7 with SMTP id e3-20020ac24e03000000b0044a0c8235e7mr20676685lfr.10.1649014874172;
        Sun, 03 Apr 2022 12:41:14 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y12-20020a2eb00c000000b00249b0547be5sm861093ljk.99.2022.04.03.12.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 12:41:13 -0700 (PDT)
Message-ID: <70d8f9a5-9360-77c9-c844-3c9c10fdf43d@linaro.org>
Date:   Sun, 3 Apr 2022 22:41:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: msm8996: Add MSS and SLPI
Content-Language: en-GB
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210926190555.278589-1-y.oudjana@protonmail.com>
 <20210926190555.278589-5-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210926190555.278589-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2021 22:06, Yassine Oudjana wrote:
> Add nodes for the MSS and SLPI remoteprocs.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #db820c


-- 
With best wishes
Dmitry
