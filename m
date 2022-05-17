Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90056529795
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiEQC7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiEQC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:59:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9D446146;
        Mon, 16 May 2022 19:59:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tk15so8576828ejc.6;
        Mon, 16 May 2022 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9L5Khg1CsV1mJj4HN4+8r3xoUYvqrWbbzNA2NHh1VS8=;
        b=O3G+JGx0PAmlDvq2x9GpUet1v7PATfl8GsiiBhyyHIVm2O0mDrFI2cdDhutDtGfXT8
         s3r8VvQON0eX5Ry7QThtY5Ty/xBOnsU2CETi0HmYP75sUk5hxbhWkNKbJQPcc7asysH3
         rFyvtkqg5Cj6OOx9VMrGTPPNAaY9oJRqoFC0UVNzLO717fTxiLm5dB/MOUzkLaQA8Fva
         doT2y8b/zS8FAyyKI3zXud6q0jC7BtPL8mUe2IfZQh3H2LoFDbzi0V9t+E4ACZRSJaUi
         xJRlJYgRdYQGDP5Twb39VaBxrLp3Z9RvZKAqa0AfGcmqrRLkokLqlQF7ciRUY/KNqI7u
         zJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9L5Khg1CsV1mJj4HN4+8r3xoUYvqrWbbzNA2NHh1VS8=;
        b=IM1PX2AOLOu9SD5+gJdSMd3odqKD+wzlVC3QlVRs6PuABevoHqnbkmj5ps6rACDLaS
         wti8H1XiSkehTO5cGc8d4jfONLMuoYSzR3PUgOngy/d02AK5X5MaL4kGdbPwYA3a+gbV
         dUeDZyQr51Sry7dsUyXBbIs89Nqqc8cP8688vcZgKXdPtODztCFhgEUqgItQv5DauPyd
         GhFZFePpd4ZIFhwTDIloFIr8gQbKE0ih4Xisx4dYMxvpFcTp4XQfWl6xsHCIyUrkV8wP
         aaAA4MtYJ67aZ55w9kpeMlJen6LMvY+WtYlGLYgiU7RXLGKMB6MqWhQBClrfB/UsAcYe
         uU9g==
X-Gm-Message-State: AOAM530Q55cBAX8dhZHehr5h4ZWINT0FQjZPqCqe1+H7IBGtBqcTzwrk
        PSTsE7HQEdJK+Eu6jW9zeNmlkMZAp1VuoXGfZu96QSmnzq9p/A==
X-Google-Smtp-Source: ABdhPJxGJ63ltlhgS8LTmZoQvHocGvopjIvM3r608Z+Du6QZiZ0iqL/BN/4qmkWhOz/wCG85LCYzZecFk94mUosNgII=
X-Received: by 2002:a17:906:6a1b:b0:6f4:a9b8:e027 with SMTP id
 qw27-20020a1709066a1b00b006f4a9b8e027mr18063258ejc.222.1652756375444; Mon, 16
 May 2022 19:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220513033450.7038-1-kflin@nuvoton.com> <20220513033450.7038-6-kflin@nuvoton.com>
 <b5361f08-f9eb-9384-f904-2625bae0fd9a@molgen.mpg.de>
In-Reply-To: <b5361f08-f9eb-9384-f904-2625bae0fd9a@molgen.mpg.de>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Tue, 17 May 2022 10:59:32 +0800
Message-ID: <CADnNmFqfxDE3UbNQiyhwkLBugfZ1fSZYDbGDQFnRZdD_4q58+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, CS20 KWLiu <kwliu@nuvoton.com>,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
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

Thanks for your review and comments.

> Please mention the datasheet name and revision used to implement this?
> How can your patch be tested?
>
> For a over 2000 line patch, I would expect a longer commit message with
> a summary of the hardware features, and implementation.

Okay, I'll add more information to the commit message, but it may not
be appropriate to add the datasheet name since it is not public.
And I tested with openbmc/obmc-ikvm (with patches to support Hextile
encoding that our driver used) and used VNC Viewer to verify the video
result.

