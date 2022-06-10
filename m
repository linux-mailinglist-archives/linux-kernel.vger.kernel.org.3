Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DB545A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiFJDRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:17:30 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04F063B1726
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:17:28 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C830E2051591;
        Fri, 10 Jun 2022 12:17:26 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 25A3HP4Z017165
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 12:17:26 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 25A3HPaZ089403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 12:17:25 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 25A3HOUk089401;
        Fri, 10 Jun 2022 12:17:24 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        Carlos Maiolino <cmaiolin@redhat.com>
Subject: Re: [PATCH v5 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220609093638.664034-1-javierm@redhat.com>
        <20220609093638.664034-4-javierm@redhat.com>
        <878rq54pf1.fsf@mail.parknet.co.jp>
        <9d837076-f666-c3c3-dd09-5c3705da23e6@redhat.com>
Date:   Fri, 10 Jun 2022 12:17:24 +0900
In-Reply-To: <9d837076-f666-c3c3-dd09-5c3705da23e6@redhat.com> (Javier
        Martinez Canillas's message of "Thu, 9 Jun 2022 22:36:21 +0200")
Message-ID: <874k0t437f.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

>> 
>> Looks like unnecessary complex (and comparing raw i_mode, not S_ISDIR(),
>> better to change before make dir dirty).  How about this change, it is
>> only tested slightly though? Can you review and test?
>>
>
> Your change looks good to me and indeed the logic is simpler than in mine.
>
> I've also tested it and AFAICT it works correctly as well. Do you plan to
> squash this or should I respin a new revision of the whole patch-set ? If
> you want to post it as a follow-up I'm also OK with that.

Could you merge to your patchset, and re-send?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
