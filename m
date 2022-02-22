Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BD4C00FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiBVSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBVSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:10:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAA1728B6;
        Tue, 22 Feb 2022 10:09:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm8so29329804edb.3;
        Tue, 22 Feb 2022 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jtom/U0GwO0Hs63autw48kBu/fshzoa9XBs0OWnJ3L8=;
        b=OmYZ3HIjMD0dUoDhZY8dEMSo1j1yZnkExjcPHkZ0rlsui50L7fmPpJiEQNHCSpO1Ca
         NIkndOKdSBdG0fKvi8kldlrSvZ3ypyBmsmgvayCDF3YHFD6r1/8OFUvqPJslcET4Y2zy
         v6wsyrKhvFI+w8pEjsWjPaTemJPPjC2cQ+kDpz5DuLpxZGazp2l/5rDqOHEate7vXTcf
         0msZttDSXExAsHHr3jSidYG/FZo78mU/WyvA0T91Vhz4PcGzIuhx3vBGHQiPUdwjJxXZ
         i+4YoSl7W7CZXwStAk+YsQi6sn+xNKkoarGVScgKUPV47W6fucJNd/jzSPOh4SuxspoB
         3AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jtom/U0GwO0Hs63autw48kBu/fshzoa9XBs0OWnJ3L8=;
        b=7xsx4Ybo5Rn8y1uQlCoxcjfcp9YAM4GtXZbJMKnePiVe3g0nqV4AsDZUsWdbSk5KBz
         NvHkli/tyckDyl8U4z5WLC6S4moFB/dls7fZHxL1BEBh04PqLXJ5zu2ZTc+rp4lhuoxr
         e96JPC21vr16OGid06/Wwkcn5QMybLfWlCogdZsr6EgWiiM3beiIlr144oTldxPJDXAf
         55sqIYXhQKJJjaOBPsIaX5WSWZelGTk3ZlP2vINoz/agnYJhH+hdu9oiLTHX5J4N5uFp
         L1+lIVylAZooL+inx6ZqCt/LAvmpITCFRa6eseEHtOyNaKzj61nN93eGRf0DQKwmQRoi
         ae9Q==
X-Gm-Message-State: AOAM533juXp2V2utSfKUhAnhfbFaBXJQwjrmceXM/KRjrIT1YIS9as04
        lPtmqfpQAe+K0uRTZayuDNo=
X-Google-Smtp-Source: ABdhPJzUnAJ/pRNXmC3AHLVojZVz9boRrWUlnT60fBM9wkx7MJFyGhNiP4CJCeIAuPdIWUlXPdmLvw==
X-Received: by 2002:aa7:dd1a:0:b0:410:9bb4:cba4 with SMTP id i26-20020aa7dd1a000000b004109bb4cba4mr27208582edv.364.1645553374474;
        Tue, 22 Feb 2022 10:09:34 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id ew6sm6393886ejc.217.2022.02.22.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:09:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 19:09:32 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document
 new partition-dynamic nodes
Message-ID: <YhUm3LDb9Bp+Pn9a@Ansuel-xps.localdomain>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
 <20220220173905.14165-2-ansuelsmth@gmail.com>
 <1645410969.414517.2041550.nullmailer@robh.at.kernel.org>
 <YhO2dK0eNP9fOeOZ@Ansuel-xps.localdomain>
 <YhUk+3P7g6bigRP3@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhUk+3P7g6bigRP3@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:01:31PM -0600, Rob Herring wrote:
> On Mon, Feb 21, 2022 at 04:57:40PM +0100, Ansuel Smith wrote:
> > On Sun, Feb 20, 2022 at 08:36:09PM -0600, Rob Herring wrote:
> > > On Sun, 20 Feb 2022 18:39:04 +0100, Ansuel Smith wrote:
> > > > Document new partition-dynamic nodes used to provide an OF node for
> > > > partition registred at runtime by parsers. This is required for nvmem
> > > > system to declare and detect nvmem-cells.
> > > > 
> > > > With these special partitions, only the label is required as the parser
> > > > will provide reg and offset of the mtd. NVMEM will use the data from the
> > > > parser and provide the NVMEM cells declared in the DTS, "connecting" the
> > > > dynamic partition with a static declaration of cells in them.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > > > 
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.example.dt.yaml: partitions: '#address-cells', '#size-cells', 'art' do not match any of the regexes: 'pinctrl-[0-9]+'
> > > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > > 
> > > doc reference errors (make refcheckdocs):
> > > 
> > > See https://patchwork.ozlabs.org/patch/1595230
> > > 
> > > This check can fail if there are any dependencies. The base for a patch
> > > series is generally the most recent rc1.
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > > 
> > > pip3 install dtschema --upgrade
> > > 
> > > Please check and re-submit.
> > > 
> > 
> > Considering the idea of this partition-dynamic, should these warning be
> > ignored or the smem-part should include the ref of these new partitions?
> 
> We can't have warnings. 
> 
> > Or should I remove the example?
> 
> Doesn't that just kick the problem to actual users?
> 
> > (or should I add the example to smem-part instead of partition-dynamic)
> 
> That shouldn't matter I think...
> 
> Rob

I mean the problem here is that smem-part doesn't accept partition
subnode... Think I should add a ref there... In theory I should be able
to keep the example... 

-- 
	Ansuel
