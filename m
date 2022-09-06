Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4E5ADCD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiIFBO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIFBO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AD21A838
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662426895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/8vBTNO10GcuOjUQ+CPVzv3pFL4JDnPwdZlqX3Wz67g=;
        b=SkegvTqrH6X8QunXo0NK/hNIFGJOa79ZP220FKXwJIStVQkmFOwNXQGJbIfEZXbhx7Gl4M
        fl2YrGiZm9oWvlLUHU8F6vlOKxd9syZ/A33dxC69fmRbC1A91AiUX/BqOJvs7/TC/XVBiH
        t4F06IngG8kW7WBiRwk+FWPQOfdXvqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-rvU7PCoePpi6N_vNuxeoxg-1; Mon, 05 Sep 2022 21:14:50 -0400
X-MC-Unique: rvU7PCoePpi6N_vNuxeoxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6D4485A585;
        Tue,  6 Sep 2022 01:14:49 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF11D1121314;
        Tue,  6 Sep 2022 01:14:44 +0000 (UTC)
Date:   Tue, 6 Sep 2022 09:14:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH V2 0/6] ublk_drv: add USER_RECOVERY support
Message-ID: <Yxae/6fxhrmHOiKG@T590>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:51:30PM +0800, ZiyangZhang wrote:
> ublk_drv is a driver simply passes all blk-mq rqs to ublksrv[1] in
> userspace. For each ublk queue, there is one ubq_daemon(pthread).
> All ubq_daemons share the same process which opens /dev/ublkcX.
> The ubq_daemon code infinitely loops on io_uring_enter() to
> send/receive io_uring cmds which pass information of blk-mq
> rqs.

BTW, given ublk document is merged, so please document the new
added commands in Documentation/block/ublk.rst in following versions.


Thanks,
Ming

