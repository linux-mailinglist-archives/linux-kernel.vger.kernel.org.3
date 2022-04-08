Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83484F9809
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiDHOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiDHOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:30:38 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11023B6D0C;
        Fri,  8 Apr 2022 07:28:35 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id z8so8994462oix.3;
        Fri, 08 Apr 2022 07:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6P/eWNSUhhChiVA2KOS+s22CliAw2GeLV4Worl1v+Mo=;
        b=79/OK/MvLwU4h0DdmcoVnobkD7MEO1GX9KNSm2LiNMvGqu6cpINmu1qClIRRiD1PH3
         X74Bt8cfa1omlsanDbxXpL1g0k4hyvYLsloqnmyVKEr2gOhpE3cu8xLb0ulq3QEfIvJZ
         xBFdPawhStaTHQq1N3Fp3jBhaTwvpaaTnHUM6xx0PBSTHmF7tAguOxxpsARminwfAsop
         VURBP15quHufon4ZOX7S37sX3hdiv8Z7bQk7HZox5Z5AZijtuQhq9oTyguJbEEEmPUmJ
         ttTKjOtvbnbNVc3fQrE9yDYwMvNFjGfnKy8lurjmkJ+kmzarLNgykvecm19XIoNPxMh3
         na1g==
X-Gm-Message-State: AOAM532FwGo5VTMpMPApageuGM5ybbBvslwhAOblkBAiArvVHpleWdwH
        yx/+F9oJ/UrWSEXma8KaaijiUmpHkA==
X-Google-Smtp-Source: ABdhPJwCYTAc9kSP9DxjzK3Qd+s1DFyWlQN1bwPqjRJXhLEIJBbp3+DVTkAUog7s4MEl1XqJcnd4cQ==
X-Received: by 2002:a05:6808:ec8:b0:2f9:6119:d6ed with SMTP id q8-20020a0568080ec800b002f96119d6edmr7910009oiv.215.1649428114209;
        Fri, 08 Apr 2022 07:28:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g25-20020a544f99000000b002da70c710b8sm8850858oiy.54.2022.04.08.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:28:33 -0700 (PDT)
Received: (nullmailer pid 3435863 invoked by uid 1000);
        Fri, 08 Apr 2022 14:28:33 -0000
Date:   Fri, 8 Apr 2022 09:28:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Marc Zyngier <maz@kernel.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: qcom,pdc: Add SM6350 compatible
Message-ID: <YlBGkVQCCEHlq1P4@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-4-luca.weiss@fairphone.com>
 <YbpLnWKRq5TRO+Uk@robh.at.kernel.org>
 <CJ4TK3GWP00Q.1SDG6H9Q4GP37@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CJ4TK3GWP00Q.1SDG6H9Q4GP37@otso>
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

On Fri, Apr 08, 2022 at 01:24:43PM +0200, Luca Weiss wrote:
> Hi all,
> 
> On Wed Dec 15, 2021 at 9:10 PM CET, Rob Herring wrote:
> > On Mon, 13 Dec 2021 09:26:04 +0100, Luca Weiss wrote:
> > > Add devicetree compatible for pdc on SM6350 SoC.
> > > 
> > > Also correct the compatibles for sm8250 and sm8350.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > > I do have the .txt -> .yaml conversion ready for this but will send
> > > as a separate patch.
> > > 
> > >  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt    | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> It looks like this patch hasn't been applied yet. Could the responsible
> maintainer please pick it up?

Applied.

Rob
