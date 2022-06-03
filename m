Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA353CC49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245497AbiFCP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiFCP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:26:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413927152;
        Fri,  3 Jun 2022 08:26:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id v1so5915453ejg.13;
        Fri, 03 Jun 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/Mweah5lN/kO56CrN8XrafLn21dNoeqLFoQo/YGrZZg=;
        b=cDkSCXFXXZ6hfs/MNXUVXtr4eQAK9Zs/2YsWJ1Rr417bnEgJuvwSaONZjhR5BiGtJT
         ikt0i76nSlNiaPI6pwdHiineTc3hJ3nkQZ6dau3UmIhQUUfgP7e2QFxMquH27SZ+GKak
         e4EU9v6Yc1r/T3leuTmpqbxMHZVufZK9geZlMqX0rpFIKHovA1k0CWLFhgseTzOE+kRs
         j2oB5SE/zzbJfVq/li1UwNa6S6Z9fYOgo8lZaAr86LFGQCfcSXKZYAk78Ib7N3iroK/p
         CZNWuKSl5GqE9YOeH9m25tpUx8HYzxryeFDzEvpI0TWqjGPNbT8Buim74KLLELs/FSO6
         KPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Mweah5lN/kO56CrN8XrafLn21dNoeqLFoQo/YGrZZg=;
        b=nZksm3VxiGzZAKU68sAXuSmmURnhu6gd0XvF3T9SpEBsPVj9JFKkBr8GiT1l+JbCwu
         aW3iUZRpEUgeGmQrdFzFSPsBz9ESxcCfSm9HJiQqJxJkox3R4lnSL4T9kjLnxNvO14aW
         MYKyVgUvsPAE6zh0MZFiB+mqWVGMJ0UQDnvbyPsI6/MSZ+BJhUDDXlW3RtJxPhRQee+O
         cpxAkoPRERSlVVs83/ie2dUL+6ANOQqJAc2bOS2UHd+Zk1ftvAYRwA4FZPhx+KLku3GG
         mImXhVPmXFoUtA5/ddr8nq3V0hNIKKgLGO9MeN6McUxZHpyO8N8eJhT4sMTzNT9czpPy
         1eKg==
X-Gm-Message-State: AOAM532FZet9UO3c2f44yV4GhpLPjsSZ2ErlLVhnoq+neKK7spVJdVjf
        6capyrfsj41mVkxDGXdrMAQ=
X-Google-Smtp-Source: ABdhPJwZRfAbfi8MfMjOXkdqBIdB7kvAR10anP++LMR+VIwz1J0DvlAX3GxVcPzHUEBsM3POfZBQhQ==
X-Received: by 2002:a17:907:7baa:b0:6fe:b3dc:2378 with SMTP id ne42-20020a1709077baa00b006feb3dc2378mr9204315ejc.266.1654269958847;
        Fri, 03 Jun 2022 08:25:58 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402150300b0042dd3bf1403sm4028469edw.54.2022.06.03.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:25:58 -0700 (PDT)
Message-ID: <629a2806.1c69fb81.591ea.6012@mx.google.com>
X-Google-Original-Message-ID: <YpooBMVzdSpVkDXi@Ansuel-xps.>
Date:   Fri, 3 Jun 2022 17:25:56 +0200
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

Actually found the repo...This is the link [1].

My implementation is a variant of this since originally they used a
sysfs entry to swap the ecc configuration.

[1] https://github.com/marxfang/ipq807x-spf100-cs/blob/master/qsdk/qca/src/linux-4.4/drivers/mtd/nand/qcom_nandc.c

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
