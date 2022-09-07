Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B45B01BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIGKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIGKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F12AE33
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662545833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afHMjG2HkRYvCDuYzjTQhxoQdwvvL29SNFSccxhwbQY=;
        b=OXf2w8aOd9FNVRhg23RECFwnmLWX4mi8bnqMIjBQbGAu7DuvGiw9QVqu6Cn3GnF+gXQPpG
        A8qe/6XH3SQRa0l4GVHLUzLpfyzWIGCBcwzwNeeB4w5KtqMnfYQcS3a+9vxiHuXX2Hsigr
        lBBI/UlATevjeWeXlbzn95SxXEEQuKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-AZwPBN3lN5GhXRakgF0ASA-1; Wed, 07 Sep 2022 06:17:10 -0400
X-MC-Unique: AZwPBN3lN5GhXRakgF0ASA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5F2580418F;
        Wed,  7 Sep 2022 10:17:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CA001121314;
        Wed,  7 Sep 2022 10:17:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 017DF180039B; Wed,  7 Sep 2022 12:17:07 +0200 (CEST)
Date:   Wed, 7 Sep 2022 12:17:07 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Zongmin Zhou <min_halo@163.com>
Cc:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhouzongmin@kylinos.cn,
        Ming Xie <xieming@kylinos.cn>
Subject: Re: [PATCH] drm/qxl: fix the suspend/resume issue on qxl device
Message-ID: <20220907101707.ghkrtsba4eeje43p@sirius.home.kraxel.org>
References: <20220907094423.93581-1-min_halo@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907094423.93581-1-min_halo@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:44:23PM +0800, Zongmin Zhou wrote:
> 
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Details:
> Currently, when trying to suspend and resume with qxl device，
> there are some error messages after resuming,
> eventually caused to black screen and can't be recovered.

[ analysis snipped ]

> Let's fix this by reset io and remove the qxl_ring_init_hdr calling.

Pushed to drm-misc-next

thanks,
  Gerd

