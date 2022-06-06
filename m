Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8946C53DFC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbiFFCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352206AbiFFCmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:42:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903AB95B7;
        Sun,  5 Jun 2022 19:42:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg6so6505313ejb.0;
        Sun, 05 Jun 2022 19:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1N3UQUBc3SITykVwo1DI11Mg5L1Q2wcvd0ubz4CZVpI=;
        b=QR1BrIRVMMEg2pgbBohP2/arDirkXnP+tL4I5QMLHUWjiYDbuH6aIrxuPPxCPrWBpx
         E7AeY+OCPrIOCSFxXu6077V46+Bknu5f1NrpoPF4TXfMtH+KH/ypkYQ9d3ME2aeDANp/
         b3+bimiNl8MpeSYkBDFlBYwV0AQX3bB2Rd1WAT3/PB3IEBfpVaWO0HXtUsL80NX/V0r9
         3YC26wLFLQHE1W8LV4p4sx00MCYjzwbdkBOq2YsZlKFZMHlEACQ8CcaAGLVWh/kQIlGU
         g72pssLvO4y/Iwr9EgKi5wtbfPb5mxpRE7TeZ+NuXc0bq716HTfN7raiAr1TeA/4F3wx
         DbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1N3UQUBc3SITykVwo1DI11Mg5L1Q2wcvd0ubz4CZVpI=;
        b=pTEQMQVCnYcEbjE+kyEXsNjAhXVs0F7oXsbFN3UI6Ql38i9pyDY/PvkSYGHnuWWhmc
         nHnWANtii74/hI+S4a5su10ni2PmKlpIh2Cbi89I/eOWX2yr1BaPW5Hn5g5pxnH3Bv28
         fh2OhpfIG9IAW5So0iTDEOIVvSQo9ctcG45Cpz0T24QgyLHXZykO2pnDUfT8UHVuWNHt
         nKIJF/kc0jLu81I9NJX4J22Le8qRVrM8ePGVcuLyVjSzpopCut/lrdMlS5maRblgycB8
         XsI4KrawPokx2JyZyue4P2I4Y3g+10gZA9Epd1l7cfNmmK0L8OaQsS9zRP02/50yALHW
         S+Aw==
X-Gm-Message-State: AOAM530EgC7wilYlK0glWcixPSG7XCv9A+6YNjJezCMPCo1hAp9HjSh5
        W/IgV9Ip/iNZl0KZ7CHi7fY5pRbktjuopTCDD8yp1PVdMbU=
X-Google-Smtp-Source: ABdhPJxkVMadKzZkp4603xDlsiXx/Hb59+1zjauQ6/hsxzM25KnSP9koqlSzgftzD42Y0SBSjP9JmAjC536SXaDMa24=
X-Received: by 2002:a17:906:b294:b0:6fe:fdb9:5fb4 with SMTP id
 q20-20020a170906b29400b006fefdb95fb4mr19414342ejz.179.1654483346371; Sun, 05
 Jun 2022 19:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513033450.7038-1-kflin@nuvoton.com> <20220513033450.7038-6-kflin@nuvoton.com>
 <b5361f08-f9eb-9384-f904-2625bae0fd9a@molgen.mpg.de> <CADnNmFqfxDE3UbNQiyhwkLBugfZ1fSZYDbGDQFnRZdD_4q58+A@mail.gmail.com>
In-Reply-To: <CADnNmFqfxDE3UbNQiyhwkLBugfZ1fSZYDbGDQFnRZdD_4q58+A@mail.gmail.com>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 6 Jun 2022 10:42:39 +0800
Message-ID: <CADnNmFqzAmyxgc0jbXFXUy8ueb=6-RxoWWHP4A=iRUO1fx4zRA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, CS20 KWLiu <kwliu@nuvoton.com>,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

These problems have been addressed in the new patch.
Could you please help to review the new patch v4? Thanks.

Regards,
Marvin

