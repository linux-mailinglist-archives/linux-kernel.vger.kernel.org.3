Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C664AFC18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiBISyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiBISyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:54:07 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4AC1038C5;
        Wed,  9 Feb 2022 10:49:37 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso2160759ott.7;
        Wed, 09 Feb 2022 10:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ol4BsW1oMUlKiUOMTOMJiIWnj4Q1uMf6kno3XDyNZOA=;
        b=Ka/4XpFyOPmdDzlfOTzVtYFK53wKBbUuR6/GGWMIMHjsGXCVwnt5EoVsvUotxRJpbx
         aq7jxihI5N+ULRufX+7lNK6wjarzlY5tF2Y4KVJphg+cnIa1TDlZhlHw5W0Gca232ueO
         33M9YREy0AP3Kex7XL084NrCFDl3wwZ6we6CLVsGe/LpbvIKSYqhgJI/tENhQUHicr/K
         nQgXOWUqh5f04PAHWsW42DZUpknCpT5CMwJNGUj0/S0duxzXIMh3I8IfF8UmWlWXx1Vf
         2L4tNOuQRRQkkQeZmfqrKMP7WdDbbvEckYJDwaZvk3u2p4RTb2HEGG+VuD8eB7I2zOMH
         qUWA==
X-Gm-Message-State: AOAM531WQA7fIgCmDh/5hhJN/LMZ+whGiBCUXB/UECZYy+CeacXEjxGi
        qBcs54FjCe2tVYH5Rmu8omhwD/2vfg==
X-Google-Smtp-Source: ABdhPJz+VCZspSXacvPHH6CrC/kxILESQsbekO37HlQjWHQZMcp1DTf1NUx7uszKx75y4LZYh2dHRQ==
X-Received: by 2002:a9d:6d85:: with SMTP id x5mr1497301otp.302.1644432576631;
        Wed, 09 Feb 2022 10:49:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b7sm7024971ooq.30.2022.02.09.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:49:35 -0800 (PST)
Received: (nullmailer pid 679557 invoked by uid 1000);
        Wed, 09 Feb 2022 18:49:34 -0000
Date:   Wed, 9 Feb 2022 12:49:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        swboyd@chromium.org, Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, quic_subbaram@quicinc.com,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, quic_jprakash@quicinc.com,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V5 1/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
Message-ID: <YgQMvrgA+gz/YtOU@robh.at.kernel.org>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-2-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644331940-18986-2-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, 08 Feb 2022 20:22:15 +0530, Satya Priya wrote:
> Add bindings for pm8008 pmic regulators.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V2:
>  - Moved this patch before "mfd: pm8008: Add pm8008 regulator node" to
>    resolve dtschema errors. Removed regulator-min-microvolt and
>    regulator-max-microvolt properties.
> 
> Changes in V3:
>  - As per Rob's comments added standard unit suffix for mindropout property,
>    added blank lines where required and added description for reg property.
> 
> Changes in V4:
>  - Changed compatible string to "com,pm8008-regulators"
>  - Moved "regulator-min-dropout-voltage-microvolt" to regulator.yaml as
>    separate patch.
> 
> Changes in V5:
>  - Removed the separate compatible for pm8008 regulator driver.
>  - Moved the supply nodes to chip level.
>  - Removed min-dropout property.
> 
>  .../bindings/regulator/qcom,pm8008-regulator.yaml  | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
