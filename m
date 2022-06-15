Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817C54C379
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiFOI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbiFOI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:29:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16533E10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:29:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x4so10776263pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2r1oiGvXfeDNRAgh6LnBFv64XUbfrpRFtczVkZWId2I=;
        b=amEHmRPLIJAQZy8laM9C7bo4dOAFLsW3E3wb5/2OHXlFB3ssstjDAUbAJ4sMOBhzLh
         Bdncu2eEgTT0IGop/OHWLL8EbSzzDl/2w5fHs2y2/s2l59nV6lPKm03DN7B9AHo/BTSn
         hsWiS0P7B1ylQTTr1Zn77kVmwOY/YR+GQ/UMuPXemscyZ8XAIWmii8MyvSvmonA/jBoO
         Au/7bXXGTmUsMzPjQsq4WLcujloPwCLr+vbuhazwGoNmB5u3WQlWWCOZ1mhp72YEIkhI
         IAs6p0w1OdtwbfdrQW8WgdICZSCfh6nlSHmcHcKkg7RfcR2PRoDH2ay0BH13ap+s5Akz
         Xe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2r1oiGvXfeDNRAgh6LnBFv64XUbfrpRFtczVkZWId2I=;
        b=32lmT0aWf6xiPKVv67Y4u76WGMC4bBp/Mu+tahoD7jDllSS8Uhs0Dnt6bdicVUlP42
         q2Mixxf+Bfqa9PNj6p0EuqCQHSSZ9pFonCR7gM9FC6lzHIMyMceY5wfq+Sli6ddutyYm
         ey3rjK5Fwa+EST5FRbU43W6ZyqFvwjDO0zZMeeYO4RfzCm0N6bPE6CfzgYxm4nPbxfop
         Ayxr4Qg+m9kXyzk1tsy7lH87sbzvQbRXKFyeuJDSoIfzGx7KEpsB9S29WBPJ95ie1QXr
         U6yDqviz1dLe2yvJEFJGpqYNtLHqKEWmccyDJ2iS8MM7Sngw0NHXqS3Dcjcil+Wr2yI4
         j4ow==
X-Gm-Message-State: AOAM530BuPITqUEyyvuXgqjFqLOKifdVKQH8erTqfps0IEFR4LXFJIQE
        6w3cskEiS+Ayqmh/Fr5DuhmHwQ==
X-Google-Smtp-Source: ABdhPJxpRACv4oy4zUAJE/Pmbf0Yx9OcY0SkMh9AQNfm+soxPY4zVh3roXIso+is/cjrr6O3uMfZSQ==
X-Received: by 2002:a05:6a00:124d:b0:51b:f2ac:ef8a with SMTP id u13-20020a056a00124d00b0051bf2acef8amr8768263pfi.72.1655281768995;
        Wed, 15 Jun 2022 01:29:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902ea4a00b001637997d0d4sm8648387plg.206.2022.06.15.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 01:29:28 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:29:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: Clear the connection field properly
