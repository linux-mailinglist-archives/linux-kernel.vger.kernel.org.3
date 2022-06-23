Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DA557CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiFWN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B44149CAD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655990775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y0Oi8GuJHYCibGKfwnLTLEcdVsok3xhUHT8Qu0OqDmw=;
        b=UXm9e4jdS5R9PgnHokvNJpVnAgULwfE0L6PSFgcO2i+2ubIi52ZTSropLOzBg3Cx8EO+5P
        p6VzYb24q0J8YC8ihXG1t2wJ0ObwBaiol+YWcAPBwrXwp2Grcl6xzYO1NILIfzAAnjQxGv
        GGH6HP+s/ubeUg0Fevtqsk9/EaIHGIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211--2sCdqIbO1mBLGejzmegnw-1; Thu, 23 Jun 2022 09:26:14 -0400
X-MC-Unique: -2sCdqIbO1mBLGejzmegnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB6A0801E80;
        Thu, 23 Jun 2022 13:26:13 +0000 (UTC)
Received: from localhost (unknown [10.39.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 616211121315;
        Thu, 23 Jun 2022 13:26:13 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Bo Liu <liubo03@inspur.com>, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v2 1/1] vfio: check vfio_register_iommu_driver() return
 value
In-Reply-To: <20220622045651.5416-1-liubo03@inspur.com>
Organization: Red Hat GmbH
References: <20220622045651.5416-1-liubo03@inspur.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date:   Thu, 23 Jun 2022 15:26:12 +0200
Message-ID: <875ykr8qa3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22 2022, Bo Liu <liubo03@inspur.com> wrote:

> As vfio_register_iommu_driver() can fail, we should check the return value.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  Changes from v1:
>  -move the pr_info()
>  -move  #endif above the ret test
>  -remove #ifdefs above the err_driver_register
>
>  drivers/vfio/vfio.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