Kun-Fa Lin <milkfafa@gmail.com> =E6=96=BC 2022=E5=B9=B45=E6=9C=8817=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Paul,
>
> Thanks for your review and comments.
>
> > Please mention the datasheet name and revision used to implement this?
> > How can your patch be tested?
> >
> > For a over 2000 line patch, I would expect a longer commit message with
> > a summary of the hardware features, and implementation.
>
> Okay, I'll add more information to the commit message, but it may not
> be appropriate to add the datasheet name since it is not public.
> And I tested with openbmc/obmc-ikvm (with patches to support Hextile
> encoding that our driver used) and used VNC Viewer to verify the video
> result.
>
> >
> > As the module author should you also be added to the file `MAINTAINERS`=
?
> > (Maybe even with a functional address <linux-npcm-video@nuvoton.com>?
> >
> > > Signed-off-by: Marvin Lin <kflin@nuvoton.com>
> >
> > Same comment as in 1/5 regarding the author email address.
>
> I'll add a new entry in MAINTAINERS.
>
> > > +++ b/drivers/media/platform/nuvoton/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +comment "Nuvoton media platform drivers"
> > > +
> > > +config VIDEO_NUVOTON
> >
> > Is that driver going to support all Nuvoton devices or just NPCM? If
> > only NPCM, that should be part of the Kconfig config name?
> >
> > > +     tristate "Nuvoton NPCM Video Capture/Encode Engine driver"
> > > +     depends on V4L_PLATFORM_DRIVERS
> > > +     depends on VIDEO_DEV
> > > +     select VIDEOBUF2_DMA_CONTIG
> > > +     help
> > > +       Support for the Video Capture/Differentiation Engine (VCD) an=
d
> > > +       Encoding Compression Engine (ECE) present on Nuvoton NPCM SoC=
s.
> >
> > Mention the module name?
> >
> >  > To compile this driver as a module, choose M here: the module will b=
e
> > called XXX.
>
> The driver just supports NPCM. I'll change the config to
> VIDEO_NUVOTON_NPCM_VCD_ECE.
>
> > > +struct nuvoton_video_addr {
> > > +     unsigned int size;
> >
> > size_t?
>
> > > +struct rect_list_info {
> > > +     struct rect_list *list;
> > > +     struct rect_list *first;
> > > +     struct list_head *head;
> > > +     int index;
> > > +     int tile_perline;
> > > +     int tile_perrow;
> > > +     int offset_perline;
> > > +     int tile_size;
> > > +     int tile_cnt;
> >
> > Can all of these be unsigned?
>
> > > +     int frame_rate;
> > > +     int vb_index;
> >
> > Unsigned?
> >
>
> They will be addressed in the next patch.
>
> > > +     u32 bytesperline;
> > > +     u8 bytesperpixel;
> > > +     u32 rect_cnt;
> > > +     u8 num_buffers;
> > > +     struct list_head *list;
> > > +     u32 *rect;
> >
> > I would not limit the size?
>
> It's clearer to know that it stores u32 exactly.
>
> > > +static u32 nuvoton_video_ece_get_ed_size(struct nuvoton_video *video=
,
> > > +                                      u32 offset, void *addr)
> >
> > Use unsigned int as return value?
>
> Okay.
>
> > > +static void nuvoton_video_ece_enc_rect(struct nuvoton_video *video, =
u32 r_off_x,
> > > +                                    u32 r_off_y, u32 r_w, u32 r_h)
> > > +{
> > > +     struct regmap *ece =3D video->ece.regmap;
> > > +     u32 rect_offset =3D (r_off_y * video->bytesperline) + (r_off_x =
* 2);
> > > +     u32 temp;
> > > +     u32 w_tile;
> > > +     u32 h_tile;
> > > +     u32 w_size =3D ECE_TILE_W;
> > > +     u32 h_size =3D ECE_TILE_H;
> >
> > Any reason to fix the sizes?
>
> A "Hextile" is fixed to 16x16 pixels size, which is defined in Remote
> Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile Encoding).
>
> > > +static void nuvoton_video_ece_ip_reset(struct nuvoton_video *video)
> > > +{
> > > +     reset_control_assert(video->ece.reset);
> > > +     msleep(100);
> > > +     reset_control_deassert(video->ece.reset);
> > > +     msleep(100);
> >
> > 100 ms is quite long. Please add a comment, where that is documented. I=
s
> > there a way to poll, if the device is done?
>
> I'll add a comment. It should be reduced to ~10 us (suggested in
> spec.) and there's no way to poll.
>
> > > +
> > > +static void nuvoton_video_free_diff_table(struct nuvoton_video *vide=
o)
> > > +{
> > > +     struct list_head *head, *pos, *nx;
> > > +     struct rect_list *tmp;
> > > +     int i;
> >
> > unsigned?
> >
>
> > > +static int nuvoton_video_find_rect(struct nuvoton_video *video,
> > > +                                struct rect_list_info *info, u32 off=
set)
> > > +{
> > > +     int i =3D info->index;
> > > +
> > > +     if (offset < info->tile_perline) {
> > > +             info->list =3D nuvoton_video_new_rect(video, offset, i)=
;
> >
> > `i` is only used here, so use `info->index`?
> >
>
> > > +static int nuvoton_video_build_table(struct nuvoton_video *video,
> > > +                                  struct rect_list_info *info)
> > > +{
> > > +     int i =3D info->index;
> > > +     int j, ret, bit;
> >
> > Make `j` unsigned?
> >
> > > +     u32 value;
> > > +     struct regmap *vcd =3D video->vcd_regmap;
> > > +
> > > +     for (j =3D 0; j < info->offset_perline; j +=3D 4) {
> > > +             regmap_read(vcd, VCD_DIFF_TBL + (j + i), &value);
> >
> > `i` is only used here, so use `info->index`?
> >
>
> > > +static void nuvoton_video_vcd_ip_reset(struct nuvoton_video *video)
> > > +{
> > > +     reset_control_assert(video->reset);
> > > +     msleep(100);
> > > +     reset_control_deassert(video->reset);
> > > +     msleep(100);
> >
> > 100 ms is quite long. Please add a comment, where that is documented. I=
s
> > there a way to poll, if the device is done?
> >
>
> > > +static int nuvoton_video_queue_setup(struct vb2_queue *q,
> > > +                                  unsigned int *num_buffers,
> > > +                                  unsigned int *num_planes,
> > > +                                  unsigned int sizes[],
> > > +                                  struct device *alloc_devs[])
> > > +{
> > > +     struct nuvoton_video *video =3D vb2_get_drv_priv(q);
> > > +     int i;
> >
> > unsigned?
> >
>
> > > +static void nuvoton_video_buf_queue(struct vb2_buffer *vb)
> > > +{
> > > +     int empty;
> > > +     struct nuvoton_video *video =3D vb2_get_drv_priv(vb->vb2_queue)=
;
> > > +     struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > > +     struct nuvoton_video_buffer *nvb =3D to_nuvoton_video_buffer(vb=
uf);
> > > +     unsigned long flags;
> > > +
> > > +     dev_dbg(video->dev, "%s\n", __func__);
> > > +
> > > +     spin_lock_irqsave(&video->lock, flags);
> > > +     empty =3D list_empty(&video->buffers);
> >
> > Where is empty read later?
> >
>
> > > +     regs =3D devm_platform_ioremap_resource_byname(pdev, VCD_MODULE=
_NAME);
> > > +     if (IS_ERR(regs)) {
> > > +             dev_err(&pdev->dev, "Failed to get VCD regmap resource!=
\n");
> >
> > Can you help the user more by saying what to fix like check devicetree
> > or so?
> >
>
> Okay. All of them will be addressed in the next patch.
>
> Regards,
> Marvin
