Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC164FEC88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiDMBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiDMBwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:52:43 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273981B7B1;
        Tue, 12 Apr 2022 18:50:23 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so258019otr.2;
        Tue, 12 Apr 2022 18:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrgI0eS1ElcLM6jhSgmzrK2AfeoXw8Ye7zQQqXAfmeY=;
        b=1pkbQqHe/7Mkt8P10R+3Qz6FkkcTgEKxGaTB7JozputZAC5ARBAj3z2vyqjOuQg4Jo
         PRAYFikU2rgeTdDEb9x61t+RftiISHU9mRXNET4zVfl+ESgP2OhOPVmcQFtTJtG8jsVT
         hBz2PMbFJBNEZ5GobCjT3+Q7xmlUkS5FdvTw+fgNA/Nw1dfa8h0hn7yTw8bleZahqUOp
         B5PiGVKYchwMR5GqR+Lc416YKmknHzkOx15z8duAGjMSJhVltYoCtWgsvksOBj52viHZ
         Ay+M6p79RPbV7acgGDb4gnVJuxPFGcvgUORz40L9gcVRblG0HDWw7b/2LMIeJXSki7Yz
         78vQ==
X-Gm-Message-State: AOAM530PpLOVzWjVfg9rBe68+gOcwn5A3ay5E+CFo13FNsnfm9iNFcGw
        gWVeykAQMx4g6mFyuR2pjQ==
X-Google-Smtp-Source: ABdhPJxE74US2W8ggBrC29BIxNrWj5fAECF+o/bPpXAhAJmGMZomqDl468oD66LN7mZS0P5bRihU3Q==
X-Received: by 2002:a05:6830:2695:b0:5e6:e220:511e with SMTP id l21-20020a056830269500b005e6e220511emr5100629otu.9.1649814622427;
        Tue, 12 Apr 2022 18:50:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c79-20020a4a4f52000000b003325496f49fsm242137oob.1.2022.04.12.18.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 18:50:22 -0700 (PDT)
Received: (nullmailer pid 1409466 invoked by uid 1000);
        Wed, 13 Apr 2022 01:50:21 -0000
Date:   Tue, 12 Apr 2022 20:50:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_jprakash@quicinc.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, swboyd@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, quic_subbaram@quicinc.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V9 1/6] dt-bindings: mfd: pm8008: Add reset-gpios
Message-ID: <YlYsXUZr1Mtr+rjm@robh.at.kernel.org>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-2-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649166633-25872-2-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, 05 Apr 2022 19:20:28 +0530, Satya Priya wrote:
> Add reset-gpios property for pm8008.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V7:
>  - Removed the intermediate regulators node and added ldos
>    directly under mfd node.
> 
> Changes in V8:
>  - Change the compatible as per driver, remove interrupts from required
>    properties, add reset-gpios and move regulators to separate binding.
> 
> Changes in V9:
>  - Undo the changes from V8 and only add reset-gpios. Leave interrupts
>    as required properties and do not change compatible.
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
