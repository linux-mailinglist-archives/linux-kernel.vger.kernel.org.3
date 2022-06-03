Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFB53CC40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiFCPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiFCPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:23:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C713701C;
        Fri,  3 Jun 2022 08:23:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so16608972ejk.5;
        Fri, 03 Jun 2022 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lqyq5k+XF5KgaIo5e3mhOS1nBHM477MF0d9qU6OOaQk=;
        b=HSg4VtPtX0FA6DhM4M/SK75iaIqx+VCXGg1pUX53SLtsvYkg9pR2/pFuxQOoAOefOq
         f2mBPGr0EJPdKqptHoGR2BDFmui6PKhSl5cNSTZumEQEIEtD+AwyoOGhkaKufrb/YkyA
         O7HW3sXJPjTYabzBxRqdVUgaUmMZeF/JWyndNXz9QHNiNKb8zhOFOgHXf+OwM5vtVX2m
         ga+1ePUiy0iH24OzhdlMhA4lJL3L1Hevddd64pxppQ8N2RNyc+ifeBmZqWdsamxcNaGl
         ziZC1ktFKTGilRtug72eUBvGnaFRVHgpbsfjFN9IdVMAMj/KSbx5BDYVXA7ZHxcE95GG
         cPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lqyq5k+XF5KgaIo5e3mhOS1nBHM477MF0d9qU6OOaQk=;
        b=kJPMG+RxFHyH4lbLSE5nIaCf9uU2eXOOkisdJhQaXYBcqo0CWEElAzjZb+Um+bGLn5
         FX/9UH/xbUV62UNXcyBYF7kNqvr973fjcyvcpdOtaJ/T1q7WuRi2IBFzHUwrZqiUssJB
         Cd63oJyXIDOeP1R0UUfpAWoyNcFwS5PE/EEoDgHPn3tatE1wUanpj5CfCo61uH1tkQ+h
         JsXNXX0rPy7QPgd6EgQ6nMQiQbs6MWAXHYV/bCEH6CY48XgtE4ztJD15HqM+DIRBqQlu
         Hm8kuMtdLctpurunp6UVz5MLp01pi5Kso5lk1Bxd6h4hH1yh7g1ZnzKNUGNywPWPSY/Y
         HCEA==
X-Gm-Message-State: AOAM532gnVkGoWc7L0RgRJSpqAQp+g29aQkNz+n8C5SNf7AjAep18l27
        eWte9lrazsZM0TGo2Z/5Cvw=
X-Google-Smtp-Source: ABdhPJx10a+aPHP5XcUngLeIIWoBKRDAxK9Dfy8n9eTEaJ7IOZN/o5Buq3qGXf/P3sZYGpt8fkmmXg==
X-Received: by 2002:a17:907:7290:b0:6ff:1fa2:e9e3 with SMTP id dt16-20020a170907729000b006ff1fa2e9e3mr9042275ejc.345.1654269799791;
        Fri, 03 Jun 2022 08:23:19 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b0042a2d9af0f8sm3998719edt.79.2022.06.03.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:23:19 -0700 (PDT)
Message-ID: <629a2767.1c69fb81.ee3de.6097@mx.google.com>
X-Google-Original-Message-ID: <YponZSfj3982xCYI@Ansuel-xps.>
Date:   Fri, 3 Jun 2022 17:23:17 +0200
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
Subject: Re: [PATCH v4 0/2] Add support for unprotected spare data page
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220603151806.GB26696@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603151806.GB26696@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 08:48:06PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 19, 2022 at 09:01:10PM +0200, Ansuel Smith wrote:
> > Some background about this.
> > On original qsdk ipq8064 based firmware there was a big separation from
> > boot partition and user partition. With boot partition we refer to
> > partition used to init the router (bootloader, spm firmware and other
> > internal stuff) With user partition we refer to linux partition and data
> > partition not used to init the router.
> > When someone had to write to these boot partition a special mode was
> > needed, to switch the nand driver to this special configuration.
> > 
> > Upstream version of the nandc driver totally dropped this and the result
> > is that if someone try to read data from these partition a CRC warning
> > is printed and if someone try to write that (if for example someone
> > wants to replace the bootloader) result is a broken system as the data
> > is badly written.
> > 
> 
> Can you please point me to the downstream/vendor driver that has this
> implementation?
> 
> Thanks,
> Mani
>

Sure, is it good if I give you a gist link with the source of driver?

> > This series comes to fix this.
> > 
> > A user can declare offset and size of these special partition using the
> > qcom,boot-pages binding.
> > 
> > An initial implementation of this assumed that the boot-pages started
> > from the start of the nand but we discover that some device have backup
> > of these special partition and we can have situation where we have this
> > partition scheme
> > - APPSBL (require special mode)
> > - APPSBLENV (doesn't require special mode)
> > - ART
> > - APPSBLBK (back of APPSBL require special mode)
> > - APPSBLENVBK (back of APPSBLENV doesn't require special mode)
> > With this configuration we need to declare sparse boot page and we can't
> > assume boot-pages always starts from the start of the nand.
> > 
> > A user can use this form to declare sparse boot pages
> > qcom,boot-pages = <0x0 0x0c80000 0x0c80000 0x0500000>;
> > 
> > The driver internally will parse this array, convert it to nand pages
> > and check internally on every read/write if this special configuration
> > should used for that page or the normal one.
> > 
> > The reason for all of this is that qcom FOR SOME REASON, disable ECC for
> > spare data only for these boot partition and we need to reflect this
> > special configuration to mute these warning and to permit actually
> > writing to these pages.
> > 
> > v4:
> > - Fix wrong compatible set for boot-pages (ipq8074 instead of ipq806x)
> > v3:
> > - Fix typo in Docmunetation commit desription
> > - Add items description for uint32-matrix
> > v2:
> > - Add fixes from Krzysztof in Documentation
> > 
> > Ansuel Smith (2):
> >   mtd: nand: raw: qcom_nandc: add support for unprotected spare data
> >     pages
> >   dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
> > 
> >  .../devicetree/bindings/mtd/qcom,nandc.yaml   |  26 +++
> >  drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
> >  2 files changed, 169 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
