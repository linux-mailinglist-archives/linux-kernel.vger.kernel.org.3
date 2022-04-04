Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ACB4F1FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiDDXHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbiDDXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:07:26 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D345063;
        Mon,  4 Apr 2022 15:34:42 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so1978552oof.12;
        Mon, 04 Apr 2022 15:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zggGbQOFJcmZFk0eBWIgQPmPowbbYb21nM8ye27Trm0=;
        b=4IYe/vHeJ6yJD3dwoXB4pmY729+FWTIk2didZvqwxL1NVokRQ3jNKvUtIicmyyoHSx
         5RWxSI+j2q203TjPLhls2NPz5LBDJnGjN35t2jySv0tyq/sHK9D9lMF/lWpAP0cPyux5
         0hKAFrlLGVrBMOKo4DCVJDEI+D3l2YNjK98UB6zHUvvCtL7Yejf0o5lnG3I5AWKhVp5a
         /ncDZ4RG70W3KWnfYbRP75PdxorozTgiRVTJNTNISJEVe/MaM8GE1PJ39LTlHAQoooeF
         uFeOw+BInY43iMspQ105gtTs6vVkMYMb240E4LJj7SJL2xyQaO9TkB3zfPTeacR4oGiw
         1t4Q==
X-Gm-Message-State: AOAM533N/miZqfNZBdH1VEWUXuczr1spJ4x9mupzoFJ0k24oUl5M8SGE
        RwCSeIAkfW9dPM9uziDp2Q==
X-Google-Smtp-Source: ABdhPJzQofZ81lvKdGpVk1x9AztAuD2R2C3qFlKoI5RmniUCgjx93uWVSRXCHdsrUIkBqvgln4cI6A==
X-Received: by 2002:a4a:c4cc:0:b0:324:725b:5028 with SMTP id g12-20020a4ac4cc000000b00324725b5028mr155207ooq.14.1649111681544;
        Mon, 04 Apr 2022 15:34:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0544000000b002f980b50140sm603165oif.18.2022.04.04.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:34:41 -0700 (PDT)
Received: (nullmailer pid 2125176 invoked by uid 1000);
        Mon, 04 Apr 2022 22:34:40 -0000
Date:   Mon, 4 Apr 2022 17:34:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,smsm: convert to dtschema
Message-ID: <YktygNS7OwWDJCNK@robh.at.kernel.org>
References: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:59:49PM +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory State Machine to DT schema.

Umm, the subject says 'clock', but this isn't a clock binding.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,smsm.txt           | 104 -------------
>  .../bindings/soc/qcom/qcom,smsm.yaml          | 138 ++++++++++++++++++
>  2 files changed, 138 insertions(+), 104 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
