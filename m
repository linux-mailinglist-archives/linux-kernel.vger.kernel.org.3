Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892046851C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385080AbhLDNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385083AbhLDNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:47:21 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E41C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:43:56 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id s1so3714662vks.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AydR8F2XpQAwIIfynMtw323GpH8B4sQw/G4MzaU8WuQ=;
        b=Y90YtdyZGO6pOjo6kMX8e6oJmhT5v4ENZvx82CUq+gQVik7EfzsAPm6hlO/oiiPyvO
         F/+WB/QnmhfOln5IWC8h+TkNpwBmyvm6d2OID2Em45rtf+nNNgB8HdbdQyNUDG1JhKIm
         CmwcCN3vX0bfFnF62LppXDl7K8oKr6PDjIL1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AydR8F2XpQAwIIfynMtw323GpH8B4sQw/G4MzaU8WuQ=;
        b=c2mOpJyKx25BwDZ3axg4TqshfYAeceSK4AorKzIzD5Ph1edXV1UINq/N2QoTCC82Dl
         Zz2IPqDDZUY8+hG8bk3eCOIsq75PxhFOG/myIEMooeRgVvMEq9Y66lEWXwYRAGRQ6DqD
         zoIpfzOgwd43AwOpNdLRR/1UrOZxZw25hxGG+uC3yGr3Equ+3/ba1flmFJvE/oXaP/LM
         tvXQbjRceeOehJPvX8mUIvRqS8lFhwNDofQ3IHwJyV3ttAM167HpWR7n19erT/Nq8Wxj
         iMKYRin7+XnPZ646TCMSJ6VdX/lGyorIEx5mIHAI0hi94A5lSPfB8QDbC6GCW+4Rd6Xj
         VRRQ==
X-Gm-Message-State: AOAM532HV0e0czYw0yxw0KVtqg1YV6zWVC7+iECb6VF0FkaaUOkO+mkp
        sWRFr1Not1ORC3TvKmoFlovt+L+Y2Agj0l8k5Q180w==
X-Google-Smtp-Source: ABdhPJyWq3GJEv3s6U1N7Tj4Vpnfo92Fykb0igbE9UCam071qn22efeIi3Q5vxJfMv+lS5V/Yj6Ry14ehVV/Y9DphRY=
X-Received: by 2002:ac5:cdad:: with SMTP id l13mr29280068vka.39.1638625435253;
 Sat, 04 Dec 2021 05:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com> <20211201175613.13710-2-dafna.hirschfeld@collabora.com>
In-Reply-To: <20211201175613.13710-2-dafna.hirschfeld@collabora.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 4 Dec 2021 22:43:44 +0900
Message-ID: <CAFr9PX=6Pd1Rg=wJvpuX6WX63L=iAnwPA24e59An3Kac5f_vzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] staging: media: wave5: Add vpuapi layer
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Sorry for the piecemeal emails..

On Thu, 2 Dec 2021 at 02:56, Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> diff --git a/drivers/staging/media/wave5/wave5-hw.c b/drivers/staging/media/wave5/wave5-hw.c

... snip ...

> +static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
> +{
> +       u32 gdi_status_check_value = 0x3f;
> +       u32 data;
> +
> +       if (vpu_dev->product_code == WAVE521C_CODE ||
> +           vpu_dev->product_code == WAVE521_CODE ||
> +        vpu_dev->product_code == WAVE521E1_CODE)
> +               gdi_status_check_value = 0x00ff1f3f;
> +
> +       return read_poll_timeout(wave5_vdi_read_register, data, data == gdi_status_check_value,
> +                                0, timeout * 1000, false, vpu_dev, addr);
> +}
> +

This looks like it should be s/wave5_vdi_read_register/wave5_read_register/.
For wave511 addr passed in here is 0x8e14 so well outside of what is
directly accessible.

Also it seems that this can either return 0 or -ETIMEDOUT...

... snip ...

> +int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode)
> +{
> +       u32 val = 0;
> +       int ret = 0;
> +       struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +       struct vpu_attr *p_attr = &vpu_dev->attr;
> +       // VPU doesn't send response. force to set BUSY flag to 0.
> +       vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 0);
> +
> +       if (reset_mode == SW_RESET_SAFETY) {
> +               ret = wave5_vpu_sleep_wake(dev, true, NULL, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> +       if ((val >> 16) & 0x1)
> +               p_attr->support_backbone = true;
> +       if ((val >> 22) & 0x1)
> +               p_attr->support_vcore_backbone = true;
> +       if ((val >> 28) & 0x1)
> +               p_attr->support_vcpu_backbone = true;
> +
> +       val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG1);
> +       if ((val >> 26) & 0x1)
> +               p_attr->support_dual_core = true;
> +
> +       // waiting for completion of bus transaction
> +       if (p_attr->support_backbone) {
> +               if (p_attr->support_dual_core) {
> +                       // check CORE0
> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
> +
> +                       ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
> +                                                 W5_BACKBONE_BUS_STATUS_VCORE0);
> +                       if (ret) {
> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
> +                               return ret;
> +                       }
> +
> +                       // check CORE1
> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x7);
> +
> +                       ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
> +                                                 W5_BACKBONE_BUS_STATUS_VCORE1);
> +                       if (ret) {
> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
> +                               return ret;
> +                       }
> +
> +               } else if (p_attr->support_vcore_backbone) {
> +                       if (p_attr->support_vcpu_backbone) {
> +                               // step1 : disable request
> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU,
> +                                                    0xFF);
> +
> +                               // step2 : waiting for completion of bus transaction
> +                               ret = wave5_wait_vcpu_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
> +                                                              W5_BACKBONE_BUS_STATUS_VCPU);
> +                               if (ret) {
> +                                       wave5_write_register(vpu_dev,
> +                                                            W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
> +                                       return ret;
> +                               }
> +                       }
> +                       // step1 : disable request
> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
> +
> +                       // step2 : waiting for completion of bus transaction
> +                       if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
> +                                               W5_BACKBONE_BUS_STATUS_VCORE0) == -1) {
> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
> +                               return -EBUSY;
> +                       }

but this is looking for -1 on failure.

> +               } else {
> +                       // step1 : disable request
> +                       wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x7);
> +
> +                       // step2 : waiting for completion of bus transaction
> +                       if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
> +                                               W5_COMBINED_BACKBONE_BUS_STATUS) == -1) {
> +                               wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
> +                               return -EBUSY;
> +                       }
> +               }

Here too.

Cheers,

Daniel
