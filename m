Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCB5452B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbiFIRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiFIRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:10:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2CE8BAD;
        Thu,  9 Jun 2022 10:10:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o10so32039099edi.1;
        Thu, 09 Jun 2022 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YOQJZv6DXLC4OLwRVn231eqFTPEfawUDpXHNEiex4bo=;
        b=CwbKPKSNxp5YBunmE6UC1ut68jz2Elg6HagvQgpmZ4OMU5/LGQ6gVFbCrz2QuVTENn
         IIC2XVmBXK5Mb466jWvOL/SYXcCfm944NQtIrbP1EqsWtLInlv8H9MeTEz33eRrXSxG0
         JaX3EtOzOap5l7nI3Dj8feT2lmQDA5bhpeYEY4Jy068b/xcIbQgLH610qH8Cgsjvb0eO
         1gcu5kEGDIhLTAbDpzO25UQslez7FyYFV9gTWjdwv8KCIHYx3QaC2s5qyH8rS8AiGwxI
         f6JgtB9rWjnSXq6EPJWFg8CgXePTiWYXaSZuz8CY1ERplhhgS805UrdqofNwBMiT7XOd
         a+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YOQJZv6DXLC4OLwRVn231eqFTPEfawUDpXHNEiex4bo=;
        b=INFRfK0o2MqZeInzqrQt9qKBkhFlnTl8k/yQwJyvAhFYkYYFjzn1bfLY7ZD/QAaDsj
         oVkiAw+t6sbG8ggDK+DU5SOf6jHt0GTf84d5YCKSsDKNQCvCsv05cuocqV/L2Yu4g2vj
         XO+h2oD4y0tevPbFkm0kD+BxdML8yfSkdkDeEStXHufaj05PXxSAKAFocMOiM7jhrKF7
         QpnLaM+iTTbUGWWkeAqy17dTcfvMaIfmHj2YqzkZoUe0pfDIVWm58aUIndI+psOjLmXl
         V048/wYx2KRTPpR94Lq5Y7ilq1ZAN7V77rLEwSiKWP1Z56sSUycfssJpiqZiSurfuln7
         09KQ==
X-Gm-Message-State: AOAM531p2omHf3+ON5s4cgATvnjY7wW9waDCuji+UIM5sMJJuCocSrCK
        2m718p9Hos0z6TyFT8a8C1Q=
X-Google-Smtp-Source: ABdhPJzg3yBm+tCizifx1o9yscxNe4FUUthz6U/luW+cQRetX6xULG0qN2cVQ6l8EG+UteRU3SyPsg==
X-Received: by 2002:aa7:d456:0:b0:42d:d7d9:34c1 with SMTP id q22-20020aa7d456000000b0042dd7d934c1mr46597774edr.21.1654794637540;
        Thu, 09 Jun 2022 10:10:37 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709063cea00b006f3ef214e5bsm10963516ejh.193.2022.06.09.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:10:36 -0700 (PDT)
Message-ID: <62a2298c.1c69fb81.bc909.d2d0@mx.google.com>
X-Google-Original-Message-ID: <YqIpibuM0ECVh6Gl@Ansuel-xps.>
Date:   Thu, 9 Jun 2022 19:10:33 +0200
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
Subject: Re: [PATCH v6 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
 <20220609132344.17548-2-ansuelsmth@gmail.com>
 <20220609170722.GA5081@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609170722.GA5081@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:37:22PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 09, 2022 at 03:23:42PM +0200, Ansuel Smith wrote:
> > Reorder qcom_nand_host to save holes in the struct.
> 
> You forgot to reorder other structs also as I requested :/
> 
> Thanks,
> Mani
>

Mhhh I didn't find obvius hole in other struct.
Think I will pass this with dwarf to better check them. Sorry!
Feel free to point them if you notice obvius hole that I didn't notice.

> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 1a77542c6d67..7fbbd3e7784c 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -431,11 +431,12 @@ struct qcom_nand_controller {
> >   *				and reserved bytes
> >   * @cw_data:			the number of bytes within a codeword protected
> >   *				by ECC
> > + * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> > + *				chip
> > + *
> >   * @use_ecc:			request the controller to use ECC for the
> >   *				upcoming read/write
> >   * @bch_enabled:		flag to tell whether BCH ECC mode is used
> > - * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> > - *				chip
> >   * @status:			value to be returned if NAND_CMD_STATUS command
> >   *				is executed
> >   * @last_command:		keeps track of last command on this chip. used
> > @@ -452,11 +453,12 @@ struct qcom_nand_host {
> >  	int cs;
> >  	int cw_size;
> >  	int cw_data;
> > -	bool use_ecc;
> > -	bool bch_enabled;
> >  	int ecc_bytes_hw;
> >  	int spare_bytes;
> >  	int bbm_size;
> > +
> > +	bool use_ecc;
> > +	bool bch_enabled;
> >  	u8 status;
> >  	int last_command;
> >  
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
