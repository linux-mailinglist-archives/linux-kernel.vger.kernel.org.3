Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0D5448D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbiFIK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiFIK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:26:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB61FD2BE;
        Thu,  9 Jun 2022 03:26:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y19so46547173ejq.6;
        Thu, 09 Jun 2022 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sOUTYmBneU8iG+DbESjBMogqAliu7BQ9pIctsnxzzY8=;
        b=KcbtaW+Syi3OQ9ucjj23DpcuP7IxuMzTv74WDyxY7k5J5wFm1XFA8r9gg4Y46WISer
         FbzmwndkTD9CXu7nZ6q1A1/8quMVRTePoENvbJCJw9Ayht6xn2JcDb6HuKHCVmfeVLOz
         bOTo6Z8tmPX2biiHCMn18E75JRIUt7T6NJR0FgOHouFb2hH01PdT1P9hP3yVR8hXbmTS
         dUcQDvanXVtJ6u2rCrnWa2l5bbV7kYDkK/1etnVJt6pSAjbIRcHvtZunyn4GJqdPlRUw
         GHHPJjYwDAzxZARBO6A4wDQ0LU5I5+zgr21ZfCss2ziZ6FlIlc2AgvmKiwlics3wdzab
         S2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sOUTYmBneU8iG+DbESjBMogqAliu7BQ9pIctsnxzzY8=;
        b=PZGd7nZBSJI8p/eVUFim66NDmcal+RwJDwkCAGhySdpn9r84JLvWUTAltXLZVqWCcO
         RJ0YH4bui1S44KdDpPZdDHDbXb2Ekx0OWGKAa82dQtzvoCxCGaDtF9jMdFubDl25SlVU
         jLTjTttpY9NtIRa2f35jU5LRfSeF2zqT3ZgJjtLLrryRALvTeMg3HA/VUOY0cbXlyt4o
         7b4qGQ3ryKAwnJqd7TJXFAp+rK3Lo43nFeG7CjLkxvQcVKDsF7nji2qHCBiyKETbM/CB
         vlJYmMUEeJBqzzck9ckaKD+uw1/+erVJQF0iu1ga+OFJTzwkqEpg8IZ12oMLj40GUbKs
         Pz8A==
X-Gm-Message-State: AOAM531wqn0Bb8kM/JWqrMSoLCvaRBqqIQTZt8+CAxaEjTyLBkiTO0mS
        MD69/LhsfO8MZ6wHC7L11FBvv/IUjqw=
X-Google-Smtp-Source: ABdhPJyKWGGdiwtTA3k2q4C3kDwA3pz4FW+/eH64t+dXA1QIsqIkpA0BKRQ54f3WO8G470p5FNoRcw==
X-Received: by 2002:a17:906:84b:b0:70c:d506:7817 with SMTP id f11-20020a170906084b00b0070cd5067817mr32323334ejd.206.1654770417293;
        Thu, 09 Jun 2022 03:26:57 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm10456213ejj.152.2022.06.09.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:26:56 -0700 (PDT)
Message-ID: <62a1caf0.1c69fb81.a67af.bdf8@mx.google.com>
X-Google-Original-Message-ID: <YqHK7WOZsq/YH2kV@Ansuel-xps.>
Date:   Thu, 9 Jun 2022 12:26:53 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-4-ansuelsmth@gmail.com>
 <20220609072240.GB2758@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609072240.GB2758@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:52:40PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 08, 2022 at 02:10:30AM +0200, Ansuel Smith wrote:
> > Reorder qcom_nand_host to save holes in the struct.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> If this patch gets moved to 2/3, you could save few changes. Also, do the same
> for other structs as well.
> 
> Thanks,
> Mani
>

Since 2/3 already had lots of changes didn't want to put a struct
reorder in it since it does touch also other values. Tell me if I should
squash the 2 commit.

> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 06ee9a836a3b..110f839c9e51 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -475,11 +475,13 @@ struct qcom_nand_host {
> >  	int cs;
> >  	int cw_size;
> >  	int cw_data;
> > -	bool use_ecc;
> > -	bool bch_enabled;
> >  	int ecc_bytes_hw;
> >  	int spare_bytes;
> >  	int bbm_size;
> > +
> > +	bool codeword_fixup;
> > +	bool use_ecc;
> > +	bool bch_enabled;
> >  	u8 status;
> >  	int last_command;
> >  
> > @@ -490,7 +492,6 @@ struct qcom_nand_host {
> >  	u32 clrflashstatus;
> >  	u32 clrreadstatus;
> >  
> > -	bool codeword_fixup;
> >  	int nr_boot_partitions;
> >  	struct qcom_nand_boot_partition *boot_partitions;
> >  };
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
