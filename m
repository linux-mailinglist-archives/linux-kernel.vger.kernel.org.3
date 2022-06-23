Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9B5576A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiFWJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiFWJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4050A184
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655976771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06kaMflGnUnS/V8ph3wEzp7LZpvIbOHFK6oUZfaSoWM=;
        b=iywpdV4TjB/ybFLLt4WxE7Gu56LTLJ6VFOoWvvsoYfyqZtuCWh8d03Sm5aXRBBV4ObYIip
        yBZ+NpfJe5HefXYz1ulfiVjHrm6hKGKixZ3tSHrMLmXdKIICCcclT1D5JlVXuCCFAiJ426
        0DYFbQe7PldJZW5Qu2JJqITdFle9v+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-m4fLhkaZNHyJ5oeQhajJPQ-1; Thu, 23 Jun 2022 05:32:46 -0400
X-MC-Unique: m4fLhkaZNHyJ5oeQhajJPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0815F185A7B2;
        Thu, 23 Jun 2022 09:32:46 +0000 (UTC)
Received: from [10.40.194.231] (unknown [10.40.194.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B509C2811A;
        Thu, 23 Jun 2022 09:32:45 +0000 (UTC)
Message-ID: <cc5f4465-49cf-3a87-e502-4bb21f2e3163@redhat.com>
Date:   Thu, 23 Jun 2022 11:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [Intel-gfx] i915: crash with 5.19-rc2
Content-Language: en-US
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
 <YrN/mI4Qlo66qBmg@intel.com>
From:   Zdenek Kabelac <zkabelac@redhat.com>
In-Reply-To: <YrN/mI4Qlo66qBmg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 22. 06. 22 v 22:46 Rodrigo Vivi napsal(a):
> Hi Zdenek,
>
> On Wed, Jun 22, 2022 at 01:18:42PM +0200, Zdenek Kabelac wrote:
>> Hello
>>
>> While somewhat oldish hw (T61, 4G, C2D) - I've now witnessed new crash with Xorg:
>>
>> (happened while reopening iconified Firefox window  - running 'standard'
>> rawhide -nodebug kernel 5.19.0-0.rc2.21.fc37.x86_64)
> any bisect possible?
>
> if possible, could you please file a bug?
> https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
>
> I know I know, the account requirement :/
> also on main kernel bugzilla is probably better than the email here.


Hi


So far this bisect does not seem doable, since this crash happened after 
several days of  uptime and so far happened just once (and I'm now already on 
-rc3).

If I'll spot any more regular approach to hit this crash, I may try bisecting. 
Meanwhile I just hope, someone will get an idea what has changed recently (I'd 
not seen such crash with 5.18). Although I need to say that I'm witnessing 
some GPU restarts lately causing just some 'temporary hanging' of Xorg 
desktop, but that's not such a big deal.

Zdenek

