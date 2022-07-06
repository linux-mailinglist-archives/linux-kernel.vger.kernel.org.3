Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3156926A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiGFTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiGFTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:10:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBE28E02;
        Wed,  6 Jul 2022 12:10:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e40so20462548eda.2;
        Wed, 06 Jul 2022 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=RvM6lmNq3SSzc3aGEbKdgdc4KIyTbuPCfQq5iJFL6DE=;
        b=Zt8eh7L50Fu7i0roonZosxroj3Ch43Npj6aIxsBF6MpQFDboDwSx4h3cqW6BOj8dpA
         7fkAzh7d2wBWInmVqX4cN8Lb2hwVIRlhGYW1rjUljO72Z4MHbgzDy0ecIaF9TcpTyHSI
         cOupHDY2O7R2+ZprnBzJ/FKYuuAnzcicPPegdSTEK6y4Ar5nkWcSQcJ6X5o3FYOqECYh
         hBdRvfHrSO/2AiWYRG1ykBKJB+sPZfGUU99VlPCkOD/cLTFnLa7BdR4yc2Dn2dZ3yNEt
         fZWOY4fK/PDAM4qLknS1zovzanN1mNno1lwzF0HXJlQzTfj7qWMlgqmlR1n6JPd6pCZa
         evGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=RvM6lmNq3SSzc3aGEbKdgdc4KIyTbuPCfQq5iJFL6DE=;
        b=4VUwNGDozBJVKJJ2OKgu3Qg9BY7Dd0R8AE/+lEv2+uttw21qDVMTgzA6xL8khFY5dG
         bVzfdCIqf+v9dvdsh621MpfeFCCgj6hSJqxOZQ6rhpEkbzJtiUTpBJX+3+ioaZ9EVcKv
         257/uGEMNQ8NE7PPSW89CLAsyURczJ0d3HHt7S1eVE7y3Qoa1Cb3n3RloeddZLb6zcY1
         RMOtKHHqrlQZSz0zsD3R1XS+iprnsd6e2QjXo31CWzIsKhWrEpg3gRauNcLJNYAoK7nR
         7xPPaTjzgG7STrR9JtmD7enNqYNcSlBw4eovGIgBhHCl5h5nLkhrg3VDC+Yxs0TjNoj5
         2pkA==
X-Gm-Message-State: AJIora9pmqPLabExmOiqneI9vUw0omEZDuuwejixDJzrU6H3eXfIkKuV
        Gp05QWUzqmOs2+oWo1+WlaA=
X-Google-Smtp-Source: AGRyM1u6X5e4/7pDk4okkRp9HMGJjRQJbHr92molPCUrkbATzZ9QPRy/PZCkjNO4Fu6HG8qU70j97Q==
X-Received: by 2002:a05:6402:2395:b0:43a:6d91:106c with SMTP id j21-20020a056402239500b0043a6d91106cmr21283230eda.299.1657134631884;
        Wed, 06 Jul 2022 12:10:31 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id zm9-20020a170906994900b006fee7b5dff2sm18134688ejb.143.2022.07.06.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:10:31 -0700 (PDT)
Message-ID: <62c5de27.1c69fb81.c73fe.02c5@mx.google.com>
X-Google-Original-Message-ID: <YsXeJnBqicB3Ah4Y@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 21:10:30 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new
 rpmcc clocks
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-3-ansuelsmth@gmail.com>
 <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
 <62c565dc.1c69fb81.a4566.e9b2@mx.google.com>
 <bcb64218-2d2b-2f6b-dc79-303bac8c3bd3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb64218-2d2b-2f6b-dc79-303bac8c3bd3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 05:07:12PM +0200, Krzysztof Kozlowski wrote:
> On 06/07/2022 12:20, Christian Marangi wrote:
> > On Wed, Jul 06, 2022 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
> >> On 05/07/2022 22:28, Christian Marangi wrote:
> >>> Fix dtbs_check warning for new rpmcc Documentation changes and add the
> >>> required clocks.
> >>
> >> There is no warning in the kernel, right? So the commit is not correct.
> >>
> > 
> > Oh ok, the warning is generated by the new Documentation.
> 
> Patches, especially DTS, might go via different trees, so the moment DTS
> is applied there might be no such warning.
>

I'm still confused about this topic...
With this kind of change, I notice I sent Documentation change and then
rob bot complain about dtbs_check having warning...

So the correct way is to send Documentation change and fix dtbs_check
warning in the same commit OR keep what I'm doing with sending
Documentation changes and fix DTS in a separate commit?

I assume separate patch was the way to go but now I'm not sure
anymore...

> Best regards,
> Krzysztof

-- 
	Ansuel
