Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73455B2004
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiIHOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiIHOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:02:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF018375
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:02:51 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54F9A3F473
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662645767;
        bh=jBazOeFQpWIHTwFBMzR7bbHllwYOtYl+NqES2kBpRFA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=adQFzG1bipmOiEYbmqMcvtnC08Zj1eec6VkP3Kvz5xWW1me+7ngIG39mTPe3+5++4
         kPM40JOsi1Vmwon8AiU140Un7jTry9tA86KuLBA7xkacUTMESCqsqwh63jZaCTy5Xv
         y2S5W8hli+egr4Afj1FUW8+I9RgUucWxlzl7K0TPjkyijXVO4VxsqRsHalJ/Ix47SL
         zLfJ0xKnFC+cLehViflaZ0+JADHpZ8OjzmdkBxUQ1qc6UU6JaQQkA8zkTmWwA0xk8p
         P0SZwStlamIxELgtB7vP2Ec1+CnH9GhsGJtodvbkCN5gRvYoD8PrQHvRHKgmnpxSbW
         J3RatMR+PG2MA==
Received: by mail-wm1-f70.google.com with SMTP id n7-20020a1c2707000000b003a638356355so8548856wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jBazOeFQpWIHTwFBMzR7bbHllwYOtYl+NqES2kBpRFA=;
        b=MhpjaPNrw9/0OVG4s9zFrjOi9jPRlI2DLF2vuh0Gr6R9nfDAy9jcb23lqnbbVYVSnt
         1pNFj+8YOTwG25RskzL02LwIfWXWlLUeZSPdklmt9EzxQPptNm1BtQmmpRC/Irql5114
         G5CsF2ESAm2GcaqBW9tuUnrUVzFkSH/wtOu02yv5n+YZkVrtrUCXCr8Q4AszJr5fhpY2
         reZGe5PblZVnGsdrLvBpbb7Bs+5O/QiKZdewO5E0aObeZ/V5PBDh0Z7oZGNSkFeoYdpl
         JbWlDBseYKzKsiMnkq69NUgWjrl/Qrr4r3dafcemqld8qcld/fyCUwL1pRcpMQnlFRNy
         3A7A==
X-Gm-Message-State: ACgBeo0BaYB1j3namGp3uPgswmACAjOZRh8oowOpavQRcHU5eQY38NMX
        TxHLafn0EXPxxJ9tblWIAZRauR0czPxH1tJlp4IbONbQXZMjdRgg7gAecEyNYSFKpRV7J96Irah
        T+tnKIS9f0lsYkjBLe6YJy/sVFp8izjIEnFFYGtDADO7LE1waDoARtoW5eQ==
X-Received: by 2002:a5d:44cf:0:b0:228:dc26:eb3c with SMTP id z15-20020a5d44cf000000b00228dc26eb3cmr5245645wrr.389.1662645766975;
        Thu, 08 Sep 2022 07:02:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5R64h+QMqhy56543P/zaKEpAVhDgGehq88VnAOL/4ZsZ+HE48Y4zqWwq/WPVivO2cS5wfBCkS0Cg9KXILZThQ=
X-Received: by 2002:a5d:44cf:0:b0:228:dc26:eb3c with SMTP id
 z15-20020a5d44cf000000b00228dc26eb3cmr5245613wrr.389.1662645766687; Thu, 08
 Sep 2022 07:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWlc1n4HRxawa/K@kroah.com> <DS7PR12MB60959AACEDB0AEFEE78A5B2EE2419@DS7PR12MB6095.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60959AACEDB0AEFEE78A5B2EE2419@DS7PR12MB6095.namprd12.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 8 Sep 2022 22:02:34 +0800
Message-ID: <CAAd53p5cz0VWUH9Rdvk70pcpY-PLc9SV8UCvMEc0+TBGES5W5w@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"

On Thu, Sep 8, 2022 at 12:30 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> Hi,
>
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, September 5, 2022 02:30
> > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Cc: mika.westerberg@linux.intel.com; andreas.noever@gmail.com;
> > michael.jamet@intel.com; YehezkelShB@gmail.com; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
> > on AMD USB4 controller
> >
> > On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> > > AMD USB4 can not detect external PCIe devices like external NVMe when
> > > it's hotplugged, because card/link are not up:
> > >
> > > pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101
> >
> > That sounds like a hardware bug, how does this work in other operating
> > systems for this hardware?
>
> We happen to have this HP system in our lab.  My colleague Anson (now on CC) flashed
> the same BIOS to it (01.02.01) using dediprog and loaded a 6.0-rc3 mainline kernel built
> from the Canonical mainline kernel PPA.
>
> He then tried to hotplug a TBT3 SSD a number of times but couldn't hit this issue.
> I attached his log to the kernel Bugzilla.

