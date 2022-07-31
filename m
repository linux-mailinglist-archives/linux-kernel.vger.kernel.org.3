Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C893585F64
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiGaPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiGaPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:04:32 -0400
X-Greylist: delayed 1235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 08:04:30 PDT
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D577DEAB;
        Sun, 31 Jul 2022 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=F0slf2YJCD3XvKv+dbnLCjFi/jGrdLYNNGrKXZecVsY=; b=Qax82oRkZ2/71XbaSpBsMQ8Zld
        y9D2W0RdUt/juCpV/Jpt6J+EzOx5i3/VxLzA2RBkmhvS9PTfW6ycsm5OwG6kwnMP8O4yBpKs4SntD
        9nfkPUyBCKhMiVIln0/23/YQkmoa0wQCccpJNugUbqjMrvsPL8RX0cL2IkwvtJqRyiV6MlNw1Yl5c
        N7/9y/XycmIoQQzIv90iDOn9gKEdyLITUZESrCLR/w/B5qn8UGNy3Tw/KsoH9vHUgMassCnrFRJaE
        y4n1i2enMLInlvVxB3Z8/ct6DJP/RHvJoODmIUb+ElxyIduFjLhmv7wH4QiEXBFiXnShA5MU5WYIW
        N8BYM9sQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1oIAAU-009All-PW; Sun, 31 Jul 2022 15:43:46 +0100
Date:   Sun, 31 Jul 2022 15:43:46 +0100
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     linux-kernel@vger.kernel.org, corbet@lwn.net, davem@davemloft.net,
        jgg@ziepe.ca, linux-doc@vger.kernel.org
Cc:     edumazet@google.com, dan.j.williams@intel.com
Subject: Re: [PATCH] typos: Fix 'namespace' typos
Message-ID: <YuaVIp1dug0tUSje@gallifrey>
References: <20220709132830.9869-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220709132830.9869-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 15:41:12 up 142 days,  1:06,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'namespace' is creatively typo'd in a few different places
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.
(and added a couple more cc'c)

> ---
> I've added 'namesapce' to codespell: https://github.com/codespell-project/codespell/commit/cfe751aedb234e262d7e32c1d568939c2ccd4e36
> I wasn't sure if it was worth splitting this into 3 patches given the
> different areas; please advise.
> ---
>  Documentation/driver-api/nvdimm/nvdimm.rst | 2 +-
>  Documentation/filesystems/proc.rst         | 2 +-
>  Documentation/networking/sysfs-tagging.rst | 2 +-
>  drivers/infiniband/core/device.c           | 2 +-
>  include/linux/nd.h                         | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
> index be8587a558e1e..ca16b5acbf30d 100644
> --- a/Documentation/driver-api/nvdimm/nvdimm.rst
> +++ b/Documentation/driver-api/nvdimm/nvdimm.rst
> @@ -82,7 +82,7 @@ LABEL:
>    Metadata stored on a DIMM device that partitions and identifies
>    (persistently names) capacity allocated to different PMEM namespaces. It
>    also indicates whether an address abstraction like a BTT is applied to
> -  the namepsace.  Note that traditional partition tables, GPT/MBR, are
> +  the namespace.  Note that traditional partition tables, GPT/MBR, are
>    layered on top of a PMEM namespace, or an address abstraction like BTT
>    if present, but partition support is deprecated going forward.
>  
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321a..335d028752d45 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2187,7 +2187,7 @@ are not related to tasks.
>  Chapter 5: Filesystem behavior
>  ==============================
>  
> -Originally, before the advent of pid namepsace, procfs was a global file
> +Originally, before the advent of pid namespace, procfs was a global file
>  system. It means that there was only one procfs instance in the system.
>  
>  When pid namespace was added, a separate procfs instance was mounted in
> diff --git a/Documentation/networking/sysfs-tagging.rst b/Documentation/networking/sysfs-tagging.rst
> index 83647e10c2078..65307130ab633 100644
> --- a/Documentation/networking/sysfs-tagging.rst
> +++ b/Documentation/networking/sysfs-tagging.rst
> @@ -43,6 +43,6 @@ Users of this interface:
>  
>    - current_ns() which returns current's namespace
>    - netlink_ns() which returns a socket's namespace
> -  - initial_ns() which returns the initial namesapce
> +  - initial_ns() which returns the initial namespace
>  
>  - call kobj_ns_exit() when an individual tag is no longer valid
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d275db195f1a1..0af50a1f53418 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -132,7 +132,7 @@ MODULE_PARM_DESC(netns_mode,
>   * rdma_dev_access_netns() - Return whether an rdma device can be accessed
>   *			     from a specified net namespace or not.
>   * @dev:	Pointer to rdma device which needs to be checked
> - * @net:	Pointer to net namesapce for which access to be checked
> + * @net:	Pointer to net namespace for which access to be checked
>   *
>   * When the rdma device is in shared mode, it ignores the net namespace.
>   * When the rdma device is exclusive to a net namespace, rdma device net
> diff --git a/include/linux/nd.h b/include/linux/nd.h
> index b9771ba1ef879..7095faf4a0c85 100644
> --- a/include/linux/nd.h
> +++ b/include/linux/nd.h
> @@ -179,7 +179,7 @@ static inline int nvdimm_read_bytes(struct nd_namespace_common *ndns,
>   * @buf: buffer to drain
>   * @size: transfer length
>   *
> - * NVDIMM Namepaces disks do not implement sectors internally.  Depending on
> + * NVDIMM Namespaces disks do not implement sectors internally.  Depending on
>   * the @ndns, the contents of @buf may be in cpu cache, platform buffers,
>   * or on backing memory media upon return from this routine.  Flushing
>   * to media is handled internal to the @ndns driver, if at all.
> -- 
> 2.36.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
