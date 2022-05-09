Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFE51F838
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiEIJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiEIJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:30:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8A19FB2F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:26:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q23so18541280wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XvC4vuGJ/fReLhoxIOtj//WxywUWuOvAGbrh68Zu2XI=;
        b=u6KPetVh5gX4en9xXua4fJ39OdDbDXqtbrrZWvzZxpNleg18yURy1rvlOoUc67jXpt
         z2L3P9Tn2W6SeMKdyQJae2cR5zmqj+myuOPg92SBDK14CJ7z5o4noKdalzFKviRvYMBb
         Q5CSL5BsKBd5VSj/gP48C/4v9hbPDTKBGPyv8L9U/fcLqVTWtFl8cWzl8HiC9sz0my9S
         e21d9xfBGXBEc6IA+hDISz/5h/wgydCrvPOwY5SQFbbk/eEPCcfsqauhzzRDr8kTgqlO
         FuJQUpmmMHipb0h/N3yQRV+Q7Shro/EXOmoK3MQf03NVKNlsMh6cuBmPZEIAqw/Y3Ufm
         94Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XvC4vuGJ/fReLhoxIOtj//WxywUWuOvAGbrh68Zu2XI=;
        b=cfiHIqG4Z7iWVQhkWHJQyPmmoXftir2jCWM1Wl9tovose5VF5m9jIRmxk4LqjnQBXA
         1n1l+kExgAgogVRmbpJKFd47QFUlOG+hUaTKdEogQX4yhjYvjhtmqYaQZ60LFoCpJAnn
         CXvA6POWGiAi2+qDqbpO72u+iCEmE2TjmDz+AYrF3w5/jj3Y+C3ML9fHuY3jtX0sp191
         5IOPnMivr/5Hm+z6HSYPAhdMBY4ojXUeLM13pOpYy6RiusHCQMtVKubW7YIbgI/80PfK
         F75oApWeYAZ3UljxEmQmCUEy4WgkLSIO3mGawwEbX3HeTwKUmFjbEZus0Vkjtzgfq0m2
         slAA==
X-Gm-Message-State: AOAM532emKqAVThCyAcMWGPiztemeQBW8Eh+xzJnFsDGQdhElKgp0+HI
        Xb1y0hWPSg62dL69GQBIcVy2ug==
X-Google-Smtp-Source: ABdhPJwfgmvpJMpAjetQ6aDrppF91DRKlFGaxClEH22/Wu+jpjajhRFwccHLxRXUs5lU0FsZ/Q+9xw==
X-Received: by 2002:a05:6000:1549:b0:20c:7183:439 with SMTP id 9-20020a056000154900b0020c71830439mr13118696wry.104.1652088375832;
        Mon, 09 May 2022 02:26:15 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f10-20020a1cc90a000000b003942a244ec1sm11633124wmb.6.2022.05.09.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:26:15 -0700 (PDT)
Date:   Mon, 9 May 2022 10:26:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <YnjeNUOy5zZFu+M9@google.com>
References: <20211227170151.73116-1-david@ixit.cz>
 <YnjeGIGW6Pe1R/gY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnjeGIGW6Pe1R/gY@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2022, Lee Jones wrote:

> On Mon, 27 Dec 2021, David Heidelberg wrote:
> 
> > Convert Qualcomm PMIC SPMI binding to yaml format.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > 
> > ---
> > v2:
> >  - add #address and #size-cells
> >  - add reg and remove spmi include from example
> > v3:
> >  - fix doc reference error (make refcheckdocs)
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-
> >  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
> >  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
> >  3 files changed, 121 insertions(+), 66 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> >  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 
> Applied, thanks.

Cancel.  I see that Rob already applied it.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
