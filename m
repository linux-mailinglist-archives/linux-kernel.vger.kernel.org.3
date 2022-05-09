Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFC520684
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiEIVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiEIVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:16:37 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E91F7E24;
        Mon,  9 May 2022 14:12:42 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so10967738otl.7;
        Mon, 09 May 2022 14:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tttFrTXiMauh2WUBpEtvCsG9fSFl8CjliHwByuAO7M0=;
        b=RHFjjNyOWZydGl4ZVXyUc7oH+63li+Ylat/1gIFwk27vRsy66qR6WGbWE/zX1XOePQ
         i6ZOQABn/2tLd+Rn9q3D1tJSpwX4Y4rJbpFlwcXan8KwTn6SXyPp6PENrFhlyz3AglOw
         vjEYBLX37qYZYMAC8YOLhyfzdi7w0cVMc7TU21D/3TqQZzEIYkiWGH4IyvZu/asZj516
         6Cfig5XoUKJBT5yPrRB91H2rPyoal7dFfPA90JjIKNlQdOSwt7UN26I+m1DXHC/TV6PZ
         UPlX4KszArUjG/vn+Wk0WJNOZH3/i7ASckKFT1bfu98sSfVJ1POw+RuKiZTZU+N2Vker
         bdGA==
X-Gm-Message-State: AOAM530JUmsmY5/ROkLyaM5+En97ws7XlhvNi5hfWjUaHqBAVSxj0w7J
        gFYgwlftZEVniGNWu1UN4uhCWzYbIw==
X-Google-Smtp-Source: ABdhPJzanZ6Seoj3B35XKcpPYGzW45CD+vaaHWklkwTwIlKv3kUStgSqE0Vi+IlvcbtW/rqsQChTNw==
X-Received: by 2002:a9d:4f0d:0:b0:606:1c0b:a21e with SMTP id d13-20020a9d4f0d000000b006061c0ba21emr6798761otl.371.1652130761902;
        Mon, 09 May 2022 14:12:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020aca2102000000b003264a325ecdsm4720293oiz.5.2022.05.09.14.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:12:41 -0700 (PDT)
Received: (nullmailer pid 184905 invoked by uid 1000);
        Mon, 09 May 2022 21:12:40 -0000
Date:   Mon, 9 May 2022 16:12:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add support for IPQ8074 APSS
 clock controller
Message-ID: <YnmDyDKhMlUkwJJY@robh.at.kernel.org>
References: <20220503195605.4015616-1-robimarko@gmail.com>
 <20220503195605.4015616-2-robimarko@gmail.com>
 <YnLdTIKx80wszbj7@robh.at.kernel.org>
 <CAOX2RU5RMra4zj-jWZFH_fev-EavsnLnjob0z4FsaYnn8cs5gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU5RMra4zj-jWZFH_fev-EavsnLnjob0z4FsaYnn8cs5gg@mail.gmail.com>
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

On Wed, May 04, 2022 at 10:45:22PM +0200, Robert Marko wrote:
> On Wed, 4 May 2022 at 22:08, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 03, 2022 at 09:56:01PM +0200, Robert Marko wrote:
> > > Add dt-binding for the IPQ8074 APSS clock controller which provides
> > > clocks to the CPU cores.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > > Changes in v2:
> > > * Correct subject
> > > ---
> > >  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> > >
> > > diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > > new file mode 100644
> > > index 000000000000..df07766b0146
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> >
> > Dual license please.
> 
> Hi Rob,
> Krzysztof asked about this in v1, I have derived this off IPQ6018
> binding which is marked GPL-2.0.
> So, I was not sure if it was appropriate to mark it as GPL/BSD dual license.
> If you say that its not an issue to dual-license, I will gladly do it.

Technically, you should maintain it, but I don't think 2 defines is 
really enough to represent copyrightable work (but IANAL). I also know 
that QCom prefers the DT stuff to be dual licensed because they've 
raised the issue with me. 

Rob
