Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098D6533083
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiEXSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiEXSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:34:46 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C57B9DF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:34:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2fee010f509so191125837b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBrJdmkYhyMKFfjatCCnMuBZLCB3cSo3begeOpY/XW0=;
        b=jQIgotbIxIKwjqP3Ytx/1zmEQiJy3GUwR7pfzJzuQ/KNfOg9PR/sWrGJ023UbG/uEJ
         0xHi7ypEjCWhSd1ukgWYWGlnvThWteDRtlCWJv6EwBcHPCHUF0gN51dFNaneKpRvLncC
         LAXz+ixBiY8+lJSiou2TBEtzqWwsF+sdxbMw+SGtJlzI8mpNUayyZg+RK+H05IOmfbpr
         18EPXakonYulEUB0y9ZdDRRUGcB2xuPIMwPd4c762ozCaW8xPw7dAv4F22pjDNoljNGN
         kz24YuRjs0EGn0LFKcaoPpxJnGG7K4Vf26j6JMQgIaOaoESDRviYMUu9J5qo74/Woa/W
         MWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBrJdmkYhyMKFfjatCCnMuBZLCB3cSo3begeOpY/XW0=;
        b=TD+k5FLoEfV1d2hV+EUJZClWWkQs3GndBItYvmHSLtdh+O6YSC7Ue8X/3JQsLFRrTY
         mTfOdsPeyzrRLz5g/zeZkZ+VvTNWJ4Ajd1bmvOxvCRgwENuRpKYDekIsQJL3XHkQQnZ5
         IoXWss/UFG7jf/BRw+yWkRPGO8aPbcfqTnsJfQZLkJdo2e7yIlZJK2Oo8y9Ks2rF88Ji
         jHcbJTTIm0RCaLpOYy7l3iHPx7Z/WY1JlQ+2hhvFqBGVF2105DvXbkATg6kI6e2+SXaY
         5f1lSWOd/uxRyNgv8LcUgqcr04nJ1Aq7RtEISdArr4UA5Iyts3xyZHdNSeeXXf0km5gb
         qhKQ==
X-Gm-Message-State: AOAM533SNDFjlPSH9b0jU2JQIz+mwcnrg5YVyD26u0iifQ9AvcabO4Nd
        q/SVSW4nR28ruA7PiqWAiYNLc2dWAEWdlduwWWGwVA==
X-Google-Smtp-Source: ABdhPJyY/JYhlZXxoEKO5HYVCNG5z/yk9AUUyQrAuiHIkRvGXWuoudF873m2e4tA4dlfQtDUZsLjJfE9Xq/pklwwrWc=
X-Received: by 2002:a81:72c5:0:b0:300:7d0:a642 with SMTP id
 n188-20020a8172c5000000b0030007d0a642mr8927907ywc.80.1653417283496; Tue, 24
 May 2022 11:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com> <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com> <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
 <460a746c-6b61-214b-4653-44a1430e314d@gmail.com> <alpine.DEB.2.22.394.2205181802310.1905099@ubuntu-linux-20-04-desktop>
 <6f469e9c-c26e-f4be-9a85-710afb0d77eb@gmail.com> <390ba7bb-ee9e-b7b7-5f08-71a7245fa4ec@gmail.com>
 <alpine.DEB.2.22.394.2205231856330.1905099@ubuntu-linux-20-04-desktop> <20220524160134.GE3730540-robh@kernel.org>
In-Reply-To: <20220524160134.GE3730540-robh@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 May 2022 11:34:07 -0700
Message-ID: <CAGETcx8k8VzdDgrijEYG_mAr_dPctQXT==DFWcieKKYoD9W_sQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Rob Herring <robh@kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr <olekstysh@gmail.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

"

