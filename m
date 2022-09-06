Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988D5AE36D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiIFItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbiIFIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:48:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FA7A52E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:46:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bz13so10919902wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Odm1frpHPsrLRAe7/u7i98rAPlfDwtj9Yxie2DmtS4M=;
        b=hVCnTlqjhczb0RvxNzP+8m1HDiYzK8xk6T/cjsluF6cy4nTb8pvNROcyah5EbsJ+R5
         mkAI2kqII8zS+WLiyvoWGUR9sjjN8SR43IBIz3Fj2G0GXQOnFYFlsfyTxqQiyeRfMwqT
         Ji1ubHz2AfaucLoqFnDGGw1BIXGvV9Cz+/PT1uw/zhhk1RSHN3y8MrLls4z0TC4ykBy5
         kWvYnHpAANsNtok0k89zOlidk8rN3OEMKHtlMM35h9nbEmT6MWS1xKfplwnZy3NgEZMe
         hmBPwVbGHuLU+VAu/UzBxtZbMF/r2sr9/bFCJ6up20jaHc4OoaUru0zSSkm3R5Ryz1fE
         IR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Odm1frpHPsrLRAe7/u7i98rAPlfDwtj9Yxie2DmtS4M=;
        b=14jolywA9Qayg1LwvklyCukah86ig4+8w4e3j3WCx/QJ9Rr7drbpdedXRUt9uHepWq
         +kd9J9stNg4beHDxHxM6sIDsPp5n+xf/vkeGJqBkuy6rzULlCKV5QanpH+qi7ZWVAG1H
         grOdU2FY2v0u3YdT3Mutx5zPMtJXBaK1NfYCxZWycYiF04/RzEFc2ksOyCJFnTnwEJHS
         tWRhnQZ0Ry4XQVvyEwQHY9jFi9N76w+AsMfvH20KOKzMpe+EOM8Nf5SvB/zl0myyA26d
         hE4A6jmKD123vdg9fYKbEXXy06sBnLnLdZ2MSh0dld5UJtryBEHD8sGgasEGzK+yY9Cx
         w2+Q==
X-Gm-Message-State: ACgBeo2qHiHTL6cfAXw23uK5tDMzlJ7EQCJUFCytfD5BdiSwmX/nKKp7
        gL34nEhEHISa1uAb7FXv8Z2Xdw==
X-Google-Smtp-Source: AA6agR5gtPQIV/66kXeeuRBLEkMRihbEDAybdp29TUCUCXHlUiY9DPvVWlTWEI/FKuAAiZPH0IzfDw==
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id v10-20020adfe4ca000000b00228d8b748a7mr1216182wrm.300.1662453963537;
        Tue, 06 Sep 2022 01:46:03 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003a30fbde91dsm19226259wmp.20.2022.09.06.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:46:02 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:46:01 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v7 1/2] dt-bindings: misc: fastrpc convert bindings to
 yaml
Message-ID: <YxcIyRadKQN+BmRe@linaro.org>
References: <20220905144554.1772073-1-abel.vesa@linaro.org>
 <3649a134-0ea7-b67c-8b5a-2971f090446c@linaro.org>
 <YxcFB4lEu16SXOyl@linaro.org>
 <2ffe1ad9-bce9-ff4c-f6f2-6473f4939a52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffe1ad9-bce9-ff4c-f6f2-6473f4939a52@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-06 10:36:14, Krzysztof Kozlowski wrote:
> On 06/09/2022 10:29, Abel Vesa wrote:
> > On 22-09-06 08:45:22, Krzysztof Kozlowski wrote:
> >> On 05/09/2022 16:45, Abel Vesa wrote:
> >>> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> >>> dt-entries correctly and any future additions can go into yaml format.
> >>>
> >>> Use compute-cb@ subnodes instead of just cb@.
> >>>
> >>> Also add qcom,non-secure-domain, qcom,glink-channels and
> >>> qcom,smd-channels missing properties to make sure dtbs_check doesn't
> >>> fail right off the bat.
> >>
> >> qcom,non-secure-domain is in original binding, so I don't understand why
> >> it is being "added".
> >>
> > 
> > Yeah, my bad, I should've added this line to the changes since v4.
> > 
> >>>
> >>> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>> Co-developed-by: David Heidelberg <david@ixit.cz>
> >>> Signed-off-by: David Heidelberg <david@ixit.cz>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>>
> >>> Changes since v6:
> >>>  * renamed the parent node name in the example from smd-edge to glink-edge
> >>>
> >>>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
> >>>  .../bindings/misc/qcom,fastrpc.yaml           | 118 ++++++++++++++++++
> >>
> >> As you can see in Rob's bot report - the patchset introduces errors and
> >> is not bisectable.
> > 
> > Please note that Rob's bot report is for v6.
> 
> I see report as a reply to this patch, so for v7. Why do you think it is v6?

Oh, didn't see Rob's bot reply to v7 before.

> 
> > 
> > v7 fixes the errors reported, by using glink-edge instead of smd-edge.
> > 
> > Looking at all QCOM SoCs that have fastrpc node in devicetree, they all
> > seem to be using glink-edge.
> 
> I was not talking about these errors (they were separate issue). I am
> talking about wrong path error.
> 

Yes, got it now. Will resend.

> > 
> >>
> >> You also need to fix qcom,glink-edge.yaml
> >>
> > 
> > I don't see why, with the changes I made in v7, there are no errors
> > anymore.
> 
> There are, but not from tooling. The error is wrong path. It should be
> converted to proper schema $ref.

Sure. Will do.

Thanks!

> 
> Best regards,
> Krzysztof
