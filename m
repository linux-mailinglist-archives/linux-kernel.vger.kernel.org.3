Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C858EEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiHJPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHJPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1512755;
        Wed, 10 Aug 2022 08:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598FD60F1C;
        Wed, 10 Aug 2022 15:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1516C4347C;
        Wed, 10 Aug 2022 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660144085;
        bh=87KRv5P0TwmcIHx+Jg7acxmQSkVxGdA0YWEoEXWeRpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tCyNNogygU7iT56AeigEmD9TkZ3A5cB2IgmWxv32Dmw5KDtofo5GJ9r8kbg9lz3Ry
         rB3AIOwIsUYifR8TBq+8PFjLra0thD9TPC2cBfUdqLphVKGNQC5K+F9LqDXxe/9YAe
         FRM64HN/q23sNWeZi8mhd3HSWWTCqT6bvBRGSlSEwtfAuWiVc2DNvt3N7pB6HufZCt
         VTrW59vndcAVfxi4xYQrGLEBo+BO/2DX5CnxAp+VkHVaJTyVU+kF0Vqf/fEGEQBGh0
         LHEcgRqBRA+eQlrGryiYW1k0k8EUg/EblpaikwLN8norzDlcRQD6oAgKoBS0lcrDMV
         E8LCEJ3krR/Hw==
Received: by mail-vs1-f49.google.com with SMTP id q190so15427307vsb.7;
        Wed, 10 Aug 2022 08:08:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo1umhMUDERG2IJl88Su+G6BylSsrRkTI04A8WNmi0wBFOMpaX9d
        ciCfMweXcauCpigEFrM8iWdDRmBi96bNqeim8A==
X-Google-Smtp-Source: AA6agR5J9Sw7EB/2RvIJuacGckfj71fD46KTQyeWAf0zqau1CeMwBVQLn7WlofHb8fYhxG8isT/ads3vowxg4ANxksM=
X-Received: by 2002:a67:c08f:0:b0:38a:8c1c:45aa with SMTP id
 x15-20020a67c08f000000b0038a8c1c45aamr724475vsi.85.1660144084641; Wed, 10 Aug
 2022 08:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220626191630.176835-1-david@ixit.cz> <20220809235625.GA2775377-robh@kernel.org>
 <YvOPKKw60F4qEKM6@google.com>
In-Reply-To: <YvOPKKw60F4qEKM6@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Aug 2022 09:07:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL54yLFApJHZodEPUc4MucFg=0qMXr=koiprJB8z4dY-w@mail.gmail.com>
Message-ID: <CAL_JsqL54yLFApJHZodEPUc4MucFg=0qMXr=koiprJB8z4dY-w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 4:57 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 09 Aug 2022, Rob Herring wrote:
>
> > On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
> > > Convert Qualcomm SPMI PMIC binding to yaml format.
> > >
> > > Additional changes:
> > >  - filled many missing compatibles
> > >
> > > Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > > v3:
> > >  - added subnodes, there are two not converted to YAML yet, but it works
> > >  - now it prints milion directly unrelated warning to this binding
> > >    (it's related to the included subnodes bindings, can be merged,
> > >     but it'll generate more warnings and preferably anyone can takeover
> > >     from here)
> > >  - add qcom,pmx65
> > >
> > > v2:
> > >  - changed author to myself, kept Caleb as co-author
> > >  - moved nodename to properties
> > >  - add nodenames for pm* with deprecated property
> > >  - add ^$ to pattern properties
> > >  - dropped interrupt-names property
> > >  - added reg prop. to the nodes which have register in nodename
> > >  - added compatible pmx55
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
> > >  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
> > >  2 files changed, 191 insertions(+), 94 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > >
> >
> > As this hasn't been picked up, I applied it. Thanks!
>
> I'd prefer to take it via MFD if it's all the same to you.
>
> In case there are additional fix-ups required during the next cycle.

I'm going to send it to Linus this week for rc1 so that won't be an issue.

Rob
