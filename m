Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132F51AFDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378417AbiEDU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357036AbiEDU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:59:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C515FF2;
        Wed,  4 May 2022 13:55:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so5158035ejb.6;
        Wed, 04 May 2022 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q7zZY8qF2MwCRzHE/3XXIlQWea5rmwXXYBxoggSeEAE=;
        b=U8ilqybDjMzspl9yEbac8RVR5f5bDbXLSHxsQQGrsP69fl+4ZhNDFRgg5Sti4bcSkh
         KBWJqBNrZdMAXVgsT0GFdI67GWbbKk8OYT6h+DQKqwOfMx4+/ddryZ5RiZCP+oQUjiDu
         U2g4VsPF83O9S1tyIgMxF08EE9E14tahf9BfzXsbhVHQ37hDDeWgseAyZaXKrqy+jKHR
         L+yTN4jXqZzguhDUmv9YyFtRZ8t2ZGVQnj/05WgO4CrYoLO1GCnaYQYvdLoErP8jz+6s
         THC90zInTyO2vgWd2TRipsnfRpWcNnzbiDMCd/NwFQC7LLBpT36YZCDrlw8nrWsfHu7Y
         pGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q7zZY8qF2MwCRzHE/3XXIlQWea5rmwXXYBxoggSeEAE=;
        b=C2/peot9M3gkMaSLvrLyufn7zMvP8GKzOxitQJmXQGMrEqO+kJOeK5+v0wsc8MToWz
         QWOC8r5GcTLJqipo8Nng4Q0HYJuxA423wibpYZ7Pj/cB0SleJ9EgJKTF3UfNqE+Yn4Ix
         w5Uh7alTdMbt7P8hr6J1f8JYt0zfZCFR5k77iUGaVVd3DCvuqOgCT/LpbMJRX80VgimG
         b3rkpaRQtpHgpQZNmbIM4ZaMRaASjOsb/UuQKaoUl0ETukz+ZaT7F+5UKQWaAFqZyOoF
         kyReh7kvU7KYB9MMVhibYTMa8Smpc1ON4A+e61Y3J9f2fVl7SmSfitEQlUaSgP+Tw1ud
         UHkQ==
X-Gm-Message-State: AOAM532COnBcymxVc/61aDoVIWa917Z7Ge+DU69n+rEAMpSOzS6J+ap9
        Ix0+N/ZBhh9/4l8ZdX9R6jQ=
X-Google-Smtp-Source: ABdhPJx72qWCwDTwj98zNOzlfLctr0ngFY0pMtin9Wh5YteHdfnXGfJ+SEBxr9gUSX9EpOl0dN1GUw==
X-Received: by 2002:a17:907:72ce:b0:6f4:5a57:320c with SMTP id du14-20020a17090772ce00b006f45a57320cmr14746858ejc.75.1651697753846;
        Wed, 04 May 2022 13:55:53 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id w17-20020a170907271100b006f3ef214e43sm6066313ejk.169.2022.05.04.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:55:53 -0700 (PDT)
Message-ID: <6272e859.1c69fb81.bbe18.742f@mx.google.com>
X-Google-Original-Message-ID: <YnLoV9IliQuJAz/7@Ansuel-xps.>
Date:   Wed, 4 May 2022 22:55:51 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/2] Add nvmem support for dynamic partitions
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
 <f511426e-47cd-7139-baab-ff31c9be2ba3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f511426e-47cd-7139-baab-ff31c9be2ba3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:23:16PM +0200, Rafał Miłecki wrote:
> On 29.04.2022 14:48, Ansuel Smith wrote:
> > This very small series comes to fix the very annyoing problem of
> > partitions declared by parser at runtime NOT supporting nvmem cells
> > definition.
> > 
> > The current implementation is very generic. The idea is to provide an of
> > node if defined for everyone and not strictly limit this to nvmem stuff.
> > But still the actual change is done only for nvmem-cells mtd. (just to
> > make sure) This can totally change by removing the compatible check.
> > 
> > The idea here is that a user can still use these dynamic parsers
> > instead of declaring a fixed-partition and also declare how nvmem-cells
> > are defined for the partition.
> > This live with the assumption that dynamic partition have always the
> > same name and they are known. (this is the case for smem-part partition
> > that would require a bootloader reflash to change and for parsers like
> > cmdlinepart where the name is always the same.)
> > With this assumption, it's easy to fix this problem. Just introduce a
> > new partition node that will declare just these special partition.
> > Mtdcore then will check if these special declaration are present and
> > connect the dynamic partition with the OF node present in the dts. Nvmem
> > will automagically fin the OF node and cells will be works based on the
> > data provided by the parser.
> > 
> > The initial idea was to create a special nvmem driver with a special
> > compatible where a user would declare the mtd partition name and this
> > driver would search it and register the nvmem cells but that became
> > difficult really fast, mtd notifier system is problematic for this kind
> > of stuff. So here is the better implementation. A variant of this is
> > already tested on openwrt where we have devices that use cmdlinepart.
> > (that current variant have defined in the dts the exact copy of
> > cmdlinepart in the fixed-partition scheme and we patched the cmdlinepart
> > parser to scan this fixed-partition node (that is ignored as cmdlinepart
> > have priority) and connect the dynamic partition with the dts node)
> > 
> > I provided an example of this in the documentation commit.
> > In short it's needed to add to the partitions where the compatible parser
> > is declared, a partition with just the label declared (instead of the reg).
> > Then declare some nvmem-cells and it will all work at runtime.
> > Mtdcore will check if a node with the same label is present and assign an
> > OF node to the MTD.
> > 
> > I currently tested this on my device that have smem-part and the
> > gmac driver use nvmem to get the mac-address. This works correctly and
> > the same address is provided.
> 
> Thanks a lot for working on this.
> 
> Another case (that I need this work for) is cmdline parser. Some
> partitions passed by U-Boot may require extra handling and that needs to
> be described in DT.

I see more and more OEMs and SoC using special parser to declare
partition so this is starting to become necessary.

-- 
	Ansuel