>
> As the module author should you also be added to the file `MAINTAINERS`?
> (Maybe even with a functional address <linux-npcm-video@nuvoton.com>?
>
> > Signed-off-by: Marvin Lin <kflin@nuvoton.com>
>
> Same comment as in 1/5 regarding the author email address.

I'll add a new entry in MAINTAINERS.

> > +++ b/drivers/media/platform/nuvoton/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +comment "Nuvoton media platform drivers"
> > +
> > +config VIDEO_NUVOTON
>
> Is that driver going to support all Nuvoton devices or just NPCM? If
> only NPCM, that should be part of the Kconfig config name?
>
> > +     tristate "Nuvoton NPCM Video Capture/Encode Engine driver"
> > +     depends on V4L_PLATFORM_DRIVERS
> > +     depends on VIDEO_DEV
> > +     select VIDEOBUF2_DMA_CONTIG
> > +     help
> > +       Support for the Video Capture/Differentiation Engine (VCD) and
> > +       Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
>
> Mention the module name?
>
>  > To compile this driver as a module, choose M here: the module will be
> called XXX.

The driver just supports NPCM. I'll change the config to
VIDEO_NUVOTON_NPCM_VCD_ECE.

> > +struct nuvoton_video_addr {
> > +     unsigned int size;
>
> size_t?

> > +struct rect_list_info {
> > +     struct rect_list *list;
> > +     struct rect_list *first;
> > +     struct list_head *head;
> > +     int index;
> > +     int tile_perline;
> > +     int tile_perrow;
> > +     int offset_perline;
> > +     int tile_size;
> > +     int tile_cnt;
>
> Can all of these be unsigned?

> > +     int frame_rate;
> > +     int vb_index;
>
> Unsigned?
>

They will be addressed in the next patch.

> > +     u32 bytesperline;
> > +     u8 bytesperpixel;
> > +     u32 rect_cnt;
> > +     u8 num_buffers;
> > +     struct list_head *list;
> > +     u32 *rect;
>
> I would not limit the size?

It's clearer to know that it stores u32 exactly.

> > +static u32 nuvoton_video_ece_get_ed_size(struct nuvoton_video *video,
> > +                                      u32 offset, void *addr)
>
> Use unsigned int as return value?

Okay.

> > +static void nuvoton_video_ece_enc_rect(struct nuvoton_video *video, u32 r_off_x,
> > +                                    u32 r_off_y, u32 r_w, u32 r_h)
> > +{
> > +     struct regmap *ece = video->ece.regmap;
> > +     u32 rect_offset = (r_off_y * video->bytesperline) + (r_off_x * 2);
> > +     u32 temp;
> > +     u32 w_tile;
> > +     u32 h_tile;
> > +     u32 w_size = ECE_TILE_W;
> > +     u32 h_size = ECE_TILE_H;
>
> Any reason to fix the sizes?

A "Hextile" is fixed to 16x16 pixels size, which is defined in Remote
Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile Encoding).

> > +static void nuvoton_video_ece_ip_reset(struct nuvoton_video *video)
> > +{
> > +     reset_control_assert(video->ece.reset);
> > +     msleep(100);
> > +     reset_control_deassert(video->ece.reset);
> > +     msleep(100);
>
> 100 ms is quite long. Please add a comment, where that is documented. Is
> there a way to poll, if the device is done?

I'll add a comment. It should be reduced to ~10 us (suggested in
spec.) and there's no way to poll.

> > +
> > +static void nuvoton_video_free_diff_table(struct nuvoton_video *video)
> > +{
> > +     struct list_head *head, *pos, *nx;
> > +     struct rect_list *tmp;
> > +     int i;
>
> unsigned?
>

> > +static int nuvoton_video_find_rect(struct nuvoton_video *video,
> > +                                struct rect_list_info *info, u32 offset)
> > +{
> > +     int i = info->index;
> > +
> > +     if (offset < info->tile_perline) {
> > +             info->list = nuvoton_video_new_rect(video, offset, i);
>
> `i` is only used here, so use `info->index`?
>

> > +static int nuvoton_video_build_table(struct nuvoton_video *video,
> > +                                  struct rect_list_info *info)
> > +{
> > +     int i = info->index;
> > +     int j, ret, bit;
>
> Make `j` unsigned?
>
> > +     u32 value;
> > +     struct regmap *vcd = video->vcd_regmap;
> > +
> > +     for (j = 0; j < info->offset_perline; j += 4) {
> > +             regmap_read(vcd, VCD_DIFF_TBL + (j + i), &value);
>
> `i` is only used here, so use `info->index`?
>

> > +static void nuvoton_video_vcd_ip_reset(struct nuvoton_video *video)
> > +{
> > +     reset_control_assert(video->reset);
> > +     msleep(100);
> > +     reset_control_deassert(video->reset);
> > +     msleep(100);
>
> 100 ms is quite long. Please add a comment, where that is documented. Is
> there a way to poll, if the device is done?
>

> > +static int nuvoton_video_queue_setup(struct vb2_queue *q,
> > +                                  unsigned int *num_buffers,
> > +                                  unsigned int *num_planes,
> > +                                  unsigned int sizes[],
> > +                                  struct device *alloc_devs[])
> > +{
> > +     struct nuvoton_video *video = vb2_get_drv_priv(q);
> > +     int i;
>
> unsigned?
>

> > +static void nuvoton_video_buf_queue(struct vb2_buffer *vb)
> > +{
> > +     int empty;
> > +     struct nuvoton_video *video = vb2_get_drv_priv(vb->vb2_queue);
> > +     struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > +     struct nuvoton_video_buffer *nvb = to_nuvoton_video_buffer(vbuf);
> > +     unsigned long flags;
> > +
> > +     dev_dbg(video->dev, "%s\n", __func__);
> > +
> > +     spin_lock_irqsave(&video->lock, flags);
> > +     empty = list_empty(&video->buffers);
>
> Where is empty read later?
>

> > +     regs = devm_platform_ioremap_resource_byname(pdev, VCD_MODULE_NAME);
> > +     if (IS_ERR(regs)) {
> > +             dev_err(&pdev->dev, "Failed to get VCD regmap resource!\n");
>
> Can you help the user more by saying what to fix like check devicetree
> or so?
>

Okay. All of them will be addressed in the next patch.

Regards,
Marvin
