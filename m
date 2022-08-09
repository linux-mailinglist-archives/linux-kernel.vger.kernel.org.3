Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB058DFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbiHITD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345262AbiHITCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:50 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FA22BD6;
        Tue,  9 Aug 2022 11:36:39 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id l24so10272076ion.13;
        Tue, 09 Aug 2022 11:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5EdrWPjpBP3VYdnyEWUwLGGLE7oilUX8uvXCZ6ZG7Vg=;
        b=6RW5BOXGNi3cvgKJQTeeH9nKUXIVJWsOvSFA73IR7h34oX4dOA1qJiM48ZLA64pm4X
         o90T+vVIlDLnrz1OZhUxyhlypynNN64bU1QlrzWfTBnhgu5uMH1T2VaY03LDrvid0WSh
         4OOES+ah9aUHJj86K+3VpIH3BobxNUUDezxyjdiKCHG7+qfU8Yf+JOsztt3q6WrJzUvL
         G0Xv9jWADOxjuPo7H5xTCxWb/nHWON+hN0getMabFRoPLd8kHv/7UAdns+SvXJT4OPTz
         tzLLN5tJrqtENmOlJ9cAtn4ojp/4wbtapWH86KXml7LWS1+7ydIialM1FpVNuzKOHSSl
         y9mA==
X-Gm-Message-State: ACgBeo07gm4EcGOk9L0wmqPX7tToKSgdmruF3MKtb0QcmSpqJLlLj73Q
        Bn1a8Xwnb9Zv4S97Qx3EUbQwDA8bNg==
X-Google-Smtp-Source: AA6agR5yPwtVmgqurmOG5Cpbap2+YlmJxk40xTsHVhmWulzBqkcUJkTyNz/+N2CLRsLMSt09UQhcZw==
X-Received: by 2002:a02:ccb2:0:b0:342:6ec9:491e with SMTP id t18-20020a02ccb2000000b003426ec9491emr10888479jap.241.1660070199149;
        Tue, 09 Aug 2022 11:36:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i63-20020a6bb842000000b00684384bfcbbsm1399728iof.24.2022.08.09.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:36:38 -0700 (PDT)
Received: (nullmailer pid 2162023 invoked by uid 1000);
        Tue, 09 Aug 2022 18:36:36 -0000
Date:   Tue, 9 Aug 2022 12:36:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP
 pil loader as generic
Message-ID: <20220809183636.GA2158474-robh@kernel.org>
References: <1659611751-7928-1-git-send-email-quic_srivasam@quicinc.com>
 <1659611751-7928-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659611751-7928-2-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, Aug 04, 2022 at 04:45:44PM +0530, Srinivasa Rao Mandadapu wrote:
> Rename sdm845 adsp pil bindings to generic name, for using same binings
> file for subsequent SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 160 +++++++++++++++++++++
>  .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 ---------------------
>  2 files changed, 160 insertions(+), 160 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml

Please use the git-format-patch -M option so I'm not reviewing the whole 
doc again. You also can (and should) change your git config to default 
to this.

Rob
