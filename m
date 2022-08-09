Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BE58DFAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbiHITDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345386AbiHITCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:53 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAC2B244;
        Tue,  9 Aug 2022 11:37:15 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id q124so10299212iod.3;
        Tue, 09 Aug 2022 11:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VcS9DI/HMc/JsteoV/NPZ4X0etS3RlJ37iZ4qDrww+E=;
        b=GnAey26nzHhJrA1OYtQYel4EHIIbry2J939iLUiwRh0XqL03vQ0qlclZcwFzgjMlB4
         kTa5LE+o1B4vSHsBUjyuTMoBhz0c6+eWwdVwiTgQMvJykQJxUdkBhqCmW+1eSTIMY8HF
         SSS2t7b+Y8x58qWQmXcB2goBESDy5g+14ka/QQOuAbeMlVIo1OxdtA/tVyPIMJy7vMcb
         TkP5Ux/y2okV9iicM+gRPVAkIrrGR5Z2qr0A46hdS54JO4MdEk3E4kUzmnDF5PINXMkc
         S9K8CMWmVo9kVmjLmcgZQbrjgXgjdwkiqAc/EUUmIVzkd6pMorHwvYVqoeXUNjcOb+oO
         yyyQ==
X-Gm-Message-State: ACgBeo2beBK1Z3vXekQUm+7dmW1aGeZyCJDs/9cbUQ5gCoZrCnh/g3E0
        JhzfAFNcfmCA0Ru5wg3yJg==
X-Google-Smtp-Source: AA6agR7XlRb2Pw2sz0INbVS0WO6qlPD/3W76n6AhSNKT9JG5HI3pRgKPmETO0BOlupLLg7uoKI3dGQ==
X-Received: by 2002:a5d:9616:0:b0:67c:2039:c88e with SMTP id w22-20020a5d9616000000b0067c2039c88emr9771775iol.68.1660070234418;
        Tue, 09 Aug 2022 11:37:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l10-20020a056e0212ea00b002dd6c2cf81dsm1309957iln.36.2022.08.09.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:37:13 -0700 (PDT)
Received: (nullmailer pid 2163003 invoked by uid 1000);
        Tue, 09 Aug 2022 18:37:10 -0000
Date:   Tue, 9 Aug 2022 12:37:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     bgoswami@quicinc.com, broonie@kernel.org, swboyd@chromium.org,
        srinivas.kandagatla@linaro.org, perex@perex.cz,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        tiwai@suse.com, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, quic_plai@quicinc.com,
        lgirdwood@gmail.com, agross@kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: remoteproc: qcom: adsp: Add
 compatible name for SC7280
Message-ID: <20220809183710.GA2162944-robh@kernel.org>
References: <1659611751-7928-1-git-send-email-quic_srivasam@quicinc.com>
 <1659611751-7928-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659611751-7928-3-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, 04 Aug 2022 16:45:45 +0530, Srinivasa Rao Mandadapu wrote:
> Add compatible name and update max reg items for SC7280 base platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since V1:
> 	-- Change reg property maxItems to minItems and update description.
> 
>  .../devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml       | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
