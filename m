Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DB58EF67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiHJPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiHJPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419649B66;
        Wed, 10 Aug 2022 08:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35260B81CF2;
        Wed, 10 Aug 2022 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA8EC433D6;
        Wed, 10 Aug 2022 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660145028;
        bh=mmcvq0IvE4uO5WYMgBDaxxrgQXyvkI0OYgYpgNtf0KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXPjS6Z/AYYSRkJLGptjvgYpDpOnrBDbou1MwP3hOfrHC9Am4ufWcWtNB8mIQ5aXt
         uFHtZGrttwerW1nyvUBRnjcsCEIuhoHuG/y949CqZyMBxaboSBcuanlivqlxFMx4sl
         yU5kY9BnxlGXeydAXwsccxqHkhhN+rh+e9u0iMRZotNY0YCiv+ifFEj0nWa3/03g14
         wzp4bSYWI+HZqdqk1W12apuQdQz5uH5uZYDH9HjSwjmMV015dI2FG5d+PEtFhU/tmg
         /DJ2bg3wl3hW1uzAx+2gp4flgwz/wxhADEtbvTI4Hn5ZIa5u1kLI8lhM8zl9bxpwDu
         QyvKhnYlBJAEg==
Date:   Wed, 10 Aug 2022 16:23:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, David Heidelberg <david@ixit.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <YvPNf9qL+zdXEyK+@google.com>
References: <20220626191630.176835-1-david@ixit.cz>
 <20220809235625.GA2775377-robh@kernel.org>
 <YvOPKKw60F4qEKM6@google.com>
 <CAL_JsqL54yLFApJHZodEPUc4MucFg=0qMXr=koiprJB8z4dY-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL54yLFApJHZodEPUc4MucFg=0qMXr=koiprJB8z4dY-w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022, Rob Herring wrote:

> On Wed, Aug 10, 2022 at 4:57 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 09 Aug 2022, Rob Herring wrote:
> >
> > > On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> > > > Convert Qualcomm SPMI PMIC binding to yaml format.
> > > >
> > > > Additional changes:
> > > >  - filled many missing compatibles
> > > >
> > > > Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > ---
> > > > v3:
> > > >  - added subnodes, there are two not converted to YAML yet, but it works
> > > >  - now it prints milion directly unrelated warning to this binding
> > > >    (it's related to the included subnodes bindings, can be merged,
> > > >     but it'll generate more warnings and preferably anyone can takeover
> > > >     from here)
> > > >  - add qcom,pmx65
> > > >
> > > > v2:
> > > >  - changed author to myself, kept Caleb as co-author
> > > >  - moved nodename to properties
> > > >  - add nodenames for pm* with deprecated property
> > > >  - add ^$ to pattern properties
> > > >  - dropped interrupt-names property
> > > >  - added reg prop. to the nodes which have register in nodename
> > > >  - added compatible pmx55
> > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > ---
> > > >  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
> > > >  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
> > > >  2 files changed, 191 insertions(+), 94 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > >
> > >
> > > As this hasn't been picked up, I applied it. Thanks!
> >
> > I'd prefer to take it via MFD if it's all the same to you.
> >
> > In case there are additional fix-ups required during the next cycle.
> 
> I'm going to send it to Linus this week for rc1 so that won't be an issue.

Works for me then, thanks.

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
