Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FD4BDE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379766AbiBUP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBUP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:58:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78D286EA;
        Mon, 21 Feb 2022 07:57:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id bq11so9007049edb.2;
        Mon, 21 Feb 2022 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NSVr0UaSWz2MJOjywj5QL59VZ16irz/Lajj782o4eJQ=;
        b=QQZwNVp1wf19mb1jBrCGmpNT/MUdKH6CEmcsv1lEj7qJMquOydefa08uMW7DuSVfrS
         dz7JhF1Inicn+AXa23+7UTcsMYOpvstKP3RitiDVaG/OyrYCjzld40l111xu3q6GMtkI
         yco6LkSwURf3voNuaeOFsEOm152vxeFFv2KKbib73fUD/UmeO5lu64+hHZVmTAE16leZ
         TnDg1VGIGZs2CkOT54V0KaYPhOTb+kv7EQC9jCTgGMQGi9NgMog+yMU8pKA+JHqskulp
         Nuzqm0/H3xQon+GaiM+mG6n69SpyGVfurmuc9BlYflpro/fD6ajgQl63LkvR+0llEGL/
         Mz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NSVr0UaSWz2MJOjywj5QL59VZ16irz/Lajj782o4eJQ=;
        b=L3fR/KzKkg8laN8Lld5dBhMzW0XXxtCMPrSLMkAkLWXl8u/tOCMMtSBI5aBUpFN1T+
         QYzI9JgCExcytTLH9ruZvtRvd28gSmdQ0+ZzhLGqIMriSrrX90Gdlv93xU1nxeK8XhEw
         BZ2RLYmqrPqJbw7g1hqnElMDNTMVcQdGFAjjblS1fC7n8mhI953GPvbMDMYaQgUae54e
         Zo33r4EACP8qM/KuusgXA0ycYtJyRX+sGPDsecoL8LPiG9gervu83PDMDSMMCmKhFxDG
         eZcyoCD8wDx/YjmmK4bLDSjFO2+x68XuYzWYMT019ULRWn+teJBx8HZXDUtBBp6JRasA
         BEeA==
X-Gm-Message-State: AOAM5335j1fSnoq2lBwch7naC0Irg1rno2olDhn9oSIegRZJBzI8KneJ
        esDiFr99IRTAXogDvr6q7Z83fnAQGNc=
X-Google-Smtp-Source: ABdhPJxCIp0Ja49K3sb0ldfgLY3BkK8GAlDyfezaFbQJadNkmK+XUL0RetdGTC52oRPAhnbC5WJJ0g==
X-Received: by 2002:a50:8750:0:b0:410:f1b7:86af with SMTP id 16-20020a508750000000b00410f1b786afmr21936676edv.11.1645459062824;
        Mon, 21 Feb 2022 07:57:42 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id t4sm2944659edd.7.2022.02.21.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:57:42 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:57:40 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document
 new partition-dynamic nodes
Message-ID: <YhO2dK0eNP9fOeOZ@Ansuel-xps.localdomain>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
 <20220220173905.14165-2-ansuelsmth@gmail.com>
 <1645410969.414517.2041550.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645410969.414517.2041550.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 08:36:09PM -0600, Rob Herring wrote:
> On Sun, 20 Feb 2022 18:39:04 +0100, Ansuel Smith wrote:
> > Document new partition-dynamic nodes used to provide an OF node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> > 
> > With these special partitions, only the label is required as the parser
> > will provide reg and offset of the mtd. NVMEM will use the data from the
> > parser and provide the NVMEM cells declared in the DTS, "connecting" the
> > dynamic partition with a static declaration of cells in them.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.example.dt.yaml: partitions: '#address-cells', '#size-cells', 'art' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1595230
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Considering the idea of this partition-dynamic, should these warning be
ignored or the smem-part should include the ref of these new partitions?

Or should I remove the example?
(or should I add the example to smem-part instead of partition-dynamic)

-- 
	Ansuel
