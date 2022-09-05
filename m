Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97F5ACFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiIEKGf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiIEKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:06:08 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7D558D5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:05:38 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id A354C413D5;
        Mon,  5 Sep 2022 10:05:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0270E2002B;
        Mon,  5 Sep 2022 10:05:20 +0000 (UTC)
Message-ID: <4675b119b6eafbe377711530cb55bd638b0077b5.camel@perches.com>
Subject: Re: [PATCH] drm/print: cleanup coding style in drm_print.h
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Mon, 05 Sep 2022 03:05:19 -0700
In-Reply-To: <87sfl6b3zb.fsf@intel.com>
References: <20220904203818.16775-1-jingyuwang_vip@163.com>
         <87wnaib45t.fsf@intel.com> <87sfl6b3zb.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0270E2002B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: cpg13saw4t9ky9idep3d5zibos8uaptq
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+IQgrovGfGS21oh82wDTPVfuzC1VIMDyY=
X-HE-Tag: 1662372320-471312
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-05 at 11:49 +0300, Jani Nikula wrote:
> On Mon, 05 Sep 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 05 Sep 2022, Jingyu Wang <jingyuwang_vip@163.com> wrote:
> > > Fix everything checkpatch.pl complained about in drm_print.h
> 
> [...]
> 
> > >  static inline void
> > > -drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
> > > +drm_vprintf(struct drm_printer *p, const char *fmt, va_list * va)
> > 
> > Checkpatch is just confused here. Look at all the other params, why
> > would you add an extra space here?
> 
> Joe, can you help me out here please, I can't figure out why checkpatch
> is complaining here:
> 
> include/drm/drm_print.h:106: CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
> #106: FILE: include/drm/drm_print.h:106:
> +drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)

checkpatch doesn't know what a va_list is.

It's similar to the FILE typedef that also causes this output.

A recent link to add an exception for 'FILE' to checkpatch:

https://lore.kernel.org/all/20220902111923.1488671-1-mic@digikod.net/