Message-ID: <20220615082924.GA121786@leoy-ThinkPad-X240s>
References: <20220614214024.3005275-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614214024.3005275-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:40:24PM +0100, Suzuki Kuruppassery Poulose wrote:
> coresight devices track their connections (output connections) and
> hold a reference to the fwnode. When a device goes away, we walk through
> the devices on the coresight bus and make sure that the references
> are dropped. This happens both ways:
>  a) For all output connections from the device, drop the reference to
>     the target device via coresight_release_platform_data()
> 
> b) Iterate over all the devices on the coresight bus and drop the
>    reference to fwnode if *this* device is the target of the output
>    connection, via coresight_remove_conns()->coresight_remove_match().
> 
> However, the coresight_remove_match() doesn't clear the fwnode field,
> after dropping the reference, this causes use-after-free and
> additional refcount drops on the fwnode.
> 
> e.g., if we have two devices, A and B, with a connection, A -> B.
> If we remove B first, B would clear the reference on B, from A
> via coresight_remove_match(). But when A is removed, it still has
> a connection with fwnode still pointing to B. Thus it tries to  drops
> the reference in coresight_release_platform_data(), raising the bells
> like :
> 
> [   91.990153] ------------[ cut here ]------------
> [   91.990163] refcount_t: addition on 0; use-after-free.
> [   91.990212] WARNING: CPU: 0 PID: 461 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x144
> [   91.990260] Modules linked in: coresight_funnel coresight_replicator coresight_etm4x(-)
>  crct10dif_ce coresight ip_tables x_tables ipv6 [last unloaded: coresight_cpu_debug]
> [   91.990398] CPU: 0 PID: 461 Comm: rmmod Tainted: G        W       T 5.19.0-rc2+ #53
> [   91.990418] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
> [   91.990434] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   91.990454] pc : refcount_warn_saturate+0xa0/0x144
> [   91.990476] lr : refcount_warn_saturate+0xa0/0x144
> [   91.990496] sp : ffff80000c843640
> [   91.990509] x29: ffff80000c843640 x28: ffff800009957c28 x27: ffff80000c8439a8
> [   91.990560] x26: ffff00097eff1990 x25: ffff8000092b6ad8 x24: ffff00097eff19a8
> [   91.990610] x23: ffff80000c8439a8 x22: 0000000000000000 x21: ffff80000c8439c2
> [   91.990659] x20: 0000000000000000 x19: ffff00097eff1a10 x18: ffff80000ab99c40
> [   91.990708] x17: 0000000000000000 x16: 0000000000000000 x15: ffff80000abf6fa0
> [   91.990756] x14: 000000000000001d x13: 0a2e656572662d72 x12: 657466612d657375
> [   91.990805] x11: 203b30206e6f206e x10: 6f69746964646120 x9 : ffff8000081aba28
> [   91.990854] x8 : 206e6f206e6f6974 x7 : 69646461203a745f x6 : 746e756f63666572
> [   91.990903] x5 : ffff00097648ec58 x4 : 0000000000000000 x3 : 0000000000000027
> [   91.990952] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00080260ba00
> [   91.991000] Call trace:
> [   91.991012]  refcount_warn_saturate+0xa0/0x144
> [   91.991034]  kobject_get+0xac/0xb0
> [   91.991055]  of_node_get+0x2c/0x40
> [   91.991076]  of_fwnode_get+0x40/0x60
> [   91.991094]  fwnode_handle_get+0x3c/0x60
> [   91.991116]  fwnode_get_nth_parent+0xf4/0x110
> [   91.991137]  fwnode_full_name_string+0x48/0xc0
> [   91.991158]  device_node_string+0x41c/0x530
> [   91.991178]  pointer+0x320/0x3ec
> [   91.991198]  vsnprintf+0x23c/0x750
> [   91.991217]  vprintk_store+0x104/0x4b0
> [   91.991238]  vprintk_emit+0x8c/0x360
> [   91.991257]  vprintk_default+0x44/0x50
> [   91.991276]  vprintk+0xcc/0xf0
> [   91.991295]  _printk+0x68/0x90
> [   91.991315]  of_node_release+0x13c/0x14c
> [   91.991334]  kobject_put+0x98/0x114
> [   91.991354]  of_node_put+0x24/0x34
> [   91.991372]  of_fwnode_put+0x40/0x5c
> [   91.991390]  fwnode_handle_put+0x38/0x50
> [   91.991411]  coresight_release_platform_data+0x74/0xb0 [coresight]
> [   91.991472]  coresight_unregister+0x64/0xcc [coresight]
> [   91.991525]  etm4_remove_dev+0x64/0x78 [coresight_etm4x]
> [   91.991563]  etm4_remove_amba+0x1c/0x2c [coresight_etm4x]
> [   91.991598]  amba_remove+0x3c/0x19c
> 
> Reproducible by: (Build all coresight components as modules):
> 
>   #!/bin/sh
>   while true
>   do
>      for m in tmc stm cpu_debug etm4x replicator funnel
>      do
>      	modprobe coresight_${m}
>      done
> 
>      for m in tmc stm cpu_debug etm4x replicator funnel
>      do
>      	rmmode coresight_${m}
>      done
>   done
> 
> Cc: stable@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ee6ce92ab4c3..1edfec1e9d18 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1424,6 +1424,7 @@ static int coresight_remove_match(struct device *dev, void *data)
>  			 * platform data.
>  			 */
>  			fwnode_handle_put(conn->child_fwnode);
> +			conn->child_fwnode = NULL;
>  			/* No need to continue */
>  			break;
>  		}
> -- 
> 2.35.3
> 