Nice to hear. Hopefully this can be fixed at firmware/hardware side.

>
> >
> > > Use `lspci` to resume pciehp bridges can find external devices.
> >
> > That's not good :(
> >
> > > A long delay before checking card/link presence doesn't help, either.
> > > The only way to make the hotplug work is to enable pciehp interrupt and
> > > check card presence after the TB switch is added.
> > >
> > > Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> > > the bridge ID so TBT driver can wake them up to check presence.
> >
> > As I mention below, this is not an acceptable solution.
> >
> > AMD developers, any ideas on how to get this fixed in the TB controller
> > firware instead?
>
> Anson also double checked on the AMD reference hardware that the HP system is built
> against and couldn't reproduce it there either.
>
> KH, I've got a few questions/comments to try to better explain why we're here.
>
> 1) How did you flash the 01.02.01 firmware?  In Anson's check, he used dediprog.
> Is it possible there was some stateful stuff used by HP's BIOS still on the SPI from the
> upgrade that didn't get set/cleared properly from an earlier pre-release BIOS?

We used UEFI capsule to update the firmware, via fwupd.

>
> 2) Did you change any BIOS settings?  Particularly anything to do with Pre-OS CM?

No, nothing in BIOS was changed.

>
> 3) If you explicitly reset to HP's "default BIOS settings" does it resolve?

Doesn't help. I put the device to ACPI G3 and it doesn't help, either.

>
> 4) Can you double check ADP_CS_5 bit 31?  I attached is a patch to kernel Bugzilla to
> add dyndbg output for it.  If it was for some reason set by Pre-OS CM in your BIOS/settings
> combination, we might need to undo it by the Linux CM.

All ports say "Hotplug disabled: 0".

dmesg attached to the bugzilla.

>
> 5) Are you changing any of the default runtime PM policies for any of the USB4 routers or
> root ports used for tunneling using software like TLP?

No. And they should be suspended by default.

Kai-Heng

>
> >
> > >
> > > Bugzilla:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> > illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216448&amp;data=05%7C01%7Cm
> > ario.limonciello%40amd.com%7C1e27b1d6f69e42796c7b08da8f107121%7C3d
> > d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637979598042186185%7CU
> > nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0lhcaKfUyoK
> > 0FXT9uDZ8a%2Fpxs9tHd8aoQcyPFdB%2F0eY%3D&amp;reserved=0
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
> > >  drivers/thunderbolt/switch.c |  6 ++++++
> > >  drivers/thunderbolt/tb.c     |  1 +
> > >  drivers/thunderbolt/tb.h     |  5 +++++
> > >  include/linux/thunderbolt.h  |  1 +
> > >  5 files changed, 42 insertions(+)
> > >
> > > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > > index cb8c9c4ae93a2..75f5ce5e22978 100644
> > > --- a/drivers/thunderbolt/nhi.c
> > > +++ b/drivers/thunderbolt/nhi.c
> > > @@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> > >  {
> > >     struct tb_nhi *nhi;
> > >     struct tb *tb;
> > > +   struct pci_dev *p = NULL;
> > > +   struct tb_pci_bridge *pci_bridge, *n;
> > >     int res;
> > >
> > >     if (!nhi_imr_valid(pdev)) {
> > > @@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> > >             nhi_shutdown(nhi);
> > >             return res;
> > >     }
> > > +
> > > +   if (pdev->vendor == PCI_VENDOR_ID_AMD) {
> > > +           while ((p = pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd,
> > p))) {
> > > +                   pci_bridge = kmalloc(sizeof(struct tb_pci_bridge),
> > GFP_KERNEL);
> > > +                   if (!pci_bridge)
> > > +                           goto cleanup;
> > > +
> > > +                   pci_bridge->bridge = p;
> > > +                   INIT_LIST_HEAD(&pci_bridge->list);
> > > +                   list_add(&pci_bridge->list, &tb->bridge_list);
> > > +           }
> > > +   }
> >
> > You can't walk the device tree and create a "shadow" list of devices
> > like this and expect any lifetime rules to work properly with them at
> > all.
> >
> > Please do not do this.
> >
> > greg k-h
