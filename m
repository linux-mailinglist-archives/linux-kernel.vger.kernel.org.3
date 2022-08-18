Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3331598A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbiHRRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344748AbiHRRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:17:03 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D03E74C;
        Thu, 18 Aug 2022 10:12:27 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id i77so1565844ioa.7;
        Thu, 18 Aug 2022 10:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=h34ROyt3to7gmxXibwOAJi1qMJdptGraIUSFnGPhnVM=;
        b=7F+4jl8fEDHJluoC6bU6tFhjzcmlzf8GCgWQWcDJRre0x3K0bS7NJP1ZLdLXX4NbsP
         UTwKfzyEvgXKwVQxSwNt/JY+B8JSWBGeF3vxwZLXcytNzg7IP/WDj0Dcc+C/7BPGWmsI
         DfqxIaD2FM7mMpBcwCcO4pYVobKsGe0GwHPWJ15NhXfbn/OhW9vfwW0HLuMvArF4/SGN
         3u6YEBikHh+ZYKWtuSfGmPhKSqbib8haYtkOSkedQBzQljw2a5KvFwmBU9e88yyxeKjl
         yhqAduTLvsPX5KeB5iuBJum4nRmjTRVQZ19QxqvFmQPkVBH18wcRSeIxzgd1rq6ucDhx
         ZLHA==
X-Gm-Message-State: ACgBeo2UQaLP/yX0g3ND31IuRout4PXqMRX9Cw1g9lYYAHKHoCCYJwgz
        Yi2F/gMbb58S8Ew3lhOQy+yFKfxpaw==
X-Google-Smtp-Source: AA6agR7HpaHm2KfXfJ2bjNl3Qk5UqRcAJECbGGNoRdZjq7jAod5+DycpivnxU6scCe+lJbgjt/6Zsw==
X-Received: by 2002:a05:6638:d93:b0:341:5cab:4d9 with SMTP id l19-20020a0566380d9300b003415cab04d9mr1792636jaj.146.1660842746366;
        Thu, 18 Aug 2022 10:12:26 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id p13-20020a056638216d00b003427e69f2b8sm780925jak.144.2022.08.18.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:12:25 -0700 (PDT)
Received: (nullmailer pid 2046290 invoked by uid 1000);
        Thu, 18 Aug 2022 17:12:22 -0000
Date:   Thu, 18 Aug 2022 11:12:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] ASoC: codecs: wsa-macro: add support for sm8450 and
 sc8280xp
Message-ID: <20220818171222.GG1978870-robh@kernel.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
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

On Thu, Aug 18, 2022 at 02:46:15PM +0100, Srinivas Kandagatla wrote:
> Add compatible for sm8450 and sc8280xp.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 27da6c6c3c5a..f82c297ea3ab 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2561,6 +2561,8 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>  static const struct of_device_id wsa_macro_dt_match[] = {
>  	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>  	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
> +	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
> +	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },

Looks like these are backwards compatible with the existing versions, 
why not reflect that in the binding?

Rob