On Tue, May 24, 2022 at 9:01 AM Rob Herring <robh@kernel.org> wrote:
>
> +Saravana
>
> On Mon, May 23, 2022 at 06:58:13PM -0700, Stefano Stabellini wrote:
> > On Mon, 23 May 2022, Oleksandr wrote:
> > > > > On Thu, 19 May 2022, Oleksandr wrote:
> > > > > > > On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.co=
m> wrote:
> > > > > > > > On 18.05.22 17:32, Arnd Bergmann wrote:
> > > > > > > > > On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
> > > > > > > > > <olekstysh@gmail.com> wrote:
> > > > > > > > >     This would mean having a device
> > > > > > > > > node for the grant-table mechanism that can be referred t=
o using
> > > > > > > > > the
> > > > > > > > > 'iommus'
> > > > > > > > > phandle property, with the domid as an additional argumen=
t.
> > > > > > > > I assume, you are speaking about something like the followi=
ng?
> > > > > > > >
> > > > > > > >
> > > > > > > > xen_dummy_iommu {
> > > > > > > >       compatible =3D "xen,dummy-iommu";
> > > > > > > >       #iommu-cells =3D <1>;
> > > > > > > > };
> > > > > > > >
> > > > > > > > virtio@3000 {
> > > > > > > >       compatible =3D "virtio,mmio";
> > > > > > > >       reg =3D <0x3000 0x100>;
> > > > > > > >       interrupts =3D <41>;
> > > > > > > >
> > > > > > > >       /* The device is located in Xen domain with ID 1 */
> > > > > > > >       iommus =3D <&xen_dummy_iommu 1>;
> > > > > > > > };
> > > > > > > Right, that's that's the idea,
> > > > > > thank you for the confirmation
> > > > > >
> > > > > >
> > > > > >
> > > > > > >    except I would not call it a 'dummy'.
> > > > > > >   From the perspective of the DT, this behaves just like an I=
OMMU,
> > > > > > > even if the exact mechanism is different from most hardware I=
OMMU
> > > > > > > implementations.
> > > > > > well, agree
> > > > > >
> > > > > >
> > > > > > > > > It does not quite fit the model that Linux currently uses=
 for
