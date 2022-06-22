Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83E554872
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354922AbiFVIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354624AbiFVIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2738BD9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v1so32552750ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BsJ9AjExKxS8yeQKPuiXrngSiNMZjysQO2j+WxtI0l8=;
        b=aIHLGGh6nKlhUde7z1f+qNmLdyXR/tOGlJN+Vf4B74ijIDsu0cdwowYkzRubsgL8mr
         uox4P12u962oGW1UABisPD7ibuTvAVwuDkXhUijF91Rbu7NLCkj5EcSd7fS9nA9JMDFQ
         SSTAayJetZ/7/yvMMnlZ48ZRlSr25fTNDsLBNMB8tFQiWaFD9davQznx15tOCTzX3sPu
         3okTQb/ExzI2h5PS4AZQI4kyaf+MdY3nCHMlXmzdvFFLcak1Sntos9XftHx337uEMkAg
         FCjtRJkYXOqeuqUYJ9tvcfcrnpplqutuebGI7RdNJJtO0XFsP05huQzpW5goTX7OKV8S
         m0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsJ9AjExKxS8yeQKPuiXrngSiNMZjysQO2j+WxtI0l8=;
        b=oJCM7nBoR2yTpvdT44jxtLTsb7aomsidZQmHDneIq5I8cbU5EQL2CVZW4oqFOeqHio
         btDIDVlng8z1VzecD+LTMBn6QovZ8Q97a4kssBpO1IGKVG5LYOuHbnHziglSBEIpLl9O
         773i2tAr340TNw0QS0L+81ZO+MWBgrSlWwhh26DTj2+vlkUo1O4VgWqNA4sAp8BfKHrL
         5Yg9OrzPXL5uJp4zRGoS3YKH+Q1XRvW/Ex2jTnAQ7MyZl0UbRYnrpmeDzEp2FNF+yufA
         IGQ0W2A+BpterW6FVFitrd7pO8CRkDGp5MaK4jg/5GVB/Sok1/VTuMsIUBsQTq3bgmjM
         GpIg==
X-Gm-Message-State: AJIora/jGbQrvWqj4boP1/lDfcY8wywnH6mc2yDKy66Pm9kglWkRhsGL
        mS00HqcJGwhTTc5W0K8UWb1F4g==
X-Google-Smtp-Source: AGRyM1teJ7lkpIDq+FmyAzllCvPp71rU4IJ/dvt17qxwuMQQdXtA9pISOpaz9GXoyQnJRIbOKaning==
X-Received: by 2002:a17:907:7288:b0:712:174:8745 with SMTP id dt8-20020a170907728800b0071201748745mr2016602ejc.268.1655886953275;
        Wed, 22 Jun 2022 01:35:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH 4/6] ARM: dts: qcom: apq8064: add unit addresses to QFPROM regions
Date:   Wed, 22 Jun 2022 10:35:38 +0200
Message-Id: <165588692598.15720.15275892628171765658.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505113802.243301-4-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org> <20220505113802.243301-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 13:38:00 +0200, Krzysztof Kozlowski wrote:
> QFPROM children have 'reg' so they must have unit address.
> 
> 

Applied, thanks!

[4/6] ARM: dts: qcom: apq8064: add unit addresses to QFPROM regions
      https://git.kernel.org/krzk/linux/c/439e49349c146c0965bd6c9e214c2b703119108f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
