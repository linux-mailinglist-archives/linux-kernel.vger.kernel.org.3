Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2D468FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhLFDPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235788AbhLFDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638760337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NUwMELfoN5sdz4QIGxURvLcCWplqvHofYeoKR0bfVRk=;
        b=ABkARrz+WuEJFZqaV5dtMdpfWNR+EYSJp4btCNZgDfjpZld80+9szgWc283yDBlLOIEYOG
        F8nQOYmHupYMDlLxZDF1CSyaYPlc/tmXPyGNyPmpOLilvxfr18w0vJSnOoLg7ohJAIvth2
        xHh54SBgyGreMSlG5wGww5KEB4g3kxQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407--P4EyFqQOUSsW2H8yBHVfQ-1; Sun, 05 Dec 2021 22:12:16 -0500
X-MC-Unique: -P4EyFqQOUSsW2H8yBHVfQ-1
Received: by mail-lf1-f69.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so3234691lfd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 19:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUwMELfoN5sdz4QIGxURvLcCWplqvHofYeoKR0bfVRk=;
        b=HVwiukP6VbRK9ReSqyZvE7ABkVSnbSJRH/rMgZH7BVoJpO3yl8zocMtPhqlfCyNNVB
         koly+Oh60LsVUXGDRwDCiCEsbTldwCxPPoIy4wKRb4EqIwdERKR24g3DKYU8cDVqmDqt
         ZdP/7f/HxtEuCnfUcgGx+q2aeQQ8um3ianGzG6sggIsFIm1xj4btKgLnIaTd9KVcD2bq
         TaUDQ97LfLIBZLnFAHT9sU87SLuhln8I1jUF393GiCfokSzHM2vF159tfyPNPFOxp0TO
         EiPtCS/BM5hq/KrAwdWPQLqTmY1Ju0clr+v8/3bLzOW40E1JOSirvFWkLcJbo47zwcrh
         LPhw==
X-Gm-Message-State: AOAM532gYhM86s9tjkTHB9slhEexl1xGZFGu+ZUbsbxYWYZFKzpB5R7y
        m6Ze8MYTb/eB47T627WWpcSaupq+JYilHpXbS3YofAOVAlpWpyyyHCn+MNFXp+48uQfHTmk7BRm
        QnrThtOQbZ1aoAkHtJ2LPxUH+kmEafX+gt/yB9JdJ
X-Received: by 2002:a2e:b169:: with SMTP id a9mr34411874ljm.369.1638760334648;
        Sun, 05 Dec 2021 19:12:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu4rPiY8eBrUgt2lLw3I3dthDt2zXcE5AbclsSH3qgPuVmutwQVyiDFVxWdCAwAF5lOseVaPhk79/aBFCs+08=
X-Received: by 2002:a2e:b169:: with SMTP id a9mr34411854ljm.369.1638760334455;
 Sun, 05 Dec 2021 19:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org>
In-Reply-To: <20211203185522.692489-1-arnd@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Dec 2021 11:12:03 +0800
Message-ID: <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 2:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> kernel runs into a link error:
>
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':

Intersting, all those belongs to the legacy library.

And I just have a try and I can complie alibaba eni without
VIRTIO_PCI_LIB is set.

Can you share your config file?

Thanks

>
> Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> only part of the VIRTIO_PCI_LIB support.
>
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/vdpa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..04466603021f 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -80,6 +80,7 @@ config VP_VDPA
>
>  config ALIBABA_ENI_VDPA
>         tristate "vDPA driver for Alibaba ENI"
> +       select VIRTIO_PCI_LIB
>         select VIRTIO_PCI_LIB_LEGACY
>         depends on PCI_MSI && X86
>         help
> --
> 2.29.2
>

