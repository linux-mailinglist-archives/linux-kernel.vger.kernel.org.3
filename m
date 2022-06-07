Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693D540400
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiFGQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiFGQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:43:39 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5EB36C0;
        Tue,  7 Jun 2022 09:43:38 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q76so10855080iod.8;
        Tue, 07 Jun 2022 09:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQhN2bCw2qzHzEfViF9RH6IaU2tqDjbhZaw77rQjUj8=;
        b=OCB+dnI5IN7FO5ybiN90ipNOZOwukyvWjrLaV9cATXZkL4R/3yitkfqugVxbI/273W
         gkly7Ey8PmU4mubLtYbILSlYzG/plbgjcEt36SefnWtqdHa0gV4hJLLdtnEi00RB084+
         YDkaE2pfuhxX8yvN6Mk8DPD7WlL+Med5QRiyeoU+Q8vp1ItLdhgIB4mxvyfyGnKeTzSX
         A8UHMb8PbzZcV+OLvB1gjIuzc8NSWWTklwrwJUOaJy8fNV0H++bR9EbZL0PAaIVtvz1b
         H5ByQqY9mzqJ8NYrPai5G51QGGcfqWxZhZBY7dzZOyy3/Q1J7n58XuD6JL3JNOUguUTQ
         g5hw==
X-Gm-Message-State: AOAM5306kN5iGxR1vFMlRz/M98xFmTprhFtIyNiErxy+rvOp7GD6qjp4
        NrUibXP8aCCZgJkmGb7d1A==
X-Google-Smtp-Source: ABdhPJyJ2L0oQIGdzZg1DvKHr4FFEhIlqyV/wjzoCkNQxGXJJFfSgVxrTPgvLeSYaY/OCk76B5bIOg==
X-Received: by 2002:a05:6638:371e:b0:331:bc34:c3b1 with SMTP id k30-20020a056638371e00b00331bc34c3b1mr4629870jav.68.1654620217640;
        Tue, 07 Jun 2022 09:43:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z9-20020a921a49000000b002d396d6a2b4sm7456318ill.13.2022.06.07.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:43:37 -0700 (PDT)
Received: (nullmailer pid 3412797 invoked by uid 1000);
        Tue, 07 Jun 2022 16:43:35 -0000
Date:   Tue, 7 Jun 2022 10:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: q6v5: fix example
Message-ID: <20220607164335.GA3409694-robh@kernel.org>
References: <20220606132324.1497349-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606132324.1497349-1-luca@z3ntu.xyz>
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

On Mon, Jun 06, 2022 at 03:23:24PM +0200, Luca Weiss wrote:
> Use the node in the examples that is present in msm8974.dtsi, which uses
> proper flags for the interrupts and add required 'xo' clock among
> others.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         | 41 +++++++++++--------
>  1 file changed, 23 insertions(+), 18 deletions(-)

Please consider just converting this to schema instead. Then we actually 
check the example.

Rob
