Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F774A9D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376822AbiBDROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiBDROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:14:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A0C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:14:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id me13so21355531ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yL40vakyvqJO/FkRCdvdMKDz5ib1Vy1dFBRB+t82Nbk=;
        b=CWt09kq24Kv+2DLXLAgOziPHHWhoUUYhzvDpvILlYebuOH6cqqxvw5Fv0uxDV9wCv9
         QnVYqsKR1b8RWp8FgO6yGJxvjbIgWN/ZO2A7AI8nW1kMTr9z3lZwnF381rTaQgukqLPL
         s1kqvaaC1tEj9mtum1s+Qo6AY5JWU/JCoxm74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL40vakyvqJO/FkRCdvdMKDz5ib1Vy1dFBRB+t82Nbk=;
        b=Avbz5Gx4oxSmO430EsEd3jx9fgF11kaOriDiP6MCjEqpvIDgd6MNoKGP0YPicMtcfG
         4tlt8icyeYuVcFLvwZTmssaLlLe5WsMtD/vtL1ms3D85NE3BOeXCzofTKfj/4+yjUGyL
         0Dh8pO6UCgHIiBu7Ashuw/9y1SKOMowRIlVsH1sFUkYvlmOKmPY32Vm6F+qiK/hPv/ov
         kiR6TZpuXiCgqmkrLwvG3U/4ViV8YohVHiJzKzW8TqtF56c0FhxB+r35BDfIwYSKOOMc
         uvU11jl7dkk/LiTSo80WG6K6aYfRXc27ArkBws/QGqmiizkU5QN5e5sTJZko2m1ZO6if
         F+FQ==
X-Gm-Message-State: AOAM532UV6U9rZ+sEKygrVAGP0Ta2RKbVeDf82JJt3x742uL9RIhAill
        DioQEfBs82ihgFLKq7dSLchs9wA7SfpnOQ==
X-Google-Smtp-Source: ABdhPJw6zm1MbCUOFl5yAjGf4K4RcTiTC9Y+6way7nkldfkhsNMLVgB2mX7f2xNA0N4dGebZhdgSyA==
X-Received: by 2002:a17:907:d8a:: with SMTP id go10mr3420730ejc.408.1643994858945;
        Fri, 04 Feb 2022 09:14:18 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g24sm847023ejx.11.2022.02.04.09.14.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 09:14:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id me13so21355385ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:14:18 -0800 (PST)
X-Received: by 2002:a17:906:15ca:: with SMTP id l10mr3475508ejd.435.1643994857975;
 Fri, 04 Feb 2022 09:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20220124190013.221601-1-ribalda@chromium.org> <20220124190013.221601-2-ribalda@chromium.org>
 <YftRjmBW75ofz8PG@pendragon.ideasonboard.com>
In-Reply-To: <YftRjmBW75ofz8PG@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 4 Feb 2022 18:14:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCsnRHzSykVZPHkpRCjkjhvmS5A5SROS5XC1nz6bSeY_2g@mail.gmail.com>
Message-ID: <CANiDSCsnRHzSykVZPHkpRCjkjhvmS5A5SROS5XC1nz6bSeY_2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: uvcvideo: Do power management granularly
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Thanks for the review! :)


I have uploaded v5 with all the changes, (please ignore v4 ;))

Best regards!

