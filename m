Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFF598763
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiHRPYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbiHRPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:24:05 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C651B72AA;
        Thu, 18 Aug 2022 08:24:04 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id u9so1854551oiv.12;
        Thu, 18 Aug 2022 08:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gnwNt4bzr2qCnvr4ju2qpGV+gCVuK0IjgUJ83knjKEA=;
        b=fE++v8k1R3dp4a4SaOAL9VdXGPSP2V4aEakKI8AF/4cwtGh06o0xgJxfvIuC7Q0P1v
         Y6tbK9FAu3Sc6FWXX1WrFWWZ+2piizUxuWTgvhzIqeG684kzPnrMzc+YM6aCRnYL4Rl/
         JcdoZqdeNllodfHIxc+1KylaAUQ8pBRtYzwJyxfVErfDpnPzPb2kozBEiVcAWnib4DrZ
         +XJdI9d4ANIVxp7N7AcblaqOZ9WjVd58h3q65wvdHG+rx0ry+DdWcCgV96+BXIcjIp5D
         vesKMS5ju2769I06iwriFVD72MAwLl6NRYkyyWKgDKY5Ak+v+7f/gyt4vUKBCAUkBltH
         ecCw==
X-Gm-Message-State: ACgBeo3fmR5t8cwp48u8WIqSv3K1xBFHH1LelT3I+a37qnrv0jPNL9K7
        v+MXsFIQa1VKh3pxd+V9aQ==
X-Google-Smtp-Source: AA6agR4bDZuxqokyMcKfa+YPkWiyULO1WtQ3vOZ6OL3mqwXVBlywPpvai3aUPwf49sLOze8PP+pkYA==
X-Received: by 2002:a05:6808:1389:b0:345:fde:79eb with SMTP id c9-20020a056808138900b003450fde79ebmr1902862oiw.21.1660836243611;
        Thu, 18 Aug 2022 08:24:03 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id p1-20020a544601000000b00344cc0c4606sm401342oip.58.2022.08.18.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:24:03 -0700 (PDT)
Received: (nullmailer pid 1895136 invoked by uid 1000);
        Thu, 18 Aug 2022 15:24:00 -0000
Date:   Thu, 18 Aug 2022 09:24:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Message-ID: <20220818152400.GL1829017-robh@kernel.org>
References: <1660649034-4303-1-git-send-email-quic_srivasam@quicinc.com>
 <1660649034-4303-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660649034-4303-2-git-send-email-quic_srivasam@quicinc.com>
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

On Tue, Aug 16, 2022 at 04:53:48PM +0530, Srinivasa Rao Mandadapu wrote:
> Add ADSP PIL loading support for SC7280 SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since V4:
> 	-- Update halt registers description in dt bindings.
> 
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 196 +++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
