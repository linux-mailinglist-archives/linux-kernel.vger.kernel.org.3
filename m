Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EAB4C9F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbiCBI0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiCBI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63AE0B82CC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646209560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtrInDoeeooDXLH4/ASDNuBM89b2Da/ya3ncv+m8FWA=;
        b=NrKxjS2mZ+3LnBTNJCqK+BpA/wvESboaJuprHaZfPRJe6Vhr9BJ5QjipGwKmKGkpMhGDZN
        tcA4cEpdd6JCOxI1V+8K/WJWZb4DGmZ29Ry5t5KweCDXskl+gZc5TgulC8NcFclj/Lcufz
        E3EHKq9FlGA4zQz7FLTkcP/hCdREJDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-sAHRB3rVNm6CEswhqULziw-1; Wed, 02 Mar 2022 03:25:57 -0500
X-MC-Unique: sAHRB3rVNm6CEswhqULziw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F944824FA7;
        Wed,  2 Mar 2022 08:25:55 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 629027FCE4;
        Wed,  2 Mar 2022 08:25:49 +0000 (UTC)
Date:   Wed, 2 Mar 2022 16:25:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>, yukuai3@huawei.com,
        linux-next <linux-next@vger.kernel.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [next-20220225][Oops][ppc] lvm snapshot merge results kernel
 panics (throtl_pending_timer_fn)
Message-ID: <Yh8qCS5JM8ZbtqY4@T590>
References: <d583adf0-2d98-60b6-620c-722912c05852@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d583adf0-2d98-60b6-620c-722912c05852@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 01:31:39PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Linux next kernel 5.17.0-rc5-next-20220225 crashed on my power 10 LPAR when
> merge lvm snapshot on nvme disk

Please try next-20220301, in which the "bad" patch of 'block: cancel all
throttled bios in del_gendisk()' is dropped.


Thanks,
Ming