On Thu, 3 Feb 2022 at 04:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Jan 24, 2022 at 08:00:13PM +0100, Ricardo Ribalda wrote:
> > Instead of suspending/resume the USB device at open()/close(), do it
> > when the device is actually used.
> >
> > This way we can reduce the power consumption when a service is holding
> > the video device and leaving it in an idle state.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c | 199 +++++++++++++++++++++++++------
> >  drivers/media/usb/uvc/uvcvideo.h |   1 +
> >  2 files changed, 166 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 711556d13d03..48217e47646f 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -25,6 +25,55 @@
> >
> >  #include "uvcvideo.h"
> >
> > +/* ------------------------------------------------------------------------
> > + * UVC power management
> > + */
> > +
> > +static int uvc_pm_get(struct uvc_streaming *stream)
> > +{
> > +     int ret = 0;
> > +
> > +     if (!video_is_registered(&stream->vdev))
> > +             return -ENODEV;
>
> Can this happen ?
It is some leftovers from code backported from our kernel sorry.

https://lkml.org/lkml/2020/8/30/183

>
> > +
> > +     /*
> > +      * We cannot hold dev->lock when calling autopm_get_interface.
> > +      */
>
> Why is that ?

Because _uvc_resume takes the same lock.

>
> > +     ret = usb_autopm_get_interface(stream->dev->intf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&stream->dev->lock);
> > +     if (!stream->dev->users)
> > +             ret = uvc_status_start(stream->dev, GFP_KERNEL);
> > +     if (!ret)
> > +             stream->dev->users++;
> > +     mutex_unlock(&stream->dev->lock);
> > +
> > +     if (ret)
> > +             usb_autopm_put_interface(stream->dev->intf);
>
> Does this use autosuspend with a delay ?

I believe the default autosuspend is 2 sec.
https://www.kernel.org/doc/Documentation/usb/power-management.txt



>
> > +
> > +     return ret;
> > +}
> > +
> > +static void uvc_pm_put(struct uvc_streaming *stream)
> > +{
> > +     if (!video_is_registered(&stream->vdev))
> > +             return;
>
> If the device gets disconnected during streaming, we'll unregister the
> video device. When uvc_pm_put() is called in uvc_v4l2_release(), it will
> then return immediately. Won't this cause an unbalanced PM issue ?

I just removed it thanks :)

>
> > +
> > +     mutex_lock(&stream->dev->lock);
> > +     if (WARN_ON(!stream->dev->users)) {
> > +             mutex_unlock(&stream->dev->lock);
> > +             return;
> > +     }
> > +     stream->dev->users--;
> > +     if (!stream->dev->users)
> > +             uvc_status_stop(stream->dev);
> > +     mutex_unlock(&stream->dev->lock);
> > +
> > +     usb_autopm_put_interface(stream->dev->intf);
> > +}
> > +
> >  /* ------------------------------------------------------------------------
> >   * UVC ioctls
> >   */
> > @@ -251,8 +300,14 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> >                       stream->ctrl.dwMaxVideoFrameSize;
> >
> >       /* Probe the device. */
> > +     ret = uvc_pm_get(stream);
> > +     if (ret) {
> > +             mutex_unlock(&stream->mutex);
> > +             goto done;
> > +     }
> >       ret = uvc_probe_video(stream, probe);
> >       mutex_unlock(&stream->mutex);
> > +     uvc_pm_put(stream);
>
> uvc_pm_get() is called with the stream->mutex held, while uvc_pm_put()
> isn't. Is there any specific reason ?

