Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF2597649
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiHQTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiHQTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5779A9A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660763472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaL6BNK8+Dum2lUbuYpY93KQMzHQlJu9Ni2H/q+UQcE=;
        b=R7/abGiB4TrUKqrEp0z4j1tnT7cL+tg5RLsXsIUuXKl44tyykkYPuPCVNagmRM1uPYiVNe
        FSFoMlf9MKjS2xJU+Y7QboRAjBhOaSlseYq6/vIYM4D/94XCC2p+pIOVEuoKm81AEXBGRu
        WF/0VJRrC9ylVGSU+GS5XEVcXxTnF94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-uK8Sh83FOCixx4aV5bhPbA-1; Wed, 17 Aug 2022 15:11:09 -0400
X-MC-Unique: uK8Sh83FOCixx4aV5bhPbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E718780418F;
        Wed, 17 Aug 2022 19:11:08 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1E34492C3B;
        Wed, 17 Aug 2022 19:11:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BE3D3416D5DE; Wed, 17 Aug 2022 16:10:51 -0300 (-03)
Date:   Wed, 17 Aug 2022 16:10:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch 0/3] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <Yv09OwcEuRUq7Dpu@fuller.cnet>
References: <20220817190136.096849758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817190136.096849758@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:01:36PM -0300, Marcelo Tosatti wrote:
> This patchset contains enhancements on top of Aaron's -v6 of the series
> (see the changelog below).

Please ignore this series. Resent series with proper "[PATCH -v7]" subject.

