Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A04BA835
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiBQS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:28:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbiBQS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:27:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791DC1FA60
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:27:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 10so5255294plj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7XAdhfqnK4iH4EoLafYbReQ6dbwtazRaihHUR1ZOE0=;
        b=aOQEOW87par6/hUQsWI+atBymO6HJq3KNqivVuk3LN53R/lXy0VZ1sMi9cb4Ezfu0k
         YcuA89dLFp6bwGyZBL0DWx0DNjvezBlAXmwcfKGPnFpt4zv+aWbt6ruHafRLZERyKDdg
         /ywSUhrnG7+TlBxdXQhUEjmKNDiJBIy4H4nAaiF2OPGqwZNNQkUMp1Yd1HVkzcfNQREr
         dhU+0IEc9tV0eofRN/OrDTJrycEHvvTySUNYqRbsJiA6fK2xbcn4vFEzHk5G2535nsn1
         ibXnD79AQeOqK0rNYxPUuGKn7BVsj01prmiRItpZYCW9GkCaeB5OrPA/sZrA6GFkBsMx
         zHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7XAdhfqnK4iH4EoLafYbReQ6dbwtazRaihHUR1ZOE0=;
        b=z8tR6MCkAcp5M4NeKNZK3PVRGTYsLWbTfHsXTM6qCIQAua73S0Sxzd3nqfXjjHT0Gw
         h7nNp6mZsxG+pPOs9Cx5Eiew6d3tiKvDm+YbK3eMWw0rmLeaDfeT1YwTjhhg34Mx+vLc
         1Q9lgwmt3SyfrBe61Oegpsh5v8DUfeWTXENf1i8W0C5MENP/LScCyS5l9IdOrNbA8bix
         elbHZJvNQBpRpUq8b4pg7D4cciTlf3Vgk8h7sNPTPt87I1HNRyXPMsrQuDLTPwIE/WNv
         5YWSTr1YQvlcQfI+3WnhPjSjfjhVe6260lnLdpzoh0iVvzbk1Vz9wQNkaosN4QYv+Iqu
         3bjw==
X-Gm-Message-State: AOAM5309/4iX8bTjh56LBhmGEu2+anL72BCNBJhV5Zo1nAMyJ1A7MBoI
        exICTJ2t7LPef+saefKWfr84Oru6VISIlH88YjLHJLlgIv0=
X-Google-Smtp-Source: ABdhPJzzl6/RD71m50k6jNfthMXlVrq4MNqDsnsfYDglBmZQcAKm9mTqZVD6H3aTVEzCKDs8r6vPYnr60mSzdBH2T10=
X-Received: by 2002:a17:902:ba96:b0:14c:8407:8e4b with SMTP id
 k22-20020a170902ba9600b0014c84078e4bmr3841382pls.135.1645122435705; Thu, 17
 Feb 2022 10:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20220216220541.1635665-1-rajatja@google.com> <Yg3oNkwS3XSzmJAu@kroah.com>
In-Reply-To: <Yg3oNkwS3XSzmJAu@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 17 Feb 2022 10:26:39 -0800
Message-ID: <CACK8Z6GvXw_V_R5YKyB-mLnLXG08v-HpcPbe5LxrS=Z7N+pffQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: ACPI: Support Microsoft's "DmaProperty"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 16, 2022 at 10:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 16, 2022 at 02:05:41PM -0800, Rajat Jain wrote:
> > The "DmaProperty" is supported and documented by Microsoft here:
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > They use this property for DMA protection:
> > https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> >
> > Support the "DmaProperty" with the same semantics. Windows documents the
> > property to apply to PCIe root ports only. Extend it to apply to any
> > PCI device. This is useful for internal PCI devices that do not hang off
> > a PCIe rootport, but offer an attack surface for DMA attacks (e.g.
> > internal network devices).
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v3: * Use Microsoft's documented property "DmaProperty"
> >     * Resctrict to ACPI only
> >
> >  drivers/pci/pci-acpi.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..660baa60c040 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1350,12 +1350,30 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >               dev->external_facing = 1;
> >  }
> >
> > +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
> > +{
> > +     u8 val;
> > +
> > +     /*
> > +      * Microsoft Windows uses this property, and is documented here:
> > +      * https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > +      * While Microsoft documents this property as only applicable to PCIe
> > +      * root ports, we expand it to be applicable to any PCI device.
> > +      */
> > +     if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> > +             return;
>
> Why not continue to only do this for PCIe devices like it is actually
> being used for?  Why expand it?

Because devices hanging off of PCIe root ports are not the only ones
that may need DMA protection. There may be internal PCI devices (that
don't hang off a PCIe root port) that may need DMA protection.
Examples include internal network controllers that may offer an attack
surface by handling network data or running vendor firmware.

>
> And what driver/device is going to use this?

This is already used by PCI subsystem to enforce stricter ACS
settings, and IOMMU drivers to enforce stricter IOMMU settings.

Thanks & Best Regards,

Rajat

>
> thanks,
>
> greg k-h
