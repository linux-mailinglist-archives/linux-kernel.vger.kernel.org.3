Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A51526F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiENDrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiENDri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:47:38 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23968D118
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:47:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7bb893309so107433747b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlgtfqIsCtTv5Jauk4wjOqDSq6O7AkKJ3RvfO9y7TuY=;
        b=Hd3y72OZxm4CV6vW7TxvqAtmoAy+5gV6r8Hf73b2YVQhbZh/HnO/aOE8OjMotWtJsU
         pgzFZb7Pbdo2z3gPi9huhyKqFUGMLw3qTCbrVpuaAWUIFHWGbwySJWLcSD3x2HJrwRq3
         9fXf4FixKmDUChFhx096IeeNMt3xcPz0/4o2aTvkQVRfQbAJc5UhQHyWxXSkV4gFPg33
         SGpNyqOFMnggv210P+5AB5hDnM0fJ36oi+VoIRbJ9v2IN0RWG2s14SDXdE2Oc2HrLKAY
         bja30YKLL/ESaJrKPVW74HGSsPp2CsdjFg4HM+oVywqUe7/hTlwWz89KB+xAYsV0Z17x
         OmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlgtfqIsCtTv5Jauk4wjOqDSq6O7AkKJ3RvfO9y7TuY=;
        b=hpHKNQl5Qtw4uYx9n+fum41h15DA4QBOv2JE3uYv50K3rOl4fqSSRT6ZFtIoHNfUA8
         gUNZCndOYDViAUVtiI6dESOTxgAF/1UOp7TBQAp86iuQ0SnoVj27lTRn8uSGDozbM+T3
         Lw8YgVjdksYuG265TLcJJ1RCFTwK6KikiJD7WxgyUG8ZuTIW7OMib3lvQLoDvKMnd3S5
         IaLIG0xisRR4kpfQTM96I9rEjgLSEpcpvIUCQOCAg/ShYy9CiUKjes/1fl3stQRdUcsz
         cXCo2fwv5HBKVy75wiXZ2H+7SFT+z97UZiTY2LewOVCbC8L3kGaxPmQG76mISCAeRa1T
         iiOw==
X-Gm-Message-State: AOAM531kt7REblX06dmYqV8rVMPpXJNFaBHHwJ73pd6tr9UGGlwVvQYh
        ms3emODaZfya/DTGrdfRPAv/+bcG+/7SHUfjMw9C9w==
X-Google-Smtp-Source: ABdhPJyuCzmt9tIN7J1096gL4CtFK52NhgqgDXFCfNnRSovHU7C3BAMp6A67Zyxusp7zpb2DBDbNkL2qgI0VZxj+CYg=
X-Received: by 2002:a0d:cfc5:0:b0:2dc:48db:dda1 with SMTP id
 r188-20020a0dcfc5000000b002dc48dbdda1mr9063293ywd.83.1652500054045; Fri, 13
 May 2022 20:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net> <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
 <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
 <YnvnNUrsCOUxMu8A@lpieralisi> <615718f9-151e-20fb-fcb0-56063ae61ca6@lucaceresoli.net>
In-Reply-To: <615718f9-151e-20fb-fcb0-56063ae61ca6@lucaceresoli.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 May 2022 20:46:57 -0700
Message-ID: <CAGETcx9r4e9PkUFNZ+vUfqOSO5=e9apmBj0+DyOkKEvc4CnsLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 7:07 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Lorenzo,
>
> On 11/05/22 18:41, Lorenzo Pieralisi wrote:
> > On Sat, Jan 15, 2022 at 10:02:00AM -0600, Rob Herring wrote:
> >> +Saravana
> >>
> >> On Tue, Jan 11, 2022 at 4:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>>
> >>> Hi Rob,
> >>>
> >>> On 16/12/21 10:08, Luca Ceresoli wrote:
> >>>> Hi Rob,
> >>>>
> >>>> thanks for the quick feedback!
> >>>>
> >>>> On 14/12/21 23:42, Rob Herring wrote:
> >>>>> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >>>>>>
> >>>>>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
> >>>>>> have already been added by device_link_add() and won't be deleted by
> >>>>>> device_link_del() because the code calls 'return' and not 'goto err_link'.
> >>>>>>
> >>>>>> Fix in a very simple way by doing all the devm_phy_get() calls before all
> >>>>>> the device_link_add() calls.
> >>>>>>
> >>>>>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> >>>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >>>>>> ---
> >>>>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
> >>>>>>  1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>> index f7f1490e7beb..2ccc53869e13 100644
> >>>>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> >>>>>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
> >>>>>>                 phy[i] = devm_phy_get(dev, name);
> >>>>>>                 if (IS_ERR(phy[i]))
> >>>>>>                         return PTR_ERR(phy[i]);
> >>>>>> +       }
> >>>>>>
> >>>>>> +       for (i = 0; i < phy_count; i++) {
> >>>>>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> >>>>>
> >>>>> I think this should happen automatically now with fw_devlink being
> >>>>> enabled by default. Can you try?
> >>>>
> >>>> Do you mean removal should be done automatically? I think they are not
> >>>> due to the DL_FLAG_STATELESS flag.
> >>>
> >>> I would love to have feedback because, as said, I think my patch is
> >>> correct, but if I'm wrong (which might well be) I have to drop patch 1
> >>> and rewrite patch 2 in a slightly more complex form.
> >>
> >> I mean that why do you need explicit dependency tracking here when
> >> dependencies on a PHY should happen automatically now. IOW, what is
> >> special about this driver and dependency?
> >
> > Any update on this patch ? I think patch 2 can be merged, please
> > let me know if this one can be dropped.
>
> Thanks for the feedback! You would say yes, you can merge patch 2,
> except it probably does not even apply as it is written in a way that is
> based on the changes in patch 1.
>
> I could rewrite patch 2 to not depend on patch 1 of course, but it
> wouldn't make code simpler, perhaps more complex. And moreover the
> hardware that I used to have access to has phy_count==1 so I could never
> test the failing case, and sadly now I have no access to that hardware.

Hi Luca,

The fw_devlink code to create device links from consumers to "phys"
suppliers is pretty well exercised. Most/all Android devices running
5.10+ kernels (including Pixel 6) use fw_devlink=on to be able to boot
properly.

So I'd be pretty confident in deleting the device_link_add/del() code
in drivers/pci/controller/dwc/pci-dra7xx.c. The device links should
already be there before the probe is even called.

Also, if you want to check if the device links (even the 1 phy one you
have) are being created, you can look at /sys/class/devlink to see the
list of all device links that are currently present. You can delete
the code and then use this to check too.

-Saravana

>
> --
> Luca
