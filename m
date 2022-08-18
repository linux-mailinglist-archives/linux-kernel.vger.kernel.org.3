Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F1598775
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbiHRP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbiHRP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:26:55 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8FBFE88;
        Thu, 18 Aug 2022 08:26:55 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w197so1887067oie.5;
        Thu, 18 Aug 2022 08:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rbisoohMs3uPePAbaauwnn0BbSjctMh4z2DNTBqGzPQ=;
        b=wpurvxFgaxi1v2Qa2k0jex7E0gRi0jh6SzSRXPiiE3y4HE1CCi5x/qgq6aznNd5bbI
         75PUqHOYxf1NcapVkpknPYc7s7nE/3AmAGte/lW8/1OeMcoi3Xf7uXZ8ARHLAv1ff1Bm
         9Me3o4roKHgDY7Q7hNdqu8crJnyBdQBMbRwBfDkNPM7rrWhzMYzjdP4WTnEnVWngjDFP
         2zuJplgUWs/Nc0hF4NmT3hLgl15x0ULbnSPAq4Du9IqNa7IeW4rwKRD7hrpnenT4+ndq
         qq3pMIz6jCh+N5aKH7oe/H9MApKqUjW+nigunLxlfcuc7fl93aG1mYSCKuYBGm7oG1ae
         6FUA==
X-Gm-Message-State: ACgBeo0klN3kyVGDwVCxOL1rj6XfOwGPyhkpnfbSJAuim3KVDQhEp85i
        1FxgI5LNMys8Azz7ujI7fA==
X-Google-Smtp-Source: AA6agR6nRlbimaon0C9gs4UjoLOSyrreNHuKdrI8XRsolBVK0h7tAf4Na97THJ2KUJwXo0Fkn3O8RQ==
X-Received: by 2002:a05:6808:2009:b0:343:60b:6dec with SMTP id q9-20020a056808200900b00343060b6decmr1453407oiw.1.1660836414323;
        Thu, 18 Aug 2022 08:26:54 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0c28000000b00636c81d4109sm478058otr.46.2022.08.18.08.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:26:53 -0700 (PDT)
Received: (nullmailer pid 1898912 invoked by uid 1000);
        Thu, 18 Aug 2022 15:26:51 -0000
Date:   Thu, 18 Aug 2022 09:26:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp lpass
 lpi pinctrl bindings
Message-ID: <20220818152651.GM1829017-robh@kernel.org>
References: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
 <20220817113747.9111-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817113747.9111-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:37:46PM +0100, Srinivas Kandagatla wrote:
> Add device tree binding Documentation details for Qualcomm SC8280XP
> LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
