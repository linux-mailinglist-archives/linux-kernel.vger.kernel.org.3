Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF14B55BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356239AbiBNQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:10:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356190AbiBNQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D160D86
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h6so27663683wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JY40me+cvEI+ZEwVsx9mxL0PQSUpWscJw7u6fHkuhDs=;
        b=AaWb3EXnFJJwL2tB8qsT5Esv4Am6bmqjQpmSxSu04umlOcmywi90ZilbwSqTqJDmQN
         OaTcel2iWBLo9lsuucGMqPy5SacvBr3kDQtKS4GyNZ1qlBBvMgz9MlWuZD9fv3WtpOwh
         /CdjMG+tEmtiy5bieQw2B9pVQ9Q4KtVVkbb96KA1iVdw0IaNfwdr0H10vcXxFeSx+32/
         b9B1fuiLbtLSVnyBfjoxvygzRnOyMlzs/rqx/N0ame2He2o7YgPbM23/YhhDSmsERznQ
         a7Mcm1E7j2+a8W2vK1d17djZNJli023KOx6uNFaebv3iFVikpUF0kM8dVI4xkrFIZBpa
         YIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JY40me+cvEI+ZEwVsx9mxL0PQSUpWscJw7u6fHkuhDs=;
        b=oGOGYEE4mdyJ0QTGOEoU8zwSLagW/js0SED0bw6yqxt79zEq2o/sSCptC2XnTNKD6g
         zlMS0Q947X0l7afArwve1e6MAJhVZaofJMt7OzKZFF80VWsKedghUADJ1U8W0cLa3VZp
         13TThTYUIQhvqTREQeVt4uyrL6OsEcMudbLzfjyB05FFSwXoTHRtj0exp/bl3hq2WcmL
         VCquRzS2UQhIMJ1LBr9aSeUr2UhhSd+5W71fe4UEPB61re5HTzatKPEf6jPbqAPemKIn
         5B4vGQbUtfYSXA7j3pSnyGjb+hHSEw8GboGzPn0ACST4MDm1nwdqT2LXzg9kbhrh9W9N
         CYMQ==
X-Gm-Message-State: AOAM530hyLGOmf0amK8ezPZM99AQUg+hasOq9Rkizq2CvjG97lg3r51Z
        dOLQ8athLz2yqWDp3S2UFnTzxQ==
X-Google-Smtp-Source: ABdhPJwe/E4mNaJBfa58EgO8WJ6izbNMYSP3r5UvZf9qn9blb5yzAxRjpNNufTXONkF8KQvFBS9CDQ==
X-Received: by 2002:a5d:4dcc:: with SMTP id f12mr277291wru.598.1644855016240;
        Mon, 14 Feb 2022 08:10:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 07/12] dt-bindings: misc: add fastrpc domain vmid property
Date:   Mon, 14 Feb 2022 16:09:57 +0000
Message-Id: <20220214161002.6831-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
References: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>

Add fastrpc domain virtual machine IDs property. This property is used to
setup memory protection for remote processor.

Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
index f9a01e2b4c96..5ec124b138a6 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -22,6 +22,11 @@ other tasks.
 	Value type: <boolean>
 	Definition: Property to specify that dsp domain is non-secure.
 
+- qcom,vmids:
+	Usage: optional
+	Value type: <u32 array>
+	Definition: Virtual machine IDs for remote processor.
+
 - #address-cells
 	Usage: required
 	Value type: <u32>
-- 
2.21.0