Good catch, moving get outside of the lock
>
> >       if (ret < 0)
> >               goto done;
> >
> > @@ -464,7 +519,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> >       }
> >
> >       /* Probe the device with the new settings. */
> > +     ret = uvc_pm_get(stream);
> > +     if (ret) {
> > +             mutex_unlock(&stream->mutex);
> > +             return ret;
> > +     }
> >       ret = uvc_probe_video(stream, &probe);
> > +     uvc_pm_put(stream);
> >       if (ret < 0) {
> >               mutex_unlock(&stream->mutex);
> >               return ret;
> > @@ -555,36 +616,24 @@ static int uvc_v4l2_open(struct file *file)
> >  {
> >       struct uvc_streaming *stream;
> >       struct uvc_fh *handle;
> > -     int ret = 0;
> >
> >       stream = video_drvdata(file);
> >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> >
> > -     ret = usb_autopm_get_interface(stream->dev->intf);
> > -     if (ret < 0)
> > -             return ret;
> > -
> >       /* Create the device handle. */
> >       handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > -     if (handle == NULL) {
> > -             usb_autopm_put_interface(stream->dev->intf);
> > +     if (!handle)
> >               return -ENOMEM;
> > -     }
> >
> > -     mutex_lock(&stream->dev->lock);
> > -     if (stream->dev->users == 0) {
> > -             ret = uvc_status_start(stream->dev, GFP_KERNEL);
> > -             if (ret < 0) {
> > -                     mutex_unlock(&stream->dev->lock);
> > -                     usb_autopm_put_interface(stream->dev->intf);
> > -                     kfree(handle);
> > -                     return ret;
> > -             }
> > +     /*
> > +      * If the uvc evdev exists we cannot suspend when the device
> > +      * is idle. Otherwise we will miss button actions.
> > +      */
> > +     if (stream->dev->input && uvc_pm_get(stream)) {
> > +             kfree(handle);
> > +             return -ENODEV;
> >       }
> >
> > -     stream->dev->users++;
> > -     mutex_unlock(&stream->dev->lock);
> > -
> >       v4l2_fh_init(&handle->vfh, &stream->vdev);
> >       v4l2_fh_add(&handle->vfh);
> >       handle->chain = stream->chain;
> > @@ -606,6 +655,12 @@ static int uvc_v4l2_release(struct file *file)
> >       if (uvc_has_privileges(handle))
> >               uvc_queue_release(&stream->queue);
> >
> > +     if (handle->is_streaming)
> > +             uvc_pm_put(stream);
> > +
> > +     if (stream->dev->input)
> > +             uvc_pm_put(stream);
> > +
> >       /* Release the file handle. */
> >       uvc_dismiss_privileges(handle);
> >       v4l2_fh_del(&handle->vfh);
> > @@ -613,12 +668,6 @@ static int uvc_v4l2_release(struct file *file)
> >       kfree(handle);
> >       file->private_data = NULL;
> >
> > -     mutex_lock(&stream->dev->lock);
> > -     if (--stream->dev->users == 0)
> > -             uvc_status_stop(stream->dev);
> > -     mutex_unlock(&stream->dev->lock);
> > -
> > -     usb_autopm_put_interface(stream->dev->intf);
> >       return 0;
> >  }
> >
> > @@ -842,7 +891,21 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
> >               return -EBUSY;
> >
> >       mutex_lock(&stream->mutex);
> > +     if (!handle->is_streaming) {
> > +             ret = uvc_pm_get(stream);
> > +             if (ret)
> > +                     goto unlock;
> > +     }
>
> Is there any reason to continue if we're already streaming ? The other
> option would be to call uvc_pm_get() unconditionally here.
I would rather handle it with the next suggestion ;)
>
> > +
> >       ret = uvc_queue_streamon(&stream->queue, type);
> > +
> > +     if (ret && !handle->is_streaming)
> > +             uvc_pm_put(stream);
> > +
> > +     if (!ret)
> > +             handle->is_streaming = true;
> > +
> > +unlock:
> >       mutex_unlock(&stream->mutex);
> >
> >       return ret;
> > @@ -859,6 +922,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
> >
> >       mutex_lock(&stream->mutex);
> >       uvc_queue_streamoff(&stream->queue, type);
>
> Should we also handle errors from uvc_queue_streamoff() ? Maybe this
> could be done in a separate patch that would also introduce
> handle->is_streaming but without the PM. That would be easier to review.

Done!

>
> > +     if (handle->is_streaming) {
> > +             handle->is_streaming = false;
> > +             uvc_pm_put(stream);
> > +     }
> >       mutex_unlock(&stream->mutex);
> >
> >       return 0;
> > @@ -909,6 +976,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> >       u8 *buf;
> >       int ret;
> >
> > @@ -922,9 +990,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
> >       if (!buf)
> >               return -ENOMEM;
> >
> > +     ret = uvc_pm_get(stream);
> > +     if (ret) {
> > +             kfree(buf);
> > +             return ret;
> > +     }
> > +
> >       ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
> >                            chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
> >                            buf, 1);
> > +     uvc_pm_put(stream);
> >       if (!ret)
> >               *input = *buf - 1;
> >
> > @@ -937,6 +1012,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> >       u8 *buf;
> >       int ret;
> >
> > @@ -958,10 +1034,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
> >       if (!buf)
> >               return -ENOMEM;
> >
> > +     ret = uvc_pm_get(stream);
> > +     if (ret) {
> > +             kfree(buf);
> > +             return ret;
> > +     }
> > +
> >       *buf = input + 1;
> >       ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
> >                            chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
> >                            buf, 1);
> > +     uvc_pm_put(stream);
> >       kfree(buf);
> >
> >       return ret;
> > @@ -972,8 +1055,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> > +     int ret;
> >
> > -     return uvc_query_v4l2_ctrl(chain, qc);
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> > +     ret = uvc_query_v4l2_ctrl(chain, qc);
> > +     uvc_pm_put(stream);
> > +     return ret;
> >  }
> >
> >  static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> > @@ -981,10 +1071,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> >       struct v4l2_queryctrl qc = { qec->id };
> >       int ret;
> >
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> >       ret = uvc_query_v4l2_ctrl(chain, &qc);
> > +     uvc_pm_put(stream);
> >       if (ret)
> >               return ret;
> >
> > @@ -1030,6 +1125,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> >       struct v4l2_ext_control *ctrl = ctrls->controls;
> >       unsigned int i;
> >       int ret;
> > @@ -1054,22 +1150,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
> >               return 0;
> >       }
> >
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> >       ret = uvc_ctrl_begin(chain);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             uvc_pm_put(stream);
> >               return ret;
>
> I'd prefer a "goto done" style.
>
> > +     }
> >
> >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> >               ret = uvc_ctrl_get(chain, ctrl);
> >               if (ret < 0) {
> >                       uvc_ctrl_rollback(handle);
> >                       ctrls->error_idx = i;
> > +                     uvc_pm_put(stream);
> >                       return ret;
> >               }
> >       }
> >
> >       ctrls->error_idx = 0;
> >
> > -     return uvc_ctrl_rollback(handle);
> > +     ret = uvc_ctrl_rollback(handle);
>
> done:
>
> > +     uvc_pm_put(stream);
> > +     return ret;
> >  }
> >
> >  static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> > @@ -1078,6 +1182,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> >  {
> >       struct v4l2_ext_control *ctrl = ctrls->controls;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> >       unsigned int i;
> >       int ret;
> >
> > @@ -1085,9 +1190,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> >       if (ret < 0)
> >               return ret;
> >
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret = uvc_ctrl_begin(chain);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             uvc_pm_put(stream);
> >               return ret;
>
> Same in this function.
>
> > +     }
> >
> >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> >               ret = uvc_ctrl_set(handle, ctrl);
> > @@ -1095,6 +1206,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> >                       uvc_ctrl_rollback(handle);
> >                       ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
> >                                                   ctrls->count : i;
> > +                     uvc_pm_put(stream);
> >                       return ret;
> >               }
> >       }
> > @@ -1102,9 +1214,12 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> >       ctrls->error_idx = 0;
> >
> >       if (ioctl == VIDIOC_S_EXT_CTRLS)
> > -             return uvc_ctrl_commit(handle, ctrls);
> > +             ret = uvc_ctrl_commit(handle, ctrls);
> >       else
> > -             return uvc_ctrl_rollback(handle);
> > +             ret = uvc_ctrl_rollback(handle);
> > +
> > +     uvc_pm_put(stream);
> > +     return ret;
> >  }
> >
> >  static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
> > @@ -1119,8 +1234,16 @@ static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
> >                                  struct v4l2_ext_controls *ctrls)
> >  {
> >       struct uvc_fh *handle = fh;
> > +     struct uvc_streaming *stream = handle->stream;
> > +     int ret;
> > +
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> > +     ret = uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> > +     uvc_pm_put(stream);
>
> uvc_ioctl_s_try_ext_ctrls() handles PM, do you need it here too ? The
> other option is to drop it from uvc_ioctl_s_try_ext_ctrls(), keep it
> here and add it to uvc_ioctl_try_ext_ctrls(). That would result in a
> smaller diff, and standardize on handling PM as close as possible to the
> top of the call stack, so it could be better.
>
> >
> > -     return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> > +     return ret;
> >  }
> >
> >  static int uvc_ioctl_querymenu(struct file *file, void *fh,
> > @@ -1128,8 +1251,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_video_chain *chain = handle->chain;
> > +     struct uvc_streaming *stream = handle->stream;
> > +     int ret;
> >
> > -     return uvc_query_v4l2_menu(chain, qm);
> > +     ret = uvc_pm_get(stream);
> > +     if (ret)
> > +             return ret;
> > +     ret = uvc_query_v4l2_menu(chain, qm);
> > +     uvc_pm_put(stream);
> > +
> > +     return ret;
> >  }
> >
> >  static int uvc_ioctl_g_selection(struct file *file, void *fh,
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 143230b3275b..5958b2a54dab 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -720,6 +720,7 @@ enum uvc_handle_state {
> >
> >  struct uvc_fh {
> >       struct v4l2_fh vfh;
> > +     bool is_streaming;
> >       struct uvc_video_chain *chain;
> >       struct uvc_streaming *stream;
> >       enum uvc_handle_state state;
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda
