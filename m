Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C94CAC4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiCBRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiCBRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:42:08 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69987C6238;
        Wed,  2 Mar 2022 09:41:25 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so2295248otl.6;
        Wed, 02 Mar 2022 09:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6IxKBTtEzw8gh7TxlNKKlosnx/4N4oHWRoIc0tYEz0g=;
        b=u9CQfVheKtjEIDVPJDda+zOKER5iBnniQp0hyMWD7613Nd9kFH4thy9VsUzK17EZG7
         wmwvDv3hsBDjkKbLqwz5FQMw/wnRSY+2Fh1+Ay0d6DihWkJIYAVEjpQj1skzawGwNqTV
         iMA1Bzzg+Hh1jA0zktxEbA8+26MMYiR0KP68t39Nu8wY14QQgD44+Ea4jv0YKqPFKIj/
         gvwx4Heb2oqcO1iqnVMDWGqvh+GuaiwqV/sijuVu8RAQY2VEjOTHy6BcpHo4A0pwr8d1
         wmF8lubPwhoN2itKQxDzS4Nm1zJtrSFgvxF9sb6D2l1ErCKvY4gmZzqMZnM73SKKlFB8
         e29A==
X-Gm-Message-State: AOAM5319jRajO22lG/1NGvOv2CYx5N95w0riXcYl7BLKeFRStQOdV/vr
        eklpVulCc9C6ZLS1t1bcfg==
X-Google-Smtp-Source: ABdhPJz3HvtB/9nZ9y7vb8pIEBLrCJ2Y7Sw6RsXgoFqpwwNdFPpxjRViFygumN6TFDWeQkduH6QHww==
X-Received: by 2002:a9d:7845:0:b0:5af:39b7:ff32 with SMTP id c5-20020a9d7845000000b005af39b7ff32mr16742817otm.8.1646242884726;
        Wed, 02 Mar 2022 09:41:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830144f00b005af6bad7fb0sm8156248otp.68.2022.03.02.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:41:24 -0800 (PST)
Received: (nullmailer pid 3939788 invoked by uid 1000);
        Wed, 02 Mar 2022 17:41:22 -0000
Date:   Wed, 2 Mar 2022 11:41:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        vkoul@kernel.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 3/3] dt-bindings: soundwire: qcom: Add bindings for
 audio CSR reset control property
Message-ID: <Yh+sQjCRWsPRqCD3@robh.at.kernel.org>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
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

On Wed, Mar 02, 2022 at 06:13:02PM +0530, Srinivasa Rao Mandadapu wrote:
> Update description for audio CSR reset control property, which is
> required for latest chipsets to allow software enabling in CGCR HCLK register.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
