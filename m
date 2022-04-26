Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAD50EDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiDZA5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiDZA45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:56:57 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505111F616;
        Mon, 25 Apr 2022 17:53:51 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id z2so19083816oic.6;
        Mon, 25 Apr 2022 17:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LiBb1G/G7jJu1o65ShfAjvqlVVoLC33DiAZWBcbJn+4=;
        b=k/thr53Z6qcTZqQ5Q4ETWcPWOx3rDwkYFVQv3tn7jtwxpYNKY/hY33VMKA1gjm7Klu
         kji4uwdiUHyaDjVjhpb+WbjnfLyNse7v9XQhJZNVAAZSwBI2wWh/Dx5+ZUJsZOip5d8v
         JmSlL6DIXb4n7yUQSRak/0HkPv8uOiVcpWR6njLesM8h9Spic5++GVEv0qL6q5jIip56
         +qAQaWt72iR+Xeq0iok7HrqdnssJnTrl+h2CZ4SMQAv6Vtt4+ZN63+DOx9Ft5ZIUCuLi
         b9ERobUYg+fqDtblai5mMuEdAbBVAkPZqG6vq6DMbqLPOg+68Wp5jBPJFMkYA6dnQf2j
         NM0Q==
X-Gm-Message-State: AOAM530bLUo4heP4U0iLKHtykNps65r8mrT4ad80thdkt0wfcDacSyM/
        iK0+PcX4AIMir799+p8ikA==
X-Google-Smtp-Source: ABdhPJxRtbVDPzmmRpgRZB/ig6Pk79odkg8n0ekCj8+d9FU1Xibzq+67urtM1Z7f1l8HGFrnC+qJGw==
X-Received: by 2002:a05:6808:28a:b0:325:5b2e:bfb2 with SMTP id z10-20020a056808028a00b003255b2ebfb2mr466762oic.206.1650934431026;
        Mon, 25 Apr 2022 17:53:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z5-20020a0568301da500b006054fd8c847sm4416348oti.11.2022.04.25.17.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:53:50 -0700 (PDT)
Received: (nullmailer pid 655384 invoked by uid 1000);
        Tue, 26 Apr 2022 00:53:49 -0000
Date:   Mon, 25 Apr 2022 19:53:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: qcom-ipcc: add missing
 compatible for SM8450
Message-ID: <YmdCnWRu6AgBlsEH@robh.at.kernel.org>
References: <20220425134717.55418-1-david@ixit.cz>
 <6f72be3c-c907-bc7a-6b64-6becfc76934e@linaro.org>
 <33da014b-bfb0-a39f-aba7-f469fcb5cfbb@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33da014b-bfb0-a39f-aba7-f469fcb5cfbb@ixit.cz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:05:57PM +0200, David Heidelberg wrote:
> On 25/04/2022 15:51, Krzysztof Kozlowski wrote:
> > On 25/04/2022 15:47, David Heidelberg wrote:
> > > Adds forgotten compatible and update SPDX header.
> > You need to explain what is this "forgotten compatible". It's to vague.
> Forgotten by someone who implemented it in driver. Hope that clarify it for
> you and possibly other readers. Btw. qcom,*sm8450* compatibles are widely
> used and fact that `make dtbs_check` noticed it missing here isn't
> suprising..
> > 
> > The SPDX update lacks answer to "why". There is no reason to do it, so
> > please explain why it is needed.
> 
> Please read https://spdx.org/licenses/GPL-2.0.html (red colored text).
> 
> I personally encountered situation, where usage GPL license without specific
> `-only` or `-or-later` caused unnecessary confusion and uncertainty.

I don't mind changing these, but please do a tree wide change for all 
bindings, not an 'while I'm here also change X' change.

Rob