> > > > > > > > > iommus,
> > > > > > > > > as that has an allocator for dma_addr_t space
> > > > > > > > yes (# 3/7 adds grant-table based allocator)
> > > > > > > >
> > > > > > > >
> > > > > > > > > , but it would think it's
> > > > > > > > > conceptually close enough that it makes sense for the bin=
ding.
> > > > > > > > Interesting idea. I am wondering, do we need an extra actio=
ns for
> > > > > > > > this
> > > > > > > > to work in Linux guest (dummy IOMMU driver, etc)?
> > > > > > > It depends on how closely the guest implementation can be mad=
e to
> > > > > > > resemble a normal iommu. If you do allocate dma_addr_t addres=
ses,
> > > > > > > it may actually be close enough that you can just turn the gr=
ant-table
> > > > > > > code into a normal iommu driver and change nothing else.
> > > > > > Unfortunately, I failed to find a way how use grant references =
at the
> > > > > > iommu_ops level (I mean to fully pretend that we are an IOMMU d=
river). I
> > > > > > am
> > > > > > not too familiar with that, so what is written below might be w=
rong or
> > > > > > at
> > > > > > least not precise.
> > > > > >
> > > > > > The normal IOMMU driver in Linux doesn=E2=80=99t allocate DMA a=
ddresses by
> > > > > > itself, it
> > > > > > just maps (IOVA-PA) what was requested to be mapped by the uppe=
r layer.
> > > > > > The
> > > > > > DMA address allocation is done by the upper layer (DMA-IOMMU wh=
ich is
> > > > > > the glue
> > > > > > layer between DMA API and IOMMU API allocates IOVA for PA?). Bu=
t, all
> > > > > > what we
> > > > > > need here is just to allocate our specific grant-table based DM=
A
> > > > > > addresses
> > > > > > (DMA address =3D grant reference + offset in the page), so let=
=E2=80=99s say we
> > > > > > need an
> > > > > > entity to take a physical address as parameter and return a DMA=
 address
> > > > > > (what
> > > > > > actually commit #3/7 is doing), and that=E2=80=99s all. So work=
ing at the
> > > > > > dma_ops
> > > > > > layer we get exactly what we need, with the minimal changes to =
guest
> > > > > > infrastructure. In our case the Xen itself acts as an IOMMU.
> > > > > >
> > > > > > Assuming that we want to reuse the IOMMU infrastructure somehow=
 for our
> > > > > > needs.
> > > > > > I think, in that case we will likely need to introduce a new sp=
ecific
> > > > > > IOVA
> > > > > > allocator (alongside with a generic one) to be hooked up by the
> > > > > > DMA-IOMMU
> > > > > > layer if we run on top of Xen. But, even having the specific IO=
VA
> > > > > > allocator to
> > > > > > return what we indeed need (DMA address =3D grant reference + o=
ffset in
> > > > > > the
> > > > > > page) we will still need the specific minimal required IOMMU dr=
iver to
> > > > > > be
> > > > > > present in the system anyway in order to track the mappings(?) =
and do
> > > > > > nothing
> > > > > > with them, returning a success (this specific IOMMU driver shou=
ld have
> > > > > > all
> > > > > > mandatory callbacks implemented).
> > > > > >
> > > > > > I completely agree, it would be really nice to reuse generic IO=
MMU
> > > > > > bindings
> > > > > > rather than introducing Xen specific property if what we are tr=
ying to
> > > > > > implement in current patch series fits in the usage of "iommus"=
 in Linux
> > > > > > more-less. But, if we will have to add more complexity/more com=
ponents
> > > > > > to the
> > > > > > code for the sake of reusing device tree binding, this raises a=
 question
> > > > > > whether that=E2=80=99s worthwhile.
> > > > > >
> > > > > > Or I really missed something?
> > > > > I think Arnd was primarily suggesting to reuse the IOMMU Device T=
ree
> > > > > bindings, not necessarily the IOMMU drivers framework in Linux (a=
lthough
> > > > > that would be an added bonus.)
> > > > >
> > > > > I know from previous discussions with you that making the grant t=
able
> > > > > fit in the existing IOMMU drivers model is difficult, but just re=
using
> > > > > the Device Tree bindings seems feasible?
> > > >
> > > > I started experimenting with that. As wrote in a separate email, I =
got a
> > > > deferred probe timeout,
> > > >
> > > > after inserting required nodes into guest device tree, which seems =
to be a
> > > > consequence of the unavailability of IOMMU, I will continue to inve=
stigate
> > > > this question.
> > >
> > >
> > > I have experimented with that. Yes, just reusing the Device Tree bind=
ings is
> > > technically feasible (and we are able to do this by only touching
> > > grant-dma-ops.c), although deferred probe timeout still stands (as th=
ere is no
> > > IOMMU driver being present actually).
> > >
> > > [    0.583771] virtio-mmio 2000000.virtio: deferred probe timeout, ig=
noring
> > > dependency
> > > [    0.615556] virtio_blk virtio0: [vda] 4096000 512-byte logical blo=
cks (2.10
> > > GB/1.95 GiB)
> > >
> > >
> > > Below the working diff (on top of current series):
> > >
> > > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.=
c
> > > index da9c7ff..6586152 100644
> > > --- a/drivers/xen/grant-dma-ops.c
> > > +++ b/drivers/xen/grant-dma-ops.c
> > > @@ -272,17 +272,24 @@ static const struct dma_map_ops xen_grant_dma_o=
ps =3D {
> > >
> > >  bool xen_is_grant_dma_device(struct device *dev)
> > >  {
> > > +       struct device_node *iommu_np;
> > > +       bool has_iommu;
> > > +
> > >         /* XXX Handle only DT devices for now */
> > >         if (!dev->of_node)
> > >                 return false;
> > >
> > > -       return of_property_read_bool(dev->of_node, "xen,backend-domid=
");
> > > +       iommu_np =3D of_parse_phandle(dev->of_node, "iommus", 0);
> > > +       has_iommu =3D iommu_np && of_device_is_compatible(iommu_np,
> > > "xen,grant-dma");
> > > +       of_node_put(iommu_np);
> > > +
> > > +       return has_iommu;
> > >  }
> > >
> > >  void xen_grant_setup_dma_ops(struct device *dev)
> > >  {
> > >         struct xen_grant_dma_data *data;
> > > -       uint32_t domid;
> > > +       struct of_phandle_args iommu_spec;
> > >
> > >         data =3D find_xen_grant_dma_data(dev);
> > >         if (data) {
> > > @@ -294,16 +301,30 @@ void xen_grant_setup_dma_ops(struct device *dev=
)
> > >         if (!dev->of_node)
> > >                 goto err;
> > >
> > > -       if (of_property_read_u32(dev->of_node, "xen,backend-domid", &=
domid)) {
> > > -               dev_err(dev, "xen,backend-domid property is not prese=
nt\n");
> > > +       if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iomm=
u-cells",
> > > +                       0, &iommu_spec)) {
> > > +               dev_err(dev, "Cannot parse iommus property\n");
> > > +               goto err;
> > > +       }
> > > +
> > > +       if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") =
||
> > > +                       iommu_spec.args_count !=3D 1) {
> > > +               dev_err(dev, "Incompatible IOMMU node\n");
> > > +               of_node_put(iommu_spec.np);
> > >                 goto err;
> > >         }
> > >
> > > +       of_node_put(iommu_spec.np);
> > > +
> > >         data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > >         if (!data)
> > >                 goto err;
> > >
> > > -       data->backend_domid =3D domid;
> > > +       /*
> > > +        * The endpoint ID here means the ID of the domain where the
> > > corresponding
> > > +        * backend is running
> > > +        */
> > > +       data->backend_domid =3D iommu_spec.args[0];
> > >
> > >         if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)de=
v, data,
> > >                         GFP_KERNEL))) {
> > > (END)
> > >
> > >
> > >
> > > Below, the nodes generated by Xen toolstack:
> > >
> > >         xen_grant_dma {
>
> Nit: iommu {
>
> > >                 compatible =3D "xen,grant-dma";
> > >                 #iommu-cells =3D <0x01>;
> > >                 phandle =3D <0xfde9>;
> > >         };
> > >
> > >         virtio@2000000 {
> > >                 compatible =3D "virtio,mmio";
> > >                 reg =3D <0x00 0x2000000 0x00 0x200>;
> > >                 interrupts =3D <0x00 0x01 0xf01>;
> > >                 interrupt-parent =3D <0xfde8>;
> > >                 dma-coherent;
> > >                 iommus =3D <0xfde9 0x01>;
> > >         };
> >
> > Not bad! I like it.
> >
> >
> > > I am wondering, would be the proper solution to eliminate deferred pr=
obe
> > > timeout issue in our particular case (without introducing an extra IO=
MMU
> > > driver)?
> >
> > In reality I don't think there is a way to do that. I would create an
> > empty skelethon IOMMU driver for xen,grant-dma.
>
> Does it have to be an empty driver? Originally, IOMMU 'drivers' were not
> drivers, but they've been getting converted. Can that be done here?
>
> Short of that, I think we could have some sort of skip probe list for
> deferred probe. Not sure if that would be easiest as IOMMU specific or
> global.

Hi Oleksandr,

If you do fw_devlink.strict=3D1, you'll notice that the consumers of
this "iommu" won't probe at all or will delay the boot by some number
of seconds. The eventual goal is to go towards fw_devlink.strict=3D1
being the default.

From a fw_devlik perspective, please implement a driver. Ideally a
real one, but at least an empty one. The empty one doesn't need to be
an IOMMU driver, but at least just do a return 0 in the probe
function. Also, if it's not a device, why even have a "compatible"
property (removing it won't necessarily remove the deferred probe
timeout issue you see)? Will any code be using "xen,grant-dma" to look
up the node? If so, that driver could be the one that probes this
device. At least from a fw_devlink perspective, it just needs to have
a driver that binds to this device.

Also, if we aren't going to implement a driver and have the supplier
("xen,grant-dma") behave like a device (as in, have a driver that
probes), I'd rather that the iommu binding not be used at all as this
would be an exception to how every other iommu device behaves.

-Saravana
