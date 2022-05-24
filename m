Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE0532BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiEXOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiEXOJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:09:44 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5027FDA;
        Tue, 24 May 2022 07:09:43 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-edeb6c3642so22373416fac.3;
        Tue, 24 May 2022 07:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nG80lP1Xa2erat+zWawIK5ymOe8Cuz6sDbYS9+ykkrA=;
        b=xA7cQC+JDISweNmgTwA+kkLsnhn4XHS0rFoZUxZDcnYc1pI0TXbNVpmpfcdDM24u5q
         PghtN+TOv+bEZVni+uZX55gfNTalLQaYYc9TwCBbQTc3zn1lbLA/HAiFEMK1mdqgRs0W
         Zns+3aNiet0y5vyuMWhv7t/KfmzIL/IEoBm9WywDWRBFN/OSiC7/C0Ein0xLPvfrWNey
         ++7978EAUcGme+3tgvheYxce/vhqiI0zK3BKX8F/UjP/38iAV8ML3daeae7IQ3g5aVbf
         pn/p3G9y6u0E78vWVHAub3hGaBHKJ/VJejFUGBpQqd0AhkpRzjgwErE+SJaLxGUIyk7r
         Slwg==
X-Gm-Message-State: AOAM532wsuA/EmAz3mhRgKPzGtsSpox2oZhLP1j1f8l178KVQqTfFy2k
        Z2E5x2Dd8wjYHswuMks0gA==
X-Google-Smtp-Source: ABdhPJzQJqlYCgtjgQgfukGhoMZ9vX8fGvWFxtOAAHoPf47UrRhdP+w+huaQWy1Q5wEXsjg773nsYQ==
X-Received: by 2002:a05:6870:524c:b0:f2:ae90:dae1 with SMTP id o12-20020a056870524c00b000f2ae90dae1mr732345oai.198.1653401382620;
        Tue, 24 May 2022 07:09:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y41-20020a4a982c000000b0035eb4e5a6c7sm5392287ooi.29.2022.05.24.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:09:41 -0700 (PDT)
Received: (nullmailer pid 3697144 invoked by uid 1000);
        Tue, 24 May 2022 14:09:40 -0000
Date:   Tue, 24 May 2022 09:09:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org
Subject: Re: [PATCH v4 3/3] dt-bindings: remoteproc: qcom: Convert SC7180 MSS
 bindings to YAML
Message-ID: <20220524140940.GA3687200-robh@kernel.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-4-git-send-email-quic_sibis@quicinc.com>
 <20220520224011.GA374485-robh@kernel.org>
 <b495fa6c-6964-d8fa-0baf-acd719cd8779@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b495fa6c-6964-d8fa-0baf-acd719cd8779@quicinc.com>
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

On Tue, May 24, 2022 at 07:40:51AM +0530, Sibi Sankar wrote:
> Hey Rob,
> Thanks for taking time to review the series.
> 
> On 5/21/22 4:10 AM, Rob Herring wrote:
> > On Thu, May 19, 2022 at 10:17:05PM +0530, Sibi Sankar wrote:
> > > Convert SC7180 MSS PIL loading bindings to YAML.
> > 
> > I suppose there is a reason the sc7180 is being split out and the only
> > one converted, but this doesn't tell me.
> 
> https://lore.kernel.org/all/e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com/#t
> 
> The reason for the split was discussed on the list ^^, thought it
> wouldn't make much sense adding any of it to the commit message.

Why not? If you did, then we wouldn't be having this conversation.

Commit messages, at a minimum, should answer why are you making the 
change. They don't really need to explain what the change is. We can all 
read the diff to understand that.

Rob
