Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2951F4AFC1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiBISzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiBISyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:54:53 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E58FC05CB8F;
        Wed,  9 Feb 2022 10:51:11 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id i5so3479189oih.1;
        Wed, 09 Feb 2022 10:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fvdpZTV3ckaaqmYf1r0cBoPpL4Nh0uK6c5tcGz3L+Q=;
        b=TMEmmd+nT/o0/S22Czexz+ropELmGNKKqaQf3XUj0Xvrrjv4URMjYPzXbcxHLdXVbG
         o/C93qswg0zw9pMHtsovPa0qmjKj9EXSIeR3gfJ5TW4bgMKQNzEy7XuYcGK4VLDjUqFF
         +qBb82wVNRi5Je7wfA70WCoA03pM1elEzdm1N2qfVmavLwKRZIfh8aqtR3CZ82ApQFf7
         Nfe/pSzPALdVR9DSlemkThuO+DW2aT9ZPyS6uWC6Aloc+AjK/4G+DNz6qIJA5dLUliPe
         nqNnc1kDu2UCpzXwdmqlp6Kj5mii0sc6I4GiMaWgrPQseo1jBGPbpiWZr9VW8bw27wEE
         OgjA==
X-Gm-Message-State: AOAM530oTgRS+1eKsT9Tyzi7osbSZ6NaYW93A6o0scLaaB82bWyNn4k5
        G00isLysbBDnZyQfGJSdow==
X-Google-Smtp-Source: ABdhPJzk+HGpZLHSZToDdciaFVZmnkfLTSXzQA4tao7CNi+oejAcML79liLhV6yLudclFs9TGhT6CA==
X-Received: by 2002:a54:408e:: with SMTP id i14mr1639470oii.200.1644432670672;
        Wed, 09 Feb 2022 10:51:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c6sm6878737ooo.19.2022.02.09.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:51:09 -0800 (PST)
Received: (nullmailer pid 681787 invoked by uid 1000);
        Wed, 09 Feb 2022 18:51:08 -0000
Date:   Wed, 9 Feb 2022 12:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, quic_collinsd@quicinc.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com, swboyd@chromium.org
Subject: Re: [PATCH V5 2/6] dt-bindings: mfd: pm8008: Add regulators node
Message-ID: <YgQNHIQSw74kKXb+@robh.at.kernel.org>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644331940-18986-3-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, 08 Feb 2022 20:22:16 +0530, Satya Priya wrote:
> Add regulators node and their supply nodes. Add separate compatible
> "qcom,pm8008-regulators" to differentiate between pm8008 infra
> and pm8008 regulators mfd devices.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V2:
>  - As per Rob's comments changed "pm8008[a-z]?-regulator" to
>    "^pm8008[a-z]?-regulators".
> 
> Changes in V3:
>  - Fixed bot errors.
>  - As per stephen's comments, changed "^pm8008[a-z]?-regulators$" to
>    "regulators".
> 
> Changes in V4:
>  - Changed compatible string to "qcom,pm8008-regulators"
> 
> Changes in V5:
>  - Remove compatible for regulators node.
>  - Move supply nodes of the regulators to chip level.
> 
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 49 +++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
