Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225054CE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355504AbiFOQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355006AbiFOQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:19:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998FACE17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655309974; x=1686845974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCvI0tPa54YnwXT8fiikTfMGu5joUrBKkdhVfxRHttg=;
  b=ih22+P5rPvVWFzZ9z9UzfAFrLiKkDmPs/2jv2XZRmO2dIKKoDbAMIKzB
   Jvu3eXpVqFjgZtDppxLisDncm6J5xdZc7ht94qXmR//IB6d9RZ45+0r+I
   2am29k0VMDOWBMQfT6ZhFjpU0Dbot2FktfJaqFJMMKG9XiszevyMu2UB0
   lG0k3Iyjra8KIgRl33HhaSxI9zJYuYHsLGEakpQO0rmGKLdDM0dNzkaPJ
   0V+xqTEZMwevx4vmHNEVdtmq0knO0bnCqLA5+JaVIb+XPAcVdHN7f2acK
   ls7K87wtNPqvuHkgoZqOxnxDxlDNnHoaB5YiSTQ31eVLDi23o4Uen3jlI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262040071"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="262040071"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687384863"
Received: from louislifei-optiplex-7090.sh.intel.com (HELO louislifei-OptiPlex-7090) ([10.239.146.218])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2022 09:19:28 -0700
Date:   Thu, 16 Jun 2022 00:20:54 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [PATCH v1 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <20220615162054.GA571776@louislifei-OptiPlex-7090>
References: <20220607174120.34981-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607174120.34981-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:41:20PM +0300, Andy Shevchenko wrote:
> After the commits for userspace [1][2] the uuid field is not being
> used in the ACRN code. Update kernel to reflect these changes.
> I.e. we do the following:
> - adding a comment explaining that it's not used anymore
> - replacing the specific type by a raw buffer
> - updating the example code accordingly
> 
> [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> 
> Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Fei Li <fei1.li@intel.com>

> ---
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
>  #define ACRN_IO_REQUEST_MAX		16
>  
> @@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
>   * @reserved0:		Reserved and must be 0
>   * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
>   * @reserved1:		Reserved and must be 0
> - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> + * @uuid:		Reserved (used to be UUID of the VM)
>   * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
>   * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
>   *			hypervisor directly.
> @@ -198,7 +197,7 @@ struct acrn_vm_creation {
>  	__u16	reserved0;
>  	__u16	vcpu_num;
>  	__u16	reserved1;
> -	guid_t	uuid;
> +	__u8	uuid[16];
>  	__u64	vm_flag;
>  	__u64	ioreq_buf;
>  	__u64	cpu_affinity;
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
>  	}
>  	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
>  
> -	memcpy(&create_vm.uuid, &vm_uuid, 16);
>  	create_vm.ioreq_buf = (__u64)io_req_buf;
>  	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
>  	printf("Created VM! [%d]\n", ret);
> -- 
> 2.35.1
> 
