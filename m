Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC355C868
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiF0Nls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiF0Nln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:41:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2A2AFA;
        Mon, 27 Jun 2022 06:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3149EB816E3;
        Mon, 27 Jun 2022 13:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46BAC341C8;
        Mon, 27 Jun 2022 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656337299;
        bh=pCG5s39AJ9DVqDRGCv6x03MsqLw2hoNiDc/CQCC/rSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BYmjBt8UP2j6IIT72mZcrUcskbTGd8WtD/KjJrlIngIqtNG9JEAJqDVc839Ugr3kC
         qw+RdKlOAdAkxw15QJhFV3F8HDP3xGvNIHkJ99Ox8lVi19t2T3ze3lobXX6KvRnw9t
         xIMMb2WYbnzPaPhzVHcHuQCnBbXnfQOJcMoTt5rXDPeGD+c1Kk5Mal6QhPo6PLgE90
         aUEZ9XlSO82Pw73RRtCsT/B2UGiE+NOIhthC4ektNI9ocFBGcy8l3vgRbK197anjmf
         LWmEgcbLriHop5HKt9rxZ/SUaJapvMvMZTJbPZ8Y+vPJLbodSVmk9RUa72dXpF6QWG
         eCxl7rwm4Gxeg==
Received: by mail-vk1-f175.google.com with SMTP id bb7so4472371vkb.9;
        Mon, 27 Jun 2022 06:41:39 -0700 (PDT)
X-Gm-Message-State: AJIora9GXSEumQTQapiTpoYvq0bg6drz9Ehag/9Z0EfbRZbNGy51GCik
        1hUPvoTvnyO4oVBpJDOFYeLMQP4vvW5QT54m3Q==
X-Google-Smtp-Source: AGRyM1slNcLsPZreCo8jteG/8X2opfPUctBMU3rLVPYIEDG2Ydtd+0sdfd2zX3U0XFUbg2Iv6nS7EqmRIVLB7ZSf9TE=
X-Received: by 2002:a1f:2bd5:0:b0:370:23aa:ead7 with SMTP id
 r204-20020a1f2bd5000000b0037023aaead7mr1002325vkr.26.1656337298837; Mon, 27
 Jun 2022 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org> <20220521164550.91115-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220521164550.91115-4-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jun 2022 07:41:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com>
Message-ID: <CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] dt-bindings: arm: qcom: add missing QCS404 board compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 10:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Document board compatibles already present in Linux kernel.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

This is now failing in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.example.dtb:
/: compatible: 'oneOf' conditional failed, one must be fixed:
 ['qcom,qcs404'] is too short
 'qcom,qcs404' is not one of ['qcom,apq8016-sbc']
...
 'qcom,qcs404' is not one of ['qcom,sm8450-hdk', 'qcom,sm8450-qrd']
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/qcom.yaml
