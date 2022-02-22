Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9854C00D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiBVSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiBVSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:02:03 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761811165;
        Tue, 22 Feb 2022 10:01:33 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so6358836otp.13;
        Tue, 22 Feb 2022 10:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuKLz06AZYr8z+0AaROHF1CH113GpD871BS09fSdbV8=;
        b=u4FF90g3tUoZob2IXyQswSw4xhKHbZFUOcmZqiIORdCBB53oFrOSqSDSfN3s60sWR8
         LcWUPQOYTbkKop+e665QkpThvJgPItmDxi7XZVOHgE+HalLLZ2i5GFupvAwshATjQt9x
         aNAmJ5vVS94DeGI2gvNzSdnq++E0wW4p4/FyLkc3yT4j+9W67ntH51g1cm71tPX/GkrJ
         qFqFNTCryC3o2PwmvxkDLtKTYdpEFDv6pBuY88RIjZPqgVUpOqoCfBG5cOzz5vY+xK75
         1WB2fO7SMrKld+wltr1tCJDNXrBVPyYngd4mxvgra/DXNkjFgg9Lk7gIZY3WMN7aSszL
         ef5g==
X-Gm-Message-State: AOAM532kCBylLvn5FKsiBVbZDPn8eTxFHqvxz1kMgpPQXTnbg1SeFP7D
        OoLc8BLyPM0H+2ui1MFMeIWpeS/jLA==
X-Google-Smtp-Source: ABdhPJyCpi8WRkHYBg6TUjBZvXk0DpfAaYtR71zU0qpKqMyo7K65bwZg7M03m3vEHNjHT8DVDw1VvQ==
X-Received: by 2002:a05:6830:25cc:b0:5ad:7fe:3bbd with SMTP id d12-20020a05683025cc00b005ad07fe3bbdmr8423431otu.354.1645552892877;
        Tue, 22 Feb 2022 10:01:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d18sm157517otf.50.2022.02.22.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:01:32 -0800 (PST)
Received: (nullmailer pid 3314154 invoked by uid 1000);
        Tue, 22 Feb 2022 18:01:31 -0000
Date:   Tue, 22 Feb 2022 12:01:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document
 new partition-dynamic nodes
Message-ID: <YhUk+3P7g6bigRP3@robh.at.kernel.org>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
 <20220220173905.14165-2-ansuelsmth@gmail.com>
 <1645410969.414517.2041550.nullmailer@robh.at.kernel.org>
 <YhO2dK0eNP9fOeOZ@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhO2dK0eNP9fOeOZ@Ansuel-xps.localdomain>
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

On Mon, Feb 21, 2022 at 04:57:40PM +0100, Ansuel Smith wrote:
> On Sun, Feb 20, 2022 at 08:36:09PM -0600, Rob Herring wrote:
> > On Sun, 20 Feb 2022 18:39:04 +0100, Ansuel Smith wrote:
> > > Document new partition-dynamic nodes used to provide an OF node for
> > > partition registred at runtime by parsers. This is required for nvmem
> > > system to declare and detect nvmem-cells.
> > > 
> > > With these special partitions, only the label is required as the parser
> > > will provide reg and offset of the mtd. NVMEM will use the data from the
> > > parser and provide the NVMEM cells declared in the DTS, "connecting" the
> > > dynamic partition with a static declaration of cells in them.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.example.dt.yaml: partitions: '#address-cells', '#size-cells', 'art' do not match any of the regexes: 'pinctrl-[0-9]+'
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/1595230
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> Considering the idea of this partition-dynamic, should these warning be
> ignored or the smem-part should include the ref of these new partitions?

We can't have warnings. 

> Or should I remove the example?

Doesn't that just kick the problem to actual users?

> (or should I add the example to smem-part instead of partition-dynamic)

That shouldn't matter I think...

Rob
