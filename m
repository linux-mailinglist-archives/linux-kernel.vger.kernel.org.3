Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5835ACF96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiIEKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiIEKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:08:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6515A0D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:08:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x10so8720688ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=d1gGchAveHzt86CvqEfieWHGXIsGqTrznknP67kJy30=;
        b=TAMRlnEHDcqBwK30yFwx0lTrk/OO6aRfuvGt//UFzJrFVUjgmO88y58cwBnsnfyx9v
         qYepZnxihho6F0SQXPJTdtCuXykn0j8WuS9xh56cHq0eYnbwezAphx/QakEvTkS4j9I6
         kdeRSziU6OUlYvlfQHgGH6sQApDTfvrMkpmKf2GpxWzt0R6KowqVXKe6cdyxfvVlDKtm
         +lXav0JGJmk1tnuLe04kHhtkF3MekmBIb7wcTF6GXU4jCF/7qx6E2c+pCJivDcaOunwI
         y/YDFH4jSFR72PHcZ+fN8BfcsqwbDDQbVdwv/5gnftR0wJh5dyBlJfurbPy6j+74mh3A
         UH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d1gGchAveHzt86CvqEfieWHGXIsGqTrznknP67kJy30=;
        b=LX5h8Zbf3Ttk52714wg2N3e+tusaXbs4uSfAYxVRR9CVZU2JDopzi+Zgz9/qAeW/wO
         cc7qd6O6F25AfkIEj4Q53PMIr6jKDyrAhIOQ9V43AyXiLvlOd7kdb9sGCU5n8yCf8tKF
         8Ukvy9Ys0w2Tp9GQHgs6wjQccJ+mePyIlatq/k6yB5mpPF3bJ9G+8HP75fWazyRa2/Nl
         MboifRRWI4L/wIeI570RbWMDmYfcSz8Gp5V6LBPTSaZD/cIooj+YL0qcpkuuep895hYY
         a7xQiaWA7+wYLQlHHyEjjsO9n4vSCsAN1u2fRQp3+F774JV7Hyq4IZfs+D/aQ/LHxieF
         co0A==
X-Gm-Message-State: ACgBeo34LAOlBP9tOhgwL2N2v+OjuFsHRPl/IDmnCFvGN/0TT2GoxMvv
        uY6qONoRTVCTUOWujrQ/UfH2Tg==
X-Google-Smtp-Source: AA6agR7MhZ1+wSDLkfeIWuVF5HSfdbylV+gyRRbfXVc6DYgaS9hOJx7hDoxEcuLv9xg7i6lGc7aBIg==
X-Received: by 2002:a2e:934f:0:b0:24f:ea1:6232 with SMTP id m15-20020a2e934f000000b0024f0ea16232mr14853380ljh.135.1662372519831;
        Mon, 05 Sep 2022 03:08:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00492e5d31201sm1148641lfr.7.2022.09.05.03.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:08:39 -0700 (PDT)
Message-ID: <64bb3a7b-9c34-50f9-0243-36de805e62ad@linaro.org>
Date:   Mon, 5 Sep 2022 12:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: qcom: update beryllium
 compatible property
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
 <20220828205723.20834-2-joelselvaraj.oss@gmail.com>
 <d9b5e312-4999-4410-03be-299e95bbe8b2@linaro.org>
 <CAF+P-ZoAooPFEK8dueEnQg5d5+K4QRmj-W0WsjyUV-btgBfYnw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF+P-ZoAooPFEK8dueEnQg5d5+K4QRmj-W0WsjyUV-btgBfYnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 07:20, Joel Selvaraj wrote:
> Hi Krzysztof Kozlowski,
> 
>> The board compatibles are not that important for ABI yet this creates
>> precedence, so I am against it. Simple renaming should not be a reason
>> to change compatibles.
> 
> So what should I do now?
> 1. Retain "xiaomi,beryllium" for tianma and "xiaomi,beryllium-ebbg" for ebbg?
> 2. If adding new compatible is not an issue, can I do
> "xiaomi,beryllium-tianma", "xiaomi,beryllium", "qcom,sdm845" - for tianma
> "xiaomi,beryllium-ebbg", "xiaomi,beryllium", "qcom,sdm845" - for ebbg
>

Both options work for me. I understand that boards are quite compatible
and only the panel is different but the safest option (from any 3rd
party users) is (1) above. If anyone has other preference, I am also ok.
If not, then go with (1) above.

Best regards,
Krzysztof
