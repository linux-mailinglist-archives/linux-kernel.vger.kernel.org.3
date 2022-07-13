Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D092573BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiGMRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGMRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:10:32 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADB2CDF2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:10:30 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i206so3289706ybc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVwI2jih9g6A/4ukqt26Pd8sYhA6yJbIxZ7Onij0VlY=;
        b=xYu9VRi73+85XEfXBrzGKU/9tNpcEK58bc/5n0+YEJsa1kHLr6aXMGrGHe9Wyh7jTN
         y7/Fxji3XhzmxoraBJyVQloAjZmOqdWKgAXbqbrKJatlGS5QZwoZET4H3GYjCVxvaQ+P
         2EYWGbCh+V2IDfhJPyRWQPqQ32JQO96gG5rIRv9cARVRAqkpYws0nlV4HbIO+INOgiCA
         gddEYkS6Rowdkzl21KCNrcSs56oKwt94MYfoFE5hhes1BkJ6h9gErx5RG7Nfcvd3OU08
         t8sCYzzGEgUumyUNwiex3tlmGFH3OXiUCHEnFD+tdvyKa0KigXkvS0FJ3rvGPy7HxiYb
         A+HQ==
X-Gm-Message-State: AJIora8z7ZUEuV8PE9/RX0qpC9rt356++UWJ0bhQe0lu7TQetu5+rUOp
        L4joaOpLvZHbxsXpAau62SKjWfG9NGIDeHnEuyvxnKLv
X-Google-Smtp-Source: AGRyM1v2ay4H9vZWSjZxkZ2ERPhtIRyfMhE9KvAU2/82aZfDuI8sA2jaYbeOFDBMrn/mWHUVaiBusFVVQyXkZyT01LA=
X-Received: by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP id
 z2-20020a5b0202000000b0066faab49c95mr3505689ybl.81.1657732229611; Wed, 13 Jul
 2022 10:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220713170239.84362-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220713170239.84362-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 19:10:18 +0200
Message-ID: <CAJZ5v0gReYjq5uBFZMF_r=fthTB6M_JpyG07-WAs=d+BC0H_Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virt: acrn: Mark the uuid field as unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Fei Li <fei1.li@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After the commits for userspace [1][2] the uuid field is not being
> used in the ACRN code. Update kernel to reflect these changes.
> I.e. we do the following:
> - adding a comment explaining that it's not used anymore
> - replacing the specific type by a raw buffer
> - updating the example code accordingly
>
> [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097

Why don't you use a Link tag for each of these?

> Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")

Typically, the changelog should explain what was wrong in a previous
commit that is being fixed in the current one, but that information is
missing here.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Fei Li <fei1.li@intel.com>
> ---
> v2: added tag (Fei)
>  include/uapi/linux/acrn.h | 5 ++---
>  samples/acrn/vm-sample.c  | 3 ---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index ccf47ed92500..04fa83647ae5 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -12,7 +12,6 @@
>  #define _UAPI_ACRN_H
>
>  #include <linux/types.h>
> -#include <linux/uuid.h>
>
>  #define ACRN_IO_REQUEST_MAX            16
>
> @@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
>   * @reserved0:         Reserved and must be 0
>   * @vcpu_num:          Number of vCPU in the VM. Return from hypervisor.
>   * @reserved1:         Reserved and must be 0
> - * @uuid:              UUID of the VM. Pass to hypervisor directly.
> + * @uuid:              Reserved (used to be UUID of the VM)
>   * @vm_flag:           Flag of the VM creating. Pass to hypervisor directly.
>   * @ioreq_buf:         Service VM GPA of I/O request buffer. Pass to
>   *                     hypervisor directly.
> @@ -198,7 +197,7 @@ struct acrn_vm_creation {
>         __u16   reserved0;
>         __u16   vcpu_num;
>         __u16   reserved1;
> -       guid_t  uuid;
> +       __u8    uuid[16];
>         __u64   vm_flag;
>         __u64   ioreq_buf;
>         __u64   cpu_affinity;
> diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
> index b2dad47a77a0..7abd68b20153 100644
> --- a/samples/acrn/vm-sample.c
> +++ b/samples/acrn/vm-sample.c
> @@ -29,8 +29,6 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
>
>  __u16 vcpu_num;
>  __u16 vmid;
> -/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
> -guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
>
>  int hsm_fd;
>  int is_running = 1;
> @@ -63,7 +61,6 @@ int main(int argc, char **argv)
>         }
>         hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
>
> -       memcpy(&create_vm.uuid, &vm_uuid, 16);
>         create_vm.ioreq_buf = (__u64)io_req_buf;
>         ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
>         printf("Created VM! [%d]\n", ret);
> --
> 2.35.1
>
