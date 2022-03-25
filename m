Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455224E7DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiCYTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiCYTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53C3E19EB;
        Fri, 25 Mar 2022 12:26:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gb19so8352811pjb.1;
        Fri, 25 Mar 2022 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/uC+62gh9ASaYWU9iHiRiXE2TcHkD9PeF++NwFgelTU=;
        b=Cwz9lfwulKIVQ4+wpmRMxuxynoCcw8m8Ti1afP//R2/4U2ZZT8Kl7ei0CVWQZ6VCkm
         g3CHirkwFWITqiH4pdpThrN4PIsxDR0+MV54mGbDE7HKADuu726EElYYiaSpnehUJ/Yf
         oWjwAAD0EfAaHoyz5gxhs6qonctlUJ8+vMBZkxJ860iRorl7UV9gtxCnpIZ/5xKt6rU0
         mPZT4Cff4a+Vv/4VPUZeYmVUD1pFm/bbA7ox+jpbXaVFwkOiD/VdLiKRAriyLFvYi3DZ
         K4jLjRqTNYrNiYfzTEgYfPcbVe4YPw8/vhSqCI6Z/91lpaDHwQOpQ7aq9028GKZE4e97
         Og9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/uC+62gh9ASaYWU9iHiRiXE2TcHkD9PeF++NwFgelTU=;
        b=ctB0MFlODmnsa419bJTL1hGyt50w9PX6MlA7R56ZBUa5tF6vOujMsiJOLubPpRhnK4
         KZweu5Q/XnzNTOr5o3hNeKQfavdHCeuDUGYmf8il38dZxFetBB2Q3uNZR1IVcStMkXpG
         whb38Hz+Zk7CS47skOcioRiYu4WVebCM4P/MjRkY0kCL2I2o5pxP2vQGHlUFFZra95Xr
         crQvK2Dyc8ysE52kUeoLv0jr71a6c57f2fBcoebQTIm9IU818nheWKdEg9mxeXd5S2uS
         k8OEboSO9IBJ6YSvUDoH1J7gU5RIGDydAzLbxcIF8weXsvDd5CbMWlN/Iw/AfVDLSR+4
         QI2Q==
X-Gm-Message-State: AOAM530zcQxd11zSKyPMLCHovx/vtOljRBHNQuFr32bMIHNRAFVNNxRT
        l2QvHeJf6KeYYsxdJYq6t3Q=
X-Google-Smtp-Source: ABdhPJwyxsudip9jMrIETZZeYxy2xQNUzsuCk2CIo6WpAKYGRwHVxU66XjsX4nTQhgPQJLDB2ivM2g==
X-Received: by 2002:a17:902:7887:b0:154:4f3f:ec54 with SMTP id q7-20020a170902788700b001544f3fec54mr13200826pll.156.1648236404001;
        Fri, 25 Mar 2022 12:26:44 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm5878382pgd.7.2022.03.25.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:26:43 -0700 (PDT)
Date:   Sat, 26 Mar 2022 00:56:37 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220325192637.GA15904@9a2d8922b8f1>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
 <20220324062547.GA15504@9a2d8922b8f1>
 <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
 <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
 <20220325173826.GA70042@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325173826.GA70042@9a2d8922b8f1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:08:26PM +0530, Kuldeep Singh wrote:
> On Fri, Mar 25, 2022 at 10:11:41AM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 25, 2022 at 2:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 24-03-22, 11:55, Kuldeep Singh wrote:
> > > > Fixed order of values is important in case of properties like
> > > > compatibles etc. In case of dma-names, yes order shouldn't matter here.
> > > >
> > > > This patch is more of appeasing dtbs_check warning rather than fixing
> > > > something.
> > >
> > > Exactly my point. We have seen similar type of issues with other tools, like
> > > coccinelle, earlier and such patches were rejected as the kernel was just fine
> > > and tooling needs to be fixed.
> > >
> > > > It's safe to go with this patch.
> > > > I am not sure if there's a provision to exclude dma-names from fix
> > > > ordering checks. Rob can help here in providing better insights.
> > 
> > I think it's a question of the scale of the warnings: my understanding is that
> > there are only a handful of dts files that trigger the warning at all, and it
> > would be rather hard to change the tooling around this. Since the proposed
> > dts change is clearly harmless, I don't mind applying it.
> > 
> > Kuldeep, you have probably looked at all dts files in the kernel, can you
> > say how many of them are affected by the dma property reordering?
> 
> I have checked spi-pl022.yaml as of now and this was the only one which
> was affected with dma ordering.
> 
> For all dts files, I can definitely give a try and will come up with
> some numbers. Please note, there are still bindings left to be converted
> to yaml format, so won't be able to catch those cases.

I checked and found below dts with dma-names warnings[1].
spear1340, spear1310, spear13xx, fsl-ls1043a, fsl-ls1046a 

Yes Arnd, you were right. Very few dts are affected by dma ordering
right now. There might be cases where nodes don't define generic names
and thus not running required checks, still I assume the numbers will be
very less. So, probably we can go ahead with the change.

- Kuldeep
[1]
root@9a2d8922b8f1:~/linux/torvalds# grep "'rx' was expected" output.txt
arch/arm/boot/dts/spear1340-evb.dt.yaml: spi@e0100000: dma-names:0: 'rx' was expected
arch/arm/boot/dts/spear1310-evb.dt.yaml: spi@e0100000: dma-names:0: 'rx' was expected
arch/arm/boot/dts/spear1340-evb.dt.yaml: serial@b4100000: dma-names:0: 'rx' was expected

root@9a2d8922b8f1:~/linux/torvalds# grep "'rx' was expected" arm64_all
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dt.yaml: i2c@2180000: dma-names:0: 'rx' was expected
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dt.yaml: i2c@2180000: dma-names:0: 'rx' was expected
arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dt.yaml: i2c@2180000: dma-names:0: 'rx' was expected
arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dt.yaml: i2c@2180000: dma-names:0: 'rx' was expected
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dt.yaml: i2c@2180000: dma-names:0: 'rx' was expected
