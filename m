Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29F544FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiFIO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiFIO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:56:10 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59A3871A4;
        Thu,  9 Jun 2022 07:56:07 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id r5so1323355iod.5;
        Thu, 09 Jun 2022 07:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ikB6YJSl5vJ4cPxB+SR4C1C7bWjvKiJRtoZ3B3fpkIg=;
        b=kIQyrIcYQNqyT/cOJQ2YXH0Us1pnSGmDtr/pWBJWiesqTQTaRjVYOctS7KEKdJk0hv
         r2xQToYnOSEU+fRCjg0ZgAXVlduCbP2ziQYcG/5UNdGSMI3LZPwGKECKCoomFYhtNdNV
         ZksMT66THCsUulbxecH1kviKm2MXU9E1xNptNhwA5+LnogcWaJ7PeLlLLLMZQPRRbLfX
         VjoOe9/6Pk7nQpA+lM26Ygk+CZ+jARMGR9YlGWCpgHP3cgQRxp40hz7Fjbg1E24ieVB9
         4vHNSQzAYF+TYOxdxkHG6jVsCAq+WWFs2vFqfRxPK43Ydm4cMi/OQh+SF0k7IOrhknLo
         tybg==
X-Gm-Message-State: AOAM533TbW2Hmk1yNjXC4xsIHougiNYbeZp3b3ne073a9hSmpg8rR/E5
        L97oUFPLCfVXttSmZGZBGw==
X-Google-Smtp-Source: ABdhPJwrdtzdoJI7G135qeLaR3UCx5EafkyJoQg9adSeymPU9nQ4XeCrBEFI+xv1qjv0jNt5M/EEzw==
X-Received: by 2002:a02:9f14:0:b0:331:9195:dd3e with SMTP id z20-20020a029f14000000b003319195dd3emr13796820jal.0.1654786566891;
        Thu, 09 Jun 2022 07:56:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i45-20020a02602d000000b0032e22496addsm9493537jac.139.2022.06.09.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:56:06 -0700 (PDT)
Received: (nullmailer pid 3783129 invoked by uid 1000);
        Thu, 09 Jun 2022 14:56:04 -0000
Date:   Thu, 9 Jun 2022 08:56:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: clock: Add support for external
 MCLKs for LPASS on SC7280
Message-ID: <20220609145604.GA3781473-robh@kernel.org>
References: <20220604062137.14584-1-quic_tdas@quicinc.com>
 <20220604062137.14584-3-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604062137.14584-3-quic_tdas@quicinc.com>
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

On Sat, Jun 04, 2022 at 11:51:36AM +0530, Taniya Das wrote:
> Support external mclk to interface external MI2S clocks for SC7280.
> 
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
